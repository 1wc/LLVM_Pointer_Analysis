; ModuleID = 'test03.bc'
source_filename = "test03.c"
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
define i32 @clever(i32) #0 !dbg !31 {
  %2 = alloca i32, align 4
  %3 = alloca i32 (i32, i32)*, align 8
  %4 = alloca i32 (i32, i32)*, align 8
  %5 = alloca [2 x i32 (i32, i32)*], align 16
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !34, metadata !14), !dbg !35
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %3, metadata !36, metadata !14), !dbg !38
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %3, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %4, metadata !39, metadata !14), !dbg !40
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %4, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %5, metadata !41, metadata !14), !dbg !45
  %9 = bitcast [2 x i32 (i32, i32)*]* %5 to i8*, !dbg !45
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 16, i32 16, i1 false), !dbg !45
  call void @llvm.dbg.declare(metadata i32* %6, metadata !46, metadata !14), !dbg !47
  store i32 1, i32* %6, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata i32* %7, metadata !48, metadata !14), !dbg !49
  store i32 2, i32* %7, align 4, !dbg !49
  %10 = load i32, i32* %2, align 4, !dbg !50
  %11 = icmp eq i32 %10, 3, !dbg !52
  br i1 %11, label %12, label %15, !dbg !53

; <label>:12:                                     ; preds = %1
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !54
  %14 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %5, i64 0, i64 0, !dbg !56
  store i32 (i32, i32)* %13, i32 (i32, i32)** %14, align 16, !dbg !57
  br label %15, !dbg !58

; <label>:15:                                     ; preds = %12, %1
  %16 = load i32, i32* %2, align 4, !dbg !59
  %17 = icmp eq i32 %16, 4, !dbg !61
  br i1 %17, label %18, label %21, !dbg !62

; <label>:18:                                     ; preds = %15
  %19 = load i32 (i32, i32)*, i32 (i32, i32)** %4, align 8, !dbg !63
  %20 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %5, i64 0, i64 0, !dbg !65
  store i32 (i32, i32)* %19, i32 (i32, i32)** %20, align 16, !dbg !66
  br label %21, !dbg !67

; <label>:21:                                     ; preds = %18, %15
  %22 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %5, i64 0, i64 0, !dbg !68
  %23 = load i32 (i32, i32)*, i32 (i32, i32)** %22, align 16, !dbg !68
  %24 = icmp ne i32 (i32, i32)* %23, null, !dbg !70
  br i1 %24, label %25, label %31, !dbg !71

; <label>:25:                                     ; preds = %21
  call void @llvm.dbg.declare(metadata i32* %8, metadata !72, metadata !14), !dbg !75
  %26 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %5, i64 0, i64 0, !dbg !76
  %27 = load i32 (i32, i32)*, i32 (i32, i32)** %26, align 16, !dbg !76
  %28 = load i32, i32* %6, align 4, !dbg !77
  %29 = load i32, i32* %7, align 4, !dbg !78
  %30 = call i32 %27(i32 %28, i32 %29), !dbg !76
  store i32 %30, i32* %8, align 4, !dbg !75
  br label %31, !dbg !79

; <label>:31:                                     ; preds = %25, %21
  ret i32 0, !dbg !80
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test03.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!9 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !10, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 3, column: 14, scope: !9)
!16 = !DILocalVariable(name: "b", arg: 2, scope: !9, file: !1, line: 3, type: !12)
!17 = !DILocation(line: 3, column: 21, scope: !9)
!18 = !DILocation(line: 4, column: 11, scope: !9)
!19 = !DILocation(line: 4, column: 13, scope: !9)
!20 = !DILocation(line: 4, column: 12, scope: !9)
!21 = !DILocation(line: 4, column: 4, scope: !9)
!22 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !10, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 7, type: !12)
!24 = !DILocation(line: 7, column: 15, scope: !22)
!25 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 7, type: !12)
!26 = !DILocation(line: 7, column: 22, scope: !22)
!27 = !DILocation(line: 8, column: 11, scope: !22)
!28 = !DILocation(line: 8, column: 13, scope: !22)
!29 = !DILocation(line: 8, column: 12, scope: !22)
!30 = !DILocation(line: 8, column: 4, scope: !22)
!31 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 11, type: !32, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!12, !12}
!34 = !DILocalVariable(name: "x", arg: 1, scope: !31, file: !1, line: 11, type: !12)
!35 = !DILocation(line: 11, column: 16, scope: !31)
!36 = !DILocalVariable(name: "a_fptr", scope: !31, file: !1, line: 12, type: !37)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!38 = !DILocation(line: 12, column: 11, scope: !31)
!39 = !DILocalVariable(name: "s_fptr", scope: !31, file: !1, line: 13, type: !37)
!40 = !DILocation(line: 13, column: 11, scope: !31)
!41 = !DILocalVariable(name: "t_fptr", scope: !31, file: !1, line: 14, type: !42)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 128, elements: !43)
!43 = !{!44}
!44 = !DISubrange(count: 2)
!45 = !DILocation(line: 14, column: 11, scope: !31)
!46 = !DILocalVariable(name: "op1", scope: !31, file: !1, line: 16, type: !12)
!47 = !DILocation(line: 16, column: 9, scope: !31)
!48 = !DILocalVariable(name: "op2", scope: !31, file: !1, line: 16, type: !12)
!49 = !DILocation(line: 16, column: 16, scope: !31)
!50 = !DILocation(line: 18, column: 9, scope: !51)
!51 = distinct !DILexicalBlock(scope: !31, file: !1, line: 18, column: 9)
!52 = !DILocation(line: 18, column: 11, scope: !51)
!53 = !DILocation(line: 18, column: 9, scope: !31)
!54 = !DILocation(line: 19, column: 20, scope: !55)
!55 = distinct !DILexicalBlock(scope: !51, file: !1, line: 18, column: 17)
!56 = !DILocation(line: 19, column: 8, scope: !55)
!57 = !DILocation(line: 19, column: 18, scope: !55)
!58 = !DILocation(line: 20, column: 5, scope: !55)
!59 = !DILocation(line: 21, column: 9, scope: !60)
!60 = distinct !DILexicalBlock(scope: !31, file: !1, line: 21, column: 9)
!61 = !DILocation(line: 21, column: 11, scope: !60)
!62 = !DILocation(line: 21, column: 9, scope: !31)
!63 = !DILocation(line: 22, column: 19, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !1, line: 21, column: 17)
!65 = !DILocation(line: 22, column: 8, scope: !64)
!66 = !DILocation(line: 22, column: 17, scope: !64)
!67 = !DILocation(line: 23, column: 5, scope: !64)
!68 = !DILocation(line: 26, column: 9, scope: !69)
!69 = distinct !DILexicalBlock(scope: !31, file: !1, line: 26, column: 9)
!70 = !DILocation(line: 26, column: 19, scope: !69)
!71 = !DILocation(line: 26, column: 9, scope: !31)
!72 = !DILocalVariable(name: "result", scope: !73, file: !1, line: 27, type: !74)
!73 = distinct !DILexicalBlock(scope: !69, file: !1, line: 26, column: 28)
!74 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!75 = !DILocation(line: 27, column: 17, scope: !73)
!76 = !DILocation(line: 27, column: 26, scope: !73)
!77 = !DILocation(line: 27, column: 36, scope: !73)
!78 = !DILocation(line: 27, column: 41, scope: !73)
!79 = !DILocation(line: 28, column: 5, scope: !73)
!80 = !DILocation(line: 29, column: 4, scope: !31)
