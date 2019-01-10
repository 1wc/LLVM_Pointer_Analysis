#include <stdlib.h>
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}
void foo(int x)
{
	int (**a_fptr)(int,int)=(int (**)(int,int))malloc(sizeof(int (*)(int,int)));
	if(x>1)
	{
		*a_fptr=plus;
		 x=(*a_fptr)(1,x);
		 *a_fptr=minus;
	}else
	{
		*a_fptr=minus;
	}
	x=(*a_fptr)(1,x);
}
// 11 : malloc
// 15 : plus
// 21 : minus

; ModuleID = 'test06.bc'
source_filename = "test06.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !13 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !14, metadata !15), !dbg !16
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !17, metadata !15), !dbg !18
  %add = add nsw i32 %a, %b, !dbg !19
  ret i32 %add, !dbg !20
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !21 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !22, metadata !15), !dbg !23
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !24, metadata !15), !dbg !25
  %sub = sub nsw i32 %a, %b, !dbg !26
  ret i32 %sub, !dbg !27
}

; Function Attrs: noinline nounwind uwtable
define void @foo(i32 %x) #0 !dbg !28 {
entry:
  call void @llvm.dbg.value(metadata i32 %x, i64 0, metadata !31, metadata !15), !dbg !32
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !33
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)** %0, i64 0, metadata !35, metadata !15), !dbg !36
  %cmp = icmp sgt i32 %x, 1, !dbg !37
  br i1 %cmp, label %if.then, label %if.else, !dbg !39

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %0, align 8, !dbg !40
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %0, align 8, !dbg !42
  %call1 = call i32 %1(i32 1, i32 %x), !dbg !43
  call void @llvm.dbg.value(metadata i32 %call1, i64 0, metadata !31, metadata !15), !dbg !32
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %0, align 8, !dbg !44
  br label %if.end, !dbg !45

if.else:                                          ; preds = %entry
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %0, align 8, !dbg !46
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %x.addr.0 = phi i32 [ %call1, %if.then ], [ %x, %if.else ]
  call void @llvm.dbg.value(metadata i32 %x.addr.0, i64 0, metadata !31, metadata !15), !dbg !32
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %0, align 8, !dbg !48
  %call2 = call i32 %2(i32 1, i32 %x.addr.0), !dbg !49
  call void @llvm.dbg.value(metadata i32 %call2, i64 0, metadata !31, metadata !15), !dbg !32
  ret void, !dbg !50
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10, !11}
!llvm.ident = !{!12}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test06.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = !DISubroutineType(types: !7)
!7 = !{!8, !8, !8}
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{i32 2, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!13 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !6, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!14 = !DILocalVariable(name: "a", arg: 1, scope: !13, file: !1, line: 2, type: !8)
!15 = !DIExpression()
!16 = !DILocation(line: 2, column: 14, scope: !13)
!17 = !DILocalVariable(name: "b", arg: 2, scope: !13, file: !1, line: 2, type: !8)
!18 = !DILocation(line: 2, column: 21, scope: !13)
!19 = !DILocation(line: 3, column: 12, scope: !13)
!20 = !DILocation(line: 3, column: 4, scope: !13)
!21 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !6, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!22 = !DILocalVariable(name: "a", arg: 1, scope: !21, file: !1, line: 6, type: !8)
!23 = !DILocation(line: 6, column: 15, scope: !21)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !21, file: !1, line: 6, type: !8)
!25 = !DILocation(line: 6, column: 22, scope: !21)
!26 = !DILocation(line: 7, column: 12, scope: !21)
!27 = !DILocation(line: 7, column: 4, scope: !21)
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !29, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{null, !8}
!31 = !DILocalVariable(name: "x", arg: 1, scope: !28, file: !1, line: 9, type: !8)
!32 = !DILocation(line: 9, column: 14, scope: !28)
!33 = !DILocation(line: 11, column: 45, scope: !28)
!34 = !DILocation(line: 11, column: 26, scope: !28)
!35 = !DILocalVariable(name: "a_fptr", scope: !28, file: !1, line: 11, type: !4)
!36 = !DILocation(line: 11, column: 9, scope: !28)
!37 = !DILocation(line: 12, column: 6, scope: !38)
!38 = distinct !DILexicalBlock(scope: !28, file: !1, line: 12, column: 5)
!39 = !DILocation(line: 12, column: 5, scope: !28)
!40 = !DILocation(line: 14, column: 10, scope: !41)
!41 = distinct !DILexicalBlock(scope: !38, file: !1, line: 13, column: 2)
!42 = !DILocation(line: 15, column: 7, scope: !41)
!43 = !DILocation(line: 15, column: 6, scope: !41)
!44 = !DILocation(line: 16, column: 11, scope: !41)
!45 = !DILocation(line: 17, column: 2, scope: !41)
!46 = !DILocation(line: 19, column: 10, scope: !47)
!47 = distinct !DILexicalBlock(scope: !38, file: !1, line: 18, column: 2)
!48 = !DILocation(line: 21, column: 5, scope: !28)
!49 = !DILocation(line: 21, column: 4, scope: !28)
!50 = !DILocation(line: 22, column: 1, scope: !28)
