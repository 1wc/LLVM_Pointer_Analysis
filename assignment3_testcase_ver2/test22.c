d#include <stdlib.h>
struct fptr
{
int (*p_fptr)(int, int);
};
int plus(int a, int b) {
   return a+b;
}

int minus(int a,int b)
{
    return a-b;
}

int foo(int a,int b,struct fptr af_ptr)
{
    return af_ptr.p_fptr(a,b);
}
void make_simple_alias(struct fptr *a,struct fptr * b)
{
    a->p_fptr=b->p_fptr;
}
int clever() {
  
    int (*af_ptr)(int ,int ,struct fptr)=0;
    struct fptr tf_ptr={0};
    struct fptr sf_ptr={0};
    tf_ptr.p_fptr=minus;
    sf_ptr.p_fptr=plus;
    af_ptr=foo;
    make_simple_alias(&tf_ptr,&sf_ptr);
    unsigned result = af_ptr(1, 2,tf_ptr);
    return 0;
}
// 17 : plus
// 31 : make_simple_alias
// 32 : foo


triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32, i32) #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !14, metadata !12), !dbg !15
  %3 = add nsw i32 %0, %1, !dbg !16
  ret i32 %3, !dbg !17
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32, i32) #0 !dbg !18 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !19, metadata !12), !dbg !20
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !21, metadata !12), !dbg !22
  %3 = sub nsw i32 %0, %1, !dbg !23
  ret i32 %3, !dbg !24
}

; Function Attrs: noinline nounwind uwtable
define i32 @foo(i32, i32, i32 (i32, i32)*) #0 !dbg !25 {
  %4 = alloca %struct.fptr, align 8
  %5 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0
  store i32 (i32, i32)* %2, i32 (i32, i32)** %5, align 8
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !32, metadata !12), !dbg !33
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !34, metadata !12), !dbg !35
  call void @llvm.dbg.declare(metadata %struct.fptr* %4, metadata !36, metadata !12), !dbg !37
  %6 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !38
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !38
  %8 = call i32 %7(i32 %0, i32 %1), !dbg !39
  ret i32 %8, !dbg !40
}

; Function Attrs: noinline nounwind uwtable
define void @make_simple_alias(%struct.fptr*, %struct.fptr*) #0 !dbg !41 {
  call void @llvm.dbg.value(metadata %struct.fptr* %0, i64 0, metadata !45, metadata !12), !dbg !46
  call void @llvm.dbg.value(metadata %struct.fptr* %1, i64 0, metadata !47, metadata !12), !dbg !48
  %3 = getelementptr inbounds %struct.fptr, %struct.fptr* %1, i32 0, i32 0, !dbg !49
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !49
  %5 = getelementptr inbounds %struct.fptr, %struct.fptr* %0, i32 0, i32 0, !dbg !50
  store i32 (i32, i32)* %4, i32 (i32, i32)** %5, align 8, !dbg !51
  ret void, !dbg !52
}

; Function Attrs: noinline nounwind uwtable
define i32 @clever() #0 !dbg !53 {
  %1 = alloca %struct.fptr, align 8
  %2 = alloca %struct.fptr, align 8
  call void @llvm.dbg.value(metadata i32 (i32, i32, i32 (i32, i32)*)* null, i64 0, metadata !56, metadata !12), !dbg !58
  call void @llvm.dbg.declare(metadata %struct.fptr* %1, metadata !59, metadata !12), !dbg !60
  %3 = bitcast %struct.fptr* %1 to i8*, !dbg !60
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 8, i32 8, i1 false), !dbg !60
  call void @llvm.dbg.declare(metadata %struct.fptr* %2, metadata !61, metadata !12), !dbg !62
  %4 = bitcast %struct.fptr* %2 to i8*, !dbg !62
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 8, i32 8, i1 false), !dbg !62
  %5 = getelementptr inbounds %struct.fptr, %struct.fptr* %1, i32 0, i32 0, !dbg !63
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %5, align 8, !dbg !64
  %6 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !65
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %6, align 8, !dbg !66
  call void @llvm.dbg.value(metadata i32 (i32, i32, i32 (i32, i32)*)* @foo, i64 0, metadata !56, metadata !12), !dbg !58
  call void @make_simple_alias(%struct.fptr* %1, %struct.fptr* %2), !dbg !67
  %7 = getelementptr inbounds %struct.fptr, %struct.fptr* %1, i32 0, i32 0, !dbg !68
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !68
  %9 = call i32 @foo(i32 1, i32 2, i32 (i32, i32)* %8), !dbg !68
  call void @llvm.dbg.value(metadata i32 %9, i64 0, metadata !69, metadata !12), !dbg !71
  ret i32 0, !dbg !72
}
