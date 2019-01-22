#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include <llvm/IR/InstIterator.h>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IntrinsicInst.h"
#include "llvm/Support/Debug.h"
#include "Dataflow.h"
#include "llvm/IR/DebugInfo.h"


using namespace llvm;

using ValueSet = std::set<Value *>;
using PointMap = std::map<Value *, ValueSet>;

#define dfv(x) dfval->PointTos[x]

struct FunPtrInfo {
    PointMap PointTos;
    FunPtrInfo() : PointTos() {};
    FunPtrInfo(const FunPtrInfo & info) : PointTos(info.PointTos) {}

    bool operator == (const FunPtrInfo & info) const {
        return PointTos == info.PointTos;
    }
};

inline raw_ostream &operator<<(raw_ostream &out, const FunPtrInfo &info) {
    for (PointMap::const_iterator it = info.PointTos.begin();
        it != info.PointTos.end(); ++it) {
        const Value *Pointer = it->first;
        ValueSet Pointees = it->second;
        out <<"\nPointer is:\n";
        if (Pointer == NULL) {
            out <<"is NULL";
        } else{
            out << (Pointer) << (*Pointer)<<"\n";
            out <<"\nValues are:\n";
            for (auto tmpit = Pointees.begin(); tmpit != Pointees.end();
                ++tmpit)  {
                out << (*tmpit)<< (**tmpit)<<"\n";
            }
            out <<"\noverover\n";
        }
    }
    return out;
}


std::set<CallInst *> directCalls;
std::map<CallInst *, std::set<Function *>> indirectCalls;
std::map<Function *, FunPtrInfo> worklist;

// store the data flow after callee return.
std::map<Function * , PointMap> GPointTos;
std::map<ReturnInst *, ValueSet> RetVals;

class FunPtrVisitor : public DataflowVisitor<struct FunPtrInfo>{

public:
    FunPtrVisitor() {}
    void merge(FunPtrInfo * dest, const FunPtrInfo & src) override {
        for (PointMap::const_iterator ptiter = src.PointTos.begin();
            ptiter != src.PointTos.end(); ptiter++) {
            dest->PointTos[ptiter->first].insert(ptiter->second.begin(),
                (*ptiter).second.end());
       }
    }

    // get ReturnInst's ReturnValue of given CallInst.
    std::map<Function* ,ValueSet> getRetVal(CallInst *callin, FunPtrInfo * dfval){
        std::map<Function* ,ValueSet> retmap;
        if(callin->getCalledFunction() != NULL){
            Function* callfunc = callin->getCalledFunction();
            Value *retval;
            for (inst_iterator ii = inst_begin(callfunc); ii != inst_end(callfunc); ++ii) {
                if (ReturnInst *ri = dyn_cast<ReturnInst>(&*ii)) {
                    retval = ri->getReturnValue();
                    retmap[callfunc].insert(retval);
                    break;
                }
            }

        } else {
            Value * callf = callin->getCalledValue();
            for (auto it = dfv(callf).begin(); 
                it != dfv(callf).end(); it++) {
                Value *retval;
                if (Function *func = dyn_cast<Function>(*it)) {
                    for (inst_iterator ii = inst_begin(func); ii != inst_end(func); ++ii) {
                        if (ReturnInst *ri = dyn_cast<ReturnInst>(&*ii)) {
                            retval = ri->getReturnValue();
                            retmap[func].insert(retval);
                            break;
                        }
                    }
                }
            }
        }
        return retmap;
    }
    void visitMemCpyInst(MemCpyInst *MCI, FunPtrInfo *dfval) {
        BitCastInst *BCI0 = dyn_cast<BitCastInst>(MCI->getArgOperand(0));
        BitCastInst *BCI1 = dyn_cast<BitCastInst>(MCI->getArgOperand(1));
        if (!BCI0 || !BCI1) {
            return;
        }
        Value *dst = BCI0->getOperand(0);
        Value *src = BCI1->getOperand(0);
        dfv(dst).clear();
        dfv(dst).insert(dfv(src).begin(), dfv(src).end());
    }
    void visitCallInst(CallInst *CI, FunPtrInfo *dfval) {
        // process direct call inst
        if (CI->getCalledFunction() != NULL) {
            if (isa<MemCpyInst>(CI)) {
                return;
            }
            directCalls.insert(CI);

            Function *callee = CI->getCalledFunction();
            for (unsigned i = 0;i < CI->getNumArgOperands(); ++i) {
                Value *y = CI->getArgOperand(i);

                Function::arg_iterator argit = callee->arg_begin();
                argit += i;
                Value *x = &*argit;
                // x formal arg
                // y real arg
                if (isa<PHINode>(y)) {
                    dfv(x).insert(dfv(y).begin(), dfv(y).end());
                    worklist[callee].PointTos[x].insert(dfv(x).begin(), dfv(x).end());
                    // insert pointer's pointer into worklist
                    for (auto vit = dfv(y).begin(); vit != dfv(y).end(); vit++) {
                        worklist[callee].PointTos[*vit].insert(dfv(*vit).begin(),
                            dfv(*vit).end());
                    }
                    
                } else if (x->getType()->isPointerTy()) {
                    for(auto tmpit = dfv(y).begin(); tmpit != dfv(y).end(); tmpit++) {
                        worklist[callee].PointTos[*tmpit].insert(dfv(*tmpit).begin(),
                            dfv(*tmpit).end());
                    }
                    worklist[callee].PointTos[x].insert(y);
                }
                worklist[callee].PointTos[x].insert(dfv(y).begin(),
                    dfv(y).end());
            }
            
            // TODO
            // pass all the dataflow value to callee
            for (auto it = dfval->PointTos.begin(); it != dfval->PointTos.end(); it++) {
                worklist[callee].PointTos[it->first].insert(it->second.begin(),
                    it->second.end());
            }
        // end if
        } else {
            // process undirect call inst
            Value *pvv = CI->getCalledValue();

            std::set<Function *> tmpset;
            std::map<Function* ,ValueSet> retmap;

            for (auto it = dfv(pvv).begin(); it != dfv(pvv).end(); it++) {
                if (Function *func = dyn_cast<Function>(*it)) {
                    tmpset.insert(func);
                } else {
                    for (auto cddit = dfv(pvv).begin(); cddit != dfv(pvv).end(); cddit++) {
                        for (auto vit = dfv(*cddit).begin(); vit != dfv(*cddit).end(); vit++) {
                            if (Function *func = dyn_cast<Function>(*vit)) {
                                tmpset.insert(func);
                            }
                        }
                        // a special case
                        if (isa<LoadInst>(pvv)) {
                            for (auto vit = dfv(*cddit).begin(); vit != dfv(*cddit).end(); vit++) {
                                if (isa<AllocaInst>(*vit)) {
                                    for (auto vvit = dfv(*vit).begin(); vvit != dfv(*vit).end(); vvit++) {
                                        if (Function *func = dyn_cast<Function>(*vvit)) {
                                            tmpset.insert(func);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            for (auto it = dfv(pvv).begin(); it != dfv(pvv).end(); it++) {
                if (Function *callee = dyn_cast<Function>(*it)){
                    for (unsigned i = 0;i < CI->getNumArgOperands(); ++i) {
                        Value *y = CI->getArgOperand(i);    
                        Function::arg_iterator argit = callee->arg_begin();
                        argit += i;
                        Value *x = &*argit;
                        // x formal arg
                        // y real arg
                        if (isa<PHINode>(y)) {
                            dfv(x).insert(dfv(y).begin(), dfv(y).end());
                            worklist[callee].PointTos[x].insert(dfv(x).begin(), 
                                dfv(x).end());
                        } else if (isa<AllocaInst>(y)) {
                            worklist[callee].PointTos[x].insert(dfv(y).begin(),
                                dfv(y).end());
                            
                        } else if (x->getType()->isPointerTy()) {
                            worklist[callee].PointTos[x].insert(y);
                        }
                        worklist[callee].PointTos[x].insert(dfv(y).begin(),
                            dfv(y).end());
                    }

                    // TODO
                    // pass all the dataflow value to callee
                    for (PointMap::iterator iit = dfval->PointTos.begin();
                        iit != dfval->PointTos.end(); iit++) {
                        worklist[callee].PointTos[iit->first].insert(iit->second.begin(),
                            iit->second.end());
                    }
                }
            }

            // collect answers 
            indirectCalls[CI].clear();
            indirectCalls[CI].insert(tmpset.begin(), tmpset.end());


        }

        // if the callinst is a left val, get it from the callee's returninst.
        std::map<Function* ,ValueSet> retmap;
        retmap = getRetVal(CI, dfval);
        for(std::map<Function* ,ValueSet>::iterator it = retmap.begin(); it!=retmap.end(); it++){
            for(auto init = it->second.begin(); init != it->second.end(); init++){
                if (worklist[it->first].PointTos[*init].begin() != worklist[it->first].PointTos[*init].end())
                    dfv(CI).insert(worklist[it->first].PointTos[*init].begin(),
                        worklist[it->first].PointTos[*init].end());
            }
        }
        // a special case
        for (auto it = dfv(CI).begin(); it != dfv(CI).end(); it++) {
            for (auto iit = dfv(*it).begin(); iit != dfv(*it).end(); iit++) {
                if (auto *func = dyn_cast<Function>(*iit)) {
                    dfv(CI).insert(func);
                }
            }
        }

        // use GPointTos set to forcely change the dfval of caller.
        // Because the dateflow iterate always starts from the entry bb, if we only use worklist's initval,
        // the side effect the callee's dataflow iterate cannot be eliminated.
        if (CI->getCalledFunction() != NULL) {
            Function *callee = CI->getCalledFunction();
            for (unsigned i = 0;i < CI->getNumArgOperands(); ++i) {
                Value *y = CI->getArgOperand(i);

                if(GPointTos[callee].find(y)!=GPointTos[callee].end()){
                    dfv(y).clear();
                    dfv(y).insert(GPointTos[callee][y].begin(), 
                        GPointTos[callee][y].end());
                } else {
                    dfv(y).clear();
                }
            }
            
            for (PointMap::iterator it = GPointTos[callee].begin();
                it != GPointTos[callee].end(); it++) {
                dfv(it->first).clear();
                dfv(it->first).insert(it->second.begin(), it->second.end());
            }
        }
    }
    void visitReturnInst(ReturnInst *RI, FunPtrInfo *dfval) {
        if (dfv(RI->getReturnValue()).size() > 0) {
            for (std::map<CallInst *, std::set<Function *>>::iterator cit = indirectCalls.begin();
                cit != indirectCalls.end(); cit++) {
                for (std::set<Function *>::iterator fit = cit->second.begin();
                    fit != cit->second.end(); fit++) {
                    if (*fit == RI->getParent()->getParent()) {
                        Function *callee = *fit;
                        Function *caller = cit->first->getParent()->getParent();
                        for (unsigned i = 0;i < cit->first->getNumArgOperands(); ++i) {
                            Value *y = cit->first->getArgOperand(i);    
                            Function::arg_iterator argit = callee->arg_begin();
                            argit += i;
                            Value *x = &*argit;
                            // x formal arg
                            // y real arg
                            if (dfval->PointTos.find(x) != dfval->PointTos.end()) {
                                if (GPointTos[callee][y] != dfv(x)) {
                                    GPointTos[callee][y].insert(dfv(x).begin(), dfv(x).end());
                                    for (PointMap::iterator mapit = dfval->PointTos.begin();
                                        mapit != dfval->PointTos.end(); mapit++) {
                                        if (mapit->first == x) {
                                            continue;
                                        }
                                        worklist[caller].PointTos[mapit->first].insert(mapit->second.begin(), 
                                            mapit->second.end());
                                    } 
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // mark and pass to callee if the retval is changed.
        int mark = 0;
        if (RetVals[RI] != dfv(RI->getReturnValue())) {
            mark = 1;
            RetVals[RI].clear();
            RetVals[RI].insert(dfv(RI->getReturnValue()).begin(),
                dfv(RI->getReturnValue()).end());
        }

        // iterate functions to find the caller
        for (std::set<CallInst *>::iterator cit = directCalls.begin(); cit != directCalls.end(); cit++) {
            // if the real arg's data flow value have been changed, pass is to the callee and insert it 
            // into worklist.
            Function *caller = (*cit)->getParent()->getParent();
            Function *callee = (*cit)->getCalledFunction();

            if (callee == RI->getParent()->getParent()) {
                for (unsigned i = 0;i < (*cit)->getNumArgOperands(); ++i) {
                    Value *y = (*cit)->getArgOperand(i);    
                    Function::arg_iterator argit = callee->arg_begin();
                    argit += i;
                    Value *x = &*argit;
                    // x formal arg
                    // y real arg
                    if (dfval->PointTos.find(x) != dfval->PointTos.end()) {
                        if (GPointTos[callee][y] != dfv(x)) {
                            GPointTos[callee][y].insert(dfv(x).begin(), dfv(x).end());
                            for (PointMap::iterator mapit = dfval->PointTos.begin();
                                mapit != dfval->PointTos.end(); mapit++) {
                                if (mapit->first == x) {
                                    continue;
                                }
                                worklist[caller].PointTos[mapit->first].insert(mapit->second.begin(),
                                    mapit->second.end());
                            } 
                        } else if (mark) {
                            for (PointMap::iterator mapit = dfval->PointTos.begin();
                                mapit != dfval->PointTos.end(); mapit++) {
                                if (mapit->first == x) {
                                    continue;
                                }
                                worklist[caller].PointTos[mapit->first].insert(mapit->second.begin(),
                                    mapit->second.end());
                            }
                        }
                    } 
                }
            }
        }
    }
    void visitPHINode(PHINode *PHI, FunPtrInfo *dfval) {
        unsigned num = PHI->getNumIncomingValues();
        for (unsigned i = 0; i < num; ++i) {
            Value *v = PHI->getIncomingValue(i);
            dfv(PHI).insert(v);

            if (PHINode *inPhi = dyn_cast<PHINode>(v)) {
                for (unsigned j = 0;j < inPhi->getNumIncomingValues(); ++j) {
                    if (Function *func = dyn_cast<Function>(inPhi->getIncomingValue(j))) {
                        dfv(PHI).insert(func);
                    }
                }
            }
        }
    }
    void visitGetElementPtrInst(GetElementPtrInst *GEP, FunPtrInfo *dfval) {
        if (GEP->isInBounds()) {
            Value *strc = GEP->getPointerOperand();
            dfv(GEP).insert(strc);
        }
    }
    void visitStoreInst(StoreInst *SI, FunPtrInfo *dfval) {
        Value *Vop = SI->getValueOperand();
        Value *Pop = SI->getPointerOperand();
        if (isa<Function>(Vop)) {
            if (isa<BitCastInst>(Pop)) {
                dfv(Pop).clear();
                dfv(Pop).insert(Vop);
            } else {
                ValueSet tmpset = dfv(Pop);
                for (auto tmpit = tmpset.begin(); tmpit != tmpset.end(); tmpit++) {

                    // *tmpit = %24
                    // %24 -> %4
                    // for case 26's else branch
                    if (LoadInst *li = dyn_cast<LoadInst>(*tmpit)) {
                        for (auto it = dfv(li).begin(); it != dfv(li).end(); it++) {
                            if (isa<AllocaInst>(*it)) {
                                for (auto iit = dfv(*it).begin(); iit != dfv(*it).end(); iit++) {
                                    dfv(*iit).clear();
                                    dfv(*iit).insert(Vop);
                                }
                            }
                        }
                    }
                    else {
                        dfv(*tmpit).clear();
                        dfv(*tmpit).insert(Vop);
                    } 
                    
                } 
            }
            
        } else {
            if (isa<AllocaInst>(Vop)) {
                ValueSet tmpset = dfv(Pop);
                for (auto tmpit = tmpset.begin(); tmpit != tmpset.end(); tmpit++) {
                    dfv(*tmpit).clear();
                    dfv(*tmpit).insert(Vop);
                } 
            } else {
                ValueSet should_insert;

                // for case 26 if branch
                // Vop = %6
                // %6 -> %5'
                if (LoadInst *li = dyn_cast<LoadInst>(Vop)) {
                    for (auto it = dfv(li).begin(); it != dfv(li).end(); it++) {
                        if (isa<AllocaInst>(*it)) {
                            for (auto iit = dfv(*it).begin(); iit != dfv(*it).end(); iit++) {
                                if (dfv(*iit).begin() != dfv(*iit).end())
                                    should_insert = dfv(*iit);
                            }
                        }
                    }
                }
                
                ValueSet tmpset = dfv(Pop);
                for (auto tmpit = tmpset.begin(); tmpit != tmpset.end();
                    tmpit++) {
                    // *tmpit = %10
                    // %10 -> %7' bitcast
                    
                    if (LoadInst *li = dyn_cast<LoadInst>(*tmpit)) {
                        for (auto it = dfv(li).begin(); it != dfv(li).end(); it++) {
                            if (isa<BitCastInst>(*it)) {
                                for (auto iit = dfv(*it).begin(); iit != dfv(*it).end(); iit++) {
                                    for (auto iiit = dfv(*iit).begin(); iiit != dfv(*iit).end(); iiit++) {
                                        dfv(*iiit).clear();
                                        dfv(*iiit).insert(should_insert.begin(), should_insert.end());
                                        GPointTos[SI->getParent()->getParent()][*iiit].insert(dfv(*iiit).begin(),
                                            dfv(*iiit).end());
                                    }
                                }
                            }
                        }
                    } else {
                        dfv(*tmpit).clear();
                        dfv(*tmpit).insert(dfv(Vop).begin(), dfv(Vop).end());
                    }
                } 
            }        
        }
    }
    void visitLoadInst(LoadInst *LI, FunPtrInfo *dfval) {
        Value *Pop = LI->getPointerOperand();
        if (isa<BitCastInst>(Pop)) {
            dfv(LI).insert(dfv(Pop).begin(), dfv(Pop).end());
        } else if(dfv(Pop).begin() != dfv(Pop).end() && 
            isa<Function>(*(dfv(Pop).begin()))){
            dfv(LI).insert(dfv(Pop).begin(), dfv(Pop).end());
        } else{
            ValueSet tmpset = dfv(Pop);
            for (auto tmpit = tmpset.begin(); tmpit != tmpset.end(); tmpit++) {
                dfv(LI).insert(dfv(*tmpit).begin(), dfv(*tmpit).end());
            }
        }
    }
    void compDFVal(Instruction *inst, FunPtrInfo *dfval ) override {
        if (isa<DbgInfoIntrinsic>(inst)) return;
        if (isa<MemIntrinsic>(inst)) {
            if (MemCpyInst *MCI = dyn_cast<MemCpyInst>(inst)) {
                visitMemCpyInst(MCI, dfval);
            } else {
                return;
            }
        } else if (CallInst *CI = dyn_cast<CallInst>(inst)) {
            visitCallInst(CI, dfval);
        } else if (ReturnInst *RI = dyn_cast<ReturnInst>(inst)) {
            visitReturnInst(RI, dfval);
        } else if (PHINode *PHI = dyn_cast<PHINode>(inst)) {
            visitPHINode(PHI, dfval);
        } else if (GetElementPtrInst *GEP = dyn_cast<GetElementPtrInst>(inst)) {
            visitGetElementPtrInst(GEP, dfval);
        } else if (StoreInst *SI = dyn_cast<StoreInst>(inst)) {
            visitStoreInst(SI, dfval);
        } else if (LoadInst *LI = dyn_cast<LoadInst>(inst)){
            visitLoadInst(LI, dfval);
        } 
    }
};

class FuncPtrPass : public ModulePass {
public:
    static char ID; // Pass identification, replacement for typeid
    FuncPtrPass() : ModulePass(ID) {}

    void printRes() {
        std::map<unsigned, std::set<Function *>> finalres;
        for (auto it = directCalls.begin(); it != directCalls.end(); it++) {
            finalres[getLineNo(*it)].insert((*it)->getCalledFunction());
        }
        for (auto it = indirectCalls.begin(); it != indirectCalls.end(); it++) {
            finalres[getLineNo(it->first)].insert(it->second.begin(), it->second.end());
        }
        for (auto resit = finalres.begin(); resit != finalres.end(); resit++) {
            errs()<<resit->first<<" : ";
            int flag = 1;
            for (std::set<Function *>::iterator funcit = resit->second.begin();
                funcit != resit->second.end(); funcit++) {
                if (flag == 1) {
                    errs()<<(*funcit)->getName();
                    flag = 0;
                } else {
                    errs()<<", "<<(*funcit)->getName();
                }
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

        while (worklist.size() > 0) {
            Function *F = worklist.begin()->first;
            FunPtrInfo fpi = worklist.begin()->second;
            worklist.erase(worklist.begin());
            FunPtrVisitor visitor;
            DataflowResult<FunPtrInfo>::Type result;
            compForwardDataflow(F, &visitor, &result, fpi);
            // printDataflowResult<FunPtrInfo>(errs(), result);
            
        }
        printRes();
        return false;
    }
};
char FuncPtrPass::ID = 0;