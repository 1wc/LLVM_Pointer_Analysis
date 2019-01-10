; ModuleID = 'test20.bc'
source_filename = "test20.c"
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
define %struct.fptr* @foo(i32 %a, i32 %b, %struct.fsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.fsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !41, metadata !12), !dbg !42
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !43, metadata !12), !dbg !44
  store %struct.fsptr* %a_fptr, %struct.fsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a_fptr.addr, metadata !45, metadata !12), !dbg !46
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !47, metadata !12), !dbg !48
  %0 = load %struct.fsptr*, %struct.fsptr** %a_fptr.addr, align 8, !dbg !49
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !50
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !50
  ret %struct.fptr* %1, !dbg !51
}

; Function Attrs: noinline nounwind optnone uwtable
define %struct.fptr* @clever(i32 %a, i32 %b, %struct.fsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !52 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.fsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !53, metadata !12), !dbg !54
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !55, metadata !12), !dbg !56
  store %struct.fsptr* %a_fptr, %struct.fsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a_fptr.addr, metadata !57, metadata !12), !dbg !58
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !59, metadata !12), !dbg !60
  %0 = load %struct.fsptr*, %struct.fsptr** %b_fptr.addr, align 8, !dbg !61
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !62
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !62
  ret %struct.fptr* %1, !dbg !63
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !64 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fptr, align 8
  %m_fptr = alloca %struct.fsptr, align 8
  %n_fptr = alloca %struct.fsptr, align 8
  %goo_ptr = alloca %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)*, align 8
  %t_fptr = alloca %struct.fptr*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !68, metadata !12), !dbg !69
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !70, metadata !12), !dbg !71
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !72, metadata !12), !dbg !73
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !74, metadata !12), !dbg !75
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !76
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !77
  call void @llvm.dbg.declare(metadata %struct.fptr* %s_fptr, metadata !78, metadata !12), !dbg !79
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %s_fptr, i32 0, i32 0, !dbg !80
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !81
  call void @llvm.dbg.declare(metadata %struct.fsptr* %m_fptr, metadata !82, metadata !12), !dbg !83
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !84
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !85
  call void @llvm.dbg.declare(metadata %struct.fsptr* %n_fptr, metadata !86, metadata !12), !dbg !87
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %n_fptr, i32 0, i32 0, !dbg !88
  store %struct.fptr* %s_fptr, %struct.fptr** %sptr2, align 8, !dbg !89
  call void @llvm.dbg.declare(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, metadata !90, metadata !12), !dbg !92
  call void @llvm.dbg.declare(metadata %struct.fptr** %t_fptr, metadata !93, metadata !12), !dbg !94
  store %struct.fptr* null, %struct.fptr** %t_fptr, align 8, !dbg !94
  %0 = load i8, i8* %x.addr, align 1, !dbg !95
  %conv = sext i8 %0 to i32, !dbg !95
  %cmp = icmp eq i32 %conv, 43, !dbg !97
  br i1 %cmp, label %if.then, label %if.else, !dbg !98

if.then:                                          ; preds = %entry
  store %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @foo, %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, align 8, !dbg !99
  br label %if.end8, !dbg !101

if.else:                                          ; preds = %entry
  %1 = load i8, i8* %x.addr, align 1, !dbg !102
  %conv4 = sext i8 %1 to i32, !dbg !102
  %cmp5 = icmp eq i32 %conv4, 45, !dbg !104
  br i1 %cmp5, label %if.then7, label %if.end, !dbg !105

if.then7:                                         ; preds = %if.else
  store %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @clever, %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, align 8, !dbg !106
  br label %if.end, !dbg !108

if.end:                                           ; preds = %if.then7, %if.else
  br label %if.end8

if.end8:                                          ; preds = %if.end, %if.then
  %2 = load %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)*, %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, align 8, !dbg !109
  %3 = load i32, i32* %op1.addr, align 4, !dbg !110
  %4 = load i32, i32* %op2.addr, align 4, !dbg !111
  %call = call %struct.fptr* %2(i32 %3, i32 %4, %struct.fsptr* %m_fptr, %struct.fsptr* %n_fptr), !dbg !109
  store %struct.fptr* %call, %struct.fptr** %t_fptr, align 8, !dbg !112
  %5 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !113
  %p_fptr9 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !114
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr9, align 8, !dbg !114
  %7 = load i32, i32* %op1.addr, align 4, !dbg !115
  %8 = load i32, i32* %op2.addr, align 4, !dbg !116
  %call10 = call i32 %6(i32 %7, i32 %8), !dbg !113
  ret i32 0, !dbg !117
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test20.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 14, type: !10)
!22 = !DILocation(line: 14, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 14, type: !10)
!24 = !DILocation(line: 14, column: 22, scope: !20)
!25 = !DILocation(line: 15, column: 11, scope: !20)
!26 = !DILocation(line: 15, column: 13, scope: !20)
!27 = !DILocation(line: 15, column: 12, scope: !20)
!28 = !DILocation(line: 15, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !30, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32, !10, !10, !37, !37}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !33, file: !1, line: 4, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !39)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !38, file: !1, line: 8, baseType: !32, size: 64)
!41 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 18, type: !10)
!42 = !DILocation(line: 18, column: 23, scope: !29)
!43 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 18, type: !10)
!44 = !DILocation(line: 18, column: 30, scope: !29)
!45 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 18, type: !37)
!46 = !DILocation(line: 18, column: 48, scope: !29)
!47 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !29, file: !1, line: 18, type: !37)
!48 = !DILocation(line: 18, column: 71, scope: !29)
!49 = !DILocation(line: 19, column: 11, scope: !29)
!50 = !DILocation(line: 19, column: 19, scope: !29)
!51 = !DILocation(line: 19, column: 4, scope: !29)
!52 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 22, type: !30, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!53 = !DILocalVariable(name: "a", arg: 1, scope: !52, file: !1, line: 22, type: !10)
!54 = !DILocation(line: 22, column: 26, scope: !52)
!55 = !DILocalVariable(name: "b", arg: 2, scope: !52, file: !1, line: 22, type: !10)
!56 = !DILocation(line: 22, column: 33, scope: !52)
!57 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !52, file: !1, line: 22, type: !37)
!58 = !DILocation(line: 22, column: 51, scope: !52)
!59 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !52, file: !1, line: 22, type: !37)
!60 = !DILocation(line: 22, column: 74, scope: !52)
!61 = !DILocation(line: 23, column: 11, scope: !52)
!62 = !DILocation(line: 23, column: 19, scope: !52)
!63 = !DILocation(line: 23, column: 4, scope: !52)
!64 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 26, type: !65, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!65 = !DISubroutineType(types: !66)
!66 = !{!10, !67, !10, !10}
!67 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!68 = !DILocalVariable(name: "x", arg: 1, scope: !64, file: !1, line: 26, type: !67)
!69 = !DILocation(line: 26, column: 14, scope: !64)
!70 = !DILocalVariable(name: "op1", arg: 2, scope: !64, file: !1, line: 26, type: !10)
!71 = !DILocation(line: 26, column: 21, scope: !64)
!72 = !DILocalVariable(name: "op2", arg: 3, scope: !64, file: !1, line: 26, type: !10)
!73 = !DILocation(line: 26, column: 30, scope: !64)
!74 = !DILocalVariable(name: "a_fptr", scope: !64, file: !1, line: 27, type: !33)
!75 = !DILocation(line: 27, column: 17, scope: !64)
!76 = !DILocation(line: 28, column: 12, scope: !64)
!77 = !DILocation(line: 28, column: 18, scope: !64)
!78 = !DILocalVariable(name: "s_fptr", scope: !64, file: !1, line: 29, type: !33)
!79 = !DILocation(line: 29, column: 17, scope: !64)
!80 = !DILocation(line: 30, column: 12, scope: !64)
!81 = !DILocation(line: 30, column: 18, scope: !64)
!82 = !DILocalVariable(name: "m_fptr", scope: !64, file: !1, line: 31, type: !38)
!83 = !DILocation(line: 31, column: 18, scope: !64)
!84 = !DILocation(line: 32, column: 12, scope: !64)
!85 = !DILocation(line: 32, column: 16, scope: !64)
!86 = !DILocalVariable(name: "n_fptr", scope: !64, file: !1, line: 33, type: !38)
!87 = !DILocation(line: 33, column: 18, scope: !64)
!88 = !DILocation(line: 34, column: 12, scope: !64)
!89 = !DILocation(line: 34, column: 16, scope: !64)
!90 = !DILocalVariable(name: "goo_ptr", scope: !64, file: !1, line: 36, type: !91)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!92 = !DILocation(line: 36, column: 20, scope: !64)
!93 = !DILocalVariable(name: "t_fptr", scope: !64, file: !1, line: 37, type: !32)
!94 = !DILocation(line: 37, column: 18, scope: !64)
!95 = !DILocation(line: 39, column: 9, scope: !96)
!96 = distinct !DILexicalBlock(scope: !64, file: !1, line: 39, column: 9)
!97 = !DILocation(line: 39, column: 11, scope: !96)
!98 = !DILocation(line: 39, column: 9, scope: !64)
!99 = !DILocation(line: 40, column: 16, scope: !100)
!100 = distinct !DILexicalBlock(scope: !96, file: !1, line: 39, column: 19)
!101 = !DILocation(line: 41, column: 5, scope: !100)
!102 = !DILocation(line: 42, column: 14, scope: !103)
!103 = distinct !DILexicalBlock(scope: !96, file: !1, line: 42, column: 14)
!104 = !DILocation(line: 42, column: 16, scope: !103)
!105 = !DILocation(line: 42, column: 14, scope: !96)
!106 = !DILocation(line: 43, column: 16, scope: !107)
!107 = distinct !DILexicalBlock(scope: !103, file: !1, line: 42, column: 24)
!108 = !DILocation(line: 45, column: 5, scope: !107)
!109 = !DILocation(line: 47, column: 14, scope: !64)
!110 = !DILocation(line: 47, column: 22, scope: !64)
!111 = !DILocation(line: 47, column: 27, scope: !64)
!112 = !DILocation(line: 47, column: 12, scope: !64)
!113 = !DILocation(line: 48, column: 5, scope: !64)
!114 = !DILocation(line: 48, column: 13, scope: !64)
!115 = !DILocation(line: 48, column: 20, scope: !64)
!116 = !DILocation(line: 48, column: 25, scope: !64)
!117 = !DILocation(line: 50, column: 5, scope: !64)
