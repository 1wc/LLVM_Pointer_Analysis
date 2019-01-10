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
        out <<"\nPointer is:\n";
        // out << *(Pointer) << "\n";
        out << (*Pointer)<<"\n";
        out <<"\nValues are:\n";
        for (std::set<Value *>::iterator tmpit = Pointees.begin(); tmpit != Pointees.end();
            ++tmpit)  {
            // out << *(*tmpit) << " ";
            out << (*tmpit)->getName()<<" ";
        }
        out <<"\noverover\n";
    }
    return out;
}
std::set<CallInst *> directCalls;
std::map<CallInst *, std::set<Function *>> indirectCalls;
std::map<Function *, FunPtrInfo> worklist;

class FunPtrVisitor : public DataflowVisitor<struct FunPtrInfo>{

public:
    FunPtrVisitor() {}
    void merge(FunPtrInfo * dest, const FunPtrInfo & src) override {
        for (std::map<Value *, std::set<Value *>>::const_iterator ptiter = src.PointTos.begin();
            ptiter != src.PointTos.end(); ptiter++) {
            if(dest->PointTos.find((*ptiter).first) != dest->PointTos.end()){
                    dest->PointTos[(*ptiter).first].insert((*ptiter).second.begin(),(*ptiter).second.end());
            } else {
                    dest->PointTos[(*ptiter).first] = (*ptiter).second;  
            }
       }
    }
    void mergeVal(FunPtrInfo *dest, FunPtrInfo * src) {
        typedef std::map<Value *, std::set<Value *>> pointersty;

        pointersty map1 = dest->PointTos;
        pointersty map2 = src->PointTos;

        for (pointersty::iterator pit = map2.begin(); pit != map2.end(); pit++) {
            if (map1.find((*pit).first) != map1.end()) {
                map1[(*pit).first] = (*pit).second;
            } else {
                map1[(*pit).first].insert((*pit).second.begin(), (*pit).second.end());
            }
        }
    }
    void compDFVal(Instruction *inst, FunPtrInfo *dfval ) override {
        if (isa<DbgInfoIntrinsic>(inst)) return;
        if (isa<MemIntrinsic>(inst)) return;

        if (CallInst *CI = dyn_cast<CallInst>(inst)) {
            // process direct call inst
            if (CI->getCalledFunction() != NULL) {
                directCalls.insert(CI);
                // process args passed
                Function *callee = CI->getCalledFunction();
                
                for (unsigned i = 0;i < CI->getNumArgOperands(); ++i) {
                    Value *y = CI->getArgOperand(i);

                    Function::arg_iterator argit = callee->arg_begin();
                    argit += i;
                    Value *x = &*argit;
                    // x xingcan
                    // y shican
                    FunPtrInfo fpi;
                    if (PHINode *Phi = dyn_cast<PHINode>(y)) {
                        // errs()<<"isisisis in ???";
                        // for (std::set<Value *>::iterator tmpit = dfval->PointTos[y].begin(); tmpit != dfval->PointTos[y].end();
                        //     tmpit++) {
                        //     errs()<<(*tmpit)<<"\n";
                        // }
                        // errs()<<(*CI);
                        // errs()<<dfval->PointTos[y].size()<<"\n";
                        dfval->PointTos[x].insert(dfval->PointTos[y].begin(), 
                            dfval->PointTos[y].end());

                        if (worklist.find(callee) != worklist.end()) {
                            worklist[callee].PointTos[x].insert(dfval->PointTos[x].begin(), 
                                dfval->PointTos[x].end());
                        } else {
                            fpi.PointTos[x].insert(dfval->PointTos[x].begin(), 
                                dfval->PointTos[x].end());
                            worklist[callee] = fpi;
                        }
                    } else if (x->getType()->isPointerTy()) {
                        if (worklist.find(callee) != worklist.end()) {
                            worklist[callee].PointTos[x].insert(y);
                        } else {
                            fpi.PointTos[x].insert(y);
                            worklist[callee] = fpi;
                        }
                    } 
                }
            } else {
                // else, process undirect call inst
                Value *pvv = CI->getCalledValue();
                std::set<Function *> tmpset;
                for (std::set<Value *>::iterator it = dfval->PointTos[pvv].begin(); 
                    it != dfval->PointTos[pvv].end(); it++) {

                    if (Function *func = dyn_cast<Function>(*it)) {
                        tmpset.insert(func);
                    }
                }
                if (indirectCalls.find(CI) != indirectCalls.end()) {
                    indirectCalls[CI].insert(tmpset.begin(), tmpset.end());
                } else {
                    indirectCalls[CI] = tmpset;
                }

            }
            
        } else if (PHINode *Phi = dyn_cast<PHINode>(inst)) {
            std::set<Value *> pointees;
            unsigned num = Phi->getNumIncomingValues();
            for (unsigned i = 0; i < num; ++i) {
                Value *v = Phi->getIncomingValue(i);
                if (v->getType()->isFunctionTy() || v->getType()->isPointerTy()) {
                    if (v->getName() == "null") continue;
                    // errs()<<*v;
                    pointees.insert(v);
                }
            }
            if (pointees.size() != 0) {
                dfval->PointTos[Phi] = pointees;
            }
        } else if (StoreInst *Si = dyn_cast<StoreInst>(inst)) {
            // Si->getValueOperand()->print(errs());
            Value *v1 = Si->getValueOperand();
            // errs()<<"insert!!!\n"<<v1->getName();
            Value *V2 = Si->getPointerOperand();
            GetElementPtrInst *v2;
            if (v2 = dyn_cast<GetElementPtrInst>(V2)) {
                if(isa<Function>(v1)){
                    dfval->PointTos[v2].insert(v1);
                } else {
                    //TODO
                    dfval->PointTos[v2].insert(dfval->PointTos[v1].begin(),dfval->PointTos[v1].end());
                }
                if (v2->isInBounds()) {
                    Value *pvv = v2->getPointerOperand();
                    dfval->PointTos[pvv].insert(dfval->PointTos[v2].begin(),
                        dfval->PointTos[v2].end());
                }
            }
            
            // errs()<<"over store\n";
        } else if (LoadInst *Li = dyn_cast<LoadInst>(inst)){
            // errs()<<"start load\n";
            Value *V2 = Li->getPointerOperand();
            GetElementPtrInst *v2;
            if (v2 = dyn_cast<GetElementPtrInst>(V2)) {
                if (v2->isInBounds()) {
                    // errs()<<"isinbounds\n";
                    Value *pvv = v2->getPointerOperand();
                    dfval->PointTos[v2].insert(dfval->PointTos[pvv].begin(),
                        dfval->PointTos[pvv].end());
                }
            }
            dfval->PointTos[Li].insert(dfval->PointTos[v2].begin(),dfval->PointTos[v2].end());
            // errs()<<"over load\n";
        } 

    }

};

///!TODO TO BE COMPLETED BY YOU FOR ASSIGNMENT 3
class FuncPtrPass : public ModulePass {
public:
    static char ID; // Pass identification, replacement for typeid
    FuncPtrPass() : ModulePass(ID) {}

    void printRes() {
        for (std::set<CallInst *>::iterator it = directCalls.begin();
            it != directCalls.end(); it++) {
            errs()<<getLineNo(*it)<<": "<<(*it)->getCalledFunction()->getName()<<"\n";
        }

        for (std::map<CallInst *, std::set<Function *>>::iterator it = indirectCalls.begin();
            it != indirectCalls.end(); it++) {
            errs()<<getLineNo(it->first)<<": ";
            for (std::set<Function *>::iterator fit = it->second.begin(); fit != it->second.end();
                fit++) {
                errs()<<(*fit)->getName()<<" ";
            }
            errs()<<"\n";
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

        // M.print(errs(), 0);
        for (Function &F : M) {
            FunPtrInfo initval;
            worklist[&F] = initval;
        }
        int cnt = 0;
        while (worklist.size() > 0) {
            cnt += 1;
            for(std::map<Function *, FunPtrInfo>::iterator it = worklist.begin() ; it != worklist.end() ; it++){
                FunPtrVisitor visitor;
                DataflowResult<FunPtrInfo>::Type result;
                compForwardDataflow(((*it).first), &visitor, &result, (*it).second);
                printDataflowResult<FunPtrInfo>(errs(), result);
                worklist.erase(it);
            }
        }
        printRes();
        errs()<<"iterate for "<<cnt<<"times\n";
        return false;
    }
};
char FuncPtrPass::ID = 0;