#include <stdlib.h>
struct fptr
{
int (*p_fptr)(int, int);
};
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int clever(int a, int b, int (*a_fptr[])(int, int)) {
    return a_fptr[2](a, b);
}


int moo(char x, int op1, int op2) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    int (*t_fptr[3])(int, int)= {0};

    if (x == '+') {
       t_fptr[2] = a_fptr;
    } 
    else if (x == '-') {
       t_fptr[2] = s_fptr;
    }

    unsigned result = clever(op1, op2, t_fptr);
    return 0;
}
; ModuleID = 'test21.bc'
source_filename = "test21.c"
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
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)** %a_fptr) #0 !dbg !25 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !30, metadata !12), !dbg !31
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !32, metadata !12), !dbg !33
  call void @llvm.dbg.value(metadata i32 (i32, i32)** %a_fptr, i64 0, metadata !34, metadata !12), !dbg !35
  %arrayidx = getelementptr inbounds i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, i64 2, !dbg !36
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx, align 8, !dbg !36
  %call = call i32 %0(i32 %a, i32 %b), !dbg !36
  ret i32 %call, !dbg !37
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !38 {
entry:
  %t_fptr = alloca [3 x i32 (i32, i32)*], align 16
  call void @llvm.dbg.value(metadata i8 %x, i64 0, metadata !42, metadata !12), !dbg !43
  call void @llvm.dbg.value(metadata i32 %op1, i64 0, metadata !44, metadata !12), !dbg !45
  call void @llvm.dbg.value(metadata i32 %op2, i64 0, metadata !46, metadata !12), !dbg !47
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !48, metadata !12), !dbg !49
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !50, metadata !12), !dbg !51
  call void @llvm.dbg.declare(metadata [3 x i32 (i32, i32)*]* %t_fptr, metadata !52, metadata !12), !dbg !56
  %0 = bitcast [3 x i32 (i32, i32)*]* %t_fptr to i8*, !dbg !56
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 24, i32 16, i1 false), !dbg !56
  %conv = sext i8 %x to i32, !dbg !57
  %cmp = icmp eq i32 %conv, 43, !dbg !59
  br i1 %cmp, label %if.then, label %if.else, !dbg !60

if.then:                                          ; preds = %entry
  %arrayidx = getelementptr inbounds [3 x i32 (i32, i32)*], [3 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 2, !dbg !61
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %arrayidx, align 16, !dbg !63
  br label %if.end7, !dbg !64

if.else:                                          ; preds = %entry
  %conv2 = sext i8 %x to i32, !dbg !65
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !67
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !68

if.then5:                                         ; preds = %if.else
  %arrayidx6 = getelementptr inbounds [3 x i32 (i32, i32)*], [3 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 2, !dbg !69
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %arrayidx6, align 16, !dbg !71
  br label %if.end, !dbg !72

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then
  %arraydecay = getelementptr inbounds [3 x i32 (i32, i32)*], [3 x i32 (i32, i32)*]* %t_fptr, i32 0, i32 0, !dbg !73
  %call = call i32 @clever(i32 %op1, i32 %op2, i32 (i32, i32)** %arraydecay), !dbg !74
  call void @llvm.dbg.value(metadata i32 %call, i64 0, metadata !75, metadata !12), !dbg !77
  ret i32 0, !dbg !78
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test21.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 6, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 6, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 6, type: !10)
!15 = !DILocation(line: 6, column: 21, scope: !7)
!16 = !DILocation(line: 7, column: 12, scope: !7)
!17 = !DILocation(line: 7, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 10, type: !10)
!20 = !DILocation(line: 10, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 10, type: !10)
!22 = !DILocation(line: 10, column: 22, scope: !18)
!23 = !DILocation(line: 11, column: 12, scope: !18)
!24 = !DILocation(line: 11, column: 4, scope: !18)
!25 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !26, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!10, !10, !10, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!30 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 14, type: !10)
!31 = !DILocation(line: 14, column: 16, scope: !25)
!32 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 14, type: !10)
!33 = !DILocation(line: 14, column: 23, scope: !25)
!34 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !25, file: !1, line: 14, type: !28)
!35 = !DILocation(line: 14, column: 32, scope: !25)
!36 = !DILocation(line: 15, column: 12, scope: !25)
!37 = !DILocation(line: 15, column: 5, scope: !25)
!38 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 19, type: !39, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!39 = !DISubroutineType(types: !40)
!40 = !{!10, !41, !10, !10}
!41 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!42 = !DILocalVariable(name: "x", arg: 1, scope: !38, file: !1, line: 19, type: !41)
!43 = !DILocation(line: 19, column: 14, scope: !38)
!44 = !DILocalVariable(name: "op1", arg: 2, scope: !38, file: !1, line: 19, type: !10)
!45 = !DILocation(line: 19, column: 21, scope: !38)
!46 = !DILocalVariable(name: "op2", arg: 3, scope: !38, file: !1, line: 19, type: !10)
!47 = !DILocation(line: 19, column: 30, scope: !38)
!48 = !DILocalVariable(name: "a_fptr", scope: !38, file: !1, line: 20, type: !29)
!49 = !DILocation(line: 20, column: 11, scope: !38)
!50 = !DILocalVariable(name: "s_fptr", scope: !38, file: !1, line: 21, type: !29)
!51 = !DILocation(line: 21, column: 11, scope: !38)
!52 = !DILocalVariable(name: "t_fptr", scope: !38, file: !1, line: 22, type: !53)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !29, size: 192, elements: !54)
!54 = !{!55}
!55 = !DISubrange(count: 3)
!56 = !DILocation(line: 22, column: 11, scope: !38)
!57 = !DILocation(line: 24, column: 9, scope: !58)
!58 = distinct !DILexicalBlock(scope: !38, file: !1, line: 24, column: 9)
!59 = !DILocation(line: 24, column: 11, scope: !58)
!60 = !DILocation(line: 24, column: 9, scope: !38)
!61 = !DILocation(line: 25, column: 8, scope: !62)
!62 = distinct !DILexicalBlock(scope: !58, file: !1, line: 24, column: 19)
!63 = !DILocation(line: 25, column: 18, scope: !62)
!64 = !DILocation(line: 26, column: 5, scope: !62)
!65 = !DILocation(line: 27, column: 14, scope: !66)
!66 = distinct !DILexicalBlock(scope: !58, file: !1, line: 27, column: 14)
!67 = !DILocation(line: 27, column: 16, scope: !66)
!68 = !DILocation(line: 27, column: 14, scope: !58)
!69 = !DILocation(line: 28, column: 8, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !1, line: 27, column: 24)
!71 = !DILocation(line: 28, column: 18, scope: !70)
!72 = !DILocation(line: 29, column: 5, scope: !70)
!73 = !DILocation(line: 31, column: 40, scope: !38)
!74 = !DILocation(line: 31, column: 23, scope: !38)
!75 = !DILocalVariable(name: "result", scope: !38, file: !1, line: 31, type: !76)
!76 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!77 = !DILocation(line: 31, column: 14, scope: !38)
!78 = !DILocation(line: 32, column: 5, scope: !38)


// 15 : plus, minus
// 31 : clever