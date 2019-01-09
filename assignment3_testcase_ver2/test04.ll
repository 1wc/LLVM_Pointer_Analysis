; ModuleID = 'test04.bc'
source_filename = "test04.c"
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
define i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !31 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !35, metadata !14), !dbg !36
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !37, metadata !14), !dbg !38
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !39, metadata !14), !dbg !40
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !41
  %1 = load i32, i32* %a.addr, align 4, !dbg !42
  %2 = load i32, i32* %b.addr, align 4, !dbg !43
  %call = call i32 %0(i32 %1, i32 %2), !dbg !41
  ret i32 %call, !dbg !44
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32 %x) #0 !dbg !45 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  %q_fptr = alloca i32 (i32, i32)*, align 8
  %r_fptr = alloca i32 (i32, i32)*, align 8
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %op1 = alloca i32, align 4
  %op2 = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !48, metadata !14), !dbg !49
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !50, metadata !14), !dbg !51
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !51
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !52, metadata !14), !dbg !53
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !54, metadata !14), !dbg !55
  store i32 (i32, i32)* null, i32 (i32, i32)** %t_fptr, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %q_fptr, metadata !56, metadata !14), !dbg !57
  store i32 (i32, i32)* null, i32 (i32, i32)** %q_fptr, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %r_fptr, metadata !58, metadata !14), !dbg !59
  store i32 (i32, i32)* null, i32 (i32, i32)** %r_fptr, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !60, metadata !14), !dbg !62
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i32* %op1, metadata !63, metadata !14), !dbg !64
  store i32 1, i32* %op1, align 4, !dbg !64
  call void @llvm.dbg.declare(metadata i32* %op2, metadata !65, metadata !14), !dbg !66
  store i32 2, i32* %op2, align 4, !dbg !66
  %0 = load i32, i32* %x.addr, align 4, !dbg !67
  %cmp = icmp sge i32 %0, 4, !dbg !69
  br i1 %cmp, label %if.then, label %if.end, !dbg !70

if.then:                                          ; preds = %entry
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !71
  store i32 (i32, i32)* %1, i32 (i32, i32)** %t_fptr, align 8, !dbg !73
  br label %if.end, !dbg !74

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !75
  %3 = load i32, i32* %op1, align 4, !dbg !76
  %4 = load i32, i32* %op2, align 4, !dbg !77
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !78
  %call = call i32 %2(i32 %3, i32 %4, i32 (i32, i32)* %5), !dbg !75
  %6 = load i32, i32* %x.addr, align 4, !dbg !79
  %cmp1 = icmp sge i32 %6, 5, !dbg !81
  br i1 %cmp1, label %if.then2, label %if.end3, !dbg !82

if.then2:                                         ; preds = %if.end
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !83
  store i32 (i32, i32)* %7, i32 (i32, i32)** %t_fptr, align 8, !dbg !85
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !86
  store i32 (i32, i32)* %8, i32 (i32, i32)** %q_fptr, align 8, !dbg !87
  br label %if.end3, !dbg !88

if.end3:                                          ; preds = %if.then2, %if.end
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !89
  %cmp4 = icmp ne i32 (i32, i32)* %9, null, !dbg !91
  br i1 %cmp4, label %if.then5, label %if.end7, !dbg !92

if.then5:                                         ; preds = %if.end3
  call void @llvm.dbg.declare(metadata i32* %result, metadata !93, metadata !14), !dbg !96
  %10 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !97
  %11 = load i32, i32* %op1, align 4, !dbg !98
  %12 = load i32, i32* %op2, align 4, !dbg !99
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %q_fptr, align 8, !dbg !100
  %call6 = call i32 %10(i32 %11, i32 %12, i32 (i32, i32)* %13), !dbg !97
  store i32 %call6, i32* %result, align 4, !dbg !96
  br label %if.end7, !dbg !101

if.end7:                                          ; preds = %if.then5, %if.end3
  ret i32 0, !dbg !102
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test04.c", directory: "/home/liwc/compile/assignment3_testcase_ver2")
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
!31 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !32, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!12, !12, !12, !34}
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!35 = !DILocalVariable(name: "a", arg: 1, scope: !31, file: !1, line: 9, type: !12)
!36 = !DILocation(line: 9, column: 13, scope: !31)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !31, file: !1, line: 9, type: !12)
!38 = !DILocation(line: 9, column: 20, scope: !31)
!39 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !31, file: !1, line: 9, type: !34)
!40 = !DILocation(line: 9, column: 29, scope: !31)
!41 = !DILocation(line: 10, column: 12, scope: !31)
!42 = !DILocation(line: 10, column: 19, scope: !31)
!43 = !DILocation(line: 10, column: 22, scope: !31)
!44 = !DILocation(line: 10, column: 5, scope: !31)
!45 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !46, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!12, !12}
!48 = !DILocalVariable(name: "x", arg: 1, scope: !45, file: !1, line: 13, type: !12)
!49 = !DILocation(line: 13, column: 16, scope: !45)
!50 = !DILocalVariable(name: "a_fptr", scope: !45, file: !1, line: 14, type: !34)
!51 = !DILocation(line: 14, column: 11, scope: !45)
!52 = !DILocalVariable(name: "s_fptr", scope: !45, file: !1, line: 15, type: !34)
!53 = !DILocation(line: 15, column: 11, scope: !45)
!54 = !DILocalVariable(name: "t_fptr", scope: !45, file: !1, line: 16, type: !34)
!55 = !DILocation(line: 16, column: 11, scope: !45)
!56 = !DILocalVariable(name: "q_fptr", scope: !45, file: !1, line: 17, type: !34)
!57 = !DILocation(line: 17, column: 11, scope: !45)
!58 = !DILocalVariable(name: "r_fptr", scope: !45, file: !1, line: 18, type: !34)
!59 = !DILocation(line: 18, column: 11, scope: !45)
!60 = !DILocalVariable(name: "af_ptr", scope: !45, file: !1, line: 19, type: !61)
!61 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!62 = !DILocation(line: 19, column: 11, scope: !45)
!63 = !DILocalVariable(name: "op1", scope: !45, file: !1, line: 21, type: !12)
!64 = !DILocation(line: 21, column: 9, scope: !45)
!65 = !DILocalVariable(name: "op2", scope: !45, file: !1, line: 21, type: !12)
!66 = !DILocation(line: 21, column: 16, scope: !45)
!67 = !DILocation(line: 23, column: 9, scope: !68)
!68 = distinct !DILexicalBlock(scope: !45, file: !1, line: 23, column: 9)
!69 = !DILocation(line: 23, column: 11, scope: !68)
!70 = !DILocation(line: 23, column: 9, scope: !45)
!71 = !DILocation(line: 24, column: 17, scope: !72)
!72 = distinct !DILexicalBlock(scope: !68, file: !1, line: 23, column: 17)
!73 = !DILocation(line: 24, column: 15, scope: !72)
!74 = !DILocation(line: 25, column: 5, scope: !72)
!75 = !DILocation(line: 26, column: 5, scope: !45)
!76 = !DILocation(line: 26, column: 12, scope: !45)
!77 = !DILocation(line: 26, column: 16, scope: !45)
!78 = !DILocation(line: 26, column: 20, scope: !45)
!79 = !DILocation(line: 27, column: 9, scope: !80)
!80 = distinct !DILexicalBlock(scope: !45, file: !1, line: 27, column: 9)
!81 = !DILocation(line: 27, column: 11, scope: !80)
!82 = !DILocation(line: 27, column: 9, scope: !45)
!83 = !DILocation(line: 28, column: 17, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !1, line: 27, column: 17)
!85 = !DILocation(line: 28, column: 15, scope: !84)
!86 = !DILocation(line: 29, column: 17, scope: !84)
!87 = !DILocation(line: 29, column: 15, scope: !84)
!88 = !DILocation(line: 30, column: 5, scope: !84)
!89 = !DILocation(line: 32, column: 9, scope: !90)
!90 = distinct !DILexicalBlock(scope: !45, file: !1, line: 32, column: 9)
!91 = !DILocation(line: 32, column: 16, scope: !90)
!92 = !DILocation(line: 32, column: 9, scope: !45)
!93 = !DILocalVariable(name: "result", scope: !94, file: !1, line: 33, type: !95)
!94 = distinct !DILexicalBlock(scope: !90, file: !1, line: 32, column: 25)
!95 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!96 = !DILocation(line: 33, column: 17, scope: !94)
!97 = !DILocation(line: 33, column: 26, scope: !94)
!98 = !DILocation(line: 33, column: 33, scope: !94)
!99 = !DILocation(line: 33, column: 37, scope: !94)
!100 = !DILocation(line: 33, column: 41, scope: !94)
!101 = !DILocation(line: 34, column: 5, scope: !94)
!102 = !DILocation(line: 35, column: 4, scope: !45)
