; ModuleID = 'test05.bc'
source_filename = "test05.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !9 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !13, metadata !14), !dbg !15
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !16, metadata !14), !dbg !17
  %0 = load i32, i32* %a.addr, align 4, !dbg !18
  %1 = load i32, i32* %b.addr, align 4, !dbg !19
  %add = add nsw i32 %0, %1, !dbg !20
  ret i32 %add, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !22 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !23, metadata !14), !dbg !24
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !25, metadata !14), !dbg !26
  %0 = load i32, i32* %a.addr, align 4, !dbg !27
  %1 = load i32, i32* %b.addr, align 4, !dbg !28
  %sub = sub nsw i32 %0, %1, !dbg !29
  ret i32 %sub, !dbg !30
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32 %x) #0 !dbg !31 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca [2 x i32 (i32, i32)*], align 16
  %q_fptr = alloca [1 x i32 (i32, i32)*], align 8
  %r_fptr = alloca [2 x i32 (i32, i32)*], align 16
  %op1 = alloca i32, align 4
  %op2 = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !34, metadata !14), !dbg !35
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !36, metadata !14), !dbg !38
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !39, metadata !14), !dbg !40
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %t_fptr, metadata !41, metadata !14), !dbg !45
  call void @llvm.dbg.declare(metadata [1 x i32 (i32, i32)*]* %q_fptr, metadata !46, metadata !14), !dbg !50
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %r_fptr, metadata !51, metadata !14), !dbg !52
  call void @llvm.dbg.declare(metadata i32* %op1, metadata !53, metadata !14), !dbg !54
  store i32 1, i32* %op1, align 4, !dbg !54
  call void @llvm.dbg.declare(metadata i32* %op2, metadata !55, metadata !14), !dbg !56
  store i32 2, i32* %op2, align 4, !dbg !56
  %0 = load i32, i32* %x.addr, align 4, !dbg !57
  %cmp = icmp sge i32 %0, 3, !dbg !59
  br i1 %cmp, label %if.then, label %if.end, !dbg !60

if.then:                                          ; preds = %entry
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !61
  %arrayidx = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !63
  store i32 (i32, i32)* %1, i32 (i32, i32)** %arrayidx, align 8, !dbg !64
  br label %if.end, !dbg !65

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32, i32* %x.addr, align 4, !dbg !66
  %cmp1 = icmp sge i32 %2, 4, !dbg !68
  br i1 %cmp1, label %if.then2, label %if.end4, !dbg !69

if.then2:                                         ; preds = %if.end
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !70
  %arrayidx3 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !72
  store i32 (i32, i32)* %3, i32 (i32, i32)** %arrayidx3, align 8, !dbg !73
  br label %if.end4, !dbg !74

if.end4:                                          ; preds = %if.then2, %if.end
  %4 = load i32, i32* %x.addr, align 4, !dbg !75
  %cmp5 = icmp sge i32 %4, 5, !dbg !77
  br i1 %cmp5, label %if.then6, label %if.end9, !dbg !78

if.then6:                                         ; preds = %if.end4
  %arrayidx7 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !79
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx7, align 8, !dbg !79
  %arrayidx8 = getelementptr inbounds [1 x i32 (i32, i32)*], [1 x i32 (i32, i32)*]* %q_fptr, i64 0, i64 0, !dbg !81
  store i32 (i32, i32)* %5, i32 (i32, i32)** %arrayidx8, align 8, !dbg !82
  br label %if.end9, !dbg !83

if.end9:                                          ; preds = %if.then6, %if.end4
  %6 = load i32, i32* %x.addr, align 4, !dbg !84
  %cmp10 = icmp sge i32 %6, 6, !dbg !86
  br i1 %cmp10, label %if.then11, label %if.end14, !dbg !87

if.then11:                                        ; preds = %if.end9
  %arrayidx12 = getelementptr inbounds [1 x i32 (i32, i32)*], [1 x i32 (i32, i32)*]* %q_fptr, i64 0, i64 0, !dbg !88
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx12, align 8, !dbg !88
  %arrayidx13 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %r_fptr, i64 0, i64 1, !dbg !89
  store i32 (i32, i32)* %7, i32 (i32, i32)** %arrayidx13, align 8, !dbg !90
  br label %if.end14, !dbg !89

if.end14:                                         ; preds = %if.then11, %if.end9
  %arrayidx15 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !91
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx15, align 8, !dbg !91
  %cmp16 = icmp ne i32 (i32, i32)* %8, null, !dbg !93
  br i1 %cmp16, label %if.then17, label %if.end19, !dbg !94

if.then17:                                        ; preds = %if.end14
  call void @llvm.dbg.declare(metadata i32* %result, metadata !95, metadata !14), !dbg !98
  %arrayidx18 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %r_fptr, i64 0, i64 1, !dbg !99
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx18, align 8, !dbg !99
  %10 = load i32, i32* %op1, align 4, !dbg !100
  %11 = load i32, i32* %op2, align 4, !dbg !101
  %call = call i32 %9(i32 %10, i32 %11), !dbg !99
  store i32 %call, i32* %result, align 4, !dbg !98
  br label %if.end19, !dbg !102

if.end19:                                         ; preds = %if.then17, %if.end14
  ret i32 0, !dbg !103
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test05.c", directory: "/home/liwc/compile/assignment3_testcase_ver2")
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
!18 = !DILocation(line: 3, column: 11, scope: !9)
!19 = !DILocation(line: 3, column: 13, scope: !9)
!20 = !DILocation(line: 3, column: 12, scope: !9)
!21 = !DILocation(line: 3, column: 4, scope: !9)
!22 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !10, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 6, type: !12)
!24 = !DILocation(line: 6, column: 15, scope: !22)
!25 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 6, type: !12)
!26 = !DILocation(line: 6, column: 22, scope: !22)
!27 = !DILocation(line: 7, column: 11, scope: !22)
!28 = !DILocation(line: 7, column: 13, scope: !22)
!29 = !DILocation(line: 7, column: 12, scope: !22)
!30 = !DILocation(line: 7, column: 4, scope: !22)
!31 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !32, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!12, !12}
!34 = !DILocalVariable(name: "x", arg: 1, scope: !31, file: !1, line: 10, type: !12)
!35 = !DILocation(line: 10, column: 16, scope: !31)
!36 = !DILocalVariable(name: "a_fptr", scope: !31, file: !1, line: 11, type: !37)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!38 = !DILocation(line: 11, column: 11, scope: !31)
!39 = !DILocalVariable(name: "s_fptr", scope: !31, file: !1, line: 12, type: !37)
!40 = !DILocation(line: 12, column: 11, scope: !31)
!41 = !DILocalVariable(name: "t_fptr", scope: !31, file: !1, line: 13, type: !42)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 128, elements: !43)
!43 = !{!44}
!44 = !DISubrange(count: 2)
!45 = !DILocation(line: 13, column: 11, scope: !31)
!46 = !DILocalVariable(name: "q_fptr", scope: !31, file: !1, line: 14, type: !47)
!47 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 64, elements: !48)
!48 = !{!49}
!49 = !DISubrange(count: 1)
!50 = !DILocation(line: 14, column: 11, scope: !31)
!51 = !DILocalVariable(name: "r_fptr", scope: !31, file: !1, line: 15, type: !42)
!52 = !DILocation(line: 15, column: 11, scope: !31)
!53 = !DILocalVariable(name: "op1", scope: !31, file: !1, line: 17, type: !12)
!54 = !DILocation(line: 17, column: 9, scope: !31)
!55 = !DILocalVariable(name: "op2", scope: !31, file: !1, line: 17, type: !12)
!56 = !DILocation(line: 17, column: 16, scope: !31)
!57 = !DILocation(line: 19, column: 9, scope: !58)
!58 = distinct !DILexicalBlock(scope: !31, file: !1, line: 19, column: 9)
!59 = !DILocation(line: 19, column: 11, scope: !58)
!60 = !DILocation(line: 19, column: 9, scope: !31)
!61 = !DILocation(line: 20, column: 20, scope: !62)
!62 = distinct !DILexicalBlock(scope: !58, file: !1, line: 19, column: 17)
!63 = !DILocation(line: 20, column: 8, scope: !62)
!64 = !DILocation(line: 20, column: 18, scope: !62)
!65 = !DILocation(line: 21, column: 5, scope: !62)
!66 = !DILocation(line: 22, column: 9, scope: !67)
!67 = distinct !DILexicalBlock(scope: !31, file: !1, line: 22, column: 9)
!68 = !DILocation(line: 22, column: 11, scope: !67)
!69 = !DILocation(line: 22, column: 9, scope: !31)
!70 = !DILocation(line: 23, column: 20, scope: !71)
!71 = distinct !DILexicalBlock(scope: !67, file: !1, line: 22, column: 17)
!72 = !DILocation(line: 23, column: 8, scope: !71)
!73 = !DILocation(line: 23, column: 18, scope: !71)
!74 = !DILocation(line: 24, column: 5, scope: !71)
!75 = !DILocation(line: 25, column: 9, scope: !76)
!76 = distinct !DILexicalBlock(scope: !31, file: !1, line: 25, column: 9)
!77 = !DILocation(line: 25, column: 11, scope: !76)
!78 = !DILocation(line: 25, column: 9, scope: !31)
!79 = !DILocation(line: 26, column: 20, scope: !80)
!80 = distinct !DILexicalBlock(scope: !76, file: !1, line: 25, column: 17)
!81 = !DILocation(line: 26, column: 8, scope: !80)
!82 = !DILocation(line: 26, column: 18, scope: !80)
!83 = !DILocation(line: 27, column: 5, scope: !80)
!84 = !DILocation(line: 28, column: 9, scope: !85)
!85 = distinct !DILexicalBlock(scope: !31, file: !1, line: 28, column: 9)
!86 = !DILocation(line: 28, column: 11, scope: !85)
!87 = !DILocation(line: 28, column: 9, scope: !31)
!88 = !DILocation(line: 29, column: 20, scope: !85)
!89 = !DILocation(line: 29, column: 8, scope: !85)
!90 = !DILocation(line: 29, column: 18, scope: !85)
!91 = !DILocation(line: 32, column: 9, scope: !92)
!92 = distinct !DILexicalBlock(scope: !31, file: !1, line: 32, column: 9)
!93 = !DILocation(line: 32, column: 19, scope: !92)
!94 = !DILocation(line: 32, column: 9, scope: !31)
!95 = !DILocalVariable(name: "result", scope: !96, file: !1, line: 33, type: !97)
!96 = distinct !DILexicalBlock(scope: !92, file: !1, line: 32, column: 28)
!97 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!98 = !DILocation(line: 33, column: 17, scope: !96)
!99 = !DILocation(line: 33, column: 26, scope: !96)
!100 = !DILocation(line: 33, column: 36, scope: !96)
!101 = !DILocation(line: 33, column: 41, scope: !96)
!102 = !DILocation(line: 34, column: 5, scope: !96)
!103 = !DILocation(line: 35, column: 4, scope: !31)
