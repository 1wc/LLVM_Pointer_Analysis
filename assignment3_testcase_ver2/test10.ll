; ModuleID = 'test10.bc'
source_filename = "test10.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }
%struct.wfsptr = type { %struct.fsptr* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !24 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !25, metadata !26), !dbg !27
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !28, metadata !26), !dbg !29
  %0 = load i32, i32* %a.addr, align 4, !dbg !30
  %1 = load i32, i32* %b.addr, align 4, !dbg !31
  %add = add nsw i32 %0, %1, !dbg !32
  ret i32 %add, !dbg !33
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !34 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !35, metadata !26), !dbg !36
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !37, metadata !26), !dbg !38
  %0 = load i32, i32* %a.addr, align 4, !dbg !39
  %1 = load i32, i32* %b.addr, align 4, !dbg !40
  %sub = sub nsw i32 %0, %1, !dbg !41
  ret i32 %sub, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32 %x) #0 !dbg !43 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.wfsptr*, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !46, metadata !26), !dbg !47
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !48, metadata !26), !dbg !49
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !50, metadata !26), !dbg !51
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %w_fptr, metadata !52, metadata !26), !dbg !53
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !54
  %0 = bitcast i8* %call to %struct.wfsptr*, !dbg !55
  store %struct.wfsptr* %0, %struct.wfsptr** %w_fptr, align 8, !dbg !53
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !56
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !57
  %1 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !58
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %1, i32 0, i32 0, !dbg !59
  store %struct.fsptr* %s_fptr, %struct.fsptr** %wfptr, align 8, !dbg !60
  %2 = load i32, i32* %x.addr, align 4, !dbg !61
  %cmp = icmp sgt i32 %2, 1, !dbg !63
  br i1 %cmp, label %if.then, label %if.else, !dbg !64

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !65
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr, align 8, !dbg !67
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !68
  %3 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !68
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !69
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !69
  %5 = load i32, i32* %x.addr, align 4, !dbg !70
  %call3 = call i32 %4(i32 1, i32 %5), !dbg !71
  store i32 %call3, i32* %x.addr, align 4, !dbg !72
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !73
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr4, align 8, !dbg !74
  br label %if.end, !dbg !75

if.else:                                          ; preds = %entry
  %6 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !76
  %wfptr5 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %6, i32 0, i32 0, !dbg !78
  %7 = load %struct.fsptr*, %struct.fsptr** %wfptr5, align 8, !dbg !78
  %sptr6 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %7, i32 0, i32 0, !dbg !79
  %8 = load %struct.fptr*, %struct.fptr** %sptr6, align 8, !dbg !79
  %p_fptr7 = getelementptr inbounds %struct.fptr, %struct.fptr* %8, i32 0, i32 0, !dbg !80
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr7, align 8, !dbg !81
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr8 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !82
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr8, align 8, !dbg !82
  %10 = load i32, i32* %x.addr, align 4, !dbg !83
  %call9 = call i32 %9(i32 1, i32 %10), !dbg !84
  store i32 %call9, i32* %x.addr, align 4, !dbg !85
  ret void, !dbg !86
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!20, !21, !22}
!llvm.ident = !{!23}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test10.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !5, file: !1, line: 12, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !9, file: !1, line: 8, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !14)
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !13, file: !1, line: 4, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DISubroutineType(types: !18)
!18 = !{!19, !19, !19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !{i32 2, !"Dwarf Version", i32 4}
!21 = !{i32 2, !"Debug Info Version", i32 3}
!22 = !{i32 1, !"wchar_size", i32 4}
!23 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!24 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !17, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!25 = !DILocalVariable(name: "a", arg: 1, scope: !24, file: !1, line: 14, type: !19)
!26 = !DIExpression()
!27 = !DILocation(line: 14, column: 14, scope: !24)
!28 = !DILocalVariable(name: "b", arg: 2, scope: !24, file: !1, line: 14, type: !19)
!29 = !DILocation(line: 14, column: 21, scope: !24)
!30 = !DILocation(line: 15, column: 11, scope: !24)
!31 = !DILocation(line: 15, column: 13, scope: !24)
!32 = !DILocation(line: 15, column: 12, scope: !24)
!33 = !DILocation(line: 15, column: 4, scope: !24)
!34 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !17, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!35 = !DILocalVariable(name: "a", arg: 1, scope: !34, file: !1, line: 18, type: !19)
!36 = !DILocation(line: 18, column: 15, scope: !34)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !34, file: !1, line: 18, type: !19)
!38 = !DILocation(line: 18, column: 22, scope: !34)
!39 = !DILocation(line: 19, column: 11, scope: !34)
!40 = !DILocation(line: 19, column: 13, scope: !34)
!41 = !DILocation(line: 19, column: 12, scope: !34)
!42 = !DILocation(line: 19, column: 4, scope: !34)
!43 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 21, type: !44, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DISubroutineType(types: !45)
!45 = !{null, !19}
!46 = !DILocalVariable(name: "x", arg: 1, scope: !43, file: !1, line: 21, type: !19)
!47 = !DILocation(line: 21, column: 14, scope: !43)
!48 = !DILocalVariable(name: "a_fptr", scope: !43, file: !1, line: 23, type: !13)
!49 = !DILocation(line: 23, column: 14, scope: !43)
!50 = !DILocalVariable(name: "s_fptr", scope: !43, file: !1, line: 24, type: !9)
!51 = !DILocation(line: 24, column: 15, scope: !43)
!52 = !DILocalVariable(name: "w_fptr", scope: !43, file: !1, line: 25, type: !4)
!53 = !DILocation(line: 25, column: 17, scope: !43)
!54 = !DILocation(line: 25, column: 40, scope: !43)
!55 = !DILocation(line: 25, column: 24, scope: !43)
!56 = !DILocation(line: 26, column: 9, scope: !43)
!57 = !DILocation(line: 26, column: 13, scope: !43)
!58 = !DILocation(line: 27, column: 2, scope: !43)
!59 = !DILocation(line: 27, column: 10, scope: !43)
!60 = !DILocation(line: 27, column: 15, scope: !43)
!61 = !DILocation(line: 28, column: 5, scope: !62)
!62 = distinct !DILexicalBlock(scope: !43, file: !1, line: 28, column: 5)
!63 = !DILocation(line: 28, column: 6, scope: !62)
!64 = !DILocation(line: 28, column: 5, scope: !43)
!65 = !DILocation(line: 30, column: 11, scope: !66)
!66 = distinct !DILexicalBlock(scope: !62, file: !1, line: 29, column: 2)
!67 = !DILocation(line: 30, column: 17, scope: !66)
!68 = !DILocation(line: 31, column: 13, scope: !66)
!69 = !DILocation(line: 31, column: 19, scope: !66)
!70 = !DILocation(line: 31, column: 28, scope: !66)
!71 = !DILocation(line: 31, column: 6, scope: !66)
!72 = !DILocation(line: 31, column: 5, scope: !66)
!73 = !DILocation(line: 32, column: 11, scope: !66)
!74 = !DILocation(line: 32, column: 17, scope: !66)
!75 = !DILocation(line: 33, column: 2, scope: !66)
!76 = !DILocation(line: 35, column: 3, scope: !77)
!77 = distinct !DILexicalBlock(scope: !62, file: !1, line: 34, column: 2)
!78 = !DILocation(line: 35, column: 11, scope: !77)
!79 = !DILocation(line: 35, column: 18, scope: !77)
!80 = !DILocation(line: 35, column: 24, scope: !77)
!81 = !DILocation(line: 35, column: 30, scope: !77)
!82 = !DILocation(line: 37, column: 11, scope: !43)
!83 = !DILocation(line: 37, column: 20, scope: !43)
!84 = !DILocation(line: 37, column: 4, scope: !43)
!85 = !DILocation(line: 37, column: 3, scope: !43)
!86 = !DILocation(line: 38, column: 1, scope: !43)
