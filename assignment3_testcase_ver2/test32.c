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

struct fptr * foo(int a, int b, struct wfsptr * a_fptr, struct wfsptr * b_fptr) {
   if(a>0 && b<0)
   {
    struct fsptr * temp=a_fptr->wfptr;
    a_fptr->wfptr->sptr = b_fptr->wfptr->sptr;
    b_fptr->wfptr->sptr =temp->sptr;
    return a_fptr->wfptr->sptr;
   }
   return b_fptr->wfptr->sptr;
} 

struct fptr * clever(int a, int b, struct fsptr * a_fptr, struct fsptr * b_fptr ) {
   struct wfsptr t1_fptr;
   t1_fptr.wfptr=a_fptr;
   struct wfsptr t2_fptr;
   t2_fptr.wfptr=b_fptr;
   return foo(a,b,&t1_fptr,&t2_fptr);
}


int moo(char x, int op1, int op2) {
    struct fptr a_fptr ;
    a_fptr.p_fptr=plus;
    struct fptr s_fptr ;
    s_fptr.p_fptr=minus;

    struct fsptr m_fptr;
    m_fptr.sptr=&a_fptr;
    struct fsptr n_fptr;
    n_fptr.sptr=&s_fptr;
    
    struct fptr* (*goo_ptr)(int, int, struct fsptr *,struct fsptr *);
    struct fptr* t_fptr = 0;

    t_fptr = clever(op1, op2, &m_fptr, &n_fptr);
    t_fptr->p_fptr(op1, op2);
    n_fptr.sptr->p_fptr(op1,op2);
    
    return 0;
}

; ModuleID = 'test32.bc'
source_filename = "test32.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32, i32) #0 !dbg !7 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !14, metadata !12), !dbg !15
  %3 = add nsw i32 %0, %1, !dbg !16
  ret i32 %3, !dbg !17
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32, i32) #0 !dbg !18 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !19, metadata !12), !dbg !20
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !21, metadata !12), !dbg !22
  %3 = sub nsw i32 %0, %1, !dbg !23
  ret i32 %3, !dbg !24
}

; Function Attrs: noinline nounwind uwtable
define %struct.fptr* @foo(i32, i32, %struct.wfsptr*, %struct.wfsptr*) #0 !dbg !25 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !41, metadata !12), !dbg !42
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !43, metadata !12), !dbg !44
  call void @llvm.dbg.value(metadata %struct.wfsptr* %2, i64 0, metadata !45, metadata !12), !dbg !46
  call void @llvm.dbg.value(metadata %struct.wfsptr* %3, i64 0, metadata !47, metadata !12), !dbg !48
  %5 = icmp sgt i32 %0, 0, !dbg !49
  br i1 %5, label %6, label %27, !dbg !51

; <label>:6:                                      ; preds = %4
  %7 = icmp slt i32 %1, 0, !dbg !52
  br i1 %7, label %8, label %27, !dbg !53

; <label>:8:                                      ; preds = %6
  %9 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %2, i32 0, i32 0, !dbg !54
  %10 = load %struct.fsptr*, %struct.fsptr** %9, align 8, !dbg !54
  call void @llvm.dbg.value(metadata %struct.fsptr* %10, i64 0, metadata !56, metadata !12), !dbg !57
  %11 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !58
  %12 = load %struct.fsptr*, %struct.fsptr** %11, align 8, !dbg !58
  %13 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %12, i32 0, i32 0, !dbg !59
  %14 = load %struct.fptr*, %struct.fptr** %13, align 8, !dbg !59
  %15 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %2, i32 0, i32 0, !dbg !60
  %16 = load %struct.fsptr*, %struct.fsptr** %15, align 8, !dbg !60
  %17 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %16, i32 0, i32 0, !dbg !61
  store %struct.fptr* %14, %struct.fptr** %17, align 8, !dbg !62
  %18 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %10, i32 0, i32 0, !dbg !63
  %19 = load %struct.fptr*, %struct.fptr** %18, align 8, !dbg !63
  %20 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !64
  %21 = load %struct.fsptr*, %struct.fsptr** %20, align 8, !dbg !64
  %22 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %21, i32 0, i32 0, !dbg !65
  store %struct.fptr* %19, %struct.fptr** %22, align 8, !dbg !66
  %23 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %2, i32 0, i32 0, !dbg !67
  %24 = load %struct.fsptr*, %struct.fsptr** %23, align 8, !dbg !67
  %25 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %24, i32 0, i32 0, !dbg !68
  %26 = load %struct.fptr*, %struct.fptr** %25, align 8, !dbg !68
  br label %32, !dbg !69

; <label>:27:                                     ; preds = %6, %4
  %28 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !70
  %29 = load %struct.fsptr*, %struct.fsptr** %28, align 8, !dbg !70
  %30 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %29, i32 0, i32 0, !dbg !71
  %31 = load %struct.fptr*, %struct.fptr** %30, align 8, !dbg !71
  br label %32, !dbg !72

; <label>:32:                                     ; preds = %27, %8
  %.0 = phi %struct.fptr* [ %26, %8 ], [ %31, %27 ]
  ret %struct.fptr* %.0, !dbg !73
}

; Function Attrs: noinline nounwind uwtable
define %struct.fptr* @clever(i32, i32, %struct.fsptr*, %struct.fsptr*) #0 !dbg !74 {
  %5 = alloca %struct.wfsptr, align 8
  %6 = alloca %struct.wfsptr, align 8
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !77, metadata !12), !dbg !78
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !79, metadata !12), !dbg !80
  call void @llvm.dbg.value(metadata %struct.fsptr* %2, i64 0, metadata !81, metadata !12), !dbg !82
  call void @llvm.dbg.value(metadata %struct.fsptr* %3, i64 0, metadata !83, metadata !12), !dbg !84
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %5, metadata !85, metadata !12), !dbg !86
  %7 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %5, i32 0, i32 0, !dbg !87
  store %struct.fsptr* %2, %struct.fsptr** %7, align 8, !dbg !88
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %6, metadata !89, metadata !12), !dbg !90
  %8 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %6, i32 0, i32 0, !dbg !91
  store %struct.fsptr* %3, %struct.fsptr** %8, align 8, !dbg !92
  %9 = call %struct.fptr* @foo(i32 %0, i32 %1, %struct.wfsptr* %5, %struct.wfsptr* %6), !dbg !93
  ret %struct.fptr* %9, !dbg !94
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !95 {
  %4 = alloca %struct.fptr, align 8
  %5 = alloca %struct.fptr, align 8
  %6 = alloca %struct.fsptr, align 8
  %7 = alloca %struct.fsptr, align 8
  call void @llvm.dbg.value(metadata i8 %0, i64 0, metadata !99, metadata !12), !dbg !100
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !101, metadata !12), !dbg !102
  call void @llvm.dbg.value(metadata i32 %2, i64 0, metadata !103, metadata !12), !dbg !104
  call void @llvm.dbg.declare(metadata %struct.fptr* %4, metadata !105, metadata !12), !dbg !106
  %8 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !107
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %8, align 8, !dbg !108
  call void @llvm.dbg.declare(metadata %struct.fptr* %5, metadata !109, metadata !12), !dbg !110
  %9 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !111
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %9, align 8, !dbg !112
  call void @llvm.dbg.declare(metadata %struct.fsptr* %6, metadata !113, metadata !12), !dbg !114
  %10 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %6, i32 0, i32 0, !dbg !115
  store %struct.fptr* %4, %struct.fptr** %10, align 8, !dbg !116
  call void @llvm.dbg.declare(metadata %struct.fsptr* %7, metadata !117, metadata !12), !dbg !118
  %11 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %7, i32 0, i32 0, !dbg !119
  store %struct.fptr* %5, %struct.fptr** %11, align 8, !dbg !120
  call void @llvm.dbg.declare(metadata !2, metadata !121, metadata !12), !dbg !123
  call void @llvm.dbg.value(metadata %struct.fptr* null, i64 0, metadata !124, metadata !12), !dbg !125
  %12 = call %struct.fptr* @clever(i32 %1, i32 %2, %struct.fsptr* %6, %struct.fsptr* %7), !dbg !126
  call void @llvm.dbg.value(metadata %struct.fptr* %12, i64 0, metadata !124, metadata !12), !dbg !125
  %13 = getelementptr inbounds %struct.fptr, %struct.fptr* %12, i32 0, i32 0, !dbg !127
  %14 = load i32 (i32, i32)*, i32 (i32, i32)** %13, align 8, !dbg !127
  %15 = call i32 %14(i32 %1, i32 %2), !dbg !128
  %16 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %7, i32 0, i32 0, !dbg !129
  %17 = load %struct.fptr*, %struct.fptr** %16, align 8, !dbg !129
  %18 = getelementptr inbounds %struct.fptr, %struct.fptr* %17, i32 0, i32 0, !dbg !130
  %19 = load i32 (i32, i32)*, i32 (i32, i32)** %18, align 8, !dbg !130
  %20 = call i32 %19(i32 %1, i32 %2), !dbg !131
  ret i32 0, !dbg !132
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test32.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 14, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 14, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 14, type: !10)
!15 = !DILocation(line: 14, column: 21, scope: !7)
!16 = !DILocation(line: 15, column: 12, scope: !7)
!17 = !DILocation(line: 15, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 18, type: !10)
!20 = !DILocation(line: 18, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 18, type: !10)
!22 = !DILocation(line: 18, column: 22, scope: !18)
!23 = !DILocation(line: 19, column: 12, scope: !18)
!24 = !DILocation(line: 19, column: 4, scope: !18)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 22, type: !26, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!28, !10, !10, !33, !33}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !30)
!30 = !{!31}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !29, file: !1, line: 4, baseType: !32, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !35)
!35 = !{!36}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !34, file: !1, line: 12, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !39)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !38, file: !1, line: 8, baseType: !28, size: 64)
!41 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 22, type: !10)
!42 = !DILocation(line: 22, column: 23, scope: !25)
!43 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 22, type: !10)
!44 = !DILocation(line: 22, column: 30, scope: !25)
!45 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !25, file: !1, line: 22, type: !33)
!46 = !DILocation(line: 22, column: 49, scope: !25)
!47 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !25, file: !1, line: 22, type: !33)
!48 = !DILocation(line: 22, column: 73, scope: !25)
!49 = !DILocation(line: 23, column: 8, scope: !50)
!50 = distinct !DILexicalBlock(scope: !25, file: !1, line: 23, column: 7)
!51 = !DILocation(line: 23, column: 11, scope: !50)
!52 = !DILocation(line: 23, column: 15, scope: !50)
!53 = !DILocation(line: 23, column: 7, scope: !25)
!54 = !DILocation(line: 25, column: 33, scope: !55)
!55 = distinct !DILexicalBlock(scope: !50, file: !1, line: 24, column: 4)
!56 = !DILocalVariable(name: "temp", scope: !55, file: !1, line: 25, type: !37)
!57 = !DILocation(line: 25, column: 20, scope: !55)
!58 = !DILocation(line: 26, column: 35, scope: !55)
!59 = !DILocation(line: 26, column: 42, scope: !55)
!60 = !DILocation(line: 26, column: 13, scope: !55)
!61 = !DILocation(line: 26, column: 20, scope: !55)
!62 = !DILocation(line: 26, column: 25, scope: !55)
!63 = !DILocation(line: 27, column: 32, scope: !55)
!64 = !DILocation(line: 27, column: 13, scope: !55)
!65 = !DILocation(line: 27, column: 20, scope: !55)
!66 = !DILocation(line: 27, column: 25, scope: !55)
!67 = !DILocation(line: 28, column: 20, scope: !55)
!68 = !DILocation(line: 28, column: 27, scope: !55)
!69 = !DILocation(line: 28, column: 5, scope: !55)
!70 = !DILocation(line: 30, column: 19, scope: !25)
!71 = !DILocation(line: 30, column: 26, scope: !25)
!72 = !DILocation(line: 30, column: 4, scope: !25)
!73 = !DILocation(line: 31, column: 1, scope: !25)
!74 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 33, type: !75, isLocal: false, isDefinition: true, scopeLine: 33, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!75 = !DISubroutineType(types: !76)
!76 = !{!28, !10, !10, !37, !37}
!77 = !DILocalVariable(name: "a", arg: 1, scope: !74, file: !1, line: 33, type: !10)
!78 = !DILocation(line: 33, column: 26, scope: !74)
!79 = !DILocalVariable(name: "b", arg: 2, scope: !74, file: !1, line: 33, type: !10)
!80 = !DILocation(line: 33, column: 33, scope: !74)
!81 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !74, file: !1, line: 33, type: !37)
!82 = !DILocation(line: 33, column: 51, scope: !74)
!83 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !74, file: !1, line: 33, type: !37)
!84 = !DILocation(line: 33, column: 74, scope: !74)
!85 = !DILocalVariable(name: "t1_fptr", scope: !74, file: !1, line: 34, type: !34)
!86 = !DILocation(line: 34, column: 18, scope: !74)
!87 = !DILocation(line: 35, column: 12, scope: !74)
!88 = !DILocation(line: 35, column: 17, scope: !74)
!89 = !DILocalVariable(name: "t2_fptr", scope: !74, file: !1, line: 36, type: !34)
!90 = !DILocation(line: 36, column: 18, scope: !74)
!91 = !DILocation(line: 37, column: 12, scope: !74)
!92 = !DILocation(line: 37, column: 17, scope: !74)
!93 = !DILocation(line: 38, column: 11, scope: !74)
!94 = !DILocation(line: 38, column: 4, scope: !74)
!95 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 42, type: !96, isLocal: false, isDefinition: true, scopeLine: 42, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!96 = !DISubroutineType(types: !97)
!97 = !{!10, !98, !10, !10}
!98 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!99 = !DILocalVariable(name: "x", arg: 1, scope: !95, file: !1, line: 42, type: !98)
!100 = !DILocation(line: 42, column: 14, scope: !95)
!101 = !DILocalVariable(name: "op1", arg: 2, scope: !95, file: !1, line: 42, type: !10)
!102 = !DILocation(line: 42, column: 21, scope: !95)
!103 = !DILocalVariable(name: "op2", arg: 3, scope: !95, file: !1, line: 42, type: !10)
!104 = !DILocation(line: 42, column: 30, scope: !95)
!105 = !DILocalVariable(name: "a_fptr", scope: !95, file: !1, line: 43, type: !29)
!106 = !DILocation(line: 43, column: 17, scope: !95)
!107 = !DILocation(line: 44, column: 12, scope: !95)
!108 = !DILocation(line: 44, column: 18, scope: !95)
!109 = !DILocalVariable(name: "s_fptr", scope: !95, file: !1, line: 45, type: !29)
!110 = !DILocation(line: 45, column: 17, scope: !95)
!111 = !DILocation(line: 46, column: 12, scope: !95)
!112 = !DILocation(line: 46, column: 18, scope: !95)
!113 = !DILocalVariable(name: "m_fptr", scope: !95, file: !1, line: 48, type: !38)
!114 = !DILocation(line: 48, column: 18, scope: !95)
!115 = !DILocation(line: 49, column: 12, scope: !95)
!116 = !DILocation(line: 49, column: 16, scope: !95)
!117 = !DILocalVariable(name: "n_fptr", scope: !95, file: !1, line: 50, type: !38)
!118 = !DILocation(line: 50, column: 18, scope: !95)
!119 = !DILocation(line: 51, column: 12, scope: !95)
!120 = !DILocation(line: 51, column: 16, scope: !95)
!121 = !DILocalVariable(name: "goo_ptr", scope: !95, file: !1, line: 53, type: !122)
!122 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!123 = !DILocation(line: 53, column: 20, scope: !95)
!124 = !DILocalVariable(name: "t_fptr", scope: !95, file: !1, line: 54, type: !28)
!125 = !DILocation(line: 54, column: 18, scope: !95)
!126 = !DILocation(line: 56, column: 14, scope: !95)
!127 = !DILocation(line: 57, column: 13, scope: !95)
!128 = !DILocation(line: 57, column: 5, scope: !95)
!129 = !DILocation(line: 58, column: 12, scope: !95)
!130 = !DILocation(line: 58, column: 18, scope: !95)
!131 = !DILocation(line: 58, column: 5, scope: !95)
!132 = !DILocation(line: 60, column: 5, scope: !95)


// 38 : foo
// 56 : clever
// 57 : minus
// 58 : minus