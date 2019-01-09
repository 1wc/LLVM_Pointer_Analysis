; ModuleID = 'test03.bc'
source_filename = "test03.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !9 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !13, metadata !14), !dbg !15
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !16, metadata !14), !dbg !17
  %0 = load i32, i32* %a.addr, align 4, !dbg !18
  %1 = load i32, i32* %b.addr, align 4, !dbg !19
  %add = add nsw i32 %0, %1, !dbg !20
  ret i32 %add, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !22 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !23, metadata !14), !dbg !24
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !25, metadata !14), !dbg !26
  %0 = load i32, i32* %a.addr, align 4, !dbg !27
  %1 = load i32, i32* %b.addr, align 4, !dbg !28
  %sub = sub nsw i32 %0, %1, !dbg !29
  ret i32 %sub, !dbg !30
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32 %x) #0 !dbg !31 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca [2 x i32 (i32, i32)*], align 16
  %op1 = alloca i32, align 4
  %op2 = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !34, metadata !14), !dbg !35
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !36, metadata !14), !dbg !38
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !38
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !39, metadata !14), !dbg !40
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !40
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %t_fptr, metadata !41, metadata !14), !dbg !45
  %0 = bitcast [2 x i32 (i32, i32)*]* %t_fptr to i8*, !dbg !45
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 16, i32 16, i1 false), !dbg !45
  call void @llvm.dbg.declare(metadata i32* %op1, metadata !46, metadata !14), !dbg !47
  store i32 1, i32* %op1, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata i32* %op2, metadata !48, metadata !14), !dbg !49
  store i32 2, i32* %op2, align 4, !dbg !49
  %1 = load i32, i32* %x.addr, align 4, !dbg !50
  %cmp = icmp eq i32 %1, 3, !dbg !52
  br i1 %cmp, label %if.then, label %if.end, !dbg !53

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !54
  %arrayidx = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 0, !dbg !56
  store i32 (i32, i32)* %2, i32 (i32, i32)** %arrayidx, align 16, !dbg !57
  br label %if.end, !dbg !58

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32, i32* %x.addr, align 4, !dbg !59
  %cmp1 = icmp eq i32 %3, 4, !dbg !61
  br i1 %cmp1, label %if.then2, label %if.end4, !dbg !62

if.then2:                                         ; preds = %if.end
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !63
  %arrayidx3 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 0, !dbg !65
  store i32 (i32, i32)* %4, i32 (i32, i32)** %arrayidx3, align 16, !dbg !66
  br label %if.end4, !dbg !67

if.end4:                                          ; preds = %if.then2, %if.end
  %arrayidx5 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 0, !dbg !68
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx5, align 16, !dbg !68
  %cmp6 = icmp ne i32 (i32, i32)* %5, null, !dbg !70
  br i1 %cmp6, label %if.then7, label %if.end9, !dbg !71

if.then7:                                         ; preds = %if.end4
  call void @llvm.dbg.declare(metadata i32* %result, metadata !72, metadata !14), !dbg !75
  %arrayidx8 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 0, !dbg !76
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx8, align 16, !dbg !76
  %7 = load i32, i32* %op1, align 4, !dbg !77
  %8 = load i32, i32* %op2, align 4, !dbg !78
  %call = call i32 %6(i32 %7, i32 %8), !dbg !76
  store i32 %call, i32* %result, align 4, !dbg !75
  br label %if.end9, !dbg !79

if.end9:                                          ; preds = %if.then7, %if.end4
  ret i32 0, !dbg !80
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test03.c", directory: "/home/liwc/compile/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!9 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !10, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 3, column: 14, scope: !9)
!16 = !DILocalVariable(name: "b", arg: 2, scope: !9, file: !1, line: 3, type: !12)
!17 = !DILocation(line: 3, column: 21, scope: !9)
!18 = !DILocation(line: 4, column: 11, scope: !9)
!19 = !DILocation(line: 4, column: 13, scope: !9)
!20 = !DILocation(line: 4, column: 12, scope: !9)
!21 = !DILocation(line: 4, column: 4, scope: !9)
!22 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !10, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 7, type: !12)
!24 = !DILocation(line: 7, column: 15, scope: !22)
!25 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 7, type: !12)
!26 = !DILocation(line: 7, column: 22, scope: !22)
!27 = !DILocation(line: 8, column: 11, scope: !22)
!28 = !DILocation(line: 8, column: 13, scope: !22)
!29 = !DILocation(line: 8, column: 12, scope: !22)
!30 = !DILocation(line: 8, column: 4, scope: !22)
!31 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 11, type: !32, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!12, !12}
!34 = !DILocalVariable(name: "x", arg: 1, scope: !31, file: !1, line: 11, type: !12)
!35 = !DILocation(line: 11, column: 16, scope: !31)
!36 = !DILocalVariable(name: "a_fptr", scope: !31, file: !1, line: 12, type: !37)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!38 = !DILocation(line: 12, column: 11, scope: !31)
!39 = !DILocalVariable(name: "s_fptr", scope: !31, file: !1, line: 13, type: !37)
!40 = !DILocation(line: 13, column: 11, scope: !31)
!41 = !DILocalVariable(name: "t_fptr", scope: !31, file: !1, line: 14, type: !42)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 128, elements: !43)
!43 = !{!44}
!44 = !DISubrange(count: 2)
!45 = !DILocation(line: 14, column: 11, scope: !31)
!46 = !DILocalVariable(name: "op1", scope: !31, file: !1, line: 16, type: !12)
!47 = !DILocation(line: 16, column: 9, scope: !31)
!48 = !DILocalVariable(name: "op2", scope: !31, file: !1, line: 16, type: !12)
!49 = !DILocation(line: 16, column: 16, scope: !31)
!50 = !DILocation(line: 18, column: 9, scope: !51)
!51 = distinct !DILexicalBlock(scope: !31, file: !1, line: 18, column: 9)
!52 = !DILocation(line: 18, column: 11, scope: !51)
!53 = !DILocation(line: 18, column: 9, scope: !31)
!54 = !DILocation(line: 19, column: 20, scope: !55)
!55 = distinct !DILexicalBlock(scope: !51, file: !1, line: 18, column: 17)
!56 = !DILocation(line: 19, column: 8, scope: !55)
!57 = !DILocation(line: 19, column: 18, scope: !55)
!58 = !DILocation(line: 20, column: 5, scope: !55)
!59 = !DILocation(line: 21, column: 9, scope: !60)
!60 = distinct !DILexicalBlock(scope: !31, file: !1, line: 21, column: 9)
!61 = !DILocation(line: 21, column: 11, scope: !60)
!62 = !DILocation(line: 21, column: 9, scope: !31)
!63 = !DILocation(line: 22, column: 19, scope: !64)
!64 = distinct !DILexicalBlock(scope: !60, file: !1, line: 21, column: 17)
!65 = !DILocation(line: 22, column: 8, scope: !64)
!66 = !DILocation(line: 22, column: 17, scope: !64)
!67 = !DILocation(line: 23, column: 5, scope: !64)
!68 = !DILocation(line: 26, column: 9, scope: !69)
!69 = distinct !DILexicalBlock(scope: !31, file: !1, line: 26, column: 9)
!70 = !DILocation(line: 26, column: 19, scope: !69)
!71 = !DILocation(line: 26, column: 9, scope: !31)
!72 = !DILocalVariable(name: "result", scope: !73, file: !1, line: 27, type: !74)
!73 = distinct !DILexicalBlock(scope: !69, file: !1, line: 26, column: 28)
!74 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!75 = !DILocation(line: 27, column: 17, scope: !73)
!76 = !DILocation(line: 27, column: 26, scope: !73)
!77 = !DILocation(line: 27, column: 36, scope: !73)
!78 = !DILocation(line: 27, column: 41, scope: !73)
!79 = !DILocation(line: 28, column: 5, scope: !73)
!80 = !DILocation(line: 29, column: 4, scope: !31)
