; ModuleID = 'test15.bc'
source_filename = "test15.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32, i32) #0 !dbg !7 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !11, metadata !12), !dbg !13
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !14, metadata !12), !dbg !15
  %5 = load i32, i32* %3, align 4, !dbg !16
  %6 = load i32, i32* %4, align 4, !dbg !17
  %7 = add nsw i32 %5, %6, !dbg !18
  ret i32 %7, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32, i32) #0 !dbg !20 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !21, metadata !12), !dbg !22
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !23, metadata !12), !dbg !24
  %5 = load i32, i32* %3, align 4, !dbg !25
  %6 = load i32, i32* %4, align 4, !dbg !26
  %7 = sub nsw i32 %5, %6, !dbg !27
  ret i32 %7, !dbg !28
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32, i32, i32 (i32, i32)*, i32 (i32, i32)*) #0 !dbg !29 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32)*, align 8
  %9 = alloca i32 (i32, i32)*, align 8
  store i32 %0, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !33, metadata !12), !dbg !34
  store i32 %1, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !35, metadata !12), !dbg !36
  store i32 (i32, i32)* %2, i32 (i32, i32)** %7, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !37, metadata !12), !dbg !38
  store i32 (i32, i32)* %3, i32 (i32, i32)** %8, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %8, metadata !39, metadata !12), !dbg !40
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %9, metadata !41, metadata !12), !dbg !42
  %10 = load i32, i32* %5, align 4, !dbg !43
  %11 = icmp sgt i32 %10, 0, !dbg !45
  br i1 %11, label %12, label %14, !dbg !46

; <label>:12:                                     ; preds = %4
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !47
  store i32 (i32, i32)* %13, i32 (i32, i32)** %9, align 8, !dbg !48
  br label %16, !dbg !49

; <label>:14:                                     ; preds = %4
  %15 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !50
  store i32 (i32, i32)* %15, i32 (i32, i32)** %9, align 8, !dbg !51
  br label %16

; <label>:16:                                     ; preds = %14, %12
  %17 = load i32 (i32, i32)*, i32 (i32, i32)** %9, align 8, !dbg !52
  %18 = load i32, i32* %5, align 4, !dbg !53
  %19 = load i32, i32* %6, align 4, !dbg !54
  %20 = call i32 %17(i32 %18, i32 %19), !dbg !52
  ret i32 %20, !dbg !55
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32, i32, i32 (i32, i32)*, i32 (i32, i32)*) #0 !dbg !56 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32)*, align 8
  store i32 %0, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !57, metadata !12), !dbg !58
  store i32 %1, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !59, metadata !12), !dbg !60
  store i32 (i32, i32)* %2, i32 (i32, i32)** %7, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !61, metadata !12), !dbg !62
  store i32 (i32, i32)* %3, i32 (i32, i32)** %8, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %8, metadata !63, metadata !12), !dbg !64
  %9 = load i32, i32* %5, align 4, !dbg !65
  %10 = load i32, i32* %6, align 4, !dbg !66
  %11 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !67
  %12 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !68
  %13 = call i32 @foo(i32 %9, i32 %10, i32 (i32, i32)* %11, i32 (i32, i32)* %12), !dbg !69
  ret i32 %13, !dbg !70
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !71 {
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32)*, align 8
  %9 = alloca i32 (i32, i32)*, align 8
  %10 = alloca i32, align 4
  store i8 %0, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !75, metadata !12), !dbg !76
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !77, metadata !12), !dbg !78
  store i32 %2, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !79, metadata !12), !dbg !80
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !81, metadata !12), !dbg !82
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %7, align 8, !dbg !82
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %8, metadata !83, metadata !12), !dbg !84
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %8, align 8, !dbg !84
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %9, metadata !85, metadata !12), !dbg !86
  store i32 (i32, i32)* null, i32 (i32, i32)** %9, align 8, !dbg !86
  %11 = load i8, i8* %4, align 1, !dbg !87
  %12 = sext i8 %11 to i32, !dbg !87
  %13 = icmp eq i32 %12, 43, !dbg !89
  br i1 %13, label %14, label %16, !dbg !90

; <label>:14:                                     ; preds = %3
  %15 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !91
  store i32 (i32, i32)* %15, i32 (i32, i32)** %9, align 8, !dbg !93
  br label %23, !dbg !94

; <label>:16:                                     ; preds = %3
  %17 = load i8, i8* %4, align 1, !dbg !95
  %18 = sext i8 %17 to i32, !dbg !95
  %19 = icmp eq i32 %18, 45, !dbg !97
  br i1 %19, label %20, label %22, !dbg !98

; <label>:20:                                     ; preds = %16
  %21 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !99
  store i32 (i32, i32)* %21, i32 (i32, i32)** %9, align 8, !dbg !101
  br label %22, !dbg !102

; <label>:22:                                     ; preds = %20, %16
  br label %23

; <label>:23:                                     ; preds = %22, %14
  call void @llvm.dbg.declare(metadata i32* %10, metadata !103, metadata !12), !dbg !105
  %24 = load i32, i32* %5, align 4, !dbg !106
  %25 = load i32, i32* %6, align 4, !dbg !107
  %26 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !108
  %27 = load i32 (i32, i32)*, i32 (i32, i32)** %9, align 8, !dbg !109
  %28 = call i32 @clever(i32 %24, i32 %25, i32 (i32, i32)* %26, i32 (i32, i32)* %27), !dbg !110
  store i32 %28, i32* %10, align 4, !dbg !105
  ret i32 0, !dbg !111
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test15.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 1, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 1, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 1, type: !10)
!15 = !DILocation(line: 1, column: 21, scope: !7)
!16 = !DILocation(line: 2, column: 11, scope: !7)
!17 = !DILocation(line: 2, column: 13, scope: !7)
!18 = !DILocation(line: 2, column: 12, scope: !7)
!19 = !DILocation(line: 2, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 5, type: !10)
!22 = !DILocation(line: 5, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 5, type: !10)
!24 = !DILocation(line: 5, column: 22, scope: !20)
!25 = !DILocation(line: 6, column: 11, scope: !20)
!26 = !DILocation(line: 6, column: 13, scope: !20)
!27 = !DILocation(line: 6, column: 12, scope: !20)
!28 = !DILocation(line: 6, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !30, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !32, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 9, type: !10)
!34 = !DILocation(line: 9, column: 13, scope: !29)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 9, type: !10)
!36 = !DILocation(line: 9, column: 20, scope: !29)
!37 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 9, type: !32)
!38 = !DILocation(line: 9, column: 29, scope: !29)
!39 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !29, file: !1, line: 9, type: !32)
!40 = !DILocation(line: 9, column: 53, scope: !29)
!41 = !DILocalVariable(name: "s_fptr", scope: !29, file: !1, line: 10, type: !32)
!42 = !DILocation(line: 10, column: 10, scope: !29)
!43 = !DILocation(line: 11, column: 8, scope: !44)
!44 = distinct !DILexicalBlock(scope: !29, file: !1, line: 11, column: 8)
!45 = !DILocation(line: 11, column: 10, scope: !44)
!46 = !DILocation(line: 11, column: 8, scope: !29)
!47 = !DILocation(line: 12, column: 16, scope: !44)
!48 = !DILocation(line: 12, column: 14, scope: !44)
!49 = !DILocation(line: 12, column: 7, scope: !44)
!50 = !DILocation(line: 14, column: 16, scope: !44)
!51 = !DILocation(line: 14, column: 14, scope: !44)
!52 = !DILocation(line: 15, column: 11, scope: !29)
!53 = !DILocation(line: 15, column: 18, scope: !29)
!54 = !DILocation(line: 15, column: 21, scope: !29)
!55 = !DILocation(line: 15, column: 4, scope: !29)
!56 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 18, type: !30, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!57 = !DILocalVariable(name: "a", arg: 1, scope: !56, file: !1, line: 18, type: !10)
!58 = !DILocation(line: 18, column: 16, scope: !56)
!59 = !DILocalVariable(name: "b", arg: 2, scope: !56, file: !1, line: 18, type: !10)
!60 = !DILocation(line: 18, column: 23, scope: !56)
!61 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !56, file: !1, line: 18, type: !32)
!62 = !DILocation(line: 18, column: 32, scope: !56)
!63 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !56, file: !1, line: 18, type: !32)
!64 = !DILocation(line: 18, column: 56, scope: !56)
!65 = !DILocation(line: 19, column: 16, scope: !56)
!66 = !DILocation(line: 19, column: 19, scope: !56)
!67 = !DILocation(line: 19, column: 22, scope: !56)
!68 = !DILocation(line: 19, column: 30, scope: !56)
!69 = !DILocation(line: 19, column: 12, scope: !56)
!70 = !DILocation(line: 19, column: 5, scope: !56)
!71 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 23, type: !72, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!72 = !DISubroutineType(types: !73)
!73 = !{!10, !74, !10, !10}
!74 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!75 = !DILocalVariable(name: "x", arg: 1, scope: !71, file: !1, line: 23, type: !74)
!76 = !DILocation(line: 23, column: 14, scope: !71)
!77 = !DILocalVariable(name: "op1", arg: 2, scope: !71, file: !1, line: 23, type: !10)
!78 = !DILocation(line: 23, column: 21, scope: !71)
!79 = !DILocalVariable(name: "op2", arg: 3, scope: !71, file: !1, line: 23, type: !10)
!80 = !DILocation(line: 23, column: 30, scope: !71)
!81 = !DILocalVariable(name: "a_fptr", scope: !71, file: !1, line: 24, type: !32)
!82 = !DILocation(line: 24, column: 11, scope: !71)
!83 = !DILocalVariable(name: "s_fptr", scope: !71, file: !1, line: 25, type: !32)
!84 = !DILocation(line: 25, column: 11, scope: !71)
!85 = !DILocalVariable(name: "t_fptr", scope: !71, file: !1, line: 26, type: !32)
!86 = !DILocation(line: 26, column: 11, scope: !71)
!87 = !DILocation(line: 28, column: 9, scope: !88)
!88 = distinct !DILexicalBlock(scope: !71, file: !1, line: 28, column: 9)
!89 = !DILocation(line: 28, column: 11, scope: !88)
!90 = !DILocation(line: 28, column: 9, scope: !71)
!91 = !DILocation(line: 29, column: 17, scope: !92)
!92 = distinct !DILexicalBlock(scope: !88, file: !1, line: 28, column: 19)
!93 = !DILocation(line: 29, column: 15, scope: !92)
!94 = !DILocation(line: 30, column: 5, scope: !92)
!95 = !DILocation(line: 31, column: 14, scope: !96)
!96 = distinct !DILexicalBlock(scope: !88, file: !1, line: 31, column: 14)
!97 = !DILocation(line: 31, column: 16, scope: !96)
!98 = !DILocation(line: 31, column: 14, scope: !88)
!99 = !DILocation(line: 32, column: 17, scope: !100)
!100 = distinct !DILexicalBlock(scope: !96, file: !1, line: 31, column: 24)
!101 = !DILocation(line: 32, column: 15, scope: !100)
!102 = !DILocation(line: 33, column: 5, scope: !100)
!103 = !DILocalVariable(name: "result", scope: !71, file: !1, line: 35, type: !104)
!104 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!105 = !DILocation(line: 35, column: 14, scope: !71)
!106 = !DILocation(line: 35, column: 30, scope: !71)
!107 = !DILocation(line: 35, column: 35, scope: !71)
!108 = !DILocation(line: 35, column: 40, scope: !71)
!109 = !DILocation(line: 35, column: 48, scope: !71)
!110 = !DILocation(line: 35, column: 23, scope: !71)
!111 = !DILocation(line: 36, column: 5, scope: !71)
