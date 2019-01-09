#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/Debug.h"
#include "Dataflow.h"
#include "llvm/IR/DebugInfo.h"
using namespace llvm;

struct FunPtrInfo {
    std::map<Value *, std::set<Value *>> PointTos;
    FunPtrInfo() : PointTos() {};
    FunPtrInfo(const FunPtrInfo & info) : PointTos(info.PointTos) {}

    bool operator == (const FunPtrInfo & info) const {
        return PointTos == info.PointTos;
    }
};

inline raw_ostream &operator<<(raw_ostream &out, const FunPtrInfo &info) {
    for (std::map<Value *, std::set<Value *>>::const_iterator it = info.PointTos.begin();
        it != info.PointTos.end(); ++it) {
        const Value *Pointer = it->first;
        std::set<Value *> Pointees = it->second;
        out << Pointer->getName();
        out << "  ";
        for (std::set<Value *>::iterator tmpit = Pointees.begin(); tmpit != Pointees.end();
            ++tmpit)  {
            out << (*tmpit) << " ";
        }
    }
    return out;
}
std::vector<CallInst *> directCalls;

class FunPtrVisitor : public DataflowVisitor<struct FunPtrInfo>{

public:
    FunPtrVisitor() {}
    void merge(FunPtrInfo * dest, const FunPtrInfo & src) override {
        for (std::map<Value *, std::set<Value *>>::const_iterator ptiter = src.PointTos.begin(); ptiter != src.PointTos.end(); ptiter++) {
            if(dest->PointTos.find((*ptiter).first) != dest->PointTos.end()){
                    dest->PointTos[(*ptiter).first].insert((*ptiter).second.begin(),(*ptiter).second.end());
            } else {
                    dest->PointTos[(*ptiter).first] = (*ptiter).second;  
            }
       }
    }

    void compDFVal(Instruction *inst, FunPtrInfo *dfval ) override {
        if (isa<DbgInfoIntrinsic>(inst)) return;
        if (CallInst *CI = dyn_cast<CallInst>(inst)) {
            // process direct call inst
            if (CI->getCalledFunction() != NULL) {
                directCalls.push_back(CI);
                // process args passed
                Function *callee = CI->getCalledFunction();
                for (unsigned i = 0;i < CI->getNumArgOprands(); ++i) {
                    Value *x = c->getArgOpreads(i);
                    Function::arg_iterator argit = func->arg_begin();
                    argit += i;

                    Value *y = &*argit;

                    if (arg->getType()->isPointerTy()) {
                        std::set<Value *> Sx = dfval->PointTos[x];
                        std::set<Value *> Sy = dfval->PointTos[y];
                        Sx.clear();
                        dfval->PointTos[x].insert(Sy.begin(), Sy.end());
                    }
                }
                
            } else {
            // else, process undirect call inst

            }
            

             
        } else if (PHINode *Phi = dyn_cast<PHINode>(inst)) {
            std::set<Value *> pointees;
            unsigned num = Phi->getNumIncomingValues();
            for (unsigned i = 0; i < num; ++i) {
                Value *v = Phi->getIncomingValue(i);
                if (v->getType()->isFunctionTy() || v->getType()->isPointerTy()) {
                    if (v->getName() == null) continue;
                    errs()<<*v;
                    pointees.insert(v);
                }
            }
            if (pointees.size() != 0) {
                dfval->PointTos[Phi] = pointees;
            }
        }

    }

};

///!TODO TO BE COMPLETED BY YOU FOR ASSIGNMENT 3
class FuncPtrPass : public ModulePass {
public:
    static char ID; // Pass identification, replacement for typeid
    FuncPtrPass() : ModulePass(ID) {}

    void printRes() {
        for (std::vector<CallInst *>::iterator it = directCalls.begin(); it != directCalls.end();
            it++) {
            errs()<<getLineNo(*it)<<": "<<(*it)->getCalledFunction()->getName()<<"\n";
        }
    }
    unsigned getLineNo(Instruction *I) {
        unsigned line;
        if (DILocation *Loc = I->getDebugLoc()) {
            line = Loc->getLine();
            std::string filename = Loc->getFilename().str();

        if (filename.empty()) {
            DILocation *oDILoc = Loc->getInlinedAt();
        if (oDILoc) {
            line = oDILoc->getLine();
        }
      }
    }
    return line;
  }
    bool runOnModule(Module &M) override {
        FunPtrInfo initval;
        FunPtrInfo old_initval;

        // M.print(errs(), 0);
        while (true) {
            for (Function &F : M) {
                FunPtrVisitor visitor;
                DataflowResult<FunPtrInfo>::Type result;
                compForwardDataflow(&F, &visitor, &result, initval);
                printDataflowResult<FunPtrInfo>(errs(), result);
            }
        if(old_initval == initval) break;
        else old_initval = initval;

        }
        printRes();

        return false;
    }
};
char FuncPtrPass::ID = 0;