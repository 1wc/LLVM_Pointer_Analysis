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

int clever(int x) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    struct fptr t_fptr={0};

    int op1=1, op2=2;

    if (x == 3) {
       t_fptr.p_fptr = a_fptr;
    } else {
       t_fptr.p_fptr = s_fptr;
    }

    if (t_fptr.p_fptr != NULL) {
       unsigned result = t_fptr.p_fptr(op1, op2);
    }  
   return 0;
}

/// 28 : plus, minus
; ModuleID = 'test02.bc'
source_filename = "test02.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

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
  %t_fptr = alloca %struct.fptr, align 8
  call void @llvm.dbg.value(metadata i32 %x, i64 0, metadata !30, metadata !14), !dbg !31
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !32, metadata !14), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !35, metadata !14), !dbg !36
  call void @llvm.dbg.declare(metadata %struct.fptr* %t_fptr, metadata !37, metadata !14), !dbg !41
  %0 = bitcast %struct.fptr* %t_fptr to i8*, !dbg !41
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8, i32 8, i1 false), !dbg !41
  call void @llvm.dbg.value(metadata i32 1, i64 0, metadata !42, metadata !14), !dbg !43
  call void @llvm.dbg.value(metadata i32 2, i64 0, metadata !44, metadata !14), !dbg !45
  %cmp = icmp eq i32 %x, 3, !dbg !46
  br i1 %cmp, label %if.then, label %if.else, !dbg !48

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !49
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !51
  br label %if.end, !dbg !52

if.else:                                          ; preds = %entry
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !53
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !55
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !56
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !56
  %cmp3 = icmp ne i32 (i32, i32)* %1, null, !dbg !58
  br i1 %cmp3, label %if.then4, label %if.end6, !dbg !59

if.then4:                                         ; preds = %if.end
  %p_fptr5 = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !60
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr5, align 8, !dbg !60
  %call = call i32 %2(i32 1, i32 2), !dbg !62
  call void @llvm.dbg.value(metadata i32 %call, i64 0, metadata !63, metadata !14), !dbg !65
  br label %if.end6, !dbg !66

if.end6:                                          ; preds = %if.then4, %if.end
  ret i32 0, !dbg !67
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test02.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!9 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 6, type: !10, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", arg: 1, scope: !9, file: !1, line: 6, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 6, column: 14, scope: !9)
!16 = !DILocalVariable(name: "b", arg: 2, scope: !9, file: !1, line: 6, type: !12)
!17 = !DILocation(line: 6, column: 21, scope: !9)
!18 = !DILocation(line: 7, column: 12, scope: !9)
!19 = !DILocation(line: 7, column: 4, scope: !9)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 10, type: !10, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !12)
!22 = !DILocation(line: 10, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !12)
!24 = !DILocation(line: 10, column: 22, scope: !20)
!25 = !DILocation(line: 11, column: 12, scope: !20)
!26 = !DILocation(line: 11, column: 4, scope: !20)
!27 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !28, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!28 = !DISubroutineType(types: !29)
!29 = !{!12, !12}
!30 = !DILocalVariable(name: "x", arg: 1, scope: !27, file: !1, line: 14, type: !12)
!31 = !DILocation(line: 14, column: 16, scope: !27)
!32 = !DILocalVariable(name: "a_fptr", scope: !27, file: !1, line: 15, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!34 = !DILocation(line: 15, column: 11, scope: !27)
!35 = !DILocalVariable(name: "s_fptr", scope: !27, file: !1, line: 16, type: !33)
!36 = !DILocation(line: 16, column: 11, scope: !27)
!37 = !DILocalVariable(name: "t_fptr", scope: !27, file: !1, line: 17, type: !38)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !39)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !38, file: !1, line: 4, baseType: !33, size: 64)
!41 = !DILocation(line: 17, column: 17, scope: !27)
!42 = !DILocalVariable(name: "op1", scope: !27, file: !1, line: 19, type: !12)
!43 = !DILocation(line: 19, column: 9, scope: !27)
!44 = !DILocalVariable(name: "op2", scope: !27, file: !1, line: 19, type: !12)
!45 = !DILocation(line: 19, column: 16, scope: !27)
!46 = !DILocation(line: 21, column: 11, scope: !47)
!47 = distinct !DILexicalBlock(scope: !27, file: !1, line: 21, column: 9)
!48 = !DILocation(line: 21, column: 9, scope: !27)
!49 = !DILocation(line: 22, column: 15, scope: !50)
!50 = distinct !DILexicalBlock(scope: !47, file: !1, line: 21, column: 17)
!51 = !DILocation(line: 22, column: 22, scope: !50)
!52 = !DILocation(line: 23, column: 5, scope: !50)
!53 = !DILocation(line: 24, column: 15, scope: !54)
!54 = distinct !DILexicalBlock(scope: !47, file: !1, line: 23, column: 12)
!55 = !DILocation(line: 24, column: 22, scope: !54)
!56 = !DILocation(line: 27, column: 16, scope: !57)
!57 = distinct !DILexicalBlock(scope: !27, file: !1, line: 27, column: 9)
!58 = !DILocation(line: 27, column: 23, scope: !57)
!59 = !DILocation(line: 27, column: 9, scope: !27)
!60 = !DILocation(line: 28, column: 33, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 27, column: 32)
!62 = !DILocation(line: 28, column: 26, scope: !61)
!63 = !DILocalVariable(name: "result", scope: !61, file: !1, line: 28, type: !64)
!64 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!65 = !DILocation(line: 28, column: 17, scope: !61)
!66 = !DILocation(line: 29, column: 5, scope: !61)
!67 = !DILocation(line: 30, column: 4, scope: !27)