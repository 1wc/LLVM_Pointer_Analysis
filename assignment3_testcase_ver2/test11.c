#include <stdlib.h>
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int clever(int a, int b, int (*a_fptr)(int, int)) {
    return a_fptr(a, b);
}


int moo(char x, int op1, int op2) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    int (**t_fptr)(int, int) = (int (**)(int, int))malloc(sizeof(int (*)(int, int)));

    if (x == '+') {
       *t_fptr = a_fptr;
    } 
    if (x == '-') {
       *t_fptr = s_fptr;
    }

    unsigned result = clever(op1, op2, *t_fptr);
    return 0;
}

// 11 : plus, minus
// 18 : malloc
// 27 : clever
; ModuleID = 'test11.bc'
source_filename = "test11.c"
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
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !28 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !31, metadata !15), !dbg !32
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !33, metadata !15), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %a_fptr, i64 0, metadata !35, metadata !15), !dbg !36
  %call = call i32 %a_fptr(i32 %a, i32 %b), !dbg !37
  ret i32 %call, !dbg !38
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !39 {
entry:
  call void @llvm.dbg.value(metadata i8 %x, i64 0, metadata !43, metadata !15), !dbg !44
  call void @llvm.dbg.value(metadata i32 %op1, i64 0, metadata !45, metadata !15), !dbg !46
  call void @llvm.dbg.value(metadata i32 %op2, i64 0, metadata !47, metadata !15), !dbg !48
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !49, metadata !15), !dbg !50
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !51, metadata !15), !dbg !52
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !53
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !54
  call void @llvm.dbg.value(metadata i32 (i32, i32)** %0, i64 0, metadata !55, metadata !15), !dbg !56
  %conv = sext i8 %x to i32, !dbg !57
  %cmp = icmp eq i32 %conv, 43, !dbg !59
  br i1 %cmp, label %if.then, label %if.end, !dbg !60

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %0, align 8, !dbg !61
  br label %if.end, !dbg !63

if.end:                                           ; preds = %if.then, %entry
  %conv2 = sext i8 %x to i32, !dbg !64
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !66
  br i1 %cmp3, label %if.then5, label %if.end6, !dbg !67

if.then5:                                         ; preds = %if.end
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %0, align 8, !dbg !68
  br label %if.end6, !dbg !70

if.end6:                                          ; preds = %if.then5, %if.end
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %0, align 8, !dbg !71
  %call7 = call i32 @clever(i32 %op1, i32 %op2, i32 (i32, i32)* %1), !dbg !72
  call void @llvm.dbg.value(metadata i32 %call7, i64 0, metadata !73, metadata !15), !dbg !75
  ret i32 0, !dbg !76
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
!1 = !DIFile(filename: "test11.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!28 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !29, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!8, !8, !8, !5}
!31 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 10, type: !8)
!32 = !DILocation(line: 10, column: 16, scope: !28)
!33 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 10, type: !8)
!34 = !DILocation(line: 10, column: 23, scope: !28)
!35 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !28, file: !1, line: 10, type: !5)
!36 = !DILocation(line: 10, column: 32, scope: !28)
!37 = !DILocation(line: 11, column: 12, scope: !28)
!38 = !DILocation(line: 11, column: 5, scope: !28)
!39 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 15, type: !40, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!8, !42, !8, !8}
!42 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!43 = !DILocalVariable(name: "x", arg: 1, scope: !39, file: !1, line: 15, type: !42)
!44 = !DILocation(line: 15, column: 14, scope: !39)
!45 = !DILocalVariable(name: "op1", arg: 2, scope: !39, file: !1, line: 15, type: !8)
!46 = !DILocation(line: 15, column: 21, scope: !39)
!47 = !DILocalVariable(name: "op2", arg: 3, scope: !39, file: !1, line: 15, type: !8)
!48 = !DILocation(line: 15, column: 30, scope: !39)
!49 = !DILocalVariable(name: "a_fptr", scope: !39, file: !1, line: 16, type: !5)
!50 = !DILocation(line: 16, column: 11, scope: !39)
!51 = !DILocalVariable(name: "s_fptr", scope: !39, file: !1, line: 17, type: !5)
!52 = !DILocation(line: 17, column: 11, scope: !39)
!53 = !DILocation(line: 18, column: 52, scope: !39)
!54 = !DILocation(line: 18, column: 32, scope: !39)
!55 = !DILocalVariable(name: "t_fptr", scope: !39, file: !1, line: 18, type: !4)
!56 = !DILocation(line: 18, column: 12, scope: !39)
!57 = !DILocation(line: 20, column: 9, scope: !58)
!58 = distinct !DILexicalBlock(scope: !39, file: !1, line: 20, column: 9)
!59 = !DILocation(line: 20, column: 11, scope: !58)
!60 = !DILocation(line: 20, column: 9, scope: !39)
!61 = !DILocation(line: 21, column: 16, scope: !62)
!62 = distinct !DILexicalBlock(scope: !58, file: !1, line: 20, column: 19)
!63 = !DILocation(line: 22, column: 5, scope: !62)
!64 = !DILocation(line: 23, column: 9, scope: !65)
!65 = distinct !DILexicalBlock(scope: !39, file: !1, line: 23, column: 9)
!66 = !DILocation(line: 23, column: 11, scope: !65)
!67 = !DILocation(line: 23, column: 9, scope: !39)
!68 = !DILocation(line: 24, column: 16, scope: !69)
!69 = distinct !DILexicalBlock(scope: !65, file: !1, line: 23, column: 19)
!70 = !DILocation(line: 25, column: 5, scope: !69)
!71 = !DILocation(line: 27, column: 40, scope: !39)
!72 = !DILocation(line: 27, column: 23, scope: !39)
!73 = !DILocalVariable(name: "result", scope: !39, file: !1, line: 27, type: !74)
!74 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!75 = !DILocation(line: 27, column: 14, scope: !39)
!76 = !DILocation(line: 28, column: 5, scope: !39)