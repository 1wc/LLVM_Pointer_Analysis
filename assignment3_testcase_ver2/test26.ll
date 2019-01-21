; ModuleID = 'test26.bc'
source_filename = "test26.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }
%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32, i32) #0 !dbg !24 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !25, metadata !26), !dbg !27
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !28, metadata !26), !dbg !29
  %5 = load i32, i32* %3, align 4, !dbg !30
  %6 = load i32, i32* %4, align 4, !dbg !31
  %7 = add nsw i32 %5, %6, !dbg !32
  ret i32 %7, !dbg !33
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32, i32) #0 !dbg !34 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !35, metadata !26), !dbg !36
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !37, metadata !26), !dbg !38
  %5 = load i32, i32* %3, align 4, !dbg !39
  %6 = load i32, i32* %4, align 4, !dbg !40
  %7 = sub nsw i32 %5, %6, !dbg !41
  ret i32 %7, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_alias(%struct.wfsptr*, %struct.fsptr*) #0 !dbg !43 {
  %3 = alloca %struct.wfsptr*, align 8
  %4 = alloca %struct.fsptr*, align 8
  store %struct.wfsptr* %0, %struct.wfsptr** %3, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %3, metadata !46, metadata !26), !dbg !47
  store %struct.fsptr* %1, %struct.fsptr** %4, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %4, metadata !48, metadata !26), !dbg !49
  %5 = load %struct.fsptr*, %struct.fsptr** %4, align 8, !dbg !50
  %6 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !51
  %7 = load %struct.fptr*, %struct.fptr** %6, align 8, !dbg !51
  %8 = getelementptr inbounds %struct.fptr, %struct.fptr* %7, i32 0, i32 0, !dbg !52
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !52
  %10 = load %struct.wfsptr*, %struct.wfsptr** %3, align 8, !dbg !53
  %11 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %10, i32 0, i32 0, !dbg !54
  %12 = load %struct.fsptr*, %struct.fsptr** %11, align 8, !dbg !54
  %13 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %12, i32 0, i32 0, !dbg !55
  %14 = load %struct.fptr*, %struct.fptr** %13, align 8, !dbg !55
  %15 = getelementptr inbounds %struct.fptr, %struct.fptr* %14, i32 0, i32 0, !dbg !56
  store i32 (i32, i32)* %9, i32 (i32, i32)** %15, align 8, !dbg !57
  ret void, !dbg !58
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32) #0 !dbg !59 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.fptr, align 8
  %4 = alloca %struct.fptr, align 8
  %5 = alloca %struct.fsptr, align 8
  %6 = alloca %struct.fsptr, align 8
  %7 = alloca %struct.wfsptr*, align 8
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !62, metadata !26), !dbg !63
  call void @llvm.dbg.declare(metadata %struct.fptr* %3, metadata !64, metadata !26), !dbg !65
  call void @llvm.dbg.declare(metadata %struct.fptr* %4, metadata !66, metadata !26), !dbg !67
  call void @llvm.dbg.declare(metadata %struct.fsptr* %5, metadata !68, metadata !26), !dbg !69
  call void @llvm.dbg.declare(metadata %struct.fsptr* %6, metadata !70, metadata !26), !dbg !71
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %7, metadata !72, metadata !26), !dbg !73
  %8 = call noalias i8* @malloc(i64 8) #3, !dbg !74
  %9 = bitcast i8* %8 to %struct.wfsptr*, !dbg !75
  store %struct.wfsptr* %9, %struct.wfsptr** %7, align 8, !dbg !73
  %10 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !76
  store %struct.fptr* %3, %struct.fptr** %10, align 8, !dbg !77
  %11 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %6, i32 0, i32 0, !dbg !78
  store %struct.fptr* %4, %struct.fptr** %11, align 8, !dbg !79
  %12 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !80
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %12, align 8, !dbg !81
  %13 = load %struct.wfsptr*, %struct.wfsptr** %7, align 8, !dbg !82
  %14 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %13, i32 0, i32 0, !dbg !83
  store %struct.fsptr* %5, %struct.fsptr** %14, align 8, !dbg !84
  %15 = load i32, i32* %2, align 4, !dbg !85
  %16 = icmp sgt i32 %15, 1, !dbg !87
  br i1 %16, label %17, label %26, !dbg !88

; <label>:17:                                     ; preds = %1
  %18 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !89
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %18, align 8, !dbg !91
  %19 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !92
  %20 = load %struct.fptr*, %struct.fptr** %19, align 8, !dbg !92
  %21 = getelementptr inbounds %struct.fptr, %struct.fptr* %20, i32 0, i32 0, !dbg !93
  %22 = load i32 (i32, i32)*, i32 (i32, i32)** %21, align 8, !dbg !93
  %23 = load i32, i32* %2, align 4, !dbg !94
  %24 = call i32 %22(i32 1, i32 %23), !dbg !95
  store i32 %24, i32* %2, align 4, !dbg !96
  %25 = load %struct.wfsptr*, %struct.wfsptr** %7, align 8, !dbg !97
  call void @make_alias(%struct.wfsptr* %25, %struct.fsptr* %6), !dbg !98
  br label %33, !dbg !99

; <label>:26:                                     ; preds = %1
  %27 = load %struct.wfsptr*, %struct.wfsptr** %7, align 8, !dbg !100
  %28 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %27, i32 0, i32 0, !dbg !102
  %29 = load %struct.fsptr*, %struct.fsptr** %28, align 8, !dbg !102
  %30 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %29, i32 0, i32 0, !dbg !103
  %31 = load %struct.fptr*, %struct.fptr** %30, align 8, !dbg !103
  %32 = getelementptr inbounds %struct.fptr, %struct.fptr* %31, i32 0, i32 0, !dbg !104
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %32, align 8, !dbg !105
  br label %33

; <label>:33:                                     ; preds = %26, %17
  %34 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !106
  %35 = load i32 (i32, i32)*, i32 (i32, i32)** %34, align 8, !dbg !106
  %36 = load i32, i32* %2, align 4, !dbg !107
  %37 = call i32 %35(i32 1, i32 %36), !dbg !108
  store i32 %37, i32* %2, align 4, !dbg !109
  ret void, !dbg !110
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!20, !21, !22}
!llvm.ident = !{!23}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test26.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !5, file: !1, line: 12, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !9, file: !1, line: 8, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !14)
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !13, file: !1, line: 4, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DISubroutineType(types: !18)
!18 = !{!19, !19, !19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !{i32 2, !"Dwarf Version", i32 4}
!21 = !{i32 2, !"Debug Info Version", i32 3}
!22 = !{i32 1, !"wchar_size", i32 4}
!23 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!24 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !17, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!25 = !DILocalVariable(name: "a", arg: 1, scope: !24, file: !1, line: 14, type: !19)
!26 = !DIExpression()
!27 = !DILocation(line: 14, column: 14, scope: !24)
!28 = !DILocalVariable(name: "b", arg: 2, scope: !24, file: !1, line: 14, type: !19)
!29 = !DILocation(line: 14, column: 21, scope: !24)
!30 = !DILocation(line: 15, column: 11, scope: !24)
!31 = !DILocation(line: 15, column: 13, scope: !24)
!32 = !DILocation(line: 15, column: 12, scope: !24)
!33 = !DILocation(line: 15, column: 4, scope: !24)
!34 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !17, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!35 = !DILocalVariable(name: "a", arg: 1, scope: !34, file: !1, line: 18, type: !19)
!36 = !DILocation(line: 18, column: 15, scope: !34)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !34, file: !1, line: 18, type: !19)
!38 = !DILocation(line: 18, column: 22, scope: !34)
!39 = !DILocation(line: 19, column: 11, scope: !34)
!40 = !DILocation(line: 19, column: 13, scope: !34)
!41 = !DILocation(line: 19, column: 12, scope: !34)
!42 = !DILocation(line: 19, column: 4, scope: !34)
!43 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 21, type: !44, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DISubroutineType(types: !45)
!45 = !{null, !4, !8}
!46 = !DILocalVariable(name: "a", arg: 1, scope: !43, file: !1, line: 21, type: !4)
!47 = !DILocation(line: 21, column: 32, scope: !43)
!48 = !DILocalVariable(name: "b", arg: 2, scope: !43, file: !1, line: 21, type: !8)
!49 = !DILocation(line: 21, column: 48, scope: !43)
!50 = !DILocation(line: 23, column: 25, scope: !43)
!51 = !DILocation(line: 23, column: 28, scope: !43)
!52 = !DILocation(line: 23, column: 34, scope: !43)
!53 = !DILocation(line: 23, column: 2, scope: !43)
!54 = !DILocation(line: 23, column: 5, scope: !43)
!55 = !DILocation(line: 23, column: 12, scope: !43)
!56 = !DILocation(line: 23, column: 18, scope: !43)
!57 = !DILocation(line: 23, column: 24, scope: !43)
!58 = !DILocation(line: 24, column: 1, scope: !43)
!59 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 25, type: !60, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!60 = !DISubroutineType(types: !61)
!61 = !{null, !19}
!62 = !DILocalVariable(name: "x", arg: 1, scope: !59, file: !1, line: 25, type: !19)
!63 = !DILocation(line: 25, column: 14, scope: !59)
!64 = !DILocalVariable(name: "a_fptr", scope: !59, file: !1, line: 27, type: !13)
!65 = !DILocation(line: 27, column: 14, scope: !59)
!66 = !DILocalVariable(name: "b_fptr", scope: !59, file: !1, line: 28, type: !13)
!67 = !DILocation(line: 28, column: 14, scope: !59)
!68 = !DILocalVariable(name: "s_fptr", scope: !59, file: !1, line: 29, type: !9)
!69 = !DILocation(line: 29, column: 15, scope: !59)
!70 = !DILocalVariable(name: "m_fptr", scope: !59, file: !1, line: 30, type: !9)
!71 = !DILocation(line: 30, column: 15, scope: !59)
!72 = !DILocalVariable(name: "w_fptr", scope: !59, file: !1, line: 31, type: !4)
!73 = !DILocation(line: 31, column: 17, scope: !59)
!74 = !DILocation(line: 31, column: 40, scope: !59)
!75 = !DILocation(line: 31, column: 24, scope: !59)
!76 = !DILocation(line: 32, column: 9, scope: !59)
!77 = !DILocation(line: 32, column: 13, scope: !59)
!78 = !DILocation(line: 33, column: 9, scope: !59)
!79 = !DILocation(line: 33, column: 13, scope: !59)
!80 = !DILocation(line: 34, column: 9, scope: !59)
!81 = !DILocation(line: 34, column: 15, scope: !59)
!82 = !DILocation(line: 35, column: 2, scope: !59)
!83 = !DILocation(line: 35, column: 10, scope: !59)
!84 = !DILocation(line: 35, column: 15, scope: !59)
!85 = !DILocation(line: 36, column: 5, scope: !86)
!86 = distinct !DILexicalBlock(scope: !59, file: !1, line: 36, column: 5)
!87 = !DILocation(line: 36, column: 6, scope: !86)
!88 = !DILocation(line: 36, column: 5, scope: !59)
!89 = !DILocation(line: 38, column: 11, scope: !90)
!90 = distinct !DILexicalBlock(scope: !86, file: !1, line: 37, column: 2)
!91 = !DILocation(line: 38, column: 17, scope: !90)
!92 = !DILocation(line: 39, column: 13, scope: !90)
!93 = !DILocation(line: 39, column: 19, scope: !90)
!94 = !DILocation(line: 39, column: 28, scope: !90)
!95 = !DILocation(line: 39, column: 6, scope: !90)
!96 = !DILocation(line: 39, column: 5, scope: !90)
!97 = !DILocation(line: 40, column: 15, scope: !90)
!98 = !DILocation(line: 40, column: 4, scope: !90)
!99 = !DILocation(line: 41, column: 2, scope: !90)
!100 = !DILocation(line: 43, column: 3, scope: !101)
!101 = distinct !DILexicalBlock(scope: !86, file: !1, line: 42, column: 2)
!102 = !DILocation(line: 43, column: 11, scope: !101)
!103 = !DILocation(line: 43, column: 18, scope: !101)
!104 = !DILocation(line: 43, column: 24, scope: !101)
!105 = !DILocation(line: 43, column: 30, scope: !101)
!106 = !DILocation(line: 45, column: 11, scope: !59)
!107 = !DILocation(line: 45, column: 20, scope: !59)
!108 = !DILocation(line: 45, column: 4, scope: !59)
!109 = !DILocation(line: 45, column: 3, scope: !59)
!110 = !DILocation(line: 46, column: 1, scope: !59)
