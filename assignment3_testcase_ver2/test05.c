#include <stdlib.h>
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int clever(int x) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    int (*t_fptr[2])(int, int) ;
    int (*q_fptr[1])(int, int) ;
    int (*r_fptr[2])(int, int) ;

    int op1=1, op2=2;

    if (x >= 3) {
       t_fptr[1] = a_fptr;
    } 
    if (x >= 4) {
       t_fptr[1] = s_fptr;
    }
    if (x >= 5) {
       q_fptr[0] = t_fptr[1];
    }
    if (x >= 6) 
       r_fptr[1] = q_fptr[0];
    

    if (t_fptr[1] != NULL) {
       unsigned result = r_fptr[1](op1, op2);
    }  
   return 0;
}
; ModuleID = 'test05.bc'
source_filename = "test05.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !9 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !16, metadata !14), !dbg !17
  %add = add nsw i32 %a, %b, !dbg !18
  ret i32 %add, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !20 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !21, metadata !14), !dbg !22
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !23, metadata !14), !dbg !24
  %sub = sub nsw i32 %a, %b, !dbg !25
  ret i32 %sub, !dbg !26
}

; Function Attrs: noinline nounwind uwtable
define i32 @clever(i32 %x) #0 !dbg !27 {
entry:
  %t_fptr = alloca [2 x i32 (i32, i32)*], align 16
  %q_fptr = alloca [1 x i32 (i32, i32)*], align 8
  %r_fptr = alloca [2 x i32 (i32, i32)*], align 16
  call void @llvm.dbg.value(metadata i32 %x, i64 0, metadata !30, metadata !14), !dbg !31
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !32, metadata !14), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !35, metadata !14), !dbg !36
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %t_fptr, metadata !37, metadata !14), !dbg !41
  call void @llvm.dbg.declare(metadata [1 x i32 (i32, i32)*]* %q_fptr, metadata !42, metadata !14), !dbg !46
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %r_fptr, metadata !47, metadata !14), !dbg !48
  call void @llvm.dbg.value(metadata i32 1, i64 0, metadata !49, metadata !14), !dbg !50
  call void @llvm.dbg.value(metadata i32 2, i64 0, metadata !51, metadata !14), !dbg !52
  %cmp = icmp sge i32 %x, 3, !dbg !53
  br i1 %cmp, label %if.then, label %if.end, !dbg !55

if.then:                                          ; preds = %entry
  %arrayidx = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !56
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %arrayidx, align 8, !dbg !58
  br label %if.end, !dbg !59

if.end:                                           ; preds = %if.then, %entry
  %cmp1 = icmp sge i32 %x, 4, !dbg !60
  br i1 %cmp1, label %if.then2, label %if.end4, !dbg !62

if.then2:                                         ; preds = %if.end
  %arrayidx3 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !63
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %arrayidx3, align 8, !dbg !65
  br label %if.end4, !dbg !66

if.end4:                                          ; preds = %if.then2, %if.end
  %cmp5 = icmp sge i32 %x, 5, !dbg !67
  br i1 %cmp5, label %if.then6, label %if.end9, !dbg !69

if.then6:                                         ; preds = %if.end4
  %arrayidx7 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !70
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx7, align 8, !dbg !70
  %arrayidx8 = getelementptr inbounds [1 x i32 (i32, i32)*], [1 x i32 (i32, i32)*]* %q_fptr, i64 0, i64 0, !dbg !72
  store i32 (i32, i32)* %0, i32 (i32, i32)** %arrayidx8, align 8, !dbg !73
  br label %if.end9, !dbg !74

if.end9:                                          ; preds = %if.then6, %if.end4
  %cmp10 = icmp sge i32 %x, 6, !dbg !75
  br i1 %cmp10, label %if.then11, label %if.end14, !dbg !77

if.then11:                                        ; preds = %if.end9
  %arrayidx12 = getelementptr inbounds [1 x i32 (i32, i32)*], [1 x i32 (i32, i32)*]* %q_fptr, i64 0, i64 0, !dbg !78
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx12, align 8, !dbg !78
  %arrayidx13 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %r_fptr, i64 0, i64 1, !dbg !79
  store i32 (i32, i32)* %1, i32 (i32, i32)** %arrayidx13, align 8, !dbg !80
  br label %if.end14, !dbg !79

if.end14:                                         ; preds = %if.then11, %if.end9
  %arrayidx15 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !81
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx15, align 8, !dbg !81
  %cmp16 = icmp ne i32 (i32, i32)* %2, null, !dbg !83
  br i1 %cmp16, label %if.then17, label %if.end19, !dbg !84

if.then17:                                        ; preds = %if.end14
  %arrayidx18 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %r_fptr, i64 0, i64 1, !dbg !85
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx18, align 8, !dbg !85
  %call = call i32 %3(i32 1, i32 2), !dbg !85
  call void @llvm.dbg.value(metadata i32 %call, i64 0, metadata !87, metadata !14), !dbg !89
  br label %if.end19, !dbg !90

if.end19:                                         ; preds = %if.then17, %if.end14
  ret i32 0, !dbg !91
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test05.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!9 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !10, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", arg: 1, scope: !9, file: !1, line: 2, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 2, column: 14, scope: !9)
!16 = !DILocalVariable(name: "b", arg: 2, scope: !9, file: !1, line: 2, type: !12)
!17 = !DILocation(line: 2, column: 21, scope: !9)
!18 = !DILocation(line: 3, column: 12, scope: !9)
!19 = !DILocation(line: 3, column: 4, scope: !9)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !10, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 6, type: !12)
!22 = !DILocation(line: 6, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 6, type: !12)
!24 = !DILocation(line: 6, column: 22, scope: !20)
!25 = !DILocation(line: 7, column: 12, scope: !20)
!26 = !DILocation(line: 7, column: 4, scope: !20)
!27 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !28, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{!12, !12}
!30 = !DILocalVariable(name: "x", arg: 1, scope: !27, file: !1, line: 10, type: !12)
!31 = !DILocation(line: 10, column: 16, scope: !27)
!32 = !DILocalVariable(name: "a_fptr", scope: !27, file: !1, line: 11, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!34 = !DILocation(line: 11, column: 11, scope: !27)
!35 = !DILocalVariable(name: "s_fptr", scope: !27, file: !1, line: 12, type: !33)
!36 = !DILocation(line: 12, column: 11, scope: !27)
!37 = !DILocalVariable(name: "t_fptr", scope: !27, file: !1, line: 13, type: !38)
!38 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 128, elements: !39)
!39 = !{!40}
!40 = !DISubrange(count: 2)
!41 = !DILocation(line: 13, column: 11, scope: !27)
!42 = !DILocalVariable(name: "q_fptr", scope: !27, file: !1, line: 14, type: !43)
!43 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 64, elements: !44)
!44 = !{!45}
!45 = !DISubrange(count: 1)
!46 = !DILocation(line: 14, column: 11, scope: !27)
!47 = !DILocalVariable(name: "r_fptr", scope: !27, file: !1, line: 15, type: !38)
!48 = !DILocation(line: 15, column: 11, scope: !27)
!49 = !DILocalVariable(name: "op1", scope: !27, file: !1, line: 17, type: !12)
!50 = !DILocation(line: 17, column: 9, scope: !27)
!51 = !DILocalVariable(name: "op2", scope: !27, file: !1, line: 17, type: !12)
!52 = !DILocation(line: 17, column: 16, scope: !27)
!53 = !DILocation(line: 19, column: 11, scope: !54)
!54 = distinct !DILexicalBlock(scope: !27, file: !1, line: 19, column: 9)
!55 = !DILocation(line: 19, column: 9, scope: !27)
!56 = !DILocation(line: 20, column: 8, scope: !57)
!57 = distinct !DILexicalBlock(scope: !54, file: !1, line: 19, column: 17)
!58 = !DILocation(line: 20, column: 18, scope: !57)
!59 = !DILocation(line: 21, column: 5, scope: !57)
!60 = !DILocation(line: 22, column: 11, scope: !61)
!61 = distinct !DILexicalBlock(scope: !27, file: !1, line: 22, column: 9)
!62 = !DILocation(line: 22, column: 9, scope: !27)
!63 = !DILocation(line: 23, column: 8, scope: !64)
!64 = distinct !DILexicalBlock(scope: !61, file: !1, line: 22, column: 17)
!65 = !DILocation(line: 23, column: 18, scope: !64)
!66 = !DILocation(line: 24, column: 5, scope: !64)
!67 = !DILocation(line: 25, column: 11, scope: !68)
!68 = distinct !DILexicalBlock(scope: !27, file: !1, line: 25, column: 9)
!69 = !DILocation(line: 25, column: 9, scope: !27)
!70 = !DILocation(line: 26, column: 20, scope: !71)
!71 = distinct !DILexicalBlock(scope: !68, file: !1, line: 25, column: 17)
!72 = !DILocation(line: 26, column: 8, scope: !71)
!73 = !DILocation(line: 26, column: 18, scope: !71)
!74 = !DILocation(line: 27, column: 5, scope: !71)
!75 = !DILocation(line: 28, column: 11, scope: !76)
!76 = distinct !DILexicalBlock(scope: !27, file: !1, line: 28, column: 9)
!77 = !DILocation(line: 28, column: 9, scope: !27)
!78 = !DILocation(line: 29, column: 20, scope: !76)
!79 = !DILocation(line: 29, column: 8, scope: !76)
!80 = !DILocation(line: 29, column: 18, scope: !76)
!81 = !DILocation(line: 32, column: 9, scope: !82)
!82 = distinct !DILexicalBlock(scope: !27, file: !1, line: 32, column: 9)
!83 = !DILocation(line: 32, column: 19, scope: !82)
!84 = !DILocation(line: 32, column: 9, scope: !27)
!85 = !DILocation(line: 33, column: 26, scope: !86)
!86 = distinct !DILexicalBlock(scope: !82, file: !1, line: 32, column: 28)
!87 = !DILocalVariable(name: "result", scope: !86, file: !1, line: 33, type: !88)
!88 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!89 = !DILocation(line: 33, column: 17, scope: !86)
!90 = !DILocation(line: 34, column: 5, scope: !86)
!91 = !DILocation(line: 35, column: 4, scope: !27)


/// 33 : plus, minus

