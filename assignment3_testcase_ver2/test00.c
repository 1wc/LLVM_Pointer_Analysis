#include <stdlib.h>

int plus(int a, int b) {
   return a+b;
}

int minus(int a,int b)
{
    return a-b;
}

int foo(int a,int b,int(* a_fptr)(int, int))
{
    return a_fptr(a,b);
}


int moo(char x)
{
    int (*af_ptr)(int ,int ,int(*)(int, int))=foo;
    int (*pf_ptr)(int,int)=0;
    if(x == '+'){
        pf_ptr=plus;
        af_ptr(1,2,pf_ptr);
        pf_ptr=minus;
    }
    af_ptr(1,2,pf_ptr);
    return 0;
}

//14 : plus, minus
//24 : foo
//27 : foo

; ModuleID = 'test00.bc'
source_filename = "test00.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !7 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !14, metadata !12), !dbg !15
  %add = add nsw i32 %a, %b, !dbg !16
  ret i32 %add, !dbg !17
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !18 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !19, metadata !12), !dbg !20
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !21, metadata !12), !dbg !22
  %sub = sub nsw i32 %a, %b, !dbg !23
  ret i32 %sub, !dbg !24
}

; Function Attrs: noinline nounwind uwtable
define i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !25 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !29, metadata !12), !dbg !30
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !31, metadata !12), !dbg !32
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %a_fptr, i64 0, metadata !33, metadata !12), !dbg !34
  %call = call i32 %a_fptr(i32 %a, i32 %b), !dbg !35
  ret i32 %call, !dbg !36
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext %x) #0 !dbg !37 {
entry:
  call void @llvm.dbg.value(metadata i8 %x, i64 0, metadata !41, metadata !12), !dbg !42
  call void @llvm.dbg.value(metadata i32 (i32, i32, i32 (i32, i32)*)* @foo, i64 0, metadata !43, metadata !12), !dbg !45
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, i64 0, metadata !46, metadata !12), !dbg !47
  %conv = sext i8 %x to i32, !dbg !48
  %cmp = icmp eq i32 %conv, 43, !dbg !50
  br i1 %cmp, label %if.then, label %if.end, !dbg !51

if.then:                                          ; preds = %entry
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !46, metadata !12), !dbg !47
  %call = call i32 @foo(i32 1, i32 2, i32 (i32, i32)* @plus), !dbg !52
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !46, metadata !12), !dbg !47
  br label %if.end, !dbg !54

if.end:                                           ; preds = %if.then, %entry
  %pf_ptr.0 = phi i32 (i32, i32)* [ @minus, %if.then ], [ null, %entry ]
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %pf_ptr.0, i64 0, metadata !46, metadata !12), !dbg !47
  %call2 = call i32 @foo(i32 1, i32 2, i32 (i32, i32)* %pf_ptr.0), !dbg !55
  ret i32 0, !dbg !56
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test00.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!15 = !DILocation(line: 3, column: 21, scope: !7)
!16 = !DILocation(line: 4, column: 12, scope: !7)
!17 = !DILocation(line: 4, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !8, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 7, type: !10)
!20 = !DILocation(line: 7, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 7, type: !10)
!22 = !DILocation(line: 7, column: 21, scope: !18)
!23 = !DILocation(line: 9, column: 13, scope: !18)
!24 = !DILocation(line: 9, column: 5, scope: !18)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !26, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!10, !10, !10, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!29 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 12, type: !10)
!30 = !DILocation(line: 12, column: 13, scope: !25)
!31 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 12, type: !10)
!32 = !DILocation(line: 12, column: 19, scope: !25)
!33 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !25, file: !1, line: 12, type: !28)
!34 = !DILocation(line: 12, column: 27, scope: !25)
!35 = !DILocation(line: 14, column: 12, scope: !25)
!36 = !DILocation(line: 14, column: 5, scope: !25)
!37 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 18, type: !38, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!38 = !DISubroutineType(types: !39)
!39 = !{!10, !40}
!40 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!41 = !DILocalVariable(name: "x", arg: 1, scope: !37, file: !1, line: 18, type: !40)
!42 = !DILocation(line: 18, column: 14, scope: !37)
!43 = !DILocalVariable(name: "af_ptr", scope: !37, file: !1, line: 20, type: !44)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!45 = !DILocation(line: 20, column: 11, scope: !37)
!46 = !DILocalVariable(name: "pf_ptr", scope: !37, file: !1, line: 21, type: !28)
!47 = !DILocation(line: 21, column: 11, scope: !37)
!48 = !DILocation(line: 22, column: 8, scope: !49)
!49 = distinct !DILexicalBlock(scope: !37, file: !1, line: 22, column: 8)
!50 = !DILocation(line: 22, column: 10, scope: !49)
!51 = !DILocation(line: 22, column: 8, scope: !37)
!52 = !DILocation(line: 24, column: 9, scope: !53)
!53 = distinct !DILexicalBlock(scope: !49, file: !1, line: 22, column: 17)
!54 = !DILocation(line: 26, column: 5, scope: !53)
!55 = !DILocation(line: 27, column: 5, scope: !37)
!56 = !DILocation(line: 28, column: 5, scope: !37)
