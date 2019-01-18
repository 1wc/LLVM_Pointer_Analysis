; ModuleID = 'test12.bc'
source_filename = "test12.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32, i32) #0 !dbg !16 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !17, metadata !18), !dbg !19
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !20, metadata !18), !dbg !21
  %5 = load i32, i32* %3, align 4, !dbg !22
  %6 = load i32, i32* %4, align 4, !dbg !23
  %7 = add nsw i32 %5, %6, !dbg !24
  ret i32 %7, !dbg !25
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32, i32) #0 !dbg !26 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !27, metadata !18), !dbg !28
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !29, metadata !18), !dbg !30
  %5 = load i32, i32* %3, align 4, !dbg !31
  %6 = load i32, i32* %4, align 4, !dbg !32
  %7 = sub nsw i32 %5, %6, !dbg !33
  ret i32 %7, !dbg !34
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @clever(i32, i32, i32 (i32, i32)*) #0 !dbg !35 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32 (i32, i32)*, align 8
  store i32 %0, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !38, metadata !18), !dbg !39
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !40, metadata !18), !dbg !41
  store i32 (i32, i32)* %2, i32 (i32, i32)** %6, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %6, metadata !42, metadata !18), !dbg !43
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %6, align 8, !dbg !44
  %8 = load i32, i32* %4, align 4, !dbg !45
  %9 = load i32, i32* %5, align 4, !dbg !46
  %10 = call i32 %7(i32 %8, i32 %9), !dbg !44
  ret i32 %10, !dbg !47
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !48 {
  %4 = alloca i8, align 1
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32 (i32, i32)*, align 8
  %8 = alloca i32 (i32, i32)*, align 8
  %9 = alloca %struct.fptr*, align 8
  %10 = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %11 = alloca i32, align 4
  store i8 %0, i8* %4, align 1
  call void @llvm.dbg.declare(metadata i8* %4, metadata !52, metadata !18), !dbg !53
  store i32 %1, i32* %5, align 4
  call void @llvm.dbg.declare(metadata i32* %5, metadata !54, metadata !18), !dbg !55
  store i32 %2, i32* %6, align 4
  call void @llvm.dbg.declare(metadata i32* %6, metadata !56, metadata !18), !dbg !57
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %7, metadata !58, metadata !18), !dbg !59
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %7, align 8, !dbg !59
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %8, metadata !60, metadata !18), !dbg !61
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %8, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata %struct.fptr** %9, metadata !62, metadata !18), !dbg !63
  %12 = call noalias i8* @malloc(i64 8) #3, !dbg !64
  %13 = bitcast i8* %12 to %struct.fptr*, !dbg !65
  store %struct.fptr* %13, %struct.fptr** %9, align 8, !dbg !63
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %10, metadata !66, metadata !18), !dbg !68
  store i32 (i32, i32, i32 (i32, i32)*)* @clever, i32 (i32, i32, i32 (i32, i32)*)** %10, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata i32* %11, metadata !69, metadata !18), !dbg !71
  store i32 0, i32* %11, align 4, !dbg !71
  %14 = load i8, i8* %4, align 1, !dbg !72
  %15 = sext i8 %14 to i32, !dbg !72
  %16 = icmp eq i32 %15, 43, !dbg !74
  br i1 %16, label %17, label %21, !dbg !75

; <label>:17:                                     ; preds = %3
  %18 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !76
  %19 = load %struct.fptr*, %struct.fptr** %9, align 8, !dbg !78
  %20 = getelementptr inbounds %struct.fptr, %struct.fptr* %19, i32 0, i32 0, !dbg !79
  store i32 (i32, i32)* %18, i32 (i32, i32)** %20, align 8, !dbg !80
  br label %25, !dbg !81

; <label>:21:                                     ; preds = %3
  %22 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !82
  %23 = load %struct.fptr*, %struct.fptr** %9, align 8, !dbg !84
  %24 = getelementptr inbounds %struct.fptr, %struct.fptr* %23, i32 0, i32 0, !dbg !85
  store i32 (i32, i32)* %22, i32 (i32, i32)** %24, align 8, !dbg !86
  br label %25

; <label>:25:                                     ; preds = %21, %17
  %26 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %10, align 8, !dbg !87
  %27 = load i32, i32* %5, align 4, !dbg !88
  %28 = load i32, i32* %6, align 4, !dbg !89
  %29 = load %struct.fptr*, %struct.fptr** %9, align 8, !dbg !90
  %30 = getelementptr inbounds %struct.fptr, %struct.fptr* %29, i32 0, i32 0, !dbg !91
  %31 = load i32 (i32, i32)*, i32 (i32, i32)** %30, align 8, !dbg !91
  %32 = call i32 %26(i32 %27, i32 %28, i32 (i32, i32)* %31), !dbg !87
  store i32 %32, i32* %11, align 4, !dbg !92
  %33 = load i32, i32* %11, align 4, !dbg !93
  ret i32 %33, !dbg !94
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test12.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 13, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !5, file: !1, line: 15, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!16 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !9, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!17 = !DILocalVariable(name: "a", arg: 1, scope: !16, file: !1, line: 2, type: !11)
!18 = !DIExpression()
!19 = !DILocation(line: 2, column: 14, scope: !16)
!20 = !DILocalVariable(name: "b", arg: 2, scope: !16, file: !1, line: 2, type: !11)
!21 = !DILocation(line: 2, column: 21, scope: !16)
!22 = !DILocation(line: 3, column: 11, scope: !16)
!23 = !DILocation(line: 3, column: 13, scope: !16)
!24 = !DILocation(line: 3, column: 12, scope: !16)
!25 = !DILocation(line: 3, column: 4, scope: !16)
!26 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !9, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!27 = !DILocalVariable(name: "a", arg: 1, scope: !26, file: !1, line: 6, type: !11)
!28 = !DILocation(line: 6, column: 15, scope: !26)
!29 = !DILocalVariable(name: "b", arg: 2, scope: !26, file: !1, line: 6, type: !11)
!30 = !DILocation(line: 6, column: 22, scope: !26)
!31 = !DILocation(line: 7, column: 11, scope: !26)
!32 = !DILocation(line: 7, column: 13, scope: !26)
!33 = !DILocation(line: 7, column: 12, scope: !26)
!34 = !DILocation(line: 7, column: 4, scope: !26)
!35 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !36, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!36 = !DISubroutineType(types: !37)
!37 = !{!11, !11, !11, !8}
!38 = !DILocalVariable(name: "a", arg: 1, scope: !35, file: !1, line: 10, type: !11)
!39 = !DILocation(line: 10, column: 16, scope: !35)
!40 = !DILocalVariable(name: "b", arg: 2, scope: !35, file: !1, line: 10, type: !11)
!41 = !DILocation(line: 10, column: 23, scope: !35)
!42 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !35, file: !1, line: 10, type: !8)
!43 = !DILocation(line: 10, column: 32, scope: !35)
!44 = !DILocation(line: 11, column: 12, scope: !35)
!45 = !DILocation(line: 11, column: 19, scope: !35)
!46 = !DILocation(line: 11, column: 22, scope: !35)
!47 = !DILocation(line: 11, column: 5, scope: !35)
!48 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 18, type: !49, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!11, !51, !11, !11}
!51 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!52 = !DILocalVariable(name: "x", arg: 1, scope: !48, file: !1, line: 18, type: !51)
!53 = !DILocation(line: 18, column: 14, scope: !48)
!54 = !DILocalVariable(name: "op1", arg: 2, scope: !48, file: !1, line: 18, type: !11)
!55 = !DILocation(line: 18, column: 21, scope: !48)
!56 = !DILocalVariable(name: "op2", arg: 3, scope: !48, file: !1, line: 18, type: !11)
!57 = !DILocation(line: 18, column: 30, scope: !48)
!58 = !DILocalVariable(name: "a_fptr", scope: !48, file: !1, line: 19, type: !8)
!59 = !DILocation(line: 19, column: 11, scope: !48)
!60 = !DILocalVariable(name: "s_fptr", scope: !48, file: !1, line: 20, type: !8)
!61 = !DILocation(line: 20, column: 11, scope: !48)
!62 = !DILocalVariable(name: "t_fptr", scope: !48, file: !1, line: 21, type: !4)
!63 = !DILocation(line: 21, column: 19, scope: !48)
!64 = !DILocation(line: 21, column: 41, scope: !48)
!65 = !DILocation(line: 21, column: 26, scope: !48)
!66 = !DILocalVariable(name: "af_ptr", scope: !48, file: !1, line: 22, type: !67)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!68 = !DILocation(line: 22, column: 11, scope: !48)
!69 = !DILocalVariable(name: "result", scope: !48, file: !1, line: 23, type: !70)
!70 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!71 = !DILocation(line: 23, column: 14, scope: !48)
!72 = !DILocation(line: 24, column: 9, scope: !73)
!73 = distinct !DILexicalBlock(scope: !48, file: !1, line: 24, column: 9)
!74 = !DILocation(line: 24, column: 11, scope: !73)
!75 = !DILocation(line: 24, column: 9, scope: !48)
!76 = !DILocation(line: 25, column: 25, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 24, column: 19)
!78 = !DILocation(line: 25, column: 8, scope: !77)
!79 = !DILocation(line: 25, column: 16, scope: !77)
!80 = !DILocation(line: 25, column: 23, scope: !77)
!81 = !DILocation(line: 26, column: 5, scope: !77)
!82 = !DILocation(line: 28, column: 25, scope: !83)
!83 = distinct !DILexicalBlock(scope: !73, file: !1, line: 27, column: 5)
!84 = !DILocation(line: 28, column: 8, scope: !83)
!85 = !DILocation(line: 28, column: 16, scope: !83)
!86 = !DILocation(line: 28, column: 23, scope: !83)
!87 = !DILocation(line: 30, column: 13, scope: !48)
!88 = !DILocation(line: 30, column: 20, scope: !48)
!89 = !DILocation(line: 30, column: 25, scope: !48)
!90 = !DILocation(line: 30, column: 30, scope: !48)
!91 = !DILocation(line: 30, column: 38, scope: !48)
!92 = !DILocation(line: 30, column: 11, scope: !48)
!93 = !DILocation(line: 31, column: 12, scope: !48)
!94 = !DILocation(line: 31, column: 5, scope: !48)
