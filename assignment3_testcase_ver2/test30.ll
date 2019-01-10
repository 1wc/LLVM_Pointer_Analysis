; ModuleID = 'test30.bc'
source_filename = "test30.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

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
define i32 (i32, i32)* @foo(i32 %a, i32 %b, %struct.fptr* %c_fptr, %struct.fptr* %d_fptr) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c_fptr.addr = alloca %struct.fptr*, align 8
  %d_fptr.addr = alloca %struct.fptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !37, metadata !12), !dbg !38
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !39, metadata !12), !dbg !40
  store %struct.fptr* %c_fptr, %struct.fptr** %c_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %c_fptr.addr, metadata !41, metadata !12), !dbg !42
  store %struct.fptr* %d_fptr, %struct.fptr** %d_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %d_fptr.addr, metadata !43, metadata !12), !dbg !44
  %0 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !45
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %0, i32 0, i32 0, !dbg !46
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !46
  ret i32 (i32, i32)* %1, !dbg !47
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 (i32, i32)* @clever(i32 %a, i32 %b, %struct.fptr* %c_fptr, %struct.fptr* %d_fptr) #0 !dbg !48 {
entry:
  %retval = alloca i32 (i32, i32)*, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c_fptr.addr = alloca %struct.fptr*, align 8
  %d_fptr.addr = alloca %struct.fptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !49, metadata !12), !dbg !50
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !51, metadata !12), !dbg !52
  store %struct.fptr* %c_fptr, %struct.fptr** %c_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %c_fptr.addr, metadata !53, metadata !12), !dbg !54
  store %struct.fptr* %d_fptr, %struct.fptr** %d_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %d_fptr.addr, metadata !55, metadata !12), !dbg !56
  %0 = load i32, i32* %a.addr, align 4, !dbg !57
  %cmp = icmp sgt i32 %0, 0, !dbg !59
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !60

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %b.addr, align 4, !dbg !61
  %cmp1 = icmp slt i32 %1, 0, !dbg !62
  br i1 %cmp1, label %if.then, label %if.end, !dbg !63

if.then:                                          ; preds = %land.lhs.true
  %2 = load %struct.fptr*, %struct.fptr** %d_fptr.addr, align 8, !dbg !64
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !66
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !66
  store i32 (i32, i32)* %3, i32 (i32, i32)** %retval, align 8, !dbg !67
  br label %return, !dbg !67

if.end:                                           ; preds = %land.lhs.true, %entry
  %4 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !68
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !69
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !69
  store i32 (i32, i32)* %5, i32 (i32, i32)** %retval, align 8, !dbg !70
  br label %return, !dbg !70

return:                                           ; preds = %if.end, %if.then
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %retval, align 8, !dbg !71
  ret i32 (i32, i32)* %6, !dbg !71
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !72 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fptr, align 8
  %goo_ptr = alloca i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)*, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !76, metadata !12), !dbg !77
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !78, metadata !12), !dbg !79
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !80, metadata !12), !dbg !81
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !82, metadata !12), !dbg !83
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !84
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !85
  call void @llvm.dbg.declare(metadata %struct.fptr* %s_fptr, metadata !86, metadata !12), !dbg !87
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %s_fptr, i32 0, i32 0, !dbg !88
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !89
  call void @llvm.dbg.declare(metadata i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)** %goo_ptr, metadata !90, metadata !12), !dbg !92
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !93, metadata !12), !dbg !94
  store i32 (i32, i32)* null, i32 (i32, i32)** %t_fptr, align 8, !dbg !94
  %0 = load i8, i8* %x.addr, align 1, !dbg !95
  %conv = sext i8 %0 to i32, !dbg !95
  %cmp = icmp eq i32 %conv, 43, !dbg !97
  br i1 %cmp, label %if.then, label %if.else, !dbg !98

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)* @foo, i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)** %goo_ptr, align 8, !dbg !99
  br label %if.end7, !dbg !101

if.else:                                          ; preds = %entry
  %1 = load i8, i8* %x.addr, align 1, !dbg !102
  %conv3 = sext i8 %1 to i32, !dbg !102
  %cmp4 = icmp eq i32 %conv3, 45, !dbg !104
  br i1 %cmp4, label %if.then6, label %if.end, !dbg !105

if.then6:                                         ; preds = %if.else
  store i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)* @clever, i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)** %goo_ptr, align 8, !dbg !106
  br label %if.end, !dbg !108

if.end:                                           ; preds = %if.then6, %if.else
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then
  %2 = load i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)*, i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)** %goo_ptr, align 8, !dbg !109
  %3 = load i32, i32* %op1.addr, align 4, !dbg !110
  %4 = load i32, i32* %op2.addr, align 4, !dbg !111
  %call = call i32 (i32, i32)* %2(i32 %3, i32 %4, %struct.fptr* %a_fptr, %struct.fptr* %s_fptr), !dbg !109
  store i32 (i32, i32)* %call, i32 (i32, i32)** %t_fptr, align 8, !dbg !112
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !113
  %6 = load i32, i32* %op1.addr, align 4, !dbg !114
  %7 = load i32, i32* %op2.addr, align 4, !dbg !115
  %call8 = call i32 %5(i32 %6, i32 %7), !dbg !113
  ret i32 0, !dbg !116
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test30.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
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
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 14, type: !30, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32, !10, !10, !33, !33}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !35)
!35 = !{!36}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !34, file: !1, line: 4, baseType: !32, size: 64)
!37 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 14, type: !10)
!38 = !DILocation(line: 14, column: 15, scope: !29)
!39 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 14, type: !10)
!40 = !DILocation(line: 14, column: 22, scope: !29)
!41 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !29, file: !1, line: 14, type: !33)
!42 = !DILocation(line: 14, column: 39, scope: !29)
!43 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !29, file: !1, line: 14, type: !33)
!44 = !DILocation(line: 14, column: 61, scope: !29)
!45 = !DILocation(line: 15, column: 11, scope: !29)
!46 = !DILocation(line: 15, column: 19, scope: !29)
!47 = !DILocation(line: 15, column: 4, scope: !29)
!48 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 18, type: !30, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DILocalVariable(name: "a", arg: 1, scope: !48, file: !1, line: 18, type: !10)
!50 = !DILocation(line: 18, column: 18, scope: !48)
!51 = !DILocalVariable(name: "b", arg: 2, scope: !48, file: !1, line: 18, type: !10)
!52 = !DILocation(line: 18, column: 25, scope: !48)
!53 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !48, file: !1, line: 18, type: !33)
!54 = !DILocation(line: 18, column: 42, scope: !48)
!55 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !48, file: !1, line: 18, type: !33)
!56 = !DILocation(line: 18, column: 64, scope: !48)
!57 = !DILocation(line: 19, column: 6, scope: !58)
!58 = distinct !DILexicalBlock(scope: !48, file: !1, line: 19, column: 6)
!59 = !DILocation(line: 19, column: 7, scope: !58)
!60 = !DILocation(line: 19, column: 10, scope: !58)
!61 = !DILocation(line: 19, column: 13, scope: !58)
!62 = !DILocation(line: 19, column: 14, scope: !58)
!63 = !DILocation(line: 19, column: 6, scope: !48)
!64 = !DILocation(line: 21, column: 11, scope: !65)
!65 = distinct !DILexicalBlock(scope: !58, file: !1, line: 20, column: 3)
!66 = !DILocation(line: 21, column: 19, scope: !65)
!67 = !DILocation(line: 21, column: 4, scope: !65)
!68 = !DILocation(line: 23, column: 10, scope: !48)
!69 = !DILocation(line: 23, column: 18, scope: !48)
!70 = !DILocation(line: 23, column: 3, scope: !48)
!71 = !DILocation(line: 24, column: 1, scope: !48)
!72 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 26, type: !73, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!73 = !DISubroutineType(types: !74)
!74 = !{!10, !75, !10, !10}
!75 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!76 = !DILocalVariable(name: "x", arg: 1, scope: !72, file: !1, line: 26, type: !75)
!77 = !DILocation(line: 26, column: 14, scope: !72)
!78 = !DILocalVariable(name: "op1", arg: 2, scope: !72, file: !1, line: 26, type: !10)
!79 = !DILocation(line: 26, column: 21, scope: !72)
!80 = !DILocalVariable(name: "op2", arg: 3, scope: !72, file: !1, line: 26, type: !10)
!81 = !DILocation(line: 26, column: 30, scope: !72)
!82 = !DILocalVariable(name: "a_fptr", scope: !72, file: !1, line: 27, type: !34)
!83 = !DILocation(line: 27, column: 17, scope: !72)
!84 = !DILocation(line: 28, column: 12, scope: !72)
!85 = !DILocation(line: 28, column: 18, scope: !72)
!86 = !DILocalVariable(name: "s_fptr", scope: !72, file: !1, line: 29, type: !34)
!87 = !DILocation(line: 29, column: 17, scope: !72)
!88 = !DILocation(line: 30, column: 12, scope: !72)
!89 = !DILocation(line: 30, column: 18, scope: !72)
!90 = !DILocalVariable(name: "goo_ptr", scope: !72, file: !1, line: 32, type: !91)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!92 = !DILocation(line: 32, column: 14, scope: !72)
!93 = !DILocalVariable(name: "t_fptr", scope: !72, file: !1, line: 33, type: !32)
!94 = !DILocation(line: 33, column: 11, scope: !72)
!95 = !DILocation(line: 35, column: 9, scope: !96)
!96 = distinct !DILexicalBlock(scope: !72, file: !1, line: 35, column: 9)
!97 = !DILocation(line: 35, column: 11, scope: !96)
!98 = !DILocation(line: 35, column: 9, scope: !72)
!99 = !DILocation(line: 36, column: 16, scope: !100)
!100 = distinct !DILexicalBlock(scope: !96, file: !1, line: 35, column: 19)
!101 = !DILocation(line: 37, column: 5, scope: !100)
!102 = !DILocation(line: 38, column: 14, scope: !103)
!103 = distinct !DILexicalBlock(scope: !96, file: !1, line: 38, column: 14)
!104 = !DILocation(line: 38, column: 16, scope: !103)
!105 = !DILocation(line: 38, column: 14, scope: !96)
!106 = !DILocation(line: 39, column: 16, scope: !107)
!107 = distinct !DILexicalBlock(scope: !103, file: !1, line: 38, column: 24)
!108 = !DILocation(line: 40, column: 5, scope: !107)
!109 = !DILocation(line: 42, column: 14, scope: !72)
!110 = !DILocation(line: 42, column: 22, scope: !72)
!111 = !DILocation(line: 42, column: 27, scope: !72)
!112 = !DILocation(line: 42, column: 12, scope: !72)
!113 = !DILocation(line: 43, column: 5, scope: !72)
!114 = !DILocation(line: 43, column: 12, scope: !72)
!115 = !DILocation(line: 43, column: 17, scope: !72)
!116 = !DILocation(line: 45, column: 5, scope: !72)
