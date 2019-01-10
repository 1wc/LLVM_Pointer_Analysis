; ModuleID = 'test09.bc'
source_filename = "test09.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !20 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !21, metadata !22), !dbg !23
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !24, metadata !22), !dbg !25
  %0 = load i32, i32* %a.addr, align 4, !dbg !26
  %1 = load i32, i32* %b.addr, align 4, !dbg !27
  %add = add nsw i32 %0, %1, !dbg !28
  ret i32 %add, !dbg !29
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !30 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !31, metadata !22), !dbg !32
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !33, metadata !22), !dbg !34
  %0 = load i32, i32* %a.addr, align 4, !dbg !35
  %1 = load i32, i32* %b.addr, align 4, !dbg !36
  %sub = sub nsw i32 %0, %1, !dbg !37
  ret i32 %sub, !dbg !38
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %x) #0 !dbg !39 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.fsptr*, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !42, metadata !22), !dbg !43
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !44, metadata !22), !dbg !45
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !46, metadata !22), !dbg !47
  call void @llvm.dbg.declare(metadata %struct.fsptr** %w_fptr, metadata !48, metadata !22), !dbg !49
  %call = call noalias i8* @malloc(i64 8) #4, !dbg !50
  %0 = bitcast i8* %call to %struct.fsptr*, !dbg !51
  store %struct.fsptr* %0, %struct.fsptr** %w_fptr, align 8, !dbg !49
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !52
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !53
  %1 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !54
  %2 = bitcast %struct.fsptr* %1 to i8*, !dbg !55
  %3 = bitcast %struct.fsptr* %s_fptr to i8*, !dbg !55
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 8, i32 8, i1 false), !dbg !55
  %4 = load i32, i32* %x.addr, align 4, !dbg !56
  %cmp = icmp sgt i32 %4, 1, !dbg !58
  br i1 %cmp, label %if.then, label %if.else, !dbg !59

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !60
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !62
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !63
  %5 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !63
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !64
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !64
  %7 = load i32, i32* %x.addr, align 4, !dbg !65
  %call3 = call i32 %6(i32 1, i32 %7), !dbg !66
  store i32 %call3, i32* %x.addr, align 4, !dbg !67
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !68
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr4, align 8, !dbg !69
  br label %if.end, !dbg !70

if.else:                                          ; preds = %entry
  %8 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !71
  %sptr5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %8, i32 0, i32 0, !dbg !73
  %9 = load %struct.fptr*, %struct.fptr** %sptr5, align 8, !dbg !73
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !74
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr6, align 8, !dbg !75
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr7 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !76
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr7, align 8, !dbg !76
  %11 = load i32, i32* %x.addr, align 4, !dbg !77
  %call8 = call i32 %10(i32 1, i32 %11), !dbg !78
  store i32 %call8, i32* %x.addr, align 4, !dbg !79
  ret void, !dbg !80
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17, !18}
!llvm.ident = !{!19}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test09.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !5, file: !1, line: 8, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !9, file: !1, line: 4, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15, !15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{i32 2, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!20 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !13, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !15)
!22 = !DIExpression()
!23 = !DILocation(line: 10, column: 14, scope: !20)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !15)
!25 = !DILocation(line: 10, column: 21, scope: !20)
!26 = !DILocation(line: 11, column: 11, scope: !20)
!27 = !DILocation(line: 11, column: 13, scope: !20)
!28 = !DILocation(line: 11, column: 12, scope: !20)
!29 = !DILocation(line: 11, column: 4, scope: !20)
!30 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !13, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!31 = !DILocalVariable(name: "a", arg: 1, scope: !30, file: !1, line: 14, type: !15)
!32 = !DILocation(line: 14, column: 15, scope: !30)
!33 = !DILocalVariable(name: "b", arg: 2, scope: !30, file: !1, line: 14, type: !15)
!34 = !DILocation(line: 14, column: 22, scope: !30)
!35 = !DILocation(line: 15, column: 11, scope: !30)
!36 = !DILocation(line: 15, column: 13, scope: !30)
!37 = !DILocation(line: 15, column: 12, scope: !30)
!38 = !DILocation(line: 15, column: 4, scope: !30)
!39 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 17, type: !40, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{null, !15}
!42 = !DILocalVariable(name: "x", arg: 1, scope: !39, file: !1, line: 17, type: !15)
!43 = !DILocation(line: 17, column: 14, scope: !39)
!44 = !DILocalVariable(name: "a_fptr", scope: !39, file: !1, line: 19, type: !9)
!45 = !DILocation(line: 19, column: 14, scope: !39)
!46 = !DILocalVariable(name: "s_fptr", scope: !39, file: !1, line: 20, type: !5)
!47 = !DILocation(line: 20, column: 15, scope: !39)
!48 = !DILocalVariable(name: "w_fptr", scope: !39, file: !1, line: 21, type: !4)
!49 = !DILocation(line: 21, column: 16, scope: !39)
!50 = !DILocation(line: 21, column: 38, scope: !39)
!51 = !DILocation(line: 21, column: 23, scope: !39)
!52 = !DILocation(line: 22, column: 9, scope: !39)
!53 = !DILocation(line: 22, column: 13, scope: !39)
!54 = !DILocation(line: 23, column: 3, scope: !39)
!55 = !DILocation(line: 23, column: 10, scope: !39)
!56 = !DILocation(line: 24, column: 5, scope: !57)
!57 = distinct !DILexicalBlock(scope: !39, file: !1, line: 24, column: 5)
!58 = !DILocation(line: 24, column: 6, scope: !57)
!59 = !DILocation(line: 24, column: 5, scope: !39)
!60 = !DILocation(line: 26, column: 11, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 25, column: 2)
!62 = !DILocation(line: 26, column: 17, scope: !61)
!63 = !DILocation(line: 27, column: 13, scope: !61)
!64 = !DILocation(line: 27, column: 19, scope: !61)
!65 = !DILocation(line: 27, column: 28, scope: !61)
!66 = !DILocation(line: 27, column: 6, scope: !61)
!67 = !DILocation(line: 27, column: 5, scope: !61)
!68 = !DILocation(line: 28, column: 11, scope: !61)
!69 = !DILocation(line: 28, column: 17, scope: !61)
!70 = !DILocation(line: 29, column: 2, scope: !61)
!71 = !DILocation(line: 31, column: 3, scope: !72)
!72 = distinct !DILexicalBlock(scope: !57, file: !1, line: 30, column: 2)
!73 = !DILocation(line: 31, column: 11, scope: !72)
!74 = !DILocation(line: 31, column: 17, scope: !72)
!75 = !DILocation(line: 31, column: 23, scope: !72)
!76 = !DILocation(line: 33, column: 11, scope: !39)
!77 = !DILocation(line: 33, column: 20, scope: !39)
!78 = !DILocation(line: 33, column: 4, scope: !39)
!79 = !DILocation(line: 33, column: 3, scope: !39)
!80 = !DILocation(line: 34, column: 1, scope: !39)
