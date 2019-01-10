; ModuleID = 'test18.bc'
source_filename = "test18.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

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
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !41
  ret i32 (i32, i32)* %0, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 (i32, i32)* @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !43 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !44, metadata !12), !dbg !45
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !46, metadata !12), !dbg !47
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !48, metadata !12), !dbg !49
  store i32 (i32, i32)* %b_fptr, i32 (i32, i32)** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %b_fptr.addr, metadata !50, metadata !12), !dbg !51
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %b_fptr.addr, align 8, !dbg !52
  ret i32 (i32, i32)* %0, !dbg !53
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !54 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %goo_ptr = alloca i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)*, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !58, metadata !12), !dbg !59
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !60, metadata !12), !dbg !61
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !62, metadata !12), !dbg !63
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !64, metadata !12), !dbg !65
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !65
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !66, metadata !12), !dbg !67
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !67
  call void @llvm.dbg.declare(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)** %goo_ptr, metadata !68, metadata !12), !dbg !70
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !71, metadata !12), !dbg !72
  store i32 (i32, i32)* null, i32 (i32, i32)** %t_fptr, align 8, !dbg !72
  %0 = load i8, i8* %x.addr, align 1, !dbg !73
  %conv = sext i8 %0 to i32, !dbg !73
  %cmp = icmp eq i32 %conv, 43, !dbg !75
  br i1 %cmp, label %if.then, label %if.else, !dbg !76

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @foo, i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)** %goo_ptr, align 8, !dbg !77
  br label %if.end6, !dbg !79

if.else:                                          ; preds = %entry
  %1 = load i8, i8* %x.addr, align 1, !dbg !80
  %conv2 = sext i8 %1 to i32, !dbg !80
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !82
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !83

if.then5:                                         ; preds = %if.else
  store i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @clever, i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)** %goo_ptr, align 8, !dbg !84
  br label %if.end, !dbg !86

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then
  %2 = load i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)*, i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)** %goo_ptr, align 8, !dbg !87
  %3 = load i32, i32* %op1.addr, align 4, !dbg !88
  %4 = load i32, i32* %op2.addr, align 4, !dbg !89
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !90
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !91
  %call = call i32 (i32, i32)* %2(i32 %3, i32 %4, i32 (i32, i32)* %5, i32 (i32, i32)* %6), !dbg !87
  store i32 (i32, i32)* %call, i32 (i32, i32)** %t_fptr, align 8, !dbg !92
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !93
  %8 = load i32, i32* %op1.addr, align 4, !dbg !94
  %9 = load i32, i32* %op2.addr, align 4, !dbg !95
  %call7 = call i32 %7(i32 %8, i32 %9), !dbg !93
  ret i32 0, !dbg !96
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test18.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 1, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 1, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 1, type: !10)
!15 = !DILocation(line: 1, column: 21, scope: !7)
!16 = !DILocation(line: 2, column: 11, scope: !7)
!17 = !DILocation(line: 2, column: 13, scope: !7)
!18 = !DILocation(line: 2, column: 12, scope: !7)
!19 = !DILocation(line: 2, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 5, type: !10)
!22 = !DILocation(line: 5, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 5, type: !10)
!24 = !DILocation(line: 5, column: 22, scope: !20)
!25 = !DILocation(line: 6, column: 11, scope: !20)
!26 = !DILocation(line: 6, column: 13, scope: !20)
!27 = !DILocation(line: 6, column: 12, scope: !20)
!28 = !DILocation(line: 6, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !30, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32, !10, !10, !32, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 9, type: !10)
!34 = !DILocation(line: 9, column: 15, scope: !29)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 9, type: !10)
!36 = !DILocation(line: 9, column: 22, scope: !29)
!37 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 9, type: !32)
!38 = !DILocation(line: 9, column: 31, scope: !29)
!39 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !29, file: !1, line: 9, type: !32)
!40 = !DILocation(line: 9, column: 55, scope: !29)
!41 = !DILocation(line: 10, column: 11, scope: !29)
!42 = !DILocation(line: 10, column: 4, scope: !29)
!43 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !30, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DILocalVariable(name: "a", arg: 1, scope: !43, file: !1, line: 13, type: !10)
!45 = !DILocation(line: 13, column: 18, scope: !43)
!46 = !DILocalVariable(name: "b", arg: 2, scope: !43, file: !1, line: 13, type: !10)
!47 = !DILocation(line: 13, column: 25, scope: !43)
!48 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !43, file: !1, line: 13, type: !32)
!49 = !DILocation(line: 13, column: 34, scope: !43)
!50 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !43, file: !1, line: 13, type: !32)
!51 = !DILocation(line: 13, column: 58, scope: !43)
!52 = !DILocation(line: 14, column: 11, scope: !43)
!53 = !DILocation(line: 14, column: 4, scope: !43)
!54 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 17, type: !55, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!55 = !DISubroutineType(types: !56)
!56 = !{!10, !57, !10, !10}
!57 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!58 = !DILocalVariable(name: "x", arg: 1, scope: !54, file: !1, line: 17, type: !57)
!59 = !DILocation(line: 17, column: 14, scope: !54)
!60 = !DILocalVariable(name: "op1", arg: 2, scope: !54, file: !1, line: 17, type: !10)
!61 = !DILocation(line: 17, column: 21, scope: !54)
!62 = !DILocalVariable(name: "op2", arg: 3, scope: !54, file: !1, line: 17, type: !10)
!63 = !DILocation(line: 17, column: 30, scope: !54)
!64 = !DILocalVariable(name: "a_fptr", scope: !54, file: !1, line: 18, type: !32)
!65 = !DILocation(line: 18, column: 11, scope: !54)
!66 = !DILocalVariable(name: "s_fptr", scope: !54, file: !1, line: 19, type: !32)
!67 = !DILocation(line: 19, column: 11, scope: !54)
!68 = !DILocalVariable(name: "goo_ptr", scope: !54, file: !1, line: 20, type: !69)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!70 = !DILocation(line: 20, column: 14, scope: !54)
!71 = !DILocalVariable(name: "t_fptr", scope: !54, file: !1, line: 21, type: !32)
!72 = !DILocation(line: 21, column: 11, scope: !54)
!73 = !DILocation(line: 23, column: 9, scope: !74)
!74 = distinct !DILexicalBlock(scope: !54, file: !1, line: 23, column: 9)
!75 = !DILocation(line: 23, column: 11, scope: !74)
!76 = !DILocation(line: 23, column: 9, scope: !54)
!77 = !DILocation(line: 24, column: 16, scope: !78)
!78 = distinct !DILexicalBlock(scope: !74, file: !1, line: 23, column: 19)
!79 = !DILocation(line: 25, column: 5, scope: !78)
!80 = !DILocation(line: 26, column: 14, scope: !81)
!81 = distinct !DILexicalBlock(scope: !74, file: !1, line: 26, column: 14)
!82 = !DILocation(line: 26, column: 16, scope: !81)
!83 = !DILocation(line: 26, column: 14, scope: !74)
!84 = !DILocation(line: 27, column: 16, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !1, line: 26, column: 24)
!86 = !DILocation(line: 28, column: 5, scope: !85)
!87 = !DILocation(line: 30, column: 14, scope: !54)
!88 = !DILocation(line: 30, column: 22, scope: !54)
!89 = !DILocation(line: 30, column: 27, scope: !54)
!90 = !DILocation(line: 30, column: 32, scope: !54)
!91 = !DILocation(line: 30, column: 40, scope: !54)
!92 = !DILocation(line: 30, column: 12, scope: !54)
!93 = !DILocation(line: 31, column: 5, scope: !54)
!94 = !DILocation(line: 31, column: 12, scope: !54)
!95 = !DILocation(line: 31, column: 17, scope: !54)
!96 = !DILocation(line: 33, column: 5, scope: !54)
