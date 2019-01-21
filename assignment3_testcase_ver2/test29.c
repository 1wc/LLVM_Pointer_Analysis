#include <stdlib.h>
struct fptr
{
	int (*p_fptr)(int, int);
};
struct fsptr
{
struct fptr * sptr;
};
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}
int clever(int a, int b, struct fptr * c_fptr, struct fptr * d_fptr) {
	int (*t_fptr)(int, int)=c_fptr->p_fptr;
	c_fptr->p_fptr=d_fptr->p_fptr;
	d_fptr->p_fptr=t_fptr;
    return t_fptr(a,b);
}
int foo(int a, int b, struct fsptr * c_fptr, struct fsptr * d_fptr) {
	struct fptr t_fptr=*(c_fptr->sptr);
	c_fptr->sptr=d_fptr->sptr;
    clever(a, b, c_fptr->sptr,&t_fptr);
    return t_fptr.p_fptr(a,b);
}
void moo(int x)
{
	struct fptr a_fptr;
	a_fptr.p_fptr=plus;
	struct fptr b_fptr;
	b_fptr.p_fptr=minus;

	struct fsptr s_fptr;
	s_fptr.sptr=&a_fptr;
	struct fsptr r_fptr;
	r_fptr.sptr=&b_fptr;

	struct fsptr* w_fptr=(struct fsptr*)malloc(sizeof(struct fsptr));
    
	*w_fptr=s_fptr;
	if(x>1)
	{
		 foo(1,x,w_fptr,&r_fptr);
	}else
	{
		w_fptr->sptr->p_fptr=plus;
	}
	foo(1,x,w_fptr,&s_fptr);
}
; ModuleID = 'test29.bc'
source_filename = "test29.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32, i32) #0 !dbg !20 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !21, metadata !22), !dbg !23
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !24, metadata !22), !dbg !25
  %3 = add nsw i32 %0, %1, !dbg !26
  ret i32 %3, !dbg !27
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32, i32) #0 !dbg !28 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !29, metadata !22), !dbg !30
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !31, metadata !22), !dbg !32
  %3 = sub nsw i32 %0, %1, !dbg !33
  ret i32 %3, !dbg !34
}

; Function Attrs: noinline nounwind uwtable
define i32 @clever(i32, i32, %struct.fptr*, %struct.fptr*) #0 !dbg !35 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !38, metadata !22), !dbg !39
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !40, metadata !22), !dbg !41
  call void @llvm.dbg.value(metadata %struct.fptr* %2, i64 0, metadata !42, metadata !22), !dbg !43
  call void @llvm.dbg.value(metadata %struct.fptr* %3, i64 0, metadata !44, metadata !22), !dbg !45
  %5 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !46
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %5, align 8, !dbg !46
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %6, i64 0, metadata !47, metadata !22), !dbg !48
  %7 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !49
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %7, align 8, !dbg !49
  %9 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !50
  store i32 (i32, i32)* %8, i32 (i32, i32)** %9, align 8, !dbg !51
  %10 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !52
  store i32 (i32, i32)* %6, i32 (i32, i32)** %10, align 8, !dbg !53
  %11 = call i32 %6(i32 %0, i32 %1), !dbg !54
  ret i32 %11, !dbg !55
}

; Function Attrs: noinline nounwind uwtable
define i32 @foo(i32, i32, %struct.fsptr*, %struct.fsptr*) #0 !dbg !56 {
  %5 = alloca %struct.fptr, align 8 // %5 dont have pointer 
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !59, metadata !22), !dbg !60
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !61, metadata !22), !dbg !62
  call void @llvm.dbg.value(metadata %struct.fsptr* %2, i64 0, metadata !63, metadata !22), !dbg !64
  call void @llvm.dbg.value(metadata %struct.fsptr* %3, i64 0, metadata !65, metadata !22), !dbg !66
  call void @llvm.dbg.declare(metadata %struct.fptr* %5, metadata !67, metadata !22), !dbg !68
  %6 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %2, i32 0, i32 0, !dbg !69
  %7 = load %struct.fptr*, %struct.fptr** %6, align 8, !dbg !69
  %8 = bitcast %struct.fptr* %5 to i8*, !dbg !70
  %9 = bitcast %struct.fptr* %7 to i8*, !dbg !70
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* %9, i64 8, i32 8, i1 false), !dbg !70
  %10 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %3, i32 0, i32 0, !dbg !71
  %11 = load %struct.fptr*, %struct.fptr** %10, align 8, !dbg !71
  %12 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %2, i32 0, i32 0, !dbg !72
  store %struct.fptr* %11, %struct.fptr** %12, align 8, !dbg !73
  %13 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %2, i32 0, i32 0, !dbg !74
  %14 = load %struct.fptr*, %struct.fptr** %13, align 8, !dbg !74
  %15 = call i32 @clever(i32 %0, i32 %1, %struct.fptr* %14, %struct.fptr* %5), !dbg !75
  %16 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !76
  %17 = load i32 (i32, i32)*, i32 (i32, i32)** %16, align 8, !dbg !76
  %18 = call i32 %17(i32 %0, i32 %1), !dbg !77
  ret i32 %18, !dbg !78
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind uwtable
define void @moo(i32) #0 !dbg !79 {
  %2 = alloca %struct.fptr, align 8
  %3 = alloca %struct.fptr, align 8
  %4 = alloca %struct.fsptr, align 8
  %5 = alloca %struct.fsptr, align 8
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !82, metadata !22), !dbg !83
  call void @llvm.dbg.declare(metadata %struct.fptr* %2, metadata !84, metadata !22), !dbg !85
  %6 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !86
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %6, align 8, !dbg !87
  call void @llvm.dbg.declare(metadata %struct.fptr* %3, metadata !88, metadata !22), !dbg !89
  %7 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !90
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %7, align 8, !dbg !91
  call void @llvm.dbg.declare(metadata %struct.fsptr* %4, metadata !92, metadata !22), !dbg !93
  %8 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !94
  store %struct.fptr* %2, %struct.fptr** %8, align 8, !dbg !95
  call void @llvm.dbg.declare(metadata %struct.fsptr* %5, metadata !96, metadata !22), !dbg !97
  %9 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !98
  store %struct.fptr* %3, %struct.fptr** %9, align 8, !dbg !99
  %10 = call noalias i8* @malloc(i64 8) #4, !dbg !100
  %11 = bitcast i8* %10 to %struct.fsptr*, !dbg !101
  call void @llvm.dbg.value(metadata %struct.fsptr* %11, i64 0, metadata !102, metadata !22), !dbg !103
  %12 = bitcast %struct.fsptr* %11 to i8*, !dbg !104
  %13 = bitcast %struct.fsptr* %4 to i8*, !dbg !104
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* %13, i64 8, i32 8, i1 false), !dbg !104
  %14 = icmp sgt i32 %0, 1, !dbg !105
  br i1 %14, label %15, label %17, !dbg !107

; <label>:15:                                     ; preds = %1
  %16 = call i32 @foo(i32 1, i32 %0, %struct.fsptr* %11, %struct.fsptr* %5), !dbg !108
  br label %21, !dbg !110

; <label>:17:                                     ; preds = %1
  %18 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %11, i32 0, i32 0, !dbg !111
  %19 = load %struct.fptr*, %struct.fptr** %18, align 8, !dbg !111
  %20 = getelementptr inbounds %struct.fptr, %struct.fptr* %19, i32 0, i32 0, !dbg !113
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %20, align 8, !dbg !114
  br label %21

; <label>:21:                                     ; preds = %17, %15
  %22 = call i32 @foo(i32 1, i32 %0, %struct.fsptr* %11, %struct.fsptr* %4), !dbg !115
  ret void, !dbg !116
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17, !18}
!llvm.ident = !{!19}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "test29.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
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
!19 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!20 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !13, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !15)
!22 = !DIExpression()
!23 = !DILocation(line: 10, column: 14, scope: !20)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !15)
!25 = !DILocation(line: 10, column: 21, scope: !20)
!26 = !DILocation(line: 11, column: 12, scope: !20)
!27 = !DILocation(line: 11, column: 4, scope: !20)
!28 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !13, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!29 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 14, type: !15)
!30 = !DILocation(line: 14, column: 15, scope: !28)
!31 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 14, type: !15)
!32 = !DILocation(line: 14, column: 22, scope: !28)
!33 = !DILocation(line: 15, column: 12, scope: !28)
!34 = !DILocation(line: 15, column: 4, scope: !28)
!35 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 17, type: !36, isLocal: false, isDefinition: true, scopeLine: 17, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!36 = !DISubroutineType(types: !37)
!37 = !{!15, !15, !15, !8, !8}
!38 = !DILocalVariable(name: "a", arg: 1, scope: !35, file: !1, line: 17, type: !15)
!39 = !DILocation(line: 17, column: 16, scope: !35)
!40 = !DILocalVariable(name: "b", arg: 2, scope: !35, file: !1, line: 17, type: !15)
!41 = !DILocation(line: 17, column: 23, scope: !35)
!42 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !35, file: !1, line: 17, type: !8)
!43 = !DILocation(line: 17, column: 40, scope: !35)
!44 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !35, file: !1, line: 17, type: !8)
!45 = !DILocation(line: 17, column: 62, scope: !35)
!46 = !DILocation(line: 18, column: 34, scope: !35)
!47 = !DILocalVariable(name: "t_fptr", scope: !35, file: !1, line: 18, type: !12)
!48 = !DILocation(line: 18, column: 8, scope: !35)
!49 = !DILocation(line: 19, column: 25, scope: !35)
!50 = !DILocation(line: 19, column: 10, scope: !35)
!51 = !DILocation(line: 19, column: 16, scope: !35)
!52 = !DILocation(line: 20, column: 10, scope: !35)
!53 = !DILocation(line: 20, column: 16, scope: !35)
!54 = !DILocation(line: 21, column: 12, scope: !35)
!55 = !DILocation(line: 21, column: 5, scope: !35)
!56 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 23, type: !57, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!57 = !DISubroutineType(types: !58)
!58 = !{!15, !15, !15, !4, !4}
!59 = !DILocalVariable(name: "a", arg: 1, scope: !56, file: !1, line: 23, type: !15)
!60 = !DILocation(line: 23, column: 13, scope: !56)
!61 = !DILocalVariable(name: "b", arg: 2, scope: !56, file: !1, line: 23, type: !15)
!62 = !DILocation(line: 23, column: 20, scope: !56)
!63 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !56, file: !1, line: 23, type: !4)
!64 = !DILocation(line: 23, column: 38, scope: !56)
!65 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !56, file: !1, line: 23, type: !4)
!66 = !DILocation(line: 23, column: 61, scope: !56)
!67 = !DILocalVariable(name: "t_fptr", scope: !56, file: !1, line: 24, type: !9)
!68 = !DILocation(line: 24, column: 14, scope: !56)
!69 = !DILocation(line: 24, column: 31, scope: !56)
!70 = !DILocation(line: 24, column: 21, scope: !56)
!71 = !DILocation(line: 25, column: 23, scope: !56)
!72 = !DILocation(line: 25, column: 10, scope: !56)
!73 = !DILocation(line: 25, column: 14, scope: !56)
!74 = !DILocation(line: 26, column: 26, scope: !56)
!75 = !DILocation(line: 26, column: 5, scope: !56)
!76 = !DILocation(line: 27, column: 19, scope: !56)
!77 = !DILocation(line: 27, column: 12, scope: !56)
!78 = !DILocation(line: 27, column: 5, scope: !56)
!79 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 29, type: !80, isLocal: false, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!80 = !DISubroutineType(types: !81)
!81 = !{null, !15}
!82 = !DILocalVariable(name: "x", arg: 1, scope: !79, file: !1, line: 29, type: !15)
!83 = !DILocation(line: 29, column: 14, scope: !79)
!84 = !DILocalVariable(name: "a_fptr", scope: !79, file: !1, line: 31, type: !9)
!85 = !DILocation(line: 31, column: 14, scope: !79)
!86 = !DILocation(line: 32, column: 9, scope: !79)
!87 = !DILocation(line: 32, column: 15, scope: !79)
!88 = !DILocalVariable(name: "b_fptr", scope: !79, file: !1, line: 33, type: !9)
!89 = !DILocation(line: 33, column: 14, scope: !79)
!90 = !DILocation(line: 34, column: 9, scope: !79)
!91 = !DILocation(line: 34, column: 15, scope: !79)
!92 = !DILocalVariable(name: "s_fptr", scope: !79, file: !1, line: 36, type: !5)
!93 = !DILocation(line: 36, column: 15, scope: !79)
!94 = !DILocation(line: 37, column: 9, scope: !79)
!95 = !DILocation(line: 37, column: 13, scope: !79)
!96 = !DILocalVariable(name: "r_fptr", scope: !79, file: !1, line: 38, type: !5)
!97 = !DILocation(line: 38, column: 15, scope: !79)
!98 = !DILocation(line: 39, column: 9, scope: !79)
!99 = !DILocation(line: 39, column: 13, scope: !79)
!100 = !DILocation(line: 41, column: 38, scope: !79)
!101 = !DILocation(line: 41, column: 23, scope: !79)
!102 = !DILocalVariable(name: "w_fptr", scope: !79, file: !1, line: 41, type: !4)
!103 = !DILocation(line: 41, column: 16, scope: !79)
!104 = !DILocation(line: 43, column: 10, scope: !79)
!105 = !DILocation(line: 44, column: 6, scope: !106)
!106 = distinct !DILexicalBlock(scope: !79, file: !1, line: 44, column: 5)
!107 = !DILocation(line: 44, column: 5, scope: !79)
!108 = !DILocation(line: 46, column: 4, scope: !109)
!109 = distinct !DILexicalBlock(scope: !106, file: !1, line: 45, column: 2)
!110 = !DILocation(line: 47, column: 2, scope: !109)
!111 = !DILocation(line: 49, column: 11, scope: !112)
!112 = distinct !DILexicalBlock(scope: !106, file: !1, line: 48, column: 2)
!113 = !DILocation(line: 49, column: 17, scope: !112)
!114 = !DILocation(line: 49, column: 23, scope: !112)
!115 = !DILocation(line: 51, column: 2, scope: !79)
!116 = !DILocation(line: 52, column: 1, scope: !79)

// 21 : minus, plus
// 26 : clever
// 27 : plus, minus
// 41 : malloc
// 46 : foo
// 51 : foo