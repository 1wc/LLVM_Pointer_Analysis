; ModuleID = 'test06.bc'
source_filename = "test06.c"
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
define void @foo(i32 %x) #0 !dbg !32 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)**, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !35, metadata !15), !dbg !36
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %a_fptr, metadata !37, metadata !15), !dbg !38
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !39
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !40
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %a_fptr, align 8, !dbg !38
  %1 = load i32, i32* %x.addr, align 4, !dbg !41
  %cmp = icmp sgt i32 %1, 1, !dbg !43
  br i1 %cmp, label %if.then, label %if.else, !dbg !44

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !45
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %2, align 8, !dbg !47
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !48
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !49
  %5 = load i32, i32* %x.addr, align 4, !dbg !50
  %call1 = call i32 %4(i32 1, i32 %5), !dbg !51
  store i32 %call1, i32* %x.addr, align 4, !dbg !52
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !53
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %6, align 8, !dbg !54
  br label %if.end, !dbg !55

if.else:                                          ; preds = %entry
  %7 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !56
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %7, align 8, !dbg !58
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %8 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !59
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !60
  %10 = load i32, i32* %x.addr, align 4, !dbg !61
  %call2 = call i32 %9(i32 1, i32 %10), !dbg !62
  store i32 %call2, i32* %x.addr, align 4, !dbg !63
  ret void, !dbg !64
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
!1 = !DIFile(filename: "test06.c", directory: "/home/liwc/compile/assignment3_testcase_ver2")
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
!32 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !33, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{null, !8}
!35 = !DILocalVariable(name: "x", arg: 1, scope: !32, file: !1, line: 9, type: !8)
!36 = !DILocation(line: 9, column: 14, scope: !32)
!37 = !DILocalVariable(name: "a_fptr", scope: !32, file: !1, line: 11, type: !4)
!38 = !DILocation(line: 11, column: 9, scope: !32)
!39 = !DILocation(line: 11, column: 45, scope: !32)
!40 = !DILocation(line: 11, column: 26, scope: !32)
!41 = !DILocation(line: 12, column: 5, scope: !42)
!42 = distinct !DILexicalBlock(scope: !32, file: !1, line: 12, column: 5)
!43 = !DILocation(line: 12, column: 6, scope: !42)
!44 = !DILocation(line: 12, column: 5, scope: !32)
!45 = !DILocation(line: 14, column: 4, scope: !46)
!46 = distinct !DILexicalBlock(scope: !42, file: !1, line: 13, column: 2)
!47 = !DILocation(line: 14, column: 10, scope: !46)
!48 = !DILocation(line: 15, column: 8, scope: !46)
!49 = !DILocation(line: 15, column: 7, scope: !46)
!50 = !DILocation(line: 15, column: 18, scope: !46)
!51 = !DILocation(line: 15, column: 6, scope: !46)
!52 = !DILocation(line: 15, column: 5, scope: !46)
!53 = !DILocation(line: 16, column: 5, scope: !46)
!54 = !DILocation(line: 16, column: 11, scope: !46)
!55 = !DILocation(line: 17, column: 2, scope: !46)
!56 = !DILocation(line: 19, column: 4, scope: !57)
!57 = distinct !DILexicalBlock(scope: !42, file: !1, line: 18, column: 2)
!58 = !DILocation(line: 19, column: 10, scope: !57)
!59 = !DILocation(line: 21, column: 6, scope: !32)
!60 = !DILocation(line: 21, column: 5, scope: !32)
!61 = !DILocation(line: 21, column: 16, scope: !32)
!62 = !DILocation(line: 21, column: 4, scope: !32)
!63 = !DILocation(line: 21, column: 3, scope: !32)
!64 = !DILocation(line: 22, column: 1, scope: !32)
