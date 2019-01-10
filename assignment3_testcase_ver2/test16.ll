; ModuleID = 'test16.bc'
source_filename = "test16.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !13 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !14, metadata !15), !dbg !16
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !17, metadata !15), !dbg !18
  %0 = load i32, i32* %a.addr, align 4, !dbg !19
  %1 = load i32, i32* %b.addr, align 4, !dbg !20
  %add = add nsw i32 %0, %1, !dbg !21
  ret i32 %add, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !23 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !24, metadata !15), !dbg !25
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !26, metadata !15), !dbg !27
  %0 = load i32, i32* %a.addr, align 4, !dbg !28
  %1 = load i32, i32* %b.addr, align 4, !dbg !29
  %sub = sub nsw i32 %0, %1, !dbg !30
  ret i32 %sub, !dbg !31
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !32 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !35, metadata !15), !dbg !36
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !37, metadata !15), !dbg !38
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !39, metadata !15), !dbg !40
  store i32 (i32, i32)* %b_fptr, i32 (i32, i32)** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %b_fptr.addr, metadata !41, metadata !15), !dbg !42
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !43
  ret i32 (i32, i32)* %0, !dbg !44
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %b_fptr) #0 !dbg !45 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)**, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !48, metadata !15), !dbg !49
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !50, metadata !15), !dbg !51
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !52, metadata !15), !dbg !53
  store i32 (i32, i32)** %b_fptr, i32 (i32, i32)*** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %b_fptr.addr, metadata !54, metadata !15), !dbg !55
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !56, metadata !15), !dbg !57
  %0 = load i32, i32* %a.addr, align 4, !dbg !58
  %1 = load i32, i32* %b.addr, align 4, !dbg !59
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !60
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %b_fptr.addr, align 8, !dbg !61
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !62
  %call = call i32 (i32, i32)* @foo(i32 %0, i32 %1, i32 (i32, i32)* %2, i32 (i32, i32)* %4), !dbg !63
  store i32 (i32, i32)* %call, i32 (i32, i32)** %s_fptr, align 8, !dbg !64
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !65
  %6 = load i32, i32* %a.addr, align 4, !dbg !66
  %7 = load i32, i32* %b.addr, align 4, !dbg !67
  %call1 = call i32 %5(i32 %6, i32 %7), !dbg !65
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
  %t_fptr = alloca i32 (i32, i32)**, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !73, metadata !15), !dbg !74
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !75, metadata !15), !dbg !76
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !77, metadata !15), !dbg !78
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !79, metadata !15), !dbg !80
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !80
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !81, metadata !15), !dbg !82
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !82
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %t_fptr, metadata !83, metadata !15), !dbg !84
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !85
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !86
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %t_fptr, align 8, !dbg !84
  %1 = load i8, i8* %x.addr, align 1, !dbg !87
  %conv = sext i8 %1 to i32, !dbg !87
  %cmp = icmp eq i32 %conv, 43, !dbg !89
  br i1 %cmp, label %if.then, label %if.else, !dbg !90

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !91
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !93
  store i32 (i32, i32)* %2, i32 (i32, i32)** %3, align 8, !dbg !94
  br label %if.end6, !dbg !95

if.else:                                          ; preds = %entry
  %4 = load i8, i8* %x.addr, align 1, !dbg !96
  %conv2 = sext i8 %4 to i32, !dbg !96
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !98
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !99

if.then5:                                         ; preds = %if.else
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !100
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !102
  store i32 (i32, i32)* %5, i32 (i32, i32)** %6, align 8, !dbg !103
  br label %if.end, !dbg !104

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %result, metadata !105, metadata !15), !dbg !107
  %7 = load i32, i32* %op1.addr, align 4, !dbg !108
  %8 = load i32, i32* %op2.addr, align 4, !dbg !109
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !110
  %10 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !111
  %call7 = call i32 @clever(i32 %7, i32 %8, i32 (i32, i32)* %9, i32 (i32, i32)** %10), !dbg !112
  store i32 %call7, i32* %result, align 4, !dbg !107
  ret i32 0, !dbg !113
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10, !11}
!llvm.ident = !{!12}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test16.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = !DISubroutineType(types: !7)
!7 = !{!8, !8, !8}
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{i32 2, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!13 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !6, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!14 = !DILocalVariable(name: "a", arg: 1, scope: !13, file: !1, line: 2, type: !8)
!15 = !DIExpression()
!16 = !DILocation(line: 2, column: 14, scope: !13)
!17 = !DILocalVariable(name: "b", arg: 2, scope: !13, file: !1, line: 2, type: !8)
!18 = !DILocation(line: 2, column: 21, scope: !13)
!19 = !DILocation(line: 3, column: 11, scope: !13)
!20 = !DILocation(line: 3, column: 13, scope: !13)
!21 = !DILocation(line: 3, column: 12, scope: !13)
!22 = !DILocation(line: 3, column: 4, scope: !13)
!23 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !6, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!24 = !DILocalVariable(name: "a", arg: 1, scope: !23, file: !1, line: 6, type: !8)
!25 = !DILocation(line: 6, column: 15, scope: !23)
!26 = !DILocalVariable(name: "b", arg: 2, scope: !23, file: !1, line: 6, type: !8)
!27 = !DILocation(line: 6, column: 22, scope: !23)
!28 = !DILocation(line: 7, column: 11, scope: !23)
!29 = !DILocation(line: 7, column: 13, scope: !23)
!30 = !DILocation(line: 7, column: 12, scope: !23)
!31 = !DILocation(line: 7, column: 4, scope: !23)
!32 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !33, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!5, !8, !8, !5, !5}
!35 = !DILocalVariable(name: "a", arg: 1, scope: !32, file: !1, line: 10, type: !8)
!36 = !DILocation(line: 10, column: 15, scope: !32)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !32, file: !1, line: 10, type: !8)
!38 = !DILocation(line: 10, column: 22, scope: !32)
!39 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !32, file: !1, line: 10, type: !5)
!40 = !DILocation(line: 10, column: 31, scope: !32)
!41 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !32, file: !1, line: 10, type: !5)
!42 = !DILocation(line: 10, column: 55, scope: !32)
!43 = !DILocation(line: 11, column: 11, scope: !32)
!44 = !DILocation(line: 11, column: 4, scope: !32)
!45 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !46, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!8, !8, !8, !5, !4}
!48 = !DILocalVariable(name: "a", arg: 1, scope: !45, file: !1, line: 14, type: !8)
!49 = !DILocation(line: 14, column: 16, scope: !45)
!50 = !DILocalVariable(name: "b", arg: 2, scope: !45, file: !1, line: 14, type: !8)
!51 = !DILocation(line: 14, column: 23, scope: !45)
!52 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !45, file: !1, line: 14, type: !5)
!53 = !DILocation(line: 14, column: 32, scope: !45)
!54 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !45, file: !1, line: 14, type: !4)
!55 = !DILocation(line: 14, column: 57, scope: !45)
!56 = !DILocalVariable(name: "s_fptr", scope: !45, file: !1, line: 15, type: !5)
!57 = !DILocation(line: 15, column: 10, scope: !45)
!58 = !DILocation(line: 16, column: 17, scope: !45)
!59 = !DILocation(line: 16, column: 20, scope: !45)
!60 = !DILocation(line: 16, column: 23, scope: !45)
!61 = !DILocation(line: 16, column: 32, scope: !45)
!62 = !DILocation(line: 16, column: 31, scope: !45)
!63 = !DILocation(line: 16, column: 13, scope: !45)
!64 = !DILocation(line: 16, column: 11, scope: !45)
!65 = !DILocation(line: 17, column: 11, scope: !45)
!66 = !DILocation(line: 17, column: 18, scope: !45)
!67 = !DILocation(line: 17, column: 21, scope: !45)
!68 = !DILocation(line: 17, column: 4, scope: !45)
!69 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 21, type: !70, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!70 = !DISubroutineType(types: !71)
!71 = !{!8, !72, !8, !8}
!72 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!73 = !DILocalVariable(name: "x", arg: 1, scope: !69, file: !1, line: 21, type: !72)
!74 = !DILocation(line: 21, column: 14, scope: !69)
!75 = !DILocalVariable(name: "op1", arg: 2, scope: !69, file: !1, line: 21, type: !8)
!76 = !DILocation(line: 21, column: 21, scope: !69)
!77 = !DILocalVariable(name: "op2", arg: 3, scope: !69, file: !1, line: 21, type: !8)
!78 = !DILocation(line: 21, column: 30, scope: !69)
!79 = !DILocalVariable(name: "a_fptr", scope: !69, file: !1, line: 22, type: !5)
!80 = !DILocation(line: 22, column: 11, scope: !69)
!81 = !DILocalVariable(name: "s_fptr", scope: !69, file: !1, line: 23, type: !5)
!82 = !DILocation(line: 23, column: 11, scope: !69)
!83 = !DILocalVariable(name: "t_fptr", scope: !69, file: !1, line: 24, type: !4)
!84 = !DILocation(line: 24, column: 12, scope: !69)
!85 = !DILocation(line: 24, column: 52, scope: !69)
!86 = !DILocation(line: 24, column: 32, scope: !69)
!87 = !DILocation(line: 26, column: 9, scope: !88)
!88 = distinct !DILexicalBlock(scope: !69, file: !1, line: 26, column: 9)
!89 = !DILocation(line: 26, column: 11, scope: !88)
!90 = !DILocation(line: 26, column: 9, scope: !69)
!91 = !DILocation(line: 27, column: 18, scope: !92)
!92 = distinct !DILexicalBlock(scope: !88, file: !1, line: 26, column: 19)
!93 = !DILocation(line: 27, column: 9, scope: !92)
!94 = !DILocation(line: 27, column: 16, scope: !92)
!95 = !DILocation(line: 28, column: 5, scope: !92)
!96 = !DILocation(line: 29, column: 14, scope: !97)
!97 = distinct !DILexicalBlock(scope: !88, file: !1, line: 29, column: 14)
!98 = !DILocation(line: 29, column: 16, scope: !97)
!99 = !DILocation(line: 29, column: 14, scope: !88)
!100 = !DILocation(line: 30, column: 18, scope: !101)
!101 = distinct !DILexicalBlock(scope: !97, file: !1, line: 29, column: 24)
!102 = !DILocation(line: 30, column: 9, scope: !101)
!103 = !DILocation(line: 30, column: 16, scope: !101)
!104 = !DILocation(line: 31, column: 5, scope: !101)
!105 = !DILocalVariable(name: "result", scope: !69, file: !1, line: 33, type: !106)
!106 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!107 = !DILocation(line: 33, column: 14, scope: !69)
!108 = !DILocation(line: 33, column: 30, scope: !69)
!109 = !DILocation(line: 33, column: 35, scope: !69)
!110 = !DILocation(line: 33, column: 40, scope: !69)
!111 = !DILocation(line: 33, column: 48, scope: !69)
!112 = !DILocation(line: 33, column: 23, scope: !69)
!113 = !DILocation(line: 34, column: 5, scope: !69)