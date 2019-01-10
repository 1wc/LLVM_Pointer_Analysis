; ModuleID = 'test11.bc'
source_filename = "test11.c"
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
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !32 {
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
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !45 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca i32 (i32, i32)**, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !49, metadata !15), !dbg !50
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !51, metadata !15), !dbg !52
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !53, metadata !15), !dbg !54
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !55, metadata !15), !dbg !56
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !57, metadata !15), !dbg !58
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %t_fptr, metadata !59, metadata !15), !dbg !60
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !61
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !62
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %t_fptr, align 8, !dbg !60
  %1 = load i8, i8* %x.addr, align 1, !dbg !63
  %conv = sext i8 %1 to i32, !dbg !63
  %cmp = icmp eq i32 %conv, 43, !dbg !65
  br i1 %cmp, label %if.then, label %if.end, !dbg !66

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !67
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !69
  store i32 (i32, i32)* %2, i32 (i32, i32)** %3, align 8, !dbg !70
  br label %if.end, !dbg !71

if.end:                                           ; preds = %if.then, %entry
  %4 = load i8, i8* %x.addr, align 1, !dbg !72
  %conv2 = sext i8 %4 to i32, !dbg !72
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !74
  br i1 %cmp3, label %if.then5, label %if.end6, !dbg !75

if.then5:                                         ; preds = %if.end
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !76
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !78
  store i32 (i32, i32)* %5, i32 (i32, i32)** %6, align 8, !dbg !79
  br label %if.end6, !dbg !80

if.end6:                                          ; preds = %if.then5, %if.end
  call void @llvm.dbg.declare(metadata i32* %result, metadata !81, metadata !15), !dbg !83
  %7 = load i32, i32* %op1.addr, align 4, !dbg !84
  %8 = load i32, i32* %op2.addr, align 4, !dbg !85
  %9 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !86
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %9, align 8, !dbg !87
  %call7 = call i32 @clever(i32 %7, i32 %8, i32 (i32, i32)* %10), !dbg !88
  store i32 %call7, i32* %result, align 4, !dbg !83
  ret i32 0, !dbg !89
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
!1 = !DIFile(filename: "test11.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!32 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !33, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!8, !8, !8, !5}
!35 = !DILocalVariable(name: "a", arg: 1, scope: !32, file: !1, line: 10, type: !8)
!36 = !DILocation(line: 10, column: 16, scope: !32)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !32, file: !1, line: 10, type: !8)
!38 = !DILocation(line: 10, column: 23, scope: !32)
!39 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !32, file: !1, line: 10, type: !5)
!40 = !DILocation(line: 10, column: 32, scope: !32)
!41 = !DILocation(line: 11, column: 12, scope: !32)
!42 = !DILocation(line: 11, column: 19, scope: !32)
!43 = !DILocation(line: 11, column: 22, scope: !32)
!44 = !DILocation(line: 11, column: 5, scope: !32)
!45 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 15, type: !46, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!46 = !DISubroutineType(types: !47)
!47 = !{!8, !48, !8, !8}
!48 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!49 = !DILocalVariable(name: "x", arg: 1, scope: !45, file: !1, line: 15, type: !48)
!50 = !DILocation(line: 15, column: 14, scope: !45)
!51 = !DILocalVariable(name: "op1", arg: 2, scope: !45, file: !1, line: 15, type: !8)
!52 = !DILocation(line: 15, column: 21, scope: !45)
!53 = !DILocalVariable(name: "op2", arg: 3, scope: !45, file: !1, line: 15, type: !8)
!54 = !DILocation(line: 15, column: 30, scope: !45)
!55 = !DILocalVariable(name: "a_fptr", scope: !45, file: !1, line: 16, type: !5)
!56 = !DILocation(line: 16, column: 11, scope: !45)
!57 = !DILocalVariable(name: "s_fptr", scope: !45, file: !1, line: 17, type: !5)
!58 = !DILocation(line: 17, column: 11, scope: !45)
!59 = !DILocalVariable(name: "t_fptr", scope: !45, file: !1, line: 18, type: !4)
!60 = !DILocation(line: 18, column: 12, scope: !45)
!61 = !DILocation(line: 18, column: 52, scope: !45)
!62 = !DILocation(line: 18, column: 32, scope: !45)
!63 = !DILocation(line: 20, column: 9, scope: !64)
!64 = distinct !DILexicalBlock(scope: !45, file: !1, line: 20, column: 9)
!65 = !DILocation(line: 20, column: 11, scope: !64)
!66 = !DILocation(line: 20, column: 9, scope: !45)
!67 = !DILocation(line: 21, column: 18, scope: !68)
!68 = distinct !DILexicalBlock(scope: !64, file: !1, line: 20, column: 19)
!69 = !DILocation(line: 21, column: 9, scope: !68)
!70 = !DILocation(line: 21, column: 16, scope: !68)
!71 = !DILocation(line: 22, column: 5, scope: !68)
!72 = !DILocation(line: 23, column: 9, scope: !73)
!73 = distinct !DILexicalBlock(scope: !45, file: !1, line: 23, column: 9)
!74 = !DILocation(line: 23, column: 11, scope: !73)
!75 = !DILocation(line: 23, column: 9, scope: !45)
!76 = !DILocation(line: 24, column: 18, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 23, column: 19)
!78 = !DILocation(line: 24, column: 9, scope: !77)
!79 = !DILocation(line: 24, column: 16, scope: !77)
!80 = !DILocation(line: 25, column: 5, scope: !77)
!81 = !DILocalVariable(name: "result", scope: !45, file: !1, line: 27, type: !82)
!82 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!83 = !DILocation(line: 27, column: 14, scope: !45)
!84 = !DILocation(line: 27, column: 30, scope: !45)
!85 = !DILocation(line: 27, column: 35, scope: !45)
!86 = !DILocation(line: 27, column: 41, scope: !45)
!87 = !DILocation(line: 27, column: 40, scope: !45)
!88 = !DILocation(line: 27, column: 23, scope: !45)
!89 = !DILocation(line: 28, column: 5, scope: !45)
