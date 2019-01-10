; ModuleID = 'test25.bc'
source_filename = "test25.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !11, metadata !12), !dbg !13
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !14, metadata !12), !dbg !15
  %0 = load i32, i32* %a.addr, align 4, !dbg !16
  %1 = load i32, i32* %b.addr, align 4, !dbg !17
  %add = add nsw i32 %0, %1, !dbg !18
  ret i32 %add, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !20 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !21, metadata !12), !dbg !22
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !23, metadata !12), !dbg !24
  %0 = load i32, i32* %a.addr, align 4, !dbg !25
  %1 = load i32, i32* %b.addr, align 4, !dbg !26
  %sub = sub nsw i32 %0, %1, !dbg !27
  ret i32 %sub, !dbg !28
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %af_ptr.coerce) #0 !dbg !29 {
entry:
  %af_ptr = alloca %struct.fptr, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %af_ptr, i32 0, i32 0
  store i32 (i32, i32)* %af_ptr.coerce, i32 (i32, i32)** %coerce.dive, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !36, metadata !12), !dbg !37
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !38, metadata !12), !dbg !39
  call void @llvm.dbg.declare(metadata %struct.fptr* %af_ptr, metadata !40, metadata !12), !dbg !41
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %af_ptr, i32 0, i32 0, !dbg !42
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !42
  %1 = load i32, i32* %a.addr, align 4, !dbg !43
  %2 = load i32, i32* %b.addr, align 4, !dbg !44
  %call = call i32 %0(i32 %1, i32 %2), !dbg !45
  ret i32 %call, !dbg !46
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_alias(%struct.fsptr* %a, %struct.fptr* %b) #0 !dbg !47 {
entry:
  %a.addr = alloca %struct.fsptr*, align 8
  %b.addr = alloca %struct.fptr*, align 8
  store %struct.fsptr* %a, %struct.fsptr** %a.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a.addr, metadata !55, metadata !12), !dbg !56
  store %struct.fptr* %b, %struct.fptr** %b.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %b.addr, metadata !57, metadata !12), !dbg !58
  %0 = load %struct.fptr*, %struct.fptr** %b.addr, align 8, !dbg !59
  %1 = load %struct.fsptr*, %struct.fsptr** %a.addr, align 8, !dbg !60
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %1, i32 0, i32 0, !dbg !61
  store %struct.fptr* %0, %struct.fptr** %sptr, align 8, !dbg !62
  ret void, !dbg !63
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever() #0 !dbg !64 {
entry:
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %tf_ptr = alloca %struct.fptr, align 8
  %mf_ptr = alloca %struct.fptr, align 8
  %sf_ptr = alloca %struct.fsptr, align 8
  %result = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !67, metadata !12), !dbg !69
  store i32 (i32, i32, i32 (i32, i32)*)* null, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !69
  call void @llvm.dbg.declare(metadata %struct.fptr* %tf_ptr, metadata !70, metadata !12), !dbg !71
  %0 = bitcast %struct.fptr* %tf_ptr to i8*, !dbg !71
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8, i32 8, i1 false), !dbg !71
  call void @llvm.dbg.declare(metadata %struct.fptr* %mf_ptr, metadata !72, metadata !12), !dbg !73
  %1 = bitcast %struct.fptr* %mf_ptr to i8*, !dbg !73
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 8, i32 8, i1 false), !dbg !73
  call void @llvm.dbg.declare(metadata %struct.fsptr* %sf_ptr, metadata !74, metadata !12), !dbg !75
  %2 = bitcast %struct.fsptr* %sf_ptr to i8*, !dbg !75
  call void @llvm.memset.p0i8.i64(i8* %2, i8 0, i64 8, i32 8, i1 false), !dbg !75
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %sf_ptr, i32 0, i32 0, !dbg !76
  store %struct.fptr* %mf_ptr, %struct.fptr** %sptr, align 8, !dbg !77
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %tf_ptr, i32 0, i32 0, !dbg !78
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !79
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %mf_ptr, i32 0, i32 0, !dbg !80
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !81
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !82
  call void @make_alias(%struct.fsptr* %sf_ptr, %struct.fptr* %tf_ptr), !dbg !83
  call void @llvm.dbg.declare(metadata i32* %result, metadata !84, metadata !12), !dbg !86
  %3 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !87
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %sf_ptr, i32 0, i32 0, !dbg !88
  %4 = load %struct.fptr*, %struct.fptr** %sptr2, align 8, !dbg !88
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !87
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %coerce.dive, align 8, !dbg !87
  %call = call i32 %3(i32 1, i32 2, i32 (i32, i32)* %5), !dbg !87
  store i32 %call, i32* %result, align 4, !dbg !86
  ret i32 0, !dbg !89
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test25.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 10, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 10, type: !10)
!15 = !DILocation(line: 10, column: 21, scope: !7)
!16 = !DILocation(line: 11, column: 11, scope: !7)
!17 = !DILocation(line: 11, column: 13, scope: !7)
!18 = !DILocation(line: 11, column: 12, scope: !7)
!19 = !DILocation(line: 11, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 14, type: !10)
!22 = !DILocation(line: 14, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 14, type: !10)
!24 = !DILocation(line: 14, column: 21, scope: !20)
!25 = !DILocation(line: 16, column: 12, scope: !20)
!26 = !DILocation(line: 16, column: 14, scope: !20)
!27 = !DILocation(line: 16, column: 13, scope: !20)
!28 = !DILocation(line: 16, column: 5, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 19, type: !30, isLocal: false, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !32}
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !33)
!33 = !{!34}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !32, file: !1, line: 4, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!36 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 19, type: !10)
!37 = !DILocation(line: 19, column: 13, scope: !29)
!38 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 19, type: !10)
!39 = !DILocation(line: 19, column: 19, scope: !29)
!40 = !DILocalVariable(name: "af_ptr", arg: 3, scope: !29, file: !1, line: 19, type: !32)
!41 = !DILocation(line: 19, column: 33, scope: !29)
!42 = !DILocation(line: 21, column: 16, scope: !29)
!43 = !DILocation(line: 21, column: 23, scope: !29)
!44 = !DILocation(line: 21, column: 25, scope: !29)
!45 = !DILocation(line: 21, column: 9, scope: !29)
!46 = !DILocation(line: 21, column: 2, scope: !29)
!47 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 23, type: !48, isLocal: false, isDefinition: true, scopeLine: 24, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!48 = !DISubroutineType(types: !49)
!49 = !{null, !50, !54}
!50 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !51, size: 64)
!51 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !52)
!52 = !{!53}
!53 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !51, file: !1, line: 8, baseType: !54, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!55 = !DILocalVariable(name: "a", arg: 1, scope: !47, file: !1, line: 23, type: !50)
!56 = !DILocation(line: 23, column: 32, scope: !47)
!57 = !DILocalVariable(name: "b", arg: 2, scope: !47, file: !1, line: 23, type: !54)
!58 = !DILocation(line: 23, column: 47, scope: !47)
!59 = !DILocation(line: 25, column: 13, scope: !47)
!60 = !DILocation(line: 25, column: 5, scope: !47)
!61 = !DILocation(line: 25, column: 8, scope: !47)
!62 = !DILocation(line: 25, column: 12, scope: !47)
!63 = !DILocation(line: 26, column: 1, scope: !47)
!64 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 27, type: !65, isLocal: false, isDefinition: true, scopeLine: 27, isOptimized: false, unit: !0, variables: !2)
!65 = !DISubroutineType(types: !66)
!66 = !{!10}
!67 = !DILocalVariable(name: "af_ptr", scope: !64, file: !1, line: 29, type: !68)
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!69 = !DILocation(line: 29, column: 11, scope: !64)
!70 = !DILocalVariable(name: "tf_ptr", scope: !64, file: !1, line: 30, type: !32)
!71 = !DILocation(line: 30, column: 17, scope: !64)
!72 = !DILocalVariable(name: "mf_ptr", scope: !64, file: !1, line: 31, type: !32)
!73 = !DILocation(line: 31, column: 17, scope: !64)
!74 = !DILocalVariable(name: "sf_ptr", scope: !64, file: !1, line: 32, type: !51)
!75 = !DILocation(line: 32, column: 18, scope: !64)
!76 = !DILocation(line: 33, column: 12, scope: !64)
!77 = !DILocation(line: 33, column: 16, scope: !64)
!78 = !DILocation(line: 34, column: 12, scope: !64)
!79 = !DILocation(line: 34, column: 18, scope: !64)
!80 = !DILocation(line: 35, column: 12, scope: !64)
!81 = !DILocation(line: 35, column: 18, scope: !64)
!82 = !DILocation(line: 36, column: 11, scope: !64)
!83 = !DILocation(line: 37, column: 5, scope: !64)
!84 = !DILocalVariable(name: "result", scope: !64, file: !1, line: 38, type: !85)
!85 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!86 = !DILocation(line: 38, column: 14, scope: !64)
!87 = !DILocation(line: 38, column: 23, scope: !64)
!88 = !DILocation(line: 38, column: 44, scope: !64)
!89 = !DILocation(line: 39, column: 5, scope: !64)
