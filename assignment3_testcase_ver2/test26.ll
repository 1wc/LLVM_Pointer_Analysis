; ModuleID = 'test26.bc'
source_filename = "test26.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }
%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !24 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !25, metadata !26), !dbg !27
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !28, metadata !26), !dbg !29
  %0 = load i32, i32* %a.addr, align 4, !dbg !30
  %1 = load i32, i32* %b.addr, align 4, !dbg !31
  %add = add nsw i32 %0, %1, !dbg !32
  ret i32 %add, !dbg !33
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !34 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !35, metadata !26), !dbg !36
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !37, metadata !26), !dbg !38
  %0 = load i32, i32* %a.addr, align 4, !dbg !39
  %1 = load i32, i32* %b.addr, align 4, !dbg !40
  %sub = sub nsw i32 %0, %1, !dbg !41
  ret i32 %sub, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_alias(%struct.wfsptr* %a, %struct.fsptr* %b) #0 !dbg !43 {
entry:
  %a.addr = alloca %struct.wfsptr*, align 8
  %b.addr = alloca %struct.fsptr*, align 8
  store %struct.wfsptr* %a, %struct.wfsptr** %a.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a.addr, metadata !46, metadata !26), !dbg !47
  store %struct.fsptr* %b, %struct.fsptr** %b.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b.addr, metadata !48, metadata !26), !dbg !49
  %0 = load %struct.fsptr*, %struct.fsptr** %b.addr, align 8, !dbg !50
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !51
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !51
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %1, i32 0, i32 0, !dbg !52
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !52
  %3 = load %struct.wfsptr*, %struct.wfsptr** %a.addr, align 8, !dbg !53
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !54
  %4 = load %struct.fsptr*, %struct.fsptr** %wfptr, align 8, !dbg !54
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !55
  %5 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !55
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !56
  store i32 (i32, i32)* %2, i32 (i32, i32)** %p_fptr2, align 8, !dbg !57
  ret void, !dbg !58
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %x) #0 !dbg !59 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %b_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  %m_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.wfsptr*, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !62, metadata !26), !dbg !63
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !64, metadata !26), !dbg !65
  call void @llvm.dbg.declare(metadata %struct.fptr* %b_fptr, metadata !66, metadata !26), !dbg !67
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !68, metadata !26), !dbg !69
  call void @llvm.dbg.declare(metadata %struct.fsptr* %m_fptr, metadata !70, metadata !26), !dbg !71
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %w_fptr, metadata !72, metadata !26), !dbg !73
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !74
  %0 = bitcast i8* %call to %struct.wfsptr*, !dbg !75
  store %struct.wfsptr* %0, %struct.wfsptr** %w_fptr, align 8, !dbg !73
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !76
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !77
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !78
  store %struct.fptr* %b_fptr, %struct.fptr** %sptr1, align 8, !dbg !79
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0, !dbg !80
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr, align 8, !dbg !81
  %1 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !82
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %1, i32 0, i32 0, !dbg !83
  store %struct.fsptr* %s_fptr, %struct.fsptr** %wfptr, align 8, !dbg !84
  %2 = load i32, i32* %x.addr, align 4, !dbg !85
  %cmp = icmp sgt i32 %2, 1, !dbg !87
  br i1 %cmp, label %if.then, label %if.else, !dbg !88

if.then:                                          ; preds = %entry
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !89
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr2, align 8, !dbg !91
  %sptr3 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !92
  %3 = load %struct.fptr*, %struct.fptr** %sptr3, align 8, !dbg !92
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !93
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr4, align 8, !dbg !93
  %5 = load i32, i32* %x.addr, align 4, !dbg !94
  %call5 = call i32 %4(i32 1, i32 %5), !dbg !95
  store i32 %call5, i32* %x.addr, align 4, !dbg !96
  %6 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !97
  call void @make_alias(%struct.wfsptr* %6, %struct.fsptr* %m_fptr), !dbg !98
  br label %if.end, !dbg !99

if.else:                                          ; preds = %entry
  %7 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !100
  %wfptr6 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %7, i32 0, i32 0, !dbg !102
  %8 = load %struct.fsptr*, %struct.fsptr** %wfptr6, align 8, !dbg !102
  %sptr7 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %8, i32 0, i32 0, !dbg !103
  %9 = load %struct.fptr*, %struct.fptr** %sptr7, align 8, !dbg !103
  %p_fptr8 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !104
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr8, align 8, !dbg !105
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr9 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !106
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr9, align 8, !dbg !106
  %11 = load i32, i32* %x.addr, align 4, !dbg !107
  %call10 = call i32 %10(i32 1, i32 %11), !dbg !108
  store i32 %call10, i32* %x.addr, align 4, !dbg !109
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

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
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
!23 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
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
