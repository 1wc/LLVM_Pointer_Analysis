; ModuleID = 'test23.bc'
source_filename = "test23.c"
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
define i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !32 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !35, metadata !15), !dbg !36
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !37, metadata !15), !dbg !38
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !39, metadata !15), !dbg !40
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !41
  %1 = load i32, i32* %a.addr, align 4, !dbg !42
  %2 = load i32, i32* %b.addr, align 4, !dbg !43
  %call = call i32 %0(i32 %1, i32 %2), !dbg !41
  ret i32 %call, !dbg !44
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_simple_alias(i32 (i32, i32)** %af_ptr, i32 (i32, i32)** %bf_ptr) #0 !dbg !45 {
entry:
  %af_ptr.addr = alloca i32 (i32, i32)**, align 8
  %bf_ptr.addr = alloca i32 (i32, i32)**, align 8
  store i32 (i32, i32)** %af_ptr, i32 (i32, i32)*** %af_ptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %af_ptr.addr, metadata !48, metadata !15), !dbg !49
  store i32 (i32, i32)** %bf_ptr, i32 (i32, i32)*** %bf_ptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %bf_ptr.addr, metadata !50, metadata !15), !dbg !51
  %0 = load i32 (i32, i32)**, i32 (i32, i32)*** %bf_ptr.addr, align 8, !dbg !52
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %0, align 8, !dbg !53
  %2 = load i32 (i32, i32)**, i32 (i32, i32)*** %af_ptr.addr, align 8, !dbg !54
  store i32 (i32, i32)* %1, i32 (i32, i32)** %2, align 8, !dbg !55
  ret void, !dbg !56
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x) #0 !dbg !57 {
entry:
  %x.addr = alloca i8, align 1
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %pf_ptr = alloca i32 (i32, i32)**, align 8
  %mf_ptr = alloca i32 (i32, i32)**, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !61, metadata !15), !dbg !62
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !63, metadata !15), !dbg !65
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !65
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %pf_ptr, metadata !66, metadata !15), !dbg !67
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !68
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !69
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %pf_ptr, align 8, !dbg !67
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %mf_ptr, metadata !70, metadata !15), !dbg !71
  %call1 = call noalias i8* @malloc(i64 8) #3, !dbg !72
  %1 = bitcast i8* %call1 to i32 (i32, i32)**, !dbg !73
  store i32 (i32, i32)** %1, i32 (i32, i32)*** %mf_ptr, align 8, !dbg !71
  %2 = load i32 (i32, i32)**, i32 (i32, i32)*** %mf_ptr, align 8, !dbg !74
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %2, align 8, !dbg !75
  %3 = load i8, i8* %x.addr, align 1, !dbg !76
  %conv = sext i8 %3 to i32, !dbg !76
  %cmp = icmp eq i32 %conv, 43, !dbg !78
  br i1 %cmp, label %if.then, label %if.end, !dbg !79

if.then:                                          ; preds = %entry
  %4 = load i32 (i32, i32)**, i32 (i32, i32)*** %pf_ptr, align 8, !dbg !80
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %4, align 8, !dbg !82
  %5 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !83
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %pf_ptr, align 8, !dbg !84
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !85
  %call3 = call i32 %5(i32 1, i32 2, i32 (i32, i32)* %7), !dbg !83
  %8 = load i32 (i32, i32)**, i32 (i32, i32)*** %mf_ptr, align 8, !dbg !86
  %9 = load i32 (i32, i32)**, i32 (i32, i32)*** %pf_ptr, align 8, !dbg !87
  call void @make_simple_alias(i32 (i32, i32)** %8, i32 (i32, i32)** %9), !dbg !88
  br label %if.end, !dbg !89

if.end:                                           ; preds = %if.then, %entry
  %10 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !90
  %11 = load i32 (i32, i32)**, i32 (i32, i32)*** %mf_ptr, align 8, !dbg !91
  %12 = load i32 (i32, i32)*, i32 (i32, i32)** %11, align 8, !dbg !92
  %call4 = call i32 %10(i32 1, i32 2, i32 (i32, i32)* %12), !dbg !90
  ret i32 0, !dbg !93
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
!1 = !DIFile(filename: "test23.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!13 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !6, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!14 = !DILocalVariable(name: "a", arg: 1, scope: !13, file: !1, line: 3, type: !8)
!15 = !DIExpression()
!16 = !DILocation(line: 3, column: 14, scope: !13)
!17 = !DILocalVariable(name: "b", arg: 2, scope: !13, file: !1, line: 3, type: !8)
!18 = !DILocation(line: 3, column: 21, scope: !13)
!19 = !DILocation(line: 4, column: 11, scope: !13)
!20 = !DILocation(line: 4, column: 13, scope: !13)
!21 = !DILocation(line: 4, column: 12, scope: !13)
!22 = !DILocation(line: 4, column: 4, scope: !13)
!23 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !6, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!24 = !DILocalVariable(name: "a", arg: 1, scope: !23, file: !1, line: 7, type: !8)
!25 = !DILocation(line: 7, column: 15, scope: !23)
!26 = !DILocalVariable(name: "b", arg: 2, scope: !23, file: !1, line: 7, type: !8)
!27 = !DILocation(line: 7, column: 21, scope: !23)
!28 = !DILocation(line: 9, column: 12, scope: !23)
!29 = !DILocation(line: 9, column: 14, scope: !23)
!30 = !DILocation(line: 9, column: 13, scope: !23)
!31 = !DILocation(line: 9, column: 5, scope: !23)
!32 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !33, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!8, !8, !8, !5}
!35 = !DILocalVariable(name: "a", arg: 1, scope: !32, file: !1, line: 12, type: !8)
!36 = !DILocation(line: 12, column: 13, scope: !32)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !32, file: !1, line: 12, type: !8)
!38 = !DILocation(line: 12, column: 19, scope: !32)
!39 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !32, file: !1, line: 12, type: !5)
!40 = !DILocation(line: 12, column: 27, scope: !32)
!41 = !DILocation(line: 14, column: 12, scope: !32)
!42 = !DILocation(line: 14, column: 19, scope: !32)
!43 = !DILocation(line: 14, column: 21, scope: !32)
!44 = !DILocation(line: 14, column: 5, scope: !32)
!45 = distinct !DISubprogram(name: "make_simple_alias", scope: !1, file: !1, line: 17, type: !46, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{null, !4, !4}
!48 = !DILocalVariable(name: "af_ptr", arg: 1, scope: !45, file: !1, line: 17, type: !4)
!49 = !DILocation(line: 17, column: 31, scope: !45)
!50 = !DILocalVariable(name: "bf_ptr", arg: 2, scope: !45, file: !1, line: 17, type: !4)
!51 = !DILocation(line: 17, column: 55, scope: !45)
!52 = !DILocation(line: 19, column: 11, scope: !45)
!53 = !DILocation(line: 19, column: 10, scope: !45)
!54 = !DILocation(line: 19, column: 3, scope: !45)
!55 = !DILocation(line: 19, column: 9, scope: !45)
!56 = !DILocation(line: 20, column: 1, scope: !45)
!57 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 22, type: !58, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!58 = !DISubroutineType(types: !59)
!59 = !{!8, !60}
!60 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!61 = !DILocalVariable(name: "x", arg: 1, scope: !57, file: !1, line: 22, type: !60)
!62 = !DILocation(line: 22, column: 14, scope: !57)
!63 = !DILocalVariable(name: "af_ptr", scope: !57, file: !1, line: 24, type: !64)
!64 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!65 = !DILocation(line: 24, column: 11, scope: !57)
!66 = !DILocalVariable(name: "pf_ptr", scope: !57, file: !1, line: 25, type: !4)
!67 = !DILocation(line: 25, column: 12, scope: !57)
!68 = !DILocation(line: 25, column: 48, scope: !57)
!69 = !DILocation(line: 25, column: 29, scope: !57)
!70 = !DILocalVariable(name: "mf_ptr", scope: !57, file: !1, line: 26, type: !4)
!71 = !DILocation(line: 26, column: 12, scope: !57)
!72 = !DILocation(line: 26, column: 48, scope: !57)
!73 = !DILocation(line: 26, column: 29, scope: !57)
!74 = !DILocation(line: 27, column: 7, scope: !57)
!75 = !DILocation(line: 27, column: 13, scope: !57)
!76 = !DILocation(line: 28, column: 8, scope: !77)
!77 = distinct !DILexicalBlock(scope: !57, file: !1, line: 28, column: 8)
!78 = !DILocation(line: 28, column: 10, scope: !77)
!79 = !DILocation(line: 28, column: 8, scope: !57)
!80 = !DILocation(line: 29, column: 10, scope: !81)
!81 = distinct !DILexicalBlock(scope: !77, file: !1, line: 28, column: 17)
!82 = !DILocation(line: 29, column: 16, scope: !81)
!83 = !DILocation(line: 30, column: 9, scope: !81)
!84 = !DILocation(line: 30, column: 21, scope: !81)
!85 = !DILocation(line: 30, column: 20, scope: !81)
!86 = !DILocation(line: 31, column: 27, scope: !81)
!87 = !DILocation(line: 31, column: 34, scope: !81)
!88 = !DILocation(line: 31, column: 9, scope: !81)
!89 = !DILocation(line: 32, column: 5, scope: !81)
!90 = !DILocation(line: 33, column: 5, scope: !57)
!91 = !DILocation(line: 33, column: 17, scope: !57)
!92 = !DILocation(line: 33, column: 16, scope: !57)
!93 = !DILocation(line: 34, column: 5, scope: !57)
