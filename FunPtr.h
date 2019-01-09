#include <llvm/IR/Function.h>
#include <llvm/Pass.h>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/IntrinsicInst.h"

#include "Dataflow.h"

using namespace llvm;

struct FunPtrInfo {
	std::set<Value *, std::set<Value *>> PointTos;
	FunPtrInfo() : PointTos() {};
	FunPtrInfo(const FunPtrInfo & info) : PointTos(info.PointTos) {}

	bool operator == (const FunPtrInfo & info) const {
		return PointTos == info.PointTos;
	}
};



class FunPtrVisitor : public DataflowVisitor<struct FunPtrInfo>{

public:
	FunPtrVisitor() {}
	void merge(FunPtrInfo * dest, const FunPtrInfo & src) override {
		
	}

	void compDFVal() override {

	}

};