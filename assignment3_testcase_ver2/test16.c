#include <stdlib.h>
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int (*foo(int a, int b, int (*a_fptr)(int, int), int(*b_fptr)(int, int) ))(int, int) {
   return a_fptr;
}

int clever(int a, int b, int (*a_fptr)(int, int), int(**b_fptr)(int, int)) {
   int (*s_fptr)(int, int);
   s_fptr = foo(a, b, a_fptr, *b_fptr);
   return s_fptr(a, b);
}


int moo(char x, int op1, int op2) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    int (**t_fptr)(int, int) = (int (**)(int, int))malloc(sizeof(int (*)(int, int)));

    if (x == '+') {
       *t_fptr = a_fptr;
    } 
    else if (x == '-') {
       *t_fptr = s_fptr;
    }

    unsigned result = clever(op1, op2, a_fptr, t_fptr);
    return 0;
}
; ModuleID = 'test16.bc'
source_filename = "test16.c"
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
define i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !28 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !31, metadata !15), !dbg !32
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !33, metadata !15), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %a_fptr, i64 0, metadata !35, metadata !15), !dbg !36
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %b_fptr, i64 0, metadata !37, metadata !15), !dbg !38
  ret i32 (i32, i32)* %a_fptr, !dbg !39
}

; Function Attrs: noinline nounwind uwtable
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %b_fptr) #0 !dbg !40 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !43, metadata !15), !dbg !44
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !45, metadata !15), !dbg !46
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %a_fptr, i64 0, metadata !47, metadata !15), !dbg !48
  call void @llvm.dbg.value(metadata i32 (i32, i32)** %b_fptr, i64 0, metadata !49, metadata !15), !dbg !50
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %b_fptr, align 8, !dbg !51
  %call = call i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %0), !dbg !52
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %call, i64 0, metadata !53, metadata !15), !dbg !54
  %call1 = call i32 %call(i32 %a, i32 %b), !dbg !55
  ret i32 %call1, !dbg !56
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !57 {
entry:
  call void @llvm.dbg.value(metadata i8 %x, i64 0, metadata !61, metadata !15), !dbg !62
  call void @llvm.dbg.value(metadata i32 %op1, i64 0, metadata !63, metadata !15), !dbg !64
  call void @llvm.dbg.value(metadata i32 %op2, i64 0, metadata !65, metadata !15), !dbg !66
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !67, metadata !15), !dbg !68
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !69, metadata !15), !dbg !70
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !71
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !72
  call void @llvm.dbg.value(metadata i32 (i32, i32)** %0, i64 0, metadata !73, metadata !15), !dbg !74
  %conv = sext i8 %x to i32, !dbg !75
  %cmp = icmp eq i32 %conv, 43, !dbg !77
  br i1 %cmp, label %if.then, label %if.else, !dbg !78

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %0, align 8, !dbg !79
  br label %if.end6, !dbg !81

if.else:                                          ; preds = %entry
  %conv2 = sext i8 %x to i32, !dbg !82
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !84
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !85

if.then5:                                         ; preds = %if.else
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %0, align 8, !dbg !86
  br label %if.end, !dbg !88

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then
  %call7 = call i32 @clever(i32 %op1, i32 %op2, i32 (i32, i32)* @plus, i32 (i32, i32)** %0), !dbg !89
  call void @llvm.dbg.value(metadata i32 %call7, i64 0, metadata !90, metadata !15), !dbg !92
  ret i32 0, !dbg !93
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
!1 = !DIFile(filename: "test16.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !29, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!5, !8, !8, !5, !5}
!31 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 10, type: !8)
!32 = !DILocation(line: 10, column: 15, scope: !28)
!33 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 10, type: !8)
!34 = !DILocation(line: 10, column: 22, scope: !28)
!35 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !28, file: !1, line: 10, type: !5)
!36 = !DILocation(line: 10, column: 31, scope: !28)
!37 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !28, file: !1, line: 10, type: !5)
!38 = !DILocation(line: 10, column: 55, scope: !28)
!39 = !DILocation(line: 11, column: 4, scope: !28)
!40 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !41, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!8, !8, !8, !5, !4}
!43 = !DILocalVariable(name: "a", arg: 1, scope: !40, file: !1, line: 14, type: !8)
!44 = !DILocation(line: 14, column: 16, scope: !40)
!45 = !DILocalVariable(name: "b", arg: 2, scope: !40, file: !1, line: 14, type: !8)
!46 = !DILocation(line: 14, column: 23, scope: !40)
!47 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !40, file: !1, line: 14, type: !5)
!48 = !DILocation(line: 14, column: 32, scope: !40)
!49 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !40, file: !1, line: 14, type: !4)
!50 = !DILocation(line: 14, column: 57, scope: !40)
!51 = !DILocation(line: 16, column: 31, scope: !40)
!52 = !DILocation(line: 16, column: 13, scope: !40)
!53 = !DILocalVariable(name: "s_fptr", scope: !40, file: !1, line: 15, type: !5)
!54 = !DILocation(line: 15, column: 10, scope: !40)
!55 = !DILocation(line: 17, column: 11, scope: !40)
!56 = !DILocation(line: 17, column: 4, scope: !40)
!57 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 21, type: !58, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!58 = !DISubroutineType(types: !59)
!59 = !{!8, !60, !8, !8}
!60 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!61 = !DILocalVariable(name: "x", arg: 1, scope: !57, file: !1, line: 21, type: !60)
!62 = !DILocation(line: 21, column: 14, scope: !57)
!63 = !DILocalVariable(name: "op1", arg: 2, scope: !57, file: !1, line: 21, type: !8)
!64 = !DILocation(line: 21, column: 21, scope: !57)
!65 = !DILocalVariable(name: "op2", arg: 3, scope: !57, file: !1, line: 21, type: !8)
!66 = !DILocation(line: 21, column: 30, scope: !57)
!67 = !DILocalVariable(name: "a_fptr", scope: !57, file: !1, line: 22, type: !5)
!68 = !DILocation(line: 22, column: 11, scope: !57)
!69 = !DILocalVariable(name: "s_fptr", scope: !57, file: !1, line: 23, type: !5)
!70 = !DILocation(line: 23, column: 11, scope: !57)
!71 = !DILocation(line: 24, column: 52, scope: !57)
!72 = !DILocation(line: 24, column: 32, scope: !57)
!73 = !DILocalVariable(name: "t_fptr", scope: !57, file: !1, line: 24, type: !4)
!74 = !DILocation(line: 24, column: 12, scope: !57)
!75 = !DILocation(line: 26, column: 9, scope: !76)
!76 = distinct !DILexicalBlock(scope: !57, file: !1, line: 26, column: 9)
!77 = !DILocation(line: 26, column: 11, scope: !76)
!78 = !DILocation(line: 26, column: 9, scope: !57)
!79 = !DILocation(line: 27, column: 16, scope: !80)
!80 = distinct !DILexicalBlock(scope: !76, file: !1, line: 26, column: 19)
!81 = !DILocation(line: 28, column: 5, scope: !80)
!82 = !DILocation(line: 29, column: 14, scope: !83)
!83 = distinct !DILexicalBlock(scope: !76, file: !1, line: 29, column: 14)
!84 = !DILocation(line: 29, column: 16, scope: !83)
!85 = !DILocation(line: 29, column: 14, scope: !76)
!86 = !DILocation(line: 30, column: 16, scope: !87)
!87 = distinct !DILexicalBlock(scope: !83, file: !1, line: 29, column: 24)
!88 = !DILocation(line: 31, column: 5, scope: !87)
!89 = !DILocation(line: 33, column: 23, scope: !57)
!90 = !DILocalVariable(name: "result", scope: !57, file: !1, line: 33, type: !91)
!91 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!92 = !DILocation(line: 33, column: 14, scope: !57)
!93 = !DILocation(line: 34, column: 5, scope: !57)


/// 16 : foo
/// 17 : plus
/// 24 : malloc
/// 32 : clever 
