; ModuleID = 'test00.bc'
source_filename = "test00.c"
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
define i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !33, metadata !12), !dbg !34
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !35, metadata !12), !dbg !36
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !37, metadata !12), !dbg !38
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !39
  %1 = load i32, i32* %a.addr, align 4, !dbg !40
  %2 = load i32, i32* %b.addr, align 4, !dbg !41
  %call = call i32 %0(i32 %1, i32 %2), !dbg !39
  ret i32 %call, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x) #0 !dbg !43 {
entry:
  %x.addr = alloca i8, align 1
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %pf_ptr = alloca i32 (i32, i32)*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !47, metadata !12), !dbg !48
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !49, metadata !12), !dbg !51
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !51
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %pf_ptr, metadata !52, metadata !12), !dbg !53
  store i32 (i32, i32)* null, i32 (i32, i32)** %pf_ptr, align 8, !dbg !53
  %0 = load i8, i8* %x.addr, align 1, !dbg !54
  %conv = sext i8 %0 to i32, !dbg !54
  %cmp = icmp eq i32 %conv, 43, !dbg !56
  br i1 %cmp, label %if.then, label %if.end, !dbg !57

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %pf_ptr, align 8, !dbg !58
  %1 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !60
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %pf_ptr, align 8, !dbg !61
  %call = call i32 %1(i32 1, i32 2, i32 (i32, i32)* %2), !dbg !60
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %pf_ptr, align 8, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !64
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %pf_ptr, align 8, !dbg !65
  %call2 = call i32 %3(i32 1, i32 2, i32 (i32, i32)* %4), !dbg !64
  ret i32 0, !dbg !66
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test00.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!15 = !DILocation(line: 3, column: 21, scope: !7)
!16 = !DILocation(line: 4, column: 11, scope: !7)
!17 = !DILocation(line: 4, column: 13, scope: !7)
!18 = !DILocation(line: 4, column: 12, scope: !7)
!19 = !DILocation(line: 4, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !8, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 7, type: !10)
!22 = !DILocation(line: 7, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 7, type: !10)
!24 = !DILocation(line: 7, column: 21, scope: !20)
!25 = !DILocation(line: 9, column: 12, scope: !20)
!26 = !DILocation(line: 9, column: 14, scope: !20)
!27 = !DILocation(line: 9, column: 13, scope: !20)
!28 = !DILocation(line: 9, column: 5, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !30, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 12, type: !10)
!34 = !DILocation(line: 12, column: 13, scope: !29)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 12, type: !10)
!36 = !DILocation(line: 12, column: 19, scope: !29)
!37 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 12, type: !32)
!38 = !DILocation(line: 12, column: 27, scope: !29)
!39 = !DILocation(line: 14, column: 12, scope: !29)
!40 = !DILocation(line: 14, column: 19, scope: !29)
!41 = !DILocation(line: 14, column: 21, scope: !29)
!42 = !DILocation(line: 14, column: 5, scope: !29)
!43 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 18, type: !44, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DISubroutineType(types: !45)
!45 = !{!10, !46}
!46 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!47 = !DILocalVariable(name: "x", arg: 1, scope: !43, file: !1, line: 18, type: !46)
!48 = !DILocation(line: 18, column: 14, scope: !43)
!49 = !DILocalVariable(name: "af_ptr", scope: !43, file: !1, line: 20, type: !50)
!50 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!51 = !DILocation(line: 20, column: 11, scope: !43)
!52 = !DILocalVariable(name: "pf_ptr", scope: !43, file: !1, line: 21, type: !32)
!53 = !DILocation(line: 21, column: 11, scope: !43)
!54 = !DILocation(line: 22, column: 8, scope: !55)
!55 = distinct !DILexicalBlock(scope: !43, file: !1, line: 22, column: 8)
!56 = !DILocation(line: 22, column: 10, scope: !55)
!57 = !DILocation(line: 22, column: 8, scope: !43)
!58 = !DILocation(line: 23, column: 15, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !1, line: 22, column: 17)
!60 = !DILocation(line: 24, column: 9, scope: !59)
!61 = !DILocation(line: 24, column: 20, scope: !59)
!62 = !DILocation(line: 25, column: 15, scope: !59)
!63 = !DILocation(line: 26, column: 5, scope: !59)
!64 = !DILocation(line: 27, column: 5, scope: !43)
!65 = !DILocation(line: 27, column: 16, scope: !43)
!66 = !DILocation(line: 28, column: 5, scope: !43)
