; ModuleID = 'test14.bc'
source_filename = "test14.c"
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
define i32 @foo(i32, i32, i32 (i32, i32)*) #0 !dbg !29 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32 (i32, i32)*, align 8
  store i32 %0, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !33, metadata !12), !dbg !34
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !35, metadata !12), !dbg !36
  store i32 (i32, i32)* %2, i32 (i32, i32)** %6, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %6, metadata !37, metadata !12), !dbg !38
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !39
  %8 = load i32, i32* %4, align 4, !dbg !40
  %9 = load i32, i32* %5, align 4, !dbg !41
  %10 = call i32 %7(i32 %8, i32 %9), !dbg !39
  ret i32 %10, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32, i32, i32 (i32, i32)*) #0 !dbg !43 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32 (i32, i32)*, align 8
  store i32 %0, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !44, metadata !12), !dbg !45
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !46, metadata !12), !dbg !47
  store i32 (i32, i32)* %2, i32 (i32, i32)** %6, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %6, metadata !48, metadata !12), !dbg !49
  %7 = load i32, i32* %4, align 4, !dbg !50
  %8 = load i32, i32* %5, align 4, !dbg !51
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !52
  %10 = call i32 @foo(i32 %7, i32 %8, i32 (i32, i32)* %9), !dbg !53
  ret i32 %10, !dbg !54
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !55 {
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32)*, align 8
  %9 = alloca i32 (i32, i32)*, align 8
  %10 = alloca i32, align 4
  store i8 %0, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !59, metadata !12), !dbg !60
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !61, metadata !12), !dbg !62
  store i32 %2, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !63, metadata !12), !dbg !64
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !65, metadata !12), !dbg !66
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %7, align 8, !dbg !66
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %8, metadata !67, metadata !12), !dbg !68
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %8, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %9, metadata !69, metadata !12), !dbg !70
  store i32 (i32, i32)* null, i32 (i32, i32)** %9, align 8, !dbg !70
  %11 = load i8, i8* %4, align 1, !dbg !71
  %12 = sext i8 %11 to i32, !dbg !71
  %13 = icmp eq i32 %12, 43, !dbg !73
  br i1 %13, label %14, label %16, !dbg !74

; <label>:14:                                     ; preds = %3
  %15 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !75
  store i32 (i32, i32)* %15, i32 (i32, i32)** %9, align 8, !dbg !77
  br label %23, !dbg !78

; <label>:16:                                     ; preds = %3
  %17 = load i8, i8* %4, align 1, !dbg !79
  %18 = sext i8 %17 to i32, !dbg !79
  %19 = icmp eq i32 %18, 45, !dbg !81
  br i1 %19, label %20, label %22, !dbg !82

; <label>:20:                                     ; preds = %16
  %21 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !83
  store i32 (i32, i32)* %21, i32 (i32, i32)** %9, align 8, !dbg !85
  br label %22, !dbg !86

; <label>:22:                                     ; preds = %20, %16
  br label %23

; <label>:23:                                     ; preds = %22, %14
  call void @llvm.dbg.declare(metadata i32* %10, metadata !87, metadata !12), !dbg !89
  %24 = load i32, i32* %5, align 4, !dbg !90
  %25 = load i32, i32* %6, align 4, !dbg !91
  %26 = load i32 (i32, i32)*, i32 (i32, i32)** %9, align 8, !dbg !92
  %27 = call i32 @clever(i32 %24, i32 %25, i32 (i32, i32)* %26), !dbg !93
  store i32 %27, i32* %10, align 4, !dbg !89
  ret i32 0, !dbg !94
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test14.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
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
!31 = !{!10, !10, !10, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 9, type: !10)
!34 = !DILocation(line: 9, column: 13, scope: !29)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 9, type: !10)
!36 = !DILocation(line: 9, column: 20, scope: !29)
!37 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 9, type: !32)
!38 = !DILocation(line: 9, column: 29, scope: !29)
!39 = !DILocation(line: 10, column: 11, scope: !29)
!40 = !DILocation(line: 10, column: 18, scope: !29)
!41 = !DILocation(line: 10, column: 21, scope: !29)
!42 = !DILocation(line: 10, column: 4, scope: !29)
!43 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !30, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DILocalVariable(name: "a", arg: 1, scope: !43, file: !1, line: 13, type: !10)
!45 = !DILocation(line: 13, column: 16, scope: !43)
!46 = !DILocalVariable(name: "b", arg: 2, scope: !43, file: !1, line: 13, type: !10)
!47 = !DILocation(line: 13, column: 23, scope: !43)
!48 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !43, file: !1, line: 13, type: !32)
!49 = !DILocation(line: 13, column: 32, scope: !43)
!50 = !DILocation(line: 14, column: 16, scope: !43)
!51 = !DILocation(line: 14, column: 19, scope: !43)
!52 = !DILocation(line: 14, column: 22, scope: !43)
!53 = !DILocation(line: 14, column: 12, scope: !43)
!54 = !DILocation(line: 14, column: 5, scope: !43)
!55 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 18, type: !56, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!56 = !DISubroutineType(types: !57)
!57 = !{!10, !58, !10, !10}
!58 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!59 = !DILocalVariable(name: "x", arg: 1, scope: !55, file: !1, line: 18, type: !58)
!60 = !DILocation(line: 18, column: 14, scope: !55)
!61 = !DILocalVariable(name: "op1", arg: 2, scope: !55, file: !1, line: 18, type: !10)
!62 = !DILocation(line: 18, column: 21, scope: !55)
!63 = !DILocalVariable(name: "op2", arg: 3, scope: !55, file: !1, line: 18, type: !10)
!64 = !DILocation(line: 18, column: 30, scope: !55)
!65 = !DILocalVariable(name: "a_fptr", scope: !55, file: !1, line: 19, type: !32)
!66 = !DILocation(line: 19, column: 11, scope: !55)
!67 = !DILocalVariable(name: "s_fptr", scope: !55, file: !1, line: 20, type: !32)
!68 = !DILocation(line: 20, column: 11, scope: !55)
!69 = !DILocalVariable(name: "t_fptr", scope: !55, file: !1, line: 21, type: !32)
!70 = !DILocation(line: 21, column: 11, scope: !55)
!71 = !DILocation(line: 23, column: 9, scope: !72)
!72 = distinct !DILexicalBlock(scope: !55, file: !1, line: 23, column: 9)
!73 = !DILocation(line: 23, column: 11, scope: !72)
!74 = !DILocation(line: 23, column: 9, scope: !55)
!75 = !DILocation(line: 24, column: 17, scope: !76)
!76 = distinct !DILexicalBlock(scope: !72, file: !1, line: 23, column: 19)
!77 = !DILocation(line: 24, column: 15, scope: !76)
!78 = !DILocation(line: 25, column: 5, scope: !76)
!79 = !DILocation(line: 26, column: 14, scope: !80)
!80 = distinct !DILexicalBlock(scope: !72, file: !1, line: 26, column: 14)
!81 = !DILocation(line: 26, column: 16, scope: !80)
!82 = !DILocation(line: 26, column: 14, scope: !72)
!83 = !DILocation(line: 27, column: 17, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !1, line: 26, column: 24)
!85 = !DILocation(line: 27, column: 15, scope: !84)
!86 = !DILocation(line: 28, column: 5, scope: !84)
!87 = !DILocalVariable(name: "result", scope: !55, file: !1, line: 30, type: !88)
!88 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!89 = !DILocation(line: 30, column: 14, scope: !55)
!90 = !DILocation(line: 30, column: 30, scope: !55)
!91 = !DILocation(line: 30, column: 35, scope: !55)
!92 = !DILocation(line: 30, column: 40, scope: !55)
!93 = !DILocation(line: 30, column: 23, scope: !55)
!94 = !DILocation(line: 31, column: 5, scope: !55)
