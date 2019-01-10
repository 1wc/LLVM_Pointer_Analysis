#include <stdlib.h>
struct fptr
{
	int (*p_fptr)(int, int);
};
struct fsptr
{
struct fptr * sptr;
};
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}
void foo(int x)
{
	struct fptr a_fptr;
	struct fsptr s_fptr;
	struct fsptr* w_fptr=(struct fsptr*)malloc(sizeof(struct fsptr));
	s_fptr.sptr=&a_fptr;
	*w_fptr=s_fptr;
	if(x>1)
	{
		 a_fptr.p_fptr=plus;
		 x=s_fptr.sptr->p_fptr(1,x);
		 a_fptr.p_fptr=minus;
	}else
	{
		w_fptr->sptr->p_fptr=minus;
	}
	x=a_fptr.p_fptr(1,x);
}
// 21 : malloc
// 27 : plus
// 33 : minus

; ModuleID = 'test09.bc'
source_filename = "test09.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !20 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !21, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !24, metadata !22), !dbg !25
  %add = add nsw i32 %a, %b, !dbg !26
  ret i32 %add, !dbg !27
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !28 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !29, metadata !22), !dbg !30
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !31, metadata !22), !dbg !32
  %sub = sub nsw i32 %a, %b, !dbg !33
  ret i32 %sub, !dbg !34
}

; Function Attrs: noinline nounwind uwtable
define void @foo(i32 %x) #0 !dbg !35 {
entry:
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  call void @llvm.dbg.value(metadata i32 %x, i64 0, metadata !38, metadata !22), !dbg !39
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !40, metadata !22), !dbg !41
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !42, metadata !22), !dbg !43
  %call = call noalias i8* @malloc(i64 8) #4, !dbg !44
  %0 = bitcast i8* %call to %struct.fsptr*, !dbg !45
  call void @llvm.dbg.value(metadata %struct.fsptr* %0, i64 0, metadata !46, metadata !22), !dbg !47
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !48
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !49
  %1 = bitcast %struct.fsptr* %0 to i8*, !dbg !50
  %2 = bitcast %struct.fsptr* %s_fptr to i8*, !dbg !50
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 8, i32 8, i1 false), !dbg !50
  %cmp = icmp sgt i32 %x, 1, !dbg !51
  br i1 %cmp, label %if.then, label %if.else, !dbg !53

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !54
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !56
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !57
  %3 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !57
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !58
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !58
  %call3 = call i32 %4(i32 1, i32 %x), !dbg !59
  call void @llvm.dbg.value(metadata i32 %call3, i64 0, metadata !38, metadata !22), !dbg !39
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !60
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr4, align 8, !dbg !61
  br label %if.end, !dbg !62

if.else:                                          ; preds = %entry
  %sptr5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !63
  %5 = load %struct.fptr*, %struct.fptr** %sptr5, align 8, !dbg !63
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !65
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr6, align 8, !dbg !66
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %x.addr.0 = phi i32 [ %call3, %if.then ], [ %x, %if.else ]
  call void @llvm.dbg.value(metadata i32 %x.addr.0, i64 0, metadata !38, metadata !22), !dbg !39
  %p_fptr7 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !67
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr7, align 8, !dbg !67
  %call8 = call i32 %6(i32 1, i32 %x.addr.0), !dbg !68
  call void @llvm.dbg.value(metadata i32 %call8, i64 0, metadata !38, metadata !22), !dbg !39
  ret void, !dbg !69
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17, !18}
!llvm.ident = !{!19}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test09.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !5, file: !1, line: 8, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !9, file: !1, line: 4, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15, !15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{i32 2, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!20 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !13, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !15)
!22 = !DIExpression()
!23 = !DILocation(line: 10, column: 14, scope: !20)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !15)
!25 = !DILocation(line: 10, column: 21, scope: !20)
!26 = !DILocation(line: 11, column: 12, scope: !20)
!27 = !DILocation(line: 11, column: 4, scope: !20)
!28 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !13, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!29 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 14, type: !15)
!30 = !DILocation(line: 14, column: 15, scope: !28)
!31 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 14, type: !15)
!32 = !DILocation(line: 14, column: 22, scope: !28)
!33 = !DILocation(line: 15, column: 12, scope: !28)
!34 = !DILocation(line: 15, column: 4, scope: !28)
!35 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 17, type: !36, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!36 = !DISubroutineType(types: !37)
!37 = !{null, !15}
!38 = !DILocalVariable(name: "x", arg: 1, scope: !35, file: !1, line: 17, type: !15)
!39 = !DILocation(line: 17, column: 14, scope: !35)
!40 = !DILocalVariable(name: "a_fptr", scope: !35, file: !1, line: 19, type: !9)
!41 = !DILocation(line: 19, column: 14, scope: !35)
!42 = !DILocalVariable(name: "s_fptr", scope: !35, file: !1, line: 20, type: !5)
!43 = !DILocation(line: 20, column: 15, scope: !35)
!44 = !DILocation(line: 21, column: 38, scope: !35)
!45 = !DILocation(line: 21, column: 23, scope: !35)
!46 = !DILocalVariable(name: "w_fptr", scope: !35, file: !1, line: 21, type: !4)
!47 = !DILocation(line: 21, column: 16, scope: !35)
!48 = !DILocation(line: 22, column: 9, scope: !35)
!49 = !DILocation(line: 22, column: 13, scope: !35)
!50 = !DILocation(line: 23, column: 10, scope: !35)
!51 = !DILocation(line: 24, column: 6, scope: !52)
!52 = distinct !DILexicalBlock(scope: !35, file: !1, line: 24, column: 5)
!53 = !DILocation(line: 24, column: 5, scope: !35)
!54 = !DILocation(line: 26, column: 11, scope: !55)
!55 = distinct !DILexicalBlock(scope: !52, file: !1, line: 25, column: 2)
!56 = !DILocation(line: 26, column: 17, scope: !55)
!57 = !DILocation(line: 27, column: 13, scope: !55)
!58 = !DILocation(line: 27, column: 19, scope: !55)
!59 = !DILocation(line: 27, column: 6, scope: !55)
!60 = !DILocation(line: 28, column: 11, scope: !55)
!61 = !DILocation(line: 28, column: 17, scope: !55)
!62 = !DILocation(line: 29, column: 2, scope: !55)
!63 = !DILocation(line: 31, column: 11, scope: !64)
!64 = distinct !DILexicalBlock(scope: !52, file: !1, line: 30, column: 2)
!65 = !DILocation(line: 31, column: 17, scope: !64)
!66 = !DILocation(line: 31, column: 23, scope: !64)
!67 = !DILocation(line: 33, column: 11, scope: !35)
!68 = !DILocation(line: 33, column: 4, scope: !35)
!69 = !DILocation(line: 34, column: 1, scope: !35)
