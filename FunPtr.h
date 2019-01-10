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
            out << (**tmpit)<<" ";
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
            // if(dest->PointTos.find((*ptiter).first) != dest->PointTos.end()){
            //         dest->PointTos[(*ptiter).first].insert((*ptiter).second.begin(),(*ptiter).second.end());
            // } else {
            //         dest->PointTos[(*ptiter).first] = (*ptiter).second;  
            // }
            dest->PointTos[(*ptiter).first].insert((*ptiter).second.begin(),(*ptiter).second.end());
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
                    } else {
                        // tricky
                        for (std::set<Value *>::iterator cddit = dfval->PointTos[pvv].begin();
                            cddit != dfval->PointTos[pvv].end(); cddit++) {
                            if (dfval->PointTos.find(*cddit) != dfval->PointTos.end() && 
                                dfval->PointTos[*cddit].size() > 0) {
                                for (std::set<Value *>::iterator vit = dfval->PointTos[*cddit].begin();
                                    vit != dfval->PointTos[*cddit].end(); vit++) {
                                    if (Function *func = dyn_cast<Function>(*vit)) {
                                        tmpset.insert(func);
                                    }
                                }
                            }
                        }
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
        } else if (GetElementPtrInst *Gep = dyn_cast<GetElementPtrInst>(inst)) {
            
            if (Gep->isInBounds()) {

                Value *strc = Gep->getPointerOperand();
                dfval->PointTos[Gep].insert(strc);
                if (Gep->getName() == "p_fptr2") {
                    errs()<<"caocaocaocaocaco\n";
                }
            }
        } else if (StoreInst *Si = dyn_cast<StoreInst>(inst)) {
            Value *Vop = Si->getValueOperand();
            Value *Pop = Si->getPointerOperand();
            if (isa<Function>(Vop)) {
                if (isa<BitCastInst>(Pop)) {
                    dfval->PointTos[Pop].clear();
                    dfval->PointTos[Pop].insert(Vop);
                } else {
                    std::set<Value *> tmpset = dfval->PointTos[Pop];
                    for (std::set<Value *>::iterator tmpit = tmpset.begin(); tmpit != tmpset.end();
                        tmpit++) {
                        dfval->PointTos[*tmpit].clear();
                        dfval->PointTos[*tmpit].insert(Vop);
                    } 
                }
                
            } else {
                if (isa<AllocaInst>(Vop)) {
                    std::set<Value *> tmpset = dfval->PointTos[Pop];
                    for (std::set<Value *>::iterator tmpit = tmpset.begin(); tmpit != tmpset.end();
                        tmpit++) {
                        dfval->PointTos[*tmpit].clear();
                        dfval->PointTos[*tmpit].insert(Vop);
                    } 
                } else {
                    std::set<Value *> tmpset = dfval->PointTos[Pop];
                    for (std::set<Value *>::iterator tmpit = tmpset.begin(); tmpit != tmpset.end();
                        tmpit++) {
                        dfval->PointTos[*tmpit].clear();
                        dfval->PointTos[*tmpit].insert(dfval->PointTos[Vop].begin(),
                            dfval->PointTos[Vop].end());
                    } 
                }
                
            }
            // errs()<<"over store\n";
        } else if (LoadInst *Li = dyn_cast<LoadInst>(inst)){
            Value *Pop = Li->getPointerOperand();
            if (isa<BitCastInst>(Pop)) {
                dfval->PointTos[Li].insert(dfval->PointTos[Pop].begin(),
                    dfval->PointTos[Pop].end());
            } else {
                std::set<Value *> tmpset = dfval->PointTos[Pop];
                for (std::set<Value *>::iterator tmpit = tmpset.begin(); tmpit != tmpset.end();
                    tmpit++) {
                    dfval->PointTos[Li].insert(dfval->PointTos[*tmpit].begin(),
                        dfval->PointTos[*tmpit].end());
                }
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
        // while (cnt < 10) {
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