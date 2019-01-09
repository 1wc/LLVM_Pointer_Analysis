; ModuleID = 'test07.bc'
source_filename = "test07.c"
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
define void @foo(i32 %x) #0 !dbg !29 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !32, metadata !12), !dbg !33
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !34, metadata !12), !dbg !39
  %0 = load i32, i32* %x.addr, align 4, !dbg !40
  %cmp = icmp sgt i32 %0, 1, !dbg !42
  br i1 %cmp, label %if.then, label %if.else, !dbg !43

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !44
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !46
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !47
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr1, align 8, !dbg !47
  %2 = load i32, i32* %x.addr, align 4, !dbg !48
  %call = call i32 %1(i32 1, i32 %2), !dbg !49
  store i32 %call, i32* %x.addr, align 4, !dbg !50
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !51
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr2, align 8, !dbg !52
  br label %if.end, !dbg !53

if.else:                                          ; preds = %entry
  %p_fptr3 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !54
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr3, align 8, !dbg !56
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !57
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr4, align 8, !dbg !57
  %4 = load i32, i32* %x.addr, align 4, !dbg !58
  %call5 = call i32 %3(i32 1, i32 %4), !dbg !59
  store i32 %call5, i32* %x.addr, align 4, !dbg !60
  ret void, !dbg !61
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test07.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 13, type: !30, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !10}
!32 = !DILocalVariable(name: "x", arg: 1, scope: !29, file: !1, line: 13, type: !10)
!33 = !DILocation(line: 13, column: 14, scope: !29)
!34 = !DILocalVariable(name: "a_fptr", scope: !29, file: !1, line: 15, type: !35)
!35 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !36)
!36 = !{!37}
!37 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !35, file: !1, line: 4, baseType: !38, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!39 = !DILocation(line: 15, column: 14, scope: !29)
!40 = !DILocation(line: 16, column: 5, scope: !41)
!41 = distinct !DILexicalBlock(scope: !29, file: !1, line: 16, column: 5)
!42 = !DILocation(line: 16, column: 6, scope: !41)
!43 = !DILocation(line: 16, column: 5, scope: !29)
!44 = !DILocation(line: 18, column: 10, scope: !45)
!45 = distinct !DILexicalBlock(scope: !41, file: !1, line: 17, column: 2)
!46 = !DILocation(line: 18, column: 16, scope: !45)
!47 = !DILocation(line: 19, column: 13, scope: !45)
!48 = !DILocation(line: 19, column: 22, scope: !45)
!49 = !DILocation(line: 19, column: 6, scope: !45)
!50 = !DILocation(line: 19, column: 5, scope: !45)
!51 = !DILocation(line: 20, column: 11, scope: !45)
!52 = !DILocation(line: 20, column: 17, scope: !45)
!53 = !DILocation(line: 21, column: 2, scope: !45)
!54 = !DILocation(line: 23, column: 10, scope: !55)
!55 = distinct !DILexicalBlock(scope: !41, file: !1, line: 22, column: 2)
!56 = !DILocation(line: 23, column: 16, scope: !55)
!57 = !DILocation(line: 25, column: 11, scope: !29)
!58 = !DILocation(line: 25, column: 20, scope: !29)
!59 = !DILocation(line: 25, column: 4, scope: !29)
!60 = !DILocation(line: 25, column: 3, scope: !29)
!61 = !DILocation(line: 26, column: 1, scope: !29)
