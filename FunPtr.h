#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include <llvm/IR/InstIterator.h>
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

    std::set<Value *> getRetVal(CallInst *callinst, FunPtrInfo * dfval){
        std::set<Value *> retset;
        if(callin->getCalledFunction() != NULL){
            Function* callfunc = callin->getCalledFunction();
            Value *retval;
            for (inst_iterator ii = inst_begin(callfunc); ii != inst_end(callfunc); ++ii) {
                if (ReturnInst *ri = dyn_cast<ReturnInst>(&*ii)) {
                    retval = ri->getReturnValue();
                    retset.insert(retval);
                    break;
                }
            }

        } else {
            Value * callf = callin->getCalledValue();
            for (std::set<Value *>::iterator it = dfval->PointTos[callf].begin(); 
                it != dfval->PointTos[callf].end(); it++) {
                if (Function *func = dyn_cast<Function>(*it)) {
                    for (inst_iterator ii = inst_begin(func); ii != inst_end(func); ++ii) {
                        if (ReturnInst *ri = dyn_cast<ReturnInst>(&*ii)) {
                        retval = ri->getReturnValue();
                        retset.insert(retval);
                        break;
                        }
                    }
                }
            }
        }
        return retset;
    }

    void compDFVal(Instruction *inst, FunPtrInfo *dfval ) override {
        if (isa<DbgInfoIntrinsic>(inst)) return;
        if (isa<MemIntrinsic>(inst)) return;
        // if (inst->getParent()->getParent()->getName() == "clever") {
        //             errs()<<"fuck u\n";
        //             for (std::map<Value *, std::set<Value *>>::iterator it = dfval->PointTos.begin();
        //                 it != dfval->PointTos.end(); it++) {
        //                 errs()<<"key issssssssssss "<<it->first->getName()<<"\n";
        //                 for (std::set<Value *>::iterator tmpit = it->second.begin(); tmpit != it->second.end();
        //                     tmpit++) {
        //                     errs()<<(**tmpit)<<"\n";
        //                 }
        //                 errs()<<"\n\n";
        //             }
        // }
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
                    if (PHINode *Phi = dyn_cast<PHINode>(y)) {
                        dfval->PointTos[x].insert(dfval->PointTos[y].begin(), 
                            dfval->PointTos[y].end());
                        worklist[callee].PointTos[x].insert(dfval->PointTos[x].begin(), 
                            dfval->PointTos[x].end());
                    } else if (x->getType()->isPointerTy()) {
                        worklist[callee].PointTos[x].insert(y);
                    }
                    worklist[callee].PointTos[x].insert(dfval->PointTos[y].begin(),
                        dfval->PointTos[y].end());
                }
            } else {
                // else, process undirect call inst
                Value *pvv = CI->getCalledValue();
                std::set<Function *> tmpset;


                



                if(CallInst *callin = dyn_cast<CallInst>(pvv)){
                    Function* callfunc = callin->getCalledFunction();
                    Value *retval;
                    if (callfunc != NULL){
                        for (inst_iterator ii = inst_begin(callfunc); ii != inst_end(callfunc); ++ii) {
                            if (ReturnInst *ri = dyn_cast<ReturnInst>(&*ii)) {
                                retval = ri->getReturnValue();
                                break;
                            }
                        }
                        dfval->PointTos[pvv].insert(worklist[callfunc].PointTos[retval].begin(),
                    worklist[callfunc].PointTos[retval].end());
                        // for (std::set<Value *>::iterator tmpit = dfval->PointTos[retval].begin(); tmpit != dfval->PointTos[retval].end();
                        //     tmpit++) {
                        //     errs()<<(**tmpit)<<"\n";
                        // }
                        // errs()<<"\n\n";
                    } else {
                        Value * callf = callin->getCalledValue();
                        for (std::set<Value *>::iterator it = dfval->PointTos[callf].begin(); 
                    it != dfval->PointTos[callf].end(); it++) {
                            // errs()<< (**it) << '\n';
                            if (Function *func = dyn_cast<Function>(*it)) {
                                for (inst_iterator ii = inst_begin(func); ii != inst_end(func); ++ii) {
                                    if (ReturnInst *ri = dyn_cast<ReturnInst>(&*ii)) {
                                    retval = ri->getReturnValue();
                                    break;
                                    }
                                }
                                dfval->PointTos[pvv].insert(worklist[func].PointTos[retval].begin(),
                                worklist[func].PointTos[retval].end());
                            }
                        }
                    }

                }
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
                // errs()<< *pvv << '\n';
                for (std::set<Value *>::iterator it = dfval->PointTos[pvv].begin(); 
                it != dfval->PointTos[pvv].end(); it++) {
                    // errs()<< **it << '\n';
                    if (Function *callee = dyn_cast<Function>(*it)){
                        for (unsigned i = 0;i < CI->getNumArgOperands(); ++i) {
                            Value *y = CI->getArgOperand(i);    
                            Function::arg_iterator argit = callee->arg_begin();
                            argit += i;
                            Value *x = &*argit;
                            // x xingcan
                            // y shican
                            // errs()<< *x << '\n';
                            // errs() << *y <<'\n-----';
                            if (PHINode *Phi = dyn_cast<PHINode>(y)) {
                                dfval->PointTos[x].insert(dfval->PointTos[y].begin(), 
                                    dfval->PointTos[y].end());
                                worklist[callee].PointTos[x].insert(dfval->PointTos[x].begin(), 
                                    dfval->PointTos[x].end());
                            } else if (x->getType()->isPointerTy()) {
                                worklist[callee].PointTos[x].insert(y);
                            }
                            worklist[callee].PointTos[x].insert(dfval->PointTos[y].begin(),
                                dfval->PointTos[y].end());
                        }
                    }
                }
                if (indirectCalls.find(CI) != indirectCalls.end()) {
                    indirectCalls[CI].insert(tmpset.begin(), tmpset.end());
                } else {
                    indirectCalls[CI] = tmpset;
                }

            }
            
        } else if (ReturnInst *Ri = dyn_cast<ReturnInst>(inst)) {
            // errs()<<"deal with return inst\n";
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

        M.print(errs(), 0);
        for (Function &F : M) {
            FunPtrInfo initval;
            worklist[&F] = initval;
        }
        // for(std::map<Function *, FunPtrInfo>::iterator it = worklist.begin() ; it != worklist.end() ; it++) {
        //     errs()<<"firstly have "<<it->first->getName()<<"\n";
        // }
        errs()<<"\n";
        while (worklist.size() > 0) {
            for(std::map<Function *, FunPtrInfo>::iterator it = worklist.begin() ; it != worklist.end() ; it++){
                FunPtrVisitor visitor;
                DataflowResult<FunPtrInfo>::Type result;
                compForwardDataflow(((*it).first), &visitor, &result, (*it).second);
                // printDataflowResult<FunPtrInfo>(errs(), result);
                worklist.erase(it);
            }
        }
        printRes();
        return false;
    }
};
char FuncPtrPass::ID = 0;