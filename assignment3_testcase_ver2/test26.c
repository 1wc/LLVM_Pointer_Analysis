#include <stdlib.h>
struct fptr
{
	int (*p_fptr)(int, int);
};
struct fsptr
{
struct fptr * sptr;
};
struct wfsptr
{
	struct fsptr * wfptr;
};
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}
void make_alias(struct wfsptr *a,struct fsptr *b)
{
	a->wfptr->sptr->p_fptr=b->sptr->p_fptr;
}
void foo(int x)
{
	struct fptr a_fptr;
	struct fptr b_fptr;
	struct fsptr s_fptr;
	struct fsptr m_fptr;
	struct wfsptr* w_fptr=(struct wfsptr*)malloc(sizeof(struct wfsptr));
	s_fptr.sptr=&a_fptr;
	m_fptr.sptr=&b_fptr;
	b_fptr.p_fptr=minus;
	w_fptr->wfptr=&s_fptr;
	if(x>1)
	{
		 a_fptr.p_fptr=plus;
		 x=s_fptr.sptr->p_fptr(1,x);
		 make_alias(w_fptr,&m_fptr);
	}else
	{
		w_fptr->wfptr->sptr->p_fptr=minus;
	}
	x=a_fptr.p_fptr(1,x);
}


; ModuleID = 'test26.bc'
source_filename = "test26.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }
%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32, i32) #0 !dbg !24 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !25, metadata !26), !dbg !27
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !28, metadata !26), !dbg !29
  %3 = add nsw i32 %0, %1, !dbg !30
  ret i32 %3, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32, i32) #0 !dbg !32 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !33, metadata !26), !dbg !34
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !35, metadata !26), !dbg !36
  %3 = sub nsw i32 %0, %1, !dbg !37
  ret i32 %3, !dbg !38
}

; Function Attrs: noinline nounwind uwtable
define void @make_alias(%struct.wfsptr*, %struct.fsptr*) #0 !dbg !39 {
  call void @llvm.dbg.value(metadata %struct.wfsptr* %0, i64 0, metadata !42, metadata !26), !dbg !43
  call void @llvm.dbg.value(metadata %struct.fsptr* %1, i64 0, metadata !44, metadata !26), !dbg !45
  %3 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %1, i32 0, i32 0, !dbg !46
  %4 = load %struct.fptr*, %struct.fptr** %3, align 8, !dbg !46
  %5 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !47
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %5, align 8, !dbg !47
  %7 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %0, i32 0, i32 0, !dbg !48
  %8 = load %struct.fsptr*, %struct.fsptr** %7, align 8, !dbg !48
  %9 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %8, i32 0, i32 0, !dbg !49
  %10 = load %struct.fptr*, %struct.fptr** %9, align 8, !dbg !49
  %11 = getelementptr inbounds %struct.fptr, %struct.fptr* %10, i32 0, i32 0, !dbg !50
  store i32 (i32, i32)* %6, i32 (i32, i32)** %11, align 8, !dbg !51
  ret void, !dbg !52
}

; Function Attrs: noinline nounwind uwtable
define void @foo(i32) #0 !dbg !53 {
  %2 = alloca %struct.fptr, align 8
  %3 = alloca %struct.fptr, align 8
  %4 = alloca %struct.fsptr, align 8
  %5 = alloca %struct.fsptr, align 8
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !56, metadata !26), !dbg !57
  call void @llvm.dbg.declare(metadata %struct.fptr* %2, metadata !58, metadata !26), !dbg !59
  call void @llvm.dbg.declare(metadata %struct.fptr* %3, metadata !60, metadata !26), !dbg !61
  call void @llvm.dbg.declare(metadata %struct.fsptr* %4, metadata !62, metadata !26), !dbg !63
  call void @llvm.dbg.declare(metadata %struct.fsptr* %5, metadata !64, metadata !26), !dbg !65
  %6 = call noalias i8* @malloc(i64 8) #3, !dbg !66
  %7 = bitcast i8* %6 to %struct.wfsptr*, !dbg !67
  call void @llvm.dbg.value(metadata %struct.wfsptr* %7, i64 0, metadata !68, metadata !26), !dbg !69
  %8 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !70
  store %struct.fptr* %2, %struct.fptr** %8, align 8, !dbg !71
  %9 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !72
  store %struct.fptr* %3, %struct.fptr** %9, align 8, !dbg !73
  %10 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !74
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %10, align 8, !dbg !75
  %11 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %7, i32 0, i32 0, !dbg !76
  store %struct.fsptr* %4, %struct.fsptr** %11, align 8, !dbg !77
  %12 = icmp sgt i32 %0, 1, !dbg !78
  br i1 %12, label %13, label %20, !dbg !80

; <label>:13:                                     ; preds = %1
  %14 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !81
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %14, align 8, !dbg !83
  %15 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !84
  %16 = load %struct.fptr*, %struct.fptr** %15, align 8, !dbg !84
  %17 = getelementptr inbounds %struct.fptr, %struct.fptr* %16, i32 0, i32 0, !dbg !85
  %18 = load i32 (i32, i32)*, i32 (i32, i32)** %17, align 8, !dbg !85
  %19 = call i32 %18(i32 1, i32 %0), !dbg !86
  call void @llvm.dbg.value(metadata i32 %19, i64 0, metadata !56, metadata !26), !dbg !57
  call void @make_alias(%struct.wfsptr* %7, %struct.fsptr* %5), !dbg !87
  br label %26, !dbg !88

; <label>:20:                                     ; preds = %1
  %21 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %7, i32 0, i32 0, !dbg !89
  %22 = load %struct.fsptr*, %struct.fsptr** %21, align 8, !dbg !89
  %23 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %22, i32 0, i32 0, !dbg !91
  %24 = load %struct.fptr*, %struct.fptr** %23, align 8, !dbg !91
  %25 = getelementptr inbounds %struct.fptr, %struct.fptr* %24, i32 0, i32 0, !dbg !92
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %25, align 8, !dbg !93
  br label %26

; <label>:26:                                     ; preds = %20, %13
  %.0 = phi i32 [ %19, %13 ], [ %0, %20 ]
  call void @llvm.dbg.value(metadata i32 %.0, i64 0, metadata !56, metadata !26), !dbg !57
  %27 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !94
  %28 = load i32 (i32, i32)*, i32 (i32, i32)** %27, align 8, !dbg !94
  %29 = call i32 %28(i32 1, i32 %.0), !dbg !95
  call void @llvm.dbg.value(metadata i32 %29, i64 0, metadata !56, metadata !26), !dbg !57
  ret void, !dbg !96
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!20, !21, !22}
!llvm.ident = !{!23}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test26.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
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
!23 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!24 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !17, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!25 = !DILocalVariable(name: "a", arg: 1, scope: !24, file: !1, line: 14, type: !19)
!26 = !DIExpression()
!27 = !DILocation(line: 14, column: 14, scope: !24)
!28 = !DILocalVariable(name: "b", arg: 2, scope: !24, file: !1, line: 14, type: !19)
!29 = !DILocation(line: 14, column: 21, scope: !24)
!30 = !DILocation(line: 15, column: 12, scope: !24)
!31 = !DILocation(line: 15, column: 4, scope: !24)
!32 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !17, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !32, file: !1, line: 18, type: !19)
!34 = !DILocation(line: 18, column: 15, scope: !32)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !32, file: !1, line: 18, type: !19)
!36 = !DILocation(line: 18, column: 22, scope: !32)
!37 = !DILocation(line: 19, column: 12, scope: !32)
!38 = !DILocation(line: 19, column: 4, scope: !32)
!39 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 21, type: !40, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{null, !4, !8}
!42 = !DILocalVariable(name: "a", arg: 1, scope: !39, file: !1, line: 21, type: !4)
!43 = !DILocation(line: 21, column: 32, scope: !39)
!44 = !DILocalVariable(name: "b", arg: 2, scope: !39, file: !1, line: 21, type: !8)
!45 = !DILocation(line: 21, column: 48, scope: !39)
!46 = !DILocation(line: 23, column: 28, scope: !39)
!47 = !DILocation(line: 23, column: 34, scope: !39)
!48 = !DILocation(line: 23, column: 5, scope: !39)
!49 = !DILocation(line: 23, column: 12, scope: !39)
!50 = !DILocation(line: 23, column: 18, scope: !39)
!51 = !DILocation(line: 23, column: 24, scope: !39)
!52 = !DILocation(line: 24, column: 1, scope: !39)
!53 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 25, type: !54, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!54 = !DISubroutineType(types: !55)
!55 = !{null, !19}
!56 = !DILocalVariable(name: "x", arg: 1, scope: !53, file: !1, line: 25, type: !19)
!57 = !DILocation(line: 25, column: 14, scope: !53)
!58 = !DILocalVariable(name: "a_fptr", scope: !53, file: !1, line: 27, type: !13)
!59 = !DILocation(line: 27, column: 14, scope: !53)
!60 = !DILocalVariable(name: "b_fptr", scope: !53, file: !1, line: 28, type: !13)
!61 = !DILocation(line: 28, column: 14, scope: !53)
!62 = !DILocalVariable(name: "s_fptr", scope: !53, file: !1, line: 29, type: !9)
!63 = !DILocation(line: 29, column: 15, scope: !53)
!64 = !DILocalVariable(name: "m_fptr", scope: !53, file: !1, line: 30, type: !9)
!65 = !DILocation(line: 30, column: 15, scope: !53)
!66 = !DILocation(line: 31, column: 40, scope: !53)
!67 = !DILocation(line: 31, column: 24, scope: !53)
!68 = !DILocalVariable(name: "w_fptr", scope: !53, file: !1, line: 31, type: !4)
!69 = !DILocation(line: 31, column: 17, scope: !53)
!70 = !DILocation(line: 32, column: 9, scope: !53)
!71 = !DILocation(line: 32, column: 13, scope: !53)
!72 = !DILocation(line: 33, column: 9, scope: !53)
!73 = !DILocation(line: 33, column: 13, scope: !53)
!74 = !DILocation(line: 34, column: 9, scope: !53)
!75 = !DILocation(line: 34, column: 15, scope: !53)
!76 = !DILocation(line: 35, column: 10, scope: !53)
!77 = !DILocation(line: 35, column: 15, scope: !53)
!78 = !DILocation(line: 36, column: 6, scope: !79)
!79 = distinct !DILexicalBlock(scope: !53, file: !1, line: 36, column: 5)
!80 = !DILocation(line: 36, column: 5, scope: !53)
!81 = !DILocation(line: 38, column: 11, scope: !82)
!82 = distinct !DILexicalBlock(scope: !79, file: !1, line: 37, column: 2)
!83 = !DILocation(line: 38, column: 17, scope: !82)
!84 = !DILocation(line: 39, column: 13, scope: !82)
!85 = !DILocation(line: 39, column: 19, scope: !82)
!86 = !DILocation(line: 39, column: 6, scope: !82)
!87 = !DILocation(line: 40, column: 4, scope: !82)
!88 = !DILocation(line: 41, column: 2, scope: !82)
!89 = !DILocation(line: 43, column: 11, scope: !90)
!90 = distinct !DILexicalBlock(scope: !79, file: !1, line: 42, column: 2)
!91 = !DILocation(line: 43, column: 18, scope: !90)
!92 = !DILocation(line: 43, column: 24, scope: !90)
!93 = !DILocation(line: 43, column: 30, scope: !90)
!94 = !DILocation(line: 45, column: 11, scope: !53)
!95 = !DILocation(line: 45, column: 4, scope: !53)
!96 = !DILocation(line: 46, column: 1, scope: !53)


// 31 : malloc
// 39 : plus
// 40 : make_alias
// 45 : minus