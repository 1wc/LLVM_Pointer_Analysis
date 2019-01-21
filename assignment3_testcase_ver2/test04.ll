; ModuleID = 'test04.bc'
source_filename = "test04.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32, i32) #0 !dbg !9 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !13, metadata !14), !dbg !15
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !16, metadata !14), !dbg !17
  %5 = load i32, i32* %3, align 4, !dbg !18
  %6 = load i32, i32* %4, align 4, !dbg !19
  %7 = add nsw i32 %5, %6, !dbg !20
  ret i32 %7, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32, i32) #0 !dbg !22 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !23, metadata !14), !dbg !24
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !25, metadata !14), !dbg !26
  %5 = load i32, i32* %3, align 4, !dbg !27
  %6 = load i32, i32* %4, align 4, !dbg !28
  %7 = sub nsw i32 %5, %6, !dbg !29
  ret i32 %7, !dbg !30
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32, i32, i32 (i32, i32)*) #0 !dbg !31 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32 (i32, i32)*, align 8
  store i32 %0, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !35, metadata !14), !dbg !36
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !37, metadata !14), !dbg !38
  store i32 (i32, i32)* %2, i32 (i32, i32)** %6, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %6, metadata !39, metadata !14), !dbg !40
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !41
  %8 = load i32, i32* %4, align 4, !dbg !42
  %9 = load i32, i32* %5, align 4, !dbg !43
  %10 = call i32 %7(i32 %8, i32 %9), !dbg !41
  ret i32 %10, !dbg !44
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32) #0 !dbg !45 {
  %2 = alloca i32, align 4
  %3 = alloca i32 (i32, i32)*, align 8
  %4 = alloca i32 (i32, i32)*, align 8
  %5 = alloca i32 (i32, i32)*, align 8
  %6 = alloca i32 (i32, i32)*, align 8
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !48, metadata !14), !dbg !49
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %3, metadata !50, metadata !14), !dbg !51
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %3, align 8, !dbg !51
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %4, metadata !52, metadata !14), !dbg !53
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %4, align 8, !dbg !53
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %5, metadata !54, metadata !14), !dbg !55
  store i32 (i32, i32)* null, i32 (i32, i32)** %5, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %6, metadata !56, metadata !14), !dbg !57
  store i32 (i32, i32)* null, i32 (i32, i32)** %6, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !58, metadata !14), !dbg !59
  store i32 (i32, i32)* null, i32 (i32, i32)** %7, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %8, metadata !60, metadata !14), !dbg !62
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %8, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i32* %9, metadata !63, metadata !14), !dbg !64
  store i32 1, i32* %9, align 4, !dbg !64
  call void @llvm.dbg.declare(metadata i32* %10, metadata !65, metadata !14), !dbg !66
  store i32 2, i32* %10, align 4, !dbg !66
  %12 = load i32, i32* %2, align 4, !dbg !67
  %13 = icmp sge i32 %12, 4, !dbg !69
  br i1 %13, label %14, label %16, !dbg !70

; <label>:14:                                     ; preds = %1
  %15 = load i32 (i32, i32)*, i32 (i32, i32)** %4, align 8, !dbg !71
  store i32 (i32, i32)* %15, i32 (i32, i32)** %5, align 8, !dbg !73
  br label %16, !dbg !74

; <label>:16:                                     ; preds = %14, %1
  %17 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %8, align 8, !dbg !75
  %18 = load i32, i32* %9, align 4, !dbg !76
  %19 = load i32, i32* %10, align 4, !dbg !77
  %20 = load i32 (i32, i32)*, i32 (i32, i32)** %5, align 8, !dbg !78
  %21 = call i32 %17(i32 %18, i32 %19, i32 (i32, i32)* %20), !dbg !75
  %22 = load i32, i32* %2, align 4, !dbg !79
  %23 = icmp sge i32 %22, 5, !dbg !81
  br i1 %23, label %24, label %27, !dbg !82

; <label>:24:                                     ; preds = %16
  %25 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !83
  store i32 (i32, i32)* %25, i32 (i32, i32)** %5, align 8, !dbg !85
  %26 = load i32 (i32, i32)*, i32 (i32, i32)** %5, align 8, !dbg !86
  store i32 (i32, i32)* %26, i32 (i32, i32)** %6, align 8, !dbg !87
  br label %27, !dbg !88

; <label>:27:                                     ; preds = %24, %16
  %28 = load i32 (i32, i32)*, i32 (i32, i32)** %5, align 8, !dbg !89
  %29 = icmp ne i32 (i32, i32)* %28, null, !dbg !91
  br i1 %29, label %30, label %36, !dbg !92

; <label>:30:                                     ; preds = %27
  call void @llvm.dbg.declare(metadata i32* %11, metadata !93, metadata !14), !dbg !96
  %31 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %8, align 8, !dbg !97
  %32 = load i32, i32* %9, align 4, !dbg !98
  %33 = load i32, i32* %10, align 4, !dbg !99
  %34 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !100
  %35 = call i32 %31(i32 %32, i32 %33, i32 (i32, i32)* %34), !dbg !97
  store i32 %35, i32* %11, align 4, !dbg !96
  br label %36, !dbg !101

; <label>:36:                                     ; preds = %30, %27
  ret i32 0, !dbg !102
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test04.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
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
