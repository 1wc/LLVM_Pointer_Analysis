; ModuleID = 'test13.bc'
source_filename = "test13.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

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
define i32 @clever(i32, i32, i32 (i32, i32)*) #0 !dbg !29 {
  %4 = alloca %struct.fptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0
  store i32 (i32, i32)* %2, i32 (i32, i32)** %7, align 8
  store i32 %0, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !36, metadata !12), !dbg !37
  store i32 %1, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !38, metadata !12), !dbg !39
  call void @llvm.dbg.declare(metadata %struct.fptr* %4, metadata !40, metadata !12), !dbg !41
  %8 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !42
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !42
  %10 = load i32, i32* %5, align 4, !dbg !43
  %11 = load i32, i32* %6, align 4, !dbg !44
  %12 = call i32 %9(i32 %10, i32 %11), !dbg !45
  ret i32 %12, !dbg !46
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !47 {
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32)*, align 8
  %9 = alloca %struct.fptr, align 8
  %10 = alloca i32, align 4
  store i8 %0, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !51, metadata !12), !dbg !52
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !53, metadata !12), !dbg !54
  store i32 %2, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !55, metadata !12), !dbg !56
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !57, metadata !12), !dbg !58
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %7, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %8, metadata !59, metadata !12), !dbg !60
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %8, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata %struct.fptr* %9, metadata !61, metadata !12), !dbg !62
  %11 = bitcast %struct.fptr* %9 to i8*, !dbg !62
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 8, i32 8, i1 false), !dbg !62
  %12 = load i8, i8* %4, align 1, !dbg !63
  %13 = sext i8 %12 to i32, !dbg !63
  %14 = icmp eq i32 %13, 43, !dbg !65
  br i1 %14, label %15, label %18, !dbg !66

; <label>:15:                                     ; preds = %3
  %16 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !67
  %17 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !69
  store i32 (i32, i32)* %16, i32 (i32, i32)** %17, align 8, !dbg !70
  br label %26, !dbg !71

; <label>:18:                                     ; preds = %3
  %19 = load i8, i8* %4, align 1, !dbg !72
  %20 = sext i8 %19 to i32, !dbg !72
  %21 = icmp eq i32 %20, 45, !dbg !74
  br i1 %21, label %22, label %25, !dbg !75

; <label>:22:                                     ; preds = %18
  %23 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !76
  %24 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !78
  store i32 (i32, i32)* %23, i32 (i32, i32)** %24, align 8, !dbg !79
  br label %25, !dbg !80

; <label>:25:                                     ; preds = %22, %18
  br label %26

; <label>:26:                                     ; preds = %25, %15
  call void @llvm.dbg.declare(metadata i32* %10, metadata !81, metadata !12), !dbg !83
  %27 = load i32, i32* %5, align 4, !dbg !84
  %28 = load i32, i32* %6, align 4, !dbg !85
  %29 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !86
  %30 = load i32 (i32, i32)*, i32 (i32, i32)** %29, align 8, !dbg !86
  %31 = call i32 @clever(i32 %27, i32 %28, i32 (i32, i32)* %30), !dbg !86
  store i32 %31, i32* %10, align 4, !dbg !83
  ret i32 0, !dbg !87
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test13.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 6, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 6, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 6, type: !10)
!15 = !DILocation(line: 6, column: 21, scope: !7)
!16 = !DILocation(line: 7, column: 11, scope: !7)
!17 = !DILocation(line: 7, column: 13, scope: !7)
!18 = !DILocation(line: 7, column: 12, scope: !7)
!19 = !DILocation(line: 7, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !10)
!22 = !DILocation(line: 10, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !10)
!24 = !DILocation(line: 10, column: 22, scope: !20)
!25 = !DILocation(line: 11, column: 11, scope: !20)
!26 = !DILocation(line: 11, column: 13, scope: !20)
!27 = !DILocation(line: 11, column: 12, scope: !20)
!28 = !DILocation(line: 11, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !30, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !32}
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !33)
!33 = !{!34}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !32, file: !1, line: 4, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!36 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 14, type: !10)
!37 = !DILocation(line: 14, column: 16, scope: !29)
!38 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 14, type: !10)
!39 = !DILocation(line: 14, column: 23, scope: !29)
!40 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 14, type: !32)
!41 = !DILocation(line: 14, column: 38, scope: !29)
!42 = !DILocation(line: 15, column: 19, scope: !29)
!43 = !DILocation(line: 15, column: 26, scope: !29)
!44 = !DILocation(line: 15, column: 29, scope: !29)
!45 = !DILocation(line: 15, column: 12, scope: !29)
!46 = !DILocation(line: 15, column: 5, scope: !29)
!47 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 19, type: !48, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!48 = !DISubroutineType(types: !49)
!49 = !{!10, !50, !10, !10}
!50 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!51 = !DILocalVariable(name: "x", arg: 1, scope: !47, file: !1, line: 19, type: !50)
!52 = !DILocation(line: 19, column: 14, scope: !47)
!53 = !DILocalVariable(name: "op1", arg: 2, scope: !47, file: !1, line: 19, type: !10)
!54 = !DILocation(line: 19, column: 21, scope: !47)
!55 = !DILocalVariable(name: "op2", arg: 3, scope: !47, file: !1, line: 19, type: !10)
!56 = !DILocation(line: 19, column: 30, scope: !47)
!57 = !DILocalVariable(name: "a_fptr", scope: !47, file: !1, line: 20, type: !35)
!58 = !DILocation(line: 20, column: 11, scope: !47)
!59 = !DILocalVariable(name: "s_fptr", scope: !47, file: !1, line: 21, type: !35)
!60 = !DILocation(line: 21, column: 11, scope: !47)
!61 = !DILocalVariable(name: "t_fptr", scope: !47, file: !1, line: 22, type: !32)
!62 = !DILocation(line: 22, column: 17, scope: !47)
!63 = !DILocation(line: 24, column: 9, scope: !64)
!64 = distinct !DILexicalBlock(scope: !47, file: !1, line: 24, column: 9)
!65 = !DILocation(line: 24, column: 11, scope: !64)
!66 = !DILocation(line: 24, column: 9, scope: !47)
!67 = !DILocation(line: 25, column: 24, scope: !68)
!68 = distinct !DILexicalBlock(scope: !64, file: !1, line: 24, column: 19)
!69 = !DILocation(line: 25, column: 15, scope: !68)
!70 = !DILocation(line: 25, column: 22, scope: !68)
!71 = !DILocation(line: 26, column: 5, scope: !68)
!72 = !DILocation(line: 27, column: 14, scope: !73)
!73 = distinct !DILexicalBlock(scope: !64, file: !1, line: 27, column: 14)
!74 = !DILocation(line: 27, column: 16, scope: !73)
!75 = !DILocation(line: 27, column: 14, scope: !64)
!76 = !DILocation(line: 28, column: 24, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 27, column: 24)
!78 = !DILocation(line: 28, column: 16, scope: !77)
!79 = !DILocation(line: 28, column: 22, scope: !77)
!80 = !DILocation(line: 29, column: 5, scope: !77)
!81 = !DILocalVariable(name: "result", scope: !47, file: !1, line: 31, type: !82)
!82 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!83 = !DILocation(line: 31, column: 14, scope: !47)
!84 = !DILocation(line: 31, column: 30, scope: !47)
!85 = !DILocation(line: 31, column: 35, scope: !47)
!86 = !DILocation(line: 31, column: 23, scope: !47)
!87 = !DILocation(line: 32, column: 5, scope: !47)
