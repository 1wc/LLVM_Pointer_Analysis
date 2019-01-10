; ModuleID = 'test21.bc'
source_filename = "test21.c"
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
define i32 @clever(i32 %a, i32 %b, i32 (i32, i32)** %a_fptr) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)**, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !34, metadata !12), !dbg !35
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !36, metadata !12), !dbg !37
  store i32 (i32, i32)** %a_fptr, i32 (i32, i32)*** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %a_fptr.addr, metadata !38, metadata !12), !dbg !39
  %0 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr.addr, align 8, !dbg !40
  %arrayidx = getelementptr inbounds i32 (i32, i32)*, i32 (i32, i32)** %0, i64 2, !dbg !40
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx, align 8, !dbg !40
  %2 = load i32, i32* %a.addr, align 4, !dbg !41
  %3 = load i32, i32* %b.addr, align 4, !dbg !42
  %call = call i32 %1(i32 %2, i32 %3), !dbg !40
  ret i32 %call, !dbg !43
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !44 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca [3 x i32 (i32, i32)*], align 16
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !48, metadata !12), !dbg !49
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !50, metadata !12), !dbg !51
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !52, metadata !12), !dbg !53
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !54, metadata !12), !dbg !55
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !55
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !56, metadata !12), !dbg !57
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !57
  call void @llvm.dbg.declare(metadata [3 x i32 (i32, i32)*]* %t_fptr, metadata !58, metadata !12), !dbg !62
  %0 = bitcast [3 x i32 (i32, i32)*]* %t_fptr to i8*, !dbg !62
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 24, i32 16, i1 false), !dbg !62
  %1 = load i8, i8* %x.addr, align 1, !dbg !63
  %conv = sext i8 %1 to i32, !dbg !63
  %cmp = icmp eq i32 %conv, 43, !dbg !65
  br i1 %cmp, label %if.then, label %if.else, !dbg !66

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !67
  %arrayidx = getelementptr inbounds [3 x i32 (i32, i32)*], [3 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 2, !dbg !69
  store i32 (i32, i32)* %2, i32 (i32, i32)** %arrayidx, align 16, !dbg !70
  br label %if.end7, !dbg !71

if.else:                                          ; preds = %entry
  %3 = load i8, i8* %x.addr, align 1, !dbg !72
  %conv2 = sext i8 %3 to i32, !dbg !72
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !74
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !75

if.then5:                                         ; preds = %if.else
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !76
  %arrayidx6 = getelementptr inbounds [3 x i32 (i32, i32)*], [3 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 2, !dbg !78
  store i32 (i32, i32)* %4, i32 (i32, i32)** %arrayidx6, align 16, !dbg !79
  br label %if.end, !dbg !80

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %result, metadata !81, metadata !12), !dbg !83
  %5 = load i32, i32* %op1.addr, align 4, !dbg !84
  %6 = load i32, i32* %op2.addr, align 4, !dbg !85
  %arraydecay = getelementptr inbounds [3 x i32 (i32, i32)*], [3 x i32 (i32, i32)*]* %t_fptr, i32 0, i32 0, !dbg !86
  %call = call i32 @clever(i32 %5, i32 %6, i32 (i32, i32)** %arraydecay), !dbg !87
  store i32 %call, i32* %result, align 4, !dbg !83
  ret i32 0, !dbg !88
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
!1 = !DIFile(filename: "test21.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!29 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !30, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!34 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 14, type: !10)
!35 = !DILocation(line: 14, column: 16, scope: !29)
!36 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 14, type: !10)
!37 = !DILocation(line: 14, column: 23, scope: !29)
!38 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 14, type: !32)
!39 = !DILocation(line: 14, column: 32, scope: !29)
!40 = !DILocation(line: 15, column: 12, scope: !29)
!41 = !DILocation(line: 15, column: 22, scope: !29)
!42 = !DILocation(line: 15, column: 25, scope: !29)
!43 = !DILocation(line: 15, column: 5, scope: !29)
!44 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 19, type: !45, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!10, !47, !10, !10}
!47 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!48 = !DILocalVariable(name: "x", arg: 1, scope: !44, file: !1, line: 19, type: !47)
!49 = !DILocation(line: 19, column: 14, scope: !44)
!50 = !DILocalVariable(name: "op1", arg: 2, scope: !44, file: !1, line: 19, type: !10)
!51 = !DILocation(line: 19, column: 21, scope: !44)
!52 = !DILocalVariable(name: "op2", arg: 3, scope: !44, file: !1, line: 19, type: !10)
!53 = !DILocation(line: 19, column: 30, scope: !44)
!54 = !DILocalVariable(name: "a_fptr", scope: !44, file: !1, line: 20, type: !33)
!55 = !DILocation(line: 20, column: 11, scope: !44)
!56 = !DILocalVariable(name: "s_fptr", scope: !44, file: !1, line: 21, type: !33)
!57 = !DILocation(line: 21, column: 11, scope: !44)
!58 = !DILocalVariable(name: "t_fptr", scope: !44, file: !1, line: 22, type: !59)
!59 = !DICompositeType(tag: DW_TAG_array_type, baseType: !33, size: 192, elements: !60)
!60 = !{!61}
!61 = !DISubrange(count: 3)
!62 = !DILocation(line: 22, column: 11, scope: !44)
!63 = !DILocation(line: 24, column: 9, scope: !64)
!64 = distinct !DILexicalBlock(scope: !44, file: !1, line: 24, column: 9)
!65 = !DILocation(line: 24, column: 11, scope: !64)
!66 = !DILocation(line: 24, column: 9, scope: !44)
!67 = !DILocation(line: 25, column: 20, scope: !68)
!68 = distinct !DILexicalBlock(scope: !64, file: !1, line: 24, column: 19)
!69 = !DILocation(line: 25, column: 8, scope: !68)
!70 = !DILocation(line: 25, column: 18, scope: !68)
!71 = !DILocation(line: 26, column: 5, scope: !68)
!72 = !DILocation(line: 27, column: 14, scope: !73)
!73 = distinct !DILexicalBlock(scope: !64, file: !1, line: 27, column: 14)
!74 = !DILocation(line: 27, column: 16, scope: !73)
!75 = !DILocation(line: 27, column: 14, scope: !64)
!76 = !DILocation(line: 28, column: 20, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 27, column: 24)
!78 = !DILocation(line: 28, column: 8, scope: !77)
!79 = !DILocation(line: 28, column: 18, scope: !77)
!80 = !DILocation(line: 29, column: 5, scope: !77)
!81 = !DILocalVariable(name: "result", scope: !44, file: !1, line: 31, type: !82)
!82 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!83 = !DILocation(line: 31, column: 14, scope: !44)
!84 = !DILocation(line: 31, column: 30, scope: !44)
!85 = !DILocation(line: 31, column: 35, scope: !44)
!86 = !DILocation(line: 31, column: 40, scope: !44)
!87 = !DILocation(line: 31, column: 23, scope: !44)
!88 = !DILocation(line: 32, column: 5, scope: !44)
