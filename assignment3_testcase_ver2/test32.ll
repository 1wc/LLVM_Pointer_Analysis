; ModuleID = 'test32.bc'
source_filename = "test32.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }

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
define %struct.fptr* @foo(i32, i32, %struct.wfsptr*, %struct.wfsptr*) #0 !dbg !29 {
  %5 = alloca %struct.fptr*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca %struct.wfsptr*, align 8
  %9 = alloca %struct.wfsptr*, align 8
  %10 = alloca %struct.fsptr*, align 8
  store i32 %0, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !45, metadata !12), !dbg !46
  store i32 %1, i32* %7, align 4
  call void @llvm.dbg.declare(metadata i32* %7, metadata !47, metadata !12), !dbg !48
  store %struct.wfsptr* %2, %struct.wfsptr** %8, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %8, metadata !49, metadata !12), !dbg !50
  store %struct.wfsptr* %3, %struct.wfsptr** %9, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %9, metadata !51, metadata !12), !dbg !52
  %11 = load i32, i32* %6, align 4, !dbg !53
  %12 = icmp sgt i32 %11, 0, !dbg !55
  br i1 %12, label %13, label %41, !dbg !56

; <label>:13:                                     ; preds = %4
  %14 = load i32, i32* %7, align 4, !dbg !57
  %15 = icmp slt i32 %14, 0, !dbg !58
  br i1 %15, label %16, label %41, !dbg !59

; <label>:16:                                     ; preds = %13
  call void @llvm.dbg.declare(metadata %struct.fsptr** %10, metadata !60, metadata !12), !dbg !62
  %17 = load %struct.wfsptr*, %struct.wfsptr** %8, align 8, !dbg !63
  %18 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %17, i32 0, i32 0, !dbg !64
  %19 = load %struct.fsptr*, %struct.fsptr** %18, align 8, !dbg !64
  store %struct.fsptr* %19, %struct.fsptr** %10, align 8, !dbg !62
  %20 = load %struct.wfsptr*, %struct.wfsptr** %9, align 8, !dbg !65
  %21 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %20, i32 0, i32 0, !dbg !66
  %22 = load %struct.fsptr*, %struct.fsptr** %21, align 8, !dbg !66
  %23 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %22, i32 0, i32 0, !dbg !67
  %24 = load %struct.fptr*, %struct.fptr** %23, align 8, !dbg !67
  %25 = load %struct.wfsptr*, %struct.wfsptr** %8, align 8, !dbg !68
  %26 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %25, i32 0, i32 0, !dbg !69
  %27 = load %struct.fsptr*, %struct.fsptr** %26, align 8, !dbg !69
  %28 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %27, i32 0, i32 0, !dbg !70
  store %struct.fptr* %24, %struct.fptr** %28, align 8, !dbg !71
  %29 = load %struct.fsptr*, %struct.fsptr** %10, align 8, !dbg !72
  %30 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %29, i32 0, i32 0, !dbg !73
  %31 = load %struct.fptr*, %struct.fptr** %30, align 8, !dbg !73
  %32 = load %struct.wfsptr*, %struct.wfsptr** %9, align 8, !dbg !74
  %33 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %32, i32 0, i32 0, !dbg !75
  %34 = load %struct.fsptr*, %struct.fsptr** %33, align 8, !dbg !75
  %35 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %34, i32 0, i32 0, !dbg !76
  store %struct.fptr* %31, %struct.fptr** %35, align 8, !dbg !77
  %36 = load %struct.wfsptr*, %struct.wfsptr** %8, align 8, !dbg !78
  %37 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %36, i32 0, i32 0, !dbg !79
  %38 = load %struct.fsptr*, %struct.fsptr** %37, align 8, !dbg !79
  %39 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %38, i32 0, i32 0, !dbg !80
  %40 = load %struct.fptr*, %struct.fptr** %39, align 8, !dbg !80
  store %struct.fptr* %40, %struct.fptr** %5, align 8, !dbg !81
  br label %47, !dbg !81

; <label>:41:                                     ; preds = %13, %4
  %42 = load %struct.wfsptr*, %struct.wfsptr** %9, align 8, !dbg !82
  %43 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %42, i32 0, i32 0, !dbg !83
  %44 = load %struct.fsptr*, %struct.fsptr** %43, align 8, !dbg !83
  %45 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %44, i32 0, i32 0, !dbg !84
  %46 = load %struct.fptr*, %struct.fptr** %45, align 8, !dbg !84
  store %struct.fptr* %46, %struct.fptr** %5, align 8, !dbg !85
  br label %47, !dbg !85

; <label>:47:                                     ; preds = %41, %16
  %48 = load %struct.fptr*, %struct.fptr** %5, align 8, !dbg !86
  ret %struct.fptr* %48, !dbg !86
}

; Function Attrs: noinline nounwind optnone uwtable
define %struct.fptr* @clever(i32, i32, %struct.fsptr*, %struct.fsptr*) #0 !dbg !87 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.fsptr*, align 8
  %8 = alloca %struct.fsptr*, align 8
  %9 = alloca %struct.wfsptr, align 8
  %10 = alloca %struct.wfsptr, align 8
  store i32 %0, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !90, metadata !12), !dbg !91
  store i32 %1, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !92, metadata !12), !dbg !93
  store %struct.fsptr* %2, %struct.fsptr** %7, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %7, metadata !94, metadata !12), !dbg !95
  store %struct.fsptr* %3, %struct.fsptr** %8, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %8, metadata !96, metadata !12), !dbg !97
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %9, metadata !98, metadata !12), !dbg !99
  %11 = load %struct.fsptr*, %struct.fsptr** %7, align 8, !dbg !100
  %12 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %9, i32 0, i32 0, !dbg !101
  store %struct.fsptr* %11, %struct.fsptr** %12, align 8, !dbg !102
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %10, metadata !103, metadata !12), !dbg !104
  %13 = load %struct.fsptr*, %struct.fsptr** %8, align 8, !dbg !105
  %14 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %10, i32 0, i32 0, !dbg !106
  store %struct.fsptr* %13, %struct.fsptr** %14, align 8, !dbg !107
  %15 = load i32, i32* %5, align 4, !dbg !108
  %16 = load i32, i32* %6, align 4, !dbg !109
  %17 = call %struct.fptr* @foo(i32 %15, i32 %16, %struct.wfsptr* %9, %struct.wfsptr* %10), !dbg !110
  ret %struct.fptr* %17, !dbg !111
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !112 {
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca %struct.fptr, align 8
  %8 = alloca %struct.fptr, align 8
  %9 = alloca %struct.fsptr, align 8
  %10 = alloca %struct.fsptr, align 8
  %11 = alloca %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)*, align 8
  %12 = alloca %struct.fptr*, align 8
  store i8 %0, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !116, metadata !12), !dbg !117
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !118, metadata !12), !dbg !119
  store i32 %2, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !120, metadata !12), !dbg !121
  call void @llvm.dbg.declare(metadata %struct.fptr* %7, metadata !122, metadata !12), !dbg !123
  %13 = getelementptr inbounds %struct.fptr, %struct.fptr* %7, i32 0, i32 0, !dbg !124
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %13, align 8, !dbg !125
  call void @llvm.dbg.declare(metadata %struct.fptr* %8, metadata !126, metadata !12), !dbg !127
  %14 = getelementptr inbounds %struct.fptr, %struct.fptr* %8, i32 0, i32 0, !dbg !128
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %14, align 8, !dbg !129
  call void @llvm.dbg.declare(metadata %struct.fsptr* %9, metadata !130, metadata !12), !dbg !131
  %15 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %9, i32 0, i32 0, !dbg !132
  store %struct.fptr* %7, %struct.fptr** %15, align 8, !dbg !133
  call void @llvm.dbg.declare(metadata %struct.fsptr* %10, metadata !134, metadata !12), !dbg !135
  %16 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %10, i32 0, i32 0, !dbg !136
  store %struct.fptr* %8, %struct.fptr** %16, align 8, !dbg !137
  call void @llvm.dbg.declare(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %11, metadata !138, metadata !12), !dbg !140
  call void @llvm.dbg.declare(metadata %struct.fptr** %12, metadata !141, metadata !12), !dbg !142
  store %struct.fptr* null, %struct.fptr** %12, align 8, !dbg !142
  %17 = load i32, i32* %5, align 4, !dbg !143
  %18 = load i32, i32* %6, align 4, !dbg !144
  %19 = call %struct.fptr* @clever(i32 %17, i32 %18, %struct.fsptr* %9, %struct.fsptr* %10), !dbg !145
  store %struct.fptr* %19, %struct.fptr** %12, align 8, !dbg !146
  %20 = load %struct.fptr*, %struct.fptr** %12, align 8, !dbg !147
  %21 = getelementptr inbounds %struct.fptr, %struct.fptr* %20, i32 0, i32 0, !dbg !148
  %22 = load i32 (i32, i32)*, i32 (i32, i32)** %21, align 8, !dbg !148
  %23 = load i32, i32* %5, align 4, !dbg !149
  %24 = load i32, i32* %6, align 4, !dbg !150
  %25 = call i32 %22(i32 %23, i32 %24), !dbg !147
  %26 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %10, i32 0, i32 0, !dbg !151
  %27 = load %struct.fptr*, %struct.fptr** %26, align 8, !dbg !151
  %28 = getelementptr inbounds %struct.fptr, %struct.fptr* %27, i32 0, i32 0, !dbg !152
  %29 = load i32 (i32, i32)*, i32 (i32, i32)** %28, align 8, !dbg !152
  %30 = load i32, i32* %5, align 4, !dbg !153
  %31 = load i32, i32* %6, align 4, !dbg !154
  %32 = call i32 %29(i32 %30, i32 %31), !dbg !155
  ret i32 0, !dbg !156
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test32.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 14, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 14, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 14, type: !10)
!15 = !DILocation(line: 14, column: 21, scope: !7)
!16 = !DILocation(line: 15, column: 11, scope: !7)
!17 = !DILocation(line: 15, column: 13, scope: !7)
!18 = !DILocation(line: 15, column: 12, scope: !7)
!19 = !DILocation(line: 15, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 18, type: !10)
!22 = !DILocation(line: 18, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 18, type: !10)
!24 = !DILocation(line: 18, column: 22, scope: !20)
!25 = !DILocation(line: 19, column: 11, scope: !20)
!26 = !DILocation(line: 19, column: 13, scope: !20)
!27 = !DILocation(line: 19, column: 12, scope: !20)
!28 = !DILocation(line: 19, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 22, type: !30, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32, !10, !10, !37, !37}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !33, file: !1, line: 4, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !39)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !38, file: !1, line: 12, baseType: !41, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !42, size: 64)
!42 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !43)
!43 = !{!44}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !42, file: !1, line: 8, baseType: !32, size: 64)
!45 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 22, type: !10)
!46 = !DILocation(line: 22, column: 23, scope: !29)
!47 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 22, type: !10)
!48 = !DILocation(line: 22, column: 30, scope: !29)
!49 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 22, type: !37)
!50 = !DILocation(line: 22, column: 49, scope: !29)
!51 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !29, file: !1, line: 22, type: !37)
!52 = !DILocation(line: 22, column: 73, scope: !29)
!53 = !DILocation(line: 23, column: 7, scope: !54)
!54 = distinct !DILexicalBlock(scope: !29, file: !1, line: 23, column: 7)
!55 = !DILocation(line: 23, column: 8, scope: !54)
!56 = !DILocation(line: 23, column: 11, scope: !54)
!57 = !DILocation(line: 23, column: 14, scope: !54)
!58 = !DILocation(line: 23, column: 15, scope: !54)
!59 = !DILocation(line: 23, column: 7, scope: !29)
!60 = !DILocalVariable(name: "temp", scope: !61, file: !1, line: 25, type: !41)
!61 = distinct !DILexicalBlock(scope: !54, file: !1, line: 24, column: 4)
!62 = !DILocation(line: 25, column: 20, scope: !61)
!63 = !DILocation(line: 25, column: 25, scope: !61)
!64 = !DILocation(line: 25, column: 33, scope: !61)
!65 = !DILocation(line: 26, column: 27, scope: !61)
!66 = !DILocation(line: 26, column: 35, scope: !61)
!67 = !DILocation(line: 26, column: 42, scope: !61)
!68 = !DILocation(line: 26, column: 5, scope: !61)
!69 = !DILocation(line: 26, column: 13, scope: !61)
!70 = !DILocation(line: 26, column: 20, scope: !61)
!71 = !DILocation(line: 26, column: 25, scope: !61)
!72 = !DILocation(line: 27, column: 26, scope: !61)
!73 = !DILocation(line: 27, column: 32, scope: !61)
!74 = !DILocation(line: 27, column: 5, scope: !61)
!75 = !DILocation(line: 27, column: 13, scope: !61)
!76 = !DILocation(line: 27, column: 20, scope: !61)
!77 = !DILocation(line: 27, column: 25, scope: !61)
!78 = !DILocation(line: 28, column: 12, scope: !61)
!79 = !DILocation(line: 28, column: 20, scope: !61)
!80 = !DILocation(line: 28, column: 27, scope: !61)
!81 = !DILocation(line: 28, column: 5, scope: !61)
!82 = !DILocation(line: 30, column: 11, scope: !29)
!83 = !DILocation(line: 30, column: 19, scope: !29)
!84 = !DILocation(line: 30, column: 26, scope: !29)
!85 = !DILocation(line: 30, column: 4, scope: !29)
!86 = !DILocation(line: 31, column: 1, scope: !29)
!87 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 33, type: !88, isLocal: false, isDefinition: true, scopeLine: 33, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!88 = !DISubroutineType(types: !89)
!89 = !{!32, !10, !10, !41, !41}
!90 = !DILocalVariable(name: "a", arg: 1, scope: !87, file: !1, line: 33, type: !10)
!91 = !DILocation(line: 33, column: 26, scope: !87)
!92 = !DILocalVariable(name: "b", arg: 2, scope: !87, file: !1, line: 33, type: !10)
!93 = !DILocation(line: 33, column: 33, scope: !87)
!94 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !87, file: !1, line: 33, type: !41)
!95 = !DILocation(line: 33, column: 51, scope: !87)
!96 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !87, file: !1, line: 33, type: !41)
!97 = !DILocation(line: 33, column: 74, scope: !87)
!98 = !DILocalVariable(name: "t1_fptr", scope: !87, file: !1, line: 34, type: !38)
!99 = !DILocation(line: 34, column: 18, scope: !87)
!100 = !DILocation(line: 35, column: 18, scope: !87)
!101 = !DILocation(line: 35, column: 12, scope: !87)
!102 = !DILocation(line: 35, column: 17, scope: !87)
!103 = !DILocalVariable(name: "t2_fptr", scope: !87, file: !1, line: 36, type: !38)
!104 = !DILocation(line: 36, column: 18, scope: !87)
!105 = !DILocation(line: 37, column: 18, scope: !87)
!106 = !DILocation(line: 37, column: 12, scope: !87)
!107 = !DILocation(line: 37, column: 17, scope: !87)
!108 = !DILocation(line: 38, column: 15, scope: !87)
!109 = !DILocation(line: 38, column: 17, scope: !87)
!110 = !DILocation(line: 38, column: 11, scope: !87)
!111 = !DILocation(line: 38, column: 4, scope: !87)
!112 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 42, type: !113, isLocal: false, isDefinition: true, scopeLine: 42, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!113 = !DISubroutineType(types: !114)
!114 = !{!10, !115, !10, !10}
!115 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!116 = !DILocalVariable(name: "x", arg: 1, scope: !112, file: !1, line: 42, type: !115)
!117 = !DILocation(line: 42, column: 14, scope: !112)
!118 = !DILocalVariable(name: "op1", arg: 2, scope: !112, file: !1, line: 42, type: !10)
!119 = !DILocation(line: 42, column: 21, scope: !112)
!120 = !DILocalVariable(name: "op2", arg: 3, scope: !112, file: !1, line: 42, type: !10)
!121 = !DILocation(line: 42, column: 30, scope: !112)
!122 = !DILocalVariable(name: "a_fptr", scope: !112, file: !1, line: 43, type: !33)
!123 = !DILocation(line: 43, column: 17, scope: !112)
!124 = !DILocation(line: 44, column: 12, scope: !112)
!125 = !DILocation(line: 44, column: 18, scope: !112)
!126 = !DILocalVariable(name: "s_fptr", scope: !112, file: !1, line: 45, type: !33)
!127 = !DILocation(line: 45, column: 17, scope: !112)
!128 = !DILocation(line: 46, column: 12, scope: !112)
!129 = !DILocation(line: 46, column: 18, scope: !112)
!130 = !DILocalVariable(name: "m_fptr", scope: !112, file: !1, line: 48, type: !42)
!131 = !DILocation(line: 48, column: 18, scope: !112)
!132 = !DILocation(line: 49, column: 12, scope: !112)
!133 = !DILocation(line: 49, column: 16, scope: !112)
!134 = !DILocalVariable(name: "n_fptr", scope: !112, file: !1, line: 50, type: !42)
!135 = !DILocation(line: 50, column: 18, scope: !112)
!136 = !DILocation(line: 51, column: 12, scope: !112)
!137 = !DILocation(line: 51, column: 16, scope: !112)
!138 = !DILocalVariable(name: "goo_ptr", scope: !112, file: !1, line: 53, type: !139)
!139 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!140 = !DILocation(line: 53, column: 20, scope: !112)
!141 = !DILocalVariable(name: "t_fptr", scope: !112, file: !1, line: 54, type: !32)
!142 = !DILocation(line: 54, column: 18, scope: !112)
!143 = !DILocation(line: 56, column: 21, scope: !112)
!144 = !DILocation(line: 56, column: 26, scope: !112)
!145 = !DILocation(line: 56, column: 14, scope: !112)
!146 = !DILocation(line: 56, column: 12, scope: !112)
!147 = !DILocation(line: 57, column: 5, scope: !112)
!148 = !DILocation(line: 57, column: 13, scope: !112)
!149 = !DILocation(line: 57, column: 20, scope: !112)
!150 = !DILocation(line: 57, column: 25, scope: !112)
!151 = !DILocation(line: 58, column: 12, scope: !112)
!152 = !DILocation(line: 58, column: 18, scope: !112)
!153 = !DILocation(line: 58, column: 25, scope: !112)
!154 = !DILocation(line: 58, column: 29, scope: !112)
!155 = !DILocation(line: 58, column: 5, scope: !112)
!156 = !DILocation(line: 60, column: 5, scope: !112)
