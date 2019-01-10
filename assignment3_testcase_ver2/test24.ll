; ModuleID = 'test24.bc'
source_filename = "test24.c"
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
define i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %af_ptr.coerce) #0 !dbg !29 {
entry:
  %af_ptr = alloca %struct.fptr, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %af_ptr, i32 0, i32 0
  store i32 (i32, i32)* %af_ptr.coerce, i32 (i32, i32)** %coerce.dive, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !36, metadata !12), !dbg !37
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !38, metadata !12), !dbg !39
  call void @llvm.dbg.declare(metadata %struct.fptr* %af_ptr, metadata !40, metadata !12), !dbg !41
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %af_ptr, i32 0, i32 0, !dbg !42
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !42
  %1 = load i32, i32* %a.addr, align 4, !dbg !43
  %2 = load i32, i32* %b.addr, align 4, !dbg !44
  %call = call i32 %0(i32 %1, i32 %2), !dbg !45
  ret i32 %call, !dbg !46
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_no_alias(i32 (i32, i32)* %a.coerce) #0 !dbg !47 {
entry:
  %a = alloca %struct.fptr, align 8
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %a, i32 0, i32 0
  store i32 (i32, i32)* %a.coerce, i32 (i32, i32)** %coerce.dive, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr* %a, metadata !50, metadata !12), !dbg !51
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a, i32 0, i32 0, !dbg !52
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !53
  ret void, !dbg !54
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever() #0 !dbg !55 {
entry:
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %tf_ptr = alloca %struct.fptr, align 8
  %result = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !58, metadata !12), !dbg !60
  store i32 (i32, i32, i32 (i32, i32)*)* null, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata %struct.fptr* %tf_ptr, metadata !61, metadata !12), !dbg !62
  %0 = bitcast %struct.fptr* %tf_ptr to i8*, !dbg !62
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 8, i32 8, i1 false), !dbg !62
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %tf_ptr, i32 0, i32 0, !dbg !63
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr, align 8, !dbg !64
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !65
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %tf_ptr, i32 0, i32 0, !dbg !66
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %coerce.dive, align 8, !dbg !66
  call void @make_no_alias(i32 (i32, i32)* %1), !dbg !66
  call void @llvm.dbg.declare(metadata i32* %result, metadata !67, metadata !12), !dbg !69
  %2 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !70
  %coerce.dive1 = getelementptr inbounds %struct.fptr, %struct.fptr* %tf_ptr, i32 0, i32 0, !dbg !70
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %coerce.dive1, align 8, !dbg !70
  %call = call i32 %2(i32 1, i32 2, i32 (i32, i32)* %3), !dbg !70
  store i32 %call, i32* %result, align 4, !dbg !69
  ret i32 0, !dbg !71
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
!1 = !DIFile(filename: "test24.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !10)
!22 = !DILocation(line: 10, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !10)
!24 = !DILocation(line: 10, column: 21, scope: !20)
!25 = !DILocation(line: 12, column: 12, scope: !20)
!26 = !DILocation(line: 12, column: 14, scope: !20)
!27 = !DILocation(line: 12, column: 13, scope: !20)
!28 = !DILocation(line: 12, column: 5, scope: !20)
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 15, type: !30, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!10, !10, !10, !32}
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !33)
!33 = !{!34}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !32, file: !1, line: 4, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!36 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 15, type: !10)
!37 = !DILocation(line: 15, column: 13, scope: !29)
!38 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 15, type: !10)
!39 = !DILocation(line: 15, column: 19, scope: !29)
!40 = !DILocalVariable(name: "af_ptr", arg: 3, scope: !29, file: !1, line: 15, type: !32)
!41 = !DILocation(line: 15, column: 33, scope: !29)
!42 = !DILocation(line: 17, column: 16, scope: !29)
!43 = !DILocation(line: 17, column: 23, scope: !29)
!44 = !DILocation(line: 17, column: 25, scope: !29)
!45 = !DILocation(line: 17, column: 9, scope: !29)
!46 = !DILocation(line: 17, column: 2, scope: !29)
!47 = distinct !DISubprogram(name: "make_no_alias", scope: !1, file: !1, line: 19, type: !48, isLocal: false, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!48 = !DISubroutineType(types: !49)
!49 = !{null, !32}
!50 = !DILocalVariable(name: "a", arg: 1, scope: !47, file: !1, line: 19, type: !32)
!51 = !DILocation(line: 19, column: 32, scope: !47)
!52 = !DILocation(line: 21, column: 7, scope: !47)
!53 = !DILocation(line: 21, column: 13, scope: !47)
!54 = !DILocation(line: 22, column: 1, scope: !47)
!55 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 23, type: !56, isLocal: false, isDefinition: true, scopeLine: 23, isOptimized: false, unit: !0, variables: !2)
!56 = !DISubroutineType(types: !57)
!57 = !{!10}
!58 = !DILocalVariable(name: "af_ptr", scope: !55, file: !1, line: 25, type: !59)
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!60 = !DILocation(line: 25, column: 11, scope: !55)
!61 = !DILocalVariable(name: "tf_ptr", scope: !55, file: !1, line: 26, type: !32)
!62 = !DILocation(line: 26, column: 17, scope: !55)
!63 = !DILocation(line: 27, column: 12, scope: !55)
!64 = !DILocation(line: 27, column: 18, scope: !55)
!65 = !DILocation(line: 28, column: 11, scope: !55)
!66 = !DILocation(line: 29, column: 5, scope: !55)
!67 = !DILocalVariable(name: "result", scope: !55, file: !1, line: 30, type: !68)
!68 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!69 = !DILocation(line: 30, column: 14, scope: !55)
!70 = !DILocation(line: 30, column: 23, scope: !55)
!71 = !DILocation(line: 31, column: 5, scope: !55)
