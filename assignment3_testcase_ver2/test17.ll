; ModuleID = 'test17.bc'
source_filename = "test17.c"
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
define i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !33, metadata !12), !dbg !34
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !35, metadata !12), !dbg !36
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !37, metadata !12), !dbg !38
  store i32 (i32, i32)* %b_fptr, i32 (i32, i32)** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %b_fptr.addr, metadata !39, metadata !12), !dbg !40
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %b_fptr.addr, align 8, !dbg !41
  ret i32 (i32, i32)* %0, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr.coerce) #0 !dbg !43 {
entry:
  %b_fptr = alloca %struct.fptr, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0
  store i32 (i32, i32)* %b_fptr.coerce, i32 (i32, i32)** %coerce.dive, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !49, metadata !12), !dbg !50
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !51, metadata !12), !dbg !52
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !53, metadata !12), !dbg !54
  call void @llvm.dbg.declare(metadata %struct.fptr* %b_fptr, metadata !55, metadata !12), !dbg !56
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !57, metadata !12), !dbg !58
  %0 = load i32, i32* %a.addr, align 4, !dbg !59
  %1 = load i32, i32* %b.addr, align 4, !dbg !60
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !61
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0, !dbg !62
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !62
  %call = call i32 (i32, i32)* @foo(i32 %0, i32 %1, i32 (i32, i32)* %2, i32 (i32, i32)* %3), !dbg !63
  store i32 (i32, i32)* %call, i32 (i32, i32)** %s_fptr, align 8, !dbg !64
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !65
  %5 = load i32, i32* %a.addr, align 4, !dbg !66
  %6 = load i32, i32* %b.addr, align 4, !dbg !67
  %call1 = call i32 %4(i32 %5, i32 %6), !dbg !65
  ret i32 %call1, !dbg !68
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !69 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca %struct.fptr, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !73, metadata !12), !dbg !74
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !75, metadata !12), !dbg !76
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !77, metadata !12), !dbg !78
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !79, metadata !12), !dbg !80
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !80
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !81, metadata !12), !dbg !82
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !82
  call void @llvm.dbg.declare(metadata %struct.fptr* %t_fptr, metadata !83, metadata !12), !dbg !84
  %0 = bitcast %struct.fptr* %t_fptr to i8*, !dbg !84
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8, i32 8, i1 false), !dbg !84
  %1 = load i8, i8* %x.addr, align 1, !dbg !85
  %conv = sext i8 %1 to i32, !dbg !85
  %cmp = icmp eq i32 %conv, 43, !dbg !87
  br i1 %cmp, label %if.then, label %if.else, !dbg !88

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !89
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !91
  store i32 (i32, i32)* %2, i32 (i32, i32)** %p_fptr, align 8, !dbg !92
  br label %if.end7, !dbg !93

if.else:                                          ; preds = %entry
  %3 = load i8, i8* %x.addr, align 1, !dbg !94
  %conv2 = sext i8 %3 to i32, !dbg !94
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !96
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !97

if.then5:                                         ; preds = %if.else
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !98
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !100
  store i32 (i32, i32)* %4, i32 (i32, i32)** %p_fptr6, align 8, !dbg !101
  br label %if.end, !dbg !102

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %result, metadata !103, metadata !12), !dbg !105
  %5 = load i32, i32* %op1.addr, align 4, !dbg !106
  %6 = load i32, i32* %op2.addr, align 4, !dbg !107
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !108
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !109
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %coerce.dive, align 8, !dbg !109
  %call = call i32 @clever(i32 %5, i32 %6, i32 (i32, i32)* %7, i32 (i32, i32)* %8), !dbg !109
  store i32 %call, i32* %result, align 4, !dbg !105
  ret i32 0, !dbg !110
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
!1 = !DIFile(filename: "test17.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!31 = !{!32, !10, !10, !32, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 14, type: !10)
!34 = !DILocation(line: 14, column: 15, scope: !29)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 14, type: !10)
!36 = !DILocation(line: 14, column: 22, scope: !29)
!37 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 14, type: !32)
!38 = !DILocation(line: 14, column: 31, scope: !29)
!39 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !29, file: !1, line: 14, type: !32)
!40 = !DILocation(line: 14, column: 55, scope: !29)
!41 = !DILocation(line: 15, column: 11, scope: !29)
!42 = !DILocation(line: 15, column: 4, scope: !29)
!43 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 18, type: !44, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DISubroutineType(types: !45)
!45 = !{!10, !10, !10, !32, !46}
!46 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !47)
!47 = !{!48}
!48 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !46, file: !1, line: 4, baseType: !32, size: 64)
!49 = !DILocalVariable(name: "a", arg: 1, scope: !43, file: !1, line: 18, type: !10)
!50 = !DILocation(line: 18, column: 16, scope: !43)
!51 = !DILocalVariable(name: "b", arg: 2, scope: !43, file: !1, line: 18, type: !10)
!52 = !DILocation(line: 18, column: 23, scope: !43)
!53 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !43, file: !1, line: 18, type: !32)
!54 = !DILocation(line: 18, column: 32, scope: !43)
!55 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !43, file: !1, line: 18, type: !46)
!56 = !DILocation(line: 18, column: 63, scope: !43)
!57 = !DILocalVariable(name: "s_fptr", scope: !43, file: !1, line: 19, type: !32)
!58 = !DILocation(line: 19, column: 10, scope: !43)
!59 = !DILocation(line: 20, column: 17, scope: !43)
!60 = !DILocation(line: 20, column: 20, scope: !43)
!61 = !DILocation(line: 20, column: 23, scope: !43)
!62 = !DILocation(line: 20, column: 38, scope: !43)
!63 = !DILocation(line: 20, column: 13, scope: !43)
!64 = !DILocation(line: 20, column: 11, scope: !43)
!65 = !DILocation(line: 21, column: 11, scope: !43)
!66 = !DILocation(line: 21, column: 18, scope: !43)
!67 = !DILocation(line: 21, column: 21, scope: !43)
!68 = !DILocation(line: 21, column: 4, scope: !43)
!69 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 25, type: !70, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!70 = !DISubroutineType(types: !71)
!71 = !{!10, !72, !10, !10}
!72 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!73 = !DILocalVariable(name: "x", arg: 1, scope: !69, file: !1, line: 25, type: !72)
!74 = !DILocation(line: 25, column: 14, scope: !69)
!75 = !DILocalVariable(name: "op1", arg: 2, scope: !69, file: !1, line: 25, type: !10)
!76 = !DILocation(line: 25, column: 21, scope: !69)
!77 = !DILocalVariable(name: "op2", arg: 3, scope: !69, file: !1, line: 25, type: !10)
!78 = !DILocation(line: 25, column: 30, scope: !69)
!79 = !DILocalVariable(name: "a_fptr", scope: !69, file: !1, line: 26, type: !32)
!80 = !DILocation(line: 26, column: 11, scope: !69)
!81 = !DILocalVariable(name: "s_fptr", scope: !69, file: !1, line: 27, type: !32)
!82 = !DILocation(line: 27, column: 11, scope: !69)
!83 = !DILocalVariable(name: "t_fptr", scope: !69, file: !1, line: 28, type: !46)
!84 = !DILocation(line: 28, column: 17, scope: !69)
!85 = !DILocation(line: 30, column: 9, scope: !86)
!86 = distinct !DILexicalBlock(scope: !69, file: !1, line: 30, column: 9)
!87 = !DILocation(line: 30, column: 11, scope: !86)
!88 = !DILocation(line: 30, column: 9, scope: !69)
!89 = !DILocation(line: 31, column: 24, scope: !90)
!90 = distinct !DILexicalBlock(scope: !86, file: !1, line: 30, column: 19)
!91 = !DILocation(line: 31, column: 15, scope: !90)
!92 = !DILocation(line: 31, column: 22, scope: !90)
!93 = !DILocation(line: 32, column: 5, scope: !90)
!94 = !DILocation(line: 33, column: 14, scope: !95)
!95 = distinct !DILexicalBlock(scope: !86, file: !1, line: 33, column: 14)
!96 = !DILocation(line: 33, column: 16, scope: !95)
!97 = !DILocation(line: 33, column: 14, scope: !86)
!98 = !DILocation(line: 34, column: 24, scope: !99)
!99 = distinct !DILexicalBlock(scope: !95, file: !1, line: 33, column: 24)
!100 = !DILocation(line: 34, column: 15, scope: !99)
!101 = !DILocation(line: 34, column: 22, scope: !99)
!102 = !DILocation(line: 35, column: 5, scope: !99)
!103 = !DILocalVariable(name: "result", scope: !69, file: !1, line: 37, type: !104)
!104 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!105 = !DILocation(line: 37, column: 14, scope: !69)
!106 = !DILocation(line: 37, column: 30, scope: !69)
!107 = !DILocation(line: 37, column: 35, scope: !69)
!108 = !DILocation(line: 37, column: 40, scope: !69)
!109 = !DILocation(line: 37, column: 23, scope: !69)
!110 = !DILocation(line: 38, column: 5, scope: !69)
