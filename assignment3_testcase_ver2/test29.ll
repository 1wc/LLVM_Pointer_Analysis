; ModuleID = 'test29.bc'
source_filename = "test29.c"
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
define i32 @clever(i32 %a, i32 %b, %struct.fptr* %c_fptr, %struct.fptr* %d_fptr) #0 !dbg !39 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c_fptr.addr = alloca %struct.fptr*, align 8
  %d_fptr.addr = alloca %struct.fptr*, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !42, metadata !22), !dbg !43
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !44, metadata !22), !dbg !45
  store %struct.fptr* %c_fptr, %struct.fptr** %c_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %c_fptr.addr, metadata !46, metadata !22), !dbg !47
  store %struct.fptr* %d_fptr, %struct.fptr** %d_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %d_fptr.addr, metadata !48, metadata !22), !dbg !49
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !50, metadata !22), !dbg !51
  %0 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !52
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %0, i32 0, i32 0, !dbg !53
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !53
  store i32 (i32, i32)* %1, i32 (i32, i32)** %t_fptr, align 8, !dbg !51
  %2 = load %struct.fptr*, %struct.fptr** %d_fptr.addr, align 8, !dbg !54
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !55
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr1, align 8, !dbg !55
  %4 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !56
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !57
  store i32 (i32, i32)* %3, i32 (i32, i32)** %p_fptr2, align 8, !dbg !58
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !59
  %6 = load %struct.fptr*, %struct.fptr** %d_fptr.addr, align 8, !dbg !60
  %p_fptr3 = getelementptr inbounds %struct.fptr, %struct.fptr* %6, i32 0, i32 0, !dbg !61
  store i32 (i32, i32)* %5, i32 (i32, i32)** %p_fptr3, align 8, !dbg !62
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !63
  %8 = load i32, i32* %a.addr, align 4, !dbg !64
  %9 = load i32, i32* %b.addr, align 4, !dbg !65
  %call = call i32 %7(i32 %8, i32 %9), !dbg !63
  ret i32 %call, !dbg !66
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %a, i32 %b, %struct.fsptr* %c_fptr, %struct.fsptr* %d_fptr) #0 !dbg !67 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c_fptr.addr = alloca %struct.fsptr*, align 8
  %d_fptr.addr = alloca %struct.fsptr*, align 8
  %t_fptr = alloca %struct.fptr, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !70, metadata !22), !dbg !71
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !72, metadata !22), !dbg !73
  store %struct.fsptr* %c_fptr, %struct.fsptr** %c_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %c_fptr.addr, metadata !74, metadata !22), !dbg !75
  store %struct.fsptr* %d_fptr, %struct.fsptr** %d_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %d_fptr.addr, metadata !76, metadata !22), !dbg !77
  call void @llvm.dbg.declare(metadata %struct.fptr* %t_fptr, metadata !78, metadata !22), !dbg !79
  %0 = load %struct.fsptr*, %struct.fsptr** %c_fptr.addr, align 8, !dbg !80
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !81
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !81
  %2 = bitcast %struct.fptr* %t_fptr to i8*, !dbg !82
  %3 = bitcast %struct.fptr* %1 to i8*, !dbg !82
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 8, i32 8, i1 false), !dbg !82
  %4 = load %struct.fsptr*, %struct.fsptr** %d_fptr.addr, align 8, !dbg !83
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !84
  %5 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !84
  %6 = load %struct.fsptr*, %struct.fsptr** %c_fptr.addr, align 8, !dbg !85
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %6, i32 0, i32 0, !dbg !86
  store %struct.fptr* %5, %struct.fptr** %sptr2, align 8, !dbg !87
  %7 = load i32, i32* %a.addr, align 4, !dbg !88
  %8 = load i32, i32* %b.addr, align 4, !dbg !89
  %9 = load %struct.fsptr*, %struct.fsptr** %c_fptr.addr, align 8, !dbg !90
  %sptr3 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %9, i32 0, i32 0, !dbg !91
  %10 = load %struct.fptr*, %struct.fptr** %sptr3, align 8, !dbg !91
  %call = call i32 @clever(i32 %7, i32 %8, %struct.fptr* %10, %struct.fptr* %t_fptr), !dbg !92
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !93
  %11 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !93
  %12 = load i32, i32* %a.addr, align 4, !dbg !94
  %13 = load i32, i32* %b.addr, align 4, !dbg !95
  %call4 = call i32 %11(i32 %12, i32 %13), !dbg !96
  ret i32 %call4, !dbg !97
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @moo(i32 %x) #0 !dbg !98 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %b_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  %r_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.fsptr*, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !101, metadata !22), !dbg !102
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !103, metadata !22), !dbg !104
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !105
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !106
  call void @llvm.dbg.declare(metadata %struct.fptr* %b_fptr, metadata !107, metadata !22), !dbg !108
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0, !dbg !109
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !110
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !111, metadata !22), !dbg !112
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !113
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !114
  call void @llvm.dbg.declare(metadata %struct.fsptr* %r_fptr, metadata !115, metadata !22), !dbg !116
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %r_fptr, i32 0, i32 0, !dbg !117
  store %struct.fptr* %b_fptr, %struct.fptr** %sptr2, align 8, !dbg !118
  call void @llvm.dbg.declare(metadata %struct.fsptr** %w_fptr, metadata !119, metadata !22), !dbg !120
  %call = call noalias i8* @malloc(i64 8) #4, !dbg !121
  %0 = bitcast i8* %call to %struct.fsptr*, !dbg !122
  store %struct.fsptr* %0, %struct.fsptr** %w_fptr, align 8, !dbg !120
  %1 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !123
  %2 = bitcast %struct.fsptr* %1 to i8*, !dbg !124
  %3 = bitcast %struct.fsptr* %s_fptr to i8*, !dbg !124
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 8, i32 8, i1 false), !dbg !124
  %4 = load i32, i32* %x.addr, align 4, !dbg !125
  %cmp = icmp sgt i32 %4, 1, !dbg !127
  br i1 %cmp, label %if.then, label %if.else, !dbg !128

if.then:                                          ; preds = %entry
  %5 = load i32, i32* %x.addr, align 4, !dbg !129
  %6 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !131
  %call3 = call i32 @foo(i32 1, i32 %5, %struct.fsptr* %6, %struct.fsptr* %r_fptr), !dbg !132
  br label %if.end, !dbg !133

if.else:                                          ; preds = %entry
  %7 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !134
  %sptr4 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %7, i32 0, i32 0, !dbg !136
  %8 = load %struct.fptr*, %struct.fptr** %sptr4, align 8, !dbg !136
  %p_fptr5 = getelementptr inbounds %struct.fptr, %struct.fptr* %8, i32 0, i32 0, !dbg !137
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr5, align 8, !dbg !138
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %9 = load i32, i32* %x.addr, align 4, !dbg !139
  %10 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !140
  %call6 = call i32 @foo(i32 1, i32 %9, %struct.fsptr* %10, %struct.fsptr* %s_fptr), !dbg !141
  ret void, !dbg !142
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17, !18}
!llvm.ident = !{!19}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test29.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!39 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 17, type: !40, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!15, !15, !15, !8, !8}
!42 = !DILocalVariable(name: "a", arg: 1, scope: !39, file: !1, line: 17, type: !15)
!43 = !DILocation(line: 17, column: 16, scope: !39)
!44 = !DILocalVariable(name: "b", arg: 2, scope: !39, file: !1, line: 17, type: !15)
!45 = !DILocation(line: 17, column: 23, scope: !39)
!46 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !39, file: !1, line: 17, type: !8)
!47 = !DILocation(line: 17, column: 40, scope: !39)
!48 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !39, file: !1, line: 17, type: !8)
!49 = !DILocation(line: 17, column: 62, scope: !39)
!50 = !DILocalVariable(name: "t_fptr", scope: !39, file: !1, line: 18, type: !12)
!51 = !DILocation(line: 18, column: 8, scope: !39)
!52 = !DILocation(line: 18, column: 26, scope: !39)
!53 = !DILocation(line: 18, column: 34, scope: !39)
!54 = !DILocation(line: 19, column: 17, scope: !39)
!55 = !DILocation(line: 19, column: 25, scope: !39)
!56 = !DILocation(line: 19, column: 2, scope: !39)
!57 = !DILocation(line: 19, column: 10, scope: !39)
!58 = !DILocation(line: 19, column: 16, scope: !39)
!59 = !DILocation(line: 20, column: 17, scope: !39)
!60 = !DILocation(line: 20, column: 2, scope: !39)
!61 = !DILocation(line: 20, column: 10, scope: !39)
!62 = !DILocation(line: 20, column: 16, scope: !39)
!63 = !DILocation(line: 21, column: 12, scope: !39)
!64 = !DILocation(line: 21, column: 19, scope: !39)
!65 = !DILocation(line: 21, column: 21, scope: !39)
!66 = !DILocation(line: 21, column: 5, scope: !39)
!67 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 23, type: !68, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!68 = !DISubroutineType(types: !69)
!69 = !{!15, !15, !15, !4, !4}
!70 = !DILocalVariable(name: "a", arg: 1, scope: !67, file: !1, line: 23, type: !15)
!71 = !DILocation(line: 23, column: 13, scope: !67)
!72 = !DILocalVariable(name: "b", arg: 2, scope: !67, file: !1, line: 23, type: !15)
!73 = !DILocation(line: 23, column: 20, scope: !67)
!74 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !67, file: !1, line: 23, type: !4)
!75 = !DILocation(line: 23, column: 38, scope: !67)
!76 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !67, file: !1, line: 23, type: !4)
!77 = !DILocation(line: 23, column: 61, scope: !67)
!78 = !DILocalVariable(name: "t_fptr", scope: !67, file: !1, line: 24, type: !9)
!79 = !DILocation(line: 24, column: 14, scope: !67)
!80 = !DILocation(line: 24, column: 23, scope: !67)
!81 = !DILocation(line: 24, column: 31, scope: !67)
!82 = !DILocation(line: 24, column: 21, scope: !67)
!83 = !DILocation(line: 25, column: 15, scope: !67)
!84 = !DILocation(line: 25, column: 23, scope: !67)
!85 = !DILocation(line: 25, column: 2, scope: !67)
!86 = !DILocation(line: 25, column: 10, scope: !67)
!87 = !DILocation(line: 25, column: 14, scope: !67)
!88 = !DILocation(line: 26, column: 12, scope: !67)
!89 = !DILocation(line: 26, column: 15, scope: !67)
!90 = !DILocation(line: 26, column: 18, scope: !67)
!91 = !DILocation(line: 26, column: 26, scope: !67)
!92 = !DILocation(line: 26, column: 5, scope: !67)
!93 = !DILocation(line: 27, column: 19, scope: !67)
!94 = !DILocation(line: 27, column: 26, scope: !67)
!95 = !DILocation(line: 27, column: 28, scope: !67)
!96 = !DILocation(line: 27, column: 12, scope: !67)
!97 = !DILocation(line: 27, column: 5, scope: !67)
!98 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 29, type: !99, isLocal: false, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!99 = !DISubroutineType(types: !100)
!100 = !{null, !15}
!101 = !DILocalVariable(name: "x", arg: 1, scope: !98, file: !1, line: 29, type: !15)
!102 = !DILocation(line: 29, column: 14, scope: !98)
!103 = !DILocalVariable(name: "a_fptr", scope: !98, file: !1, line: 31, type: !9)
!104 = !DILocation(line: 31, column: 14, scope: !98)
!105 = !DILocation(line: 32, column: 9, scope: !98)
!106 = !DILocation(line: 32, column: 15, scope: !98)
!107 = !DILocalVariable(name: "b_fptr", scope: !98, file: !1, line: 33, type: !9)
!108 = !DILocation(line: 33, column: 14, scope: !98)
!109 = !DILocation(line: 34, column: 9, scope: !98)
!110 = !DILocation(line: 34, column: 15, scope: !98)
!111 = !DILocalVariable(name: "s_fptr", scope: !98, file: !1, line: 36, type: !5)
!112 = !DILocation(line: 36, column: 15, scope: !98)
!113 = !DILocation(line: 37, column: 9, scope: !98)
!114 = !DILocation(line: 37, column: 13, scope: !98)
!115 = !DILocalVariable(name: "r_fptr", scope: !98, file: !1, line: 38, type: !5)
!116 = !DILocation(line: 38, column: 15, scope: !98)
!117 = !DILocation(line: 39, column: 9, scope: !98)
!118 = !DILocation(line: 39, column: 13, scope: !98)
!119 = !DILocalVariable(name: "w_fptr", scope: !98, file: !1, line: 41, type: !4)
!120 = !DILocation(line: 41, column: 16, scope: !98)
!121 = !DILocation(line: 41, column: 38, scope: !98)
!122 = !DILocation(line: 41, column: 23, scope: !98)
!123 = !DILocation(line: 43, column: 3, scope: !98)
!124 = !DILocation(line: 43, column: 10, scope: !98)
!125 = !DILocation(line: 44, column: 5, scope: !126)
!126 = distinct !DILexicalBlock(scope: !98, file: !1, line: 44, column: 5)
!127 = !DILocation(line: 44, column: 6, scope: !126)
!128 = !DILocation(line: 44, column: 5, scope: !98)
!129 = !DILocation(line: 46, column: 10, scope: !130)
!130 = distinct !DILexicalBlock(scope: !126, file: !1, line: 45, column: 2)
!131 = !DILocation(line: 46, column: 12, scope: !130)
!132 = !DILocation(line: 46, column: 4, scope: !130)
!133 = !DILocation(line: 47, column: 2, scope: !130)
!134 = !DILocation(line: 49, column: 3, scope: !135)
!135 = distinct !DILexicalBlock(scope: !126, file: !1, line: 48, column: 2)
!136 = !DILocation(line: 49, column: 11, scope: !135)
!137 = !DILocation(line: 49, column: 17, scope: !135)
!138 = !DILocation(line: 49, column: 23, scope: !135)
!139 = !DILocation(line: 51, column: 8, scope: !98)
!140 = !DILocation(line: 51, column: 10, scope: !98)
!141 = !DILocation(line: 51, column: 2, scope: !98)
!142 = !DILocation(line: 52, column: 1, scope: !98)
