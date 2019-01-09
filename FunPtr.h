#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IntrinsicInst.h"

#include "Dataflow.h"

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
		int b = 1;
	}

};

///!TODO TO BE COMPLETED BY YOU FOR ASSIGNMENT 3
class FuncPtrPass : public ModulePass {
public:
    static char ID; // Pass identification, replacement for typeid
    FuncPtrPass() : ModulePass(ID) {}


    bool runOnModule(Module &M) override {
        errs() << "Hello: ";
        errs().write_escaped(M.getName()) << '\n';
        M.print(errs(), 0);
        errs() << "------------------------------\n";
		FunPtrInfo initval;
		FunPtrInfo old_initval;
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
        

        return false;
    }
};
char FuncPtrPass::ID = 0;