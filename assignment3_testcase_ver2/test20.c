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

struct fptr * foo(int a, int b, struct fsptr * a_fptr, struct fsptr * b_fptr) {
   return a_fptr->sptr;
}

struct fptr * clever(int a, int b, struct fsptr * a_fptr, struct fsptr * b_fptr ) {
   return b_fptr->sptr;
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

    if (x == '+') {
       goo_ptr = foo;
    } 
    else if (x == '-') {
       goo_ptr = clever;
       
    }

    t_fptr = goo_ptr(op1, op2, &m_fptr, &n_fptr);
    t_fptr->p_fptr(op1, op2);
    
    return 0;
}

; ModuleID = 'test20.bc'
source_filename = "test20.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
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
define %struct.fptr* @foo(i32, i32, %struct.fsptr*, %struct.fsptr*) #0 !dbg !25 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !37, metadata !12), !dbg !38
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !39, metadata !12), !dbg !40
  call void @llvm.dbg.value(metadata %struct.fsptr* %2, i64 0, metadata !41, metadata !12), !dbg !42
  call void @llvm.dbg.value(metadata %struct.fsptr* %3, i64 0, metadata !43, metadata !12), !dbg !44
  %5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %2, i32 0, i32 0, !dbg !45
  %6 = load %struct.fptr*, %struct.fptr** %5, align 8, !dbg !45
  ret %struct.fptr* %6, !dbg !46
}

; Function Attrs: noinline nounwind uwtable
define %struct.fptr* @clever(i32, i32, %struct.fsptr*, %struct.fsptr*) #0 !dbg !47 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !48, metadata !12), !dbg !49
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !50, metadata !12), !dbg !51
  call void @llvm.dbg.value(metadata %struct.fsptr* %2, i64 0, metadata !52, metadata !12), !dbg !53
  call void @llvm.dbg.value(metadata %struct.fsptr* %3, i64 0, metadata !54, metadata !12), !dbg !55
  %5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %3, i32 0, i32 0, !dbg !56
  %6 = load %struct.fptr*, %struct.fptr** %5, align 8, !dbg !56
  ret %struct.fptr* %6, !dbg !57
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !58 {
  %4 = alloca %struct.fptr, align 8
  %5 = alloca %struct.fptr, align 8
  %6 = alloca %struct.fsptr, align 8
  %7 = alloca %struct.fsptr, align 8
  call void @llvm.dbg.value(metadata i8 %0, i64 0, metadata !62, metadata !12), !dbg !63
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !64, metadata !12), !dbg !65
  call void @llvm.dbg.value(metadata i32 %2, i64 0, metadata !66, metadata !12), !dbg !67
  call void @llvm.dbg.declare(metadata %struct.fptr* %4, metadata !68, metadata !12), !dbg !69
  %8 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !70
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %8, align 8, !dbg !71
  call void @llvm.dbg.declare(metadata %struct.fptr* %5, metadata !72, metadata !12), !dbg !73
  %9 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !74
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %9, align 8, !dbg !75
  call void @llvm.dbg.declare(metadata %struct.fsptr* %6, metadata !76, metadata !12), !dbg !77
  %10 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %6, i32 0, i32 0, !dbg !78
  store %struct.fptr* %4, %struct.fptr** %10, align 8, !dbg !79
  call void @llvm.dbg.declare(metadata %struct.fsptr* %7, metadata !80, metadata !12), !dbg !81
  %11 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %7, i32 0, i32 0, !dbg !82
  store %struct.fptr* %5, %struct.fptr** %11, align 8, !dbg !83
  call void @llvm.dbg.value(metadata %struct.fptr* null, i64 0, metadata !84, metadata !12), !dbg !85
  %12 = sext i8 %0 to i32, !dbg !86
  %13 = icmp eq i32 %12, 43, !dbg !88
  br i1 %13, label %14, label %15, !dbg !89

; <label>:14:                                     ; preds = %3
  call void @llvm.dbg.value(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @foo, i64 0, metadata !90, metadata !12), !dbg !92
  br label %20, !dbg !93

; <label>:15:                                     ; preds = %3
  %16 = sext i8 %0 to i32, !dbg !95
  %17 = icmp eq i32 %16, 45, !dbg !97
  br i1 %17, label %18, label %19, !dbg !98

; <label>:18:                                     ; preds = %15
  call void @llvm.dbg.value(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @clever, i64 0, metadata !90, metadata !12), !dbg !92
  br label %19, !dbg !99

; <label>:19:                                     ; preds = %18, %15
  call void @llvm.dbg.value(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @clever, i64 0, metadata !90, metadata !12), !dbg !92
  br label %20

; <label>:20:                                     ; preds = %19, %14
  %.1 = phi %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* [ @foo, %14 ], [ @clever, %19 ]
  call void @llvm.dbg.value(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* %.1, i64 0, metadata !90, metadata !12), !dbg !92
  %21 = call %struct.fptr* %.1(i32 %1, i32 %2, %struct.fsptr* %6, %struct.fsptr* %7), !dbg !101
  call void @llvm.dbg.value(metadata %struct.fptr* %21, i64 0, metadata !84, metadata !12), !dbg !85
  %22 = getelementptr inbounds %struct.fptr, %struct.fptr* %21, i32 0, i32 0, !dbg !102
  %23 = load i32 (i32, i32)*, i32 (i32, i32)** %22, align 8, !dbg !102
  %24 = call i32 %23(i32 %1, i32 %2), !dbg !103
  ret i32 0, !dbg !104
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test20.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !8, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 10, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 10, type: !10)
!15 = !DILocation(line: 10, column: 21, scope: !7)
!16 = !DILocation(line: 11, column: 12, scope: !7)
!17 = !DILocation(line: 11, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 14, type: !10)
!20 = !DILocation(line: 14, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 14, type: !10)
!22 = !DILocation(line: 14, column: 22, scope: !18)
!23 = !DILocation(line: 15, column: 12, scope: !18)
!24 = !DILocation(line: 15, column: 4, scope: !18)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !26, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!28, !10, !10, !33, !33}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !30)
!30 = !{!31}
!31 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !29, file: !1, line: 4, baseType: !32, size: 64)
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !35)
!35 = !{!36}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !34, file: !1, line: 8, baseType: !28, size: 64)
!37 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 18, type: !10)
!38 = !DILocation(line: 18, column: 23, scope: !25)
!39 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 18, type: !10)
!40 = !DILocation(line: 18, column: 30, scope: !25)
!41 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !25, file: !1, line: 18, type: !33)
!42 = !DILocation(line: 18, column: 48, scope: !25)
!43 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !25, file: !1, line: 18, type: !33)
!44 = !DILocation(line: 18, column: 71, scope: !25)
!45 = !DILocation(line: 19, column: 19, scope: !25)
!46 = !DILocation(line: 19, column: 4, scope: !25)
!47 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 22, type: !26, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!48 = !DILocalVariable(name: "a", arg: 1, scope: !47, file: !1, line: 22, type: !10)
!49 = !DILocation(line: 22, column: 26, scope: !47)
!50 = !DILocalVariable(name: "b", arg: 2, scope: !47, file: !1, line: 22, type: !10)
!51 = !DILocation(line: 22, column: 33, scope: !47)
!52 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !47, file: !1, line: 22, type: !33)
!53 = !DILocation(line: 22, column: 51, scope: !47)
!54 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !47, file: !1, line: 22, type: !33)
!55 = !DILocation(line: 22, column: 74, scope: !47)
!56 = !DILocation(line: 23, column: 19, scope: !47)
!57 = !DILocation(line: 23, column: 4, scope: !47)
!58 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 26, type: !59, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!59 = !DISubroutineType(types: !60)
!60 = !{!10, !61, !10, !10}
!61 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!62 = !DILocalVariable(name: "x", arg: 1, scope: !58, file: !1, line: 26, type: !61)
!63 = !DILocation(line: 26, column: 14, scope: !58)
!64 = !DILocalVariable(name: "op1", arg: 2, scope: !58, file: !1, line: 26, type: !10)
!65 = !DILocation(line: 26, column: 21, scope: !58)
!66 = !DILocalVariable(name: "op2", arg: 3, scope: !58, file: !1, line: 26, type: !10)
!67 = !DILocation(line: 26, column: 30, scope: !58)
!68 = !DILocalVariable(name: "a_fptr", scope: !58, file: !1, line: 27, type: !29)
!69 = !DILocation(line: 27, column: 17, scope: !58)
!70 = !DILocation(line: 28, column: 12, scope: !58)
!71 = !DILocation(line: 28, column: 18, scope: !58)
!72 = !DILocalVariable(name: "s_fptr", scope: !58, file: !1, line: 29, type: !29)
!73 = !DILocation(line: 29, column: 17, scope: !58)
!74 = !DILocation(line: 30, column: 12, scope: !58)
!75 = !DILocation(line: 30, column: 18, scope: !58)
!76 = !DILocalVariable(name: "m_fptr", scope: !58, file: !1, line: 31, type: !34)
!77 = !DILocation(line: 31, column: 18, scope: !58)
!78 = !DILocation(line: 32, column: 12, scope: !58)
!79 = !DILocation(line: 32, column: 16, scope: !58)
!80 = !DILocalVariable(name: "n_fptr", scope: !58, file: !1, line: 33, type: !34)
!81 = !DILocation(line: 33, column: 18, scope: !58)
!82 = !DILocation(line: 34, column: 12, scope: !58)
!83 = !DILocation(line: 34, column: 16, scope: !58)
!84 = !DILocalVariable(name: "t_fptr", scope: !58, file: !1, line: 37, type: !28)
!85 = !DILocation(line: 37, column: 18, scope: !58)
!86 = !DILocation(line: 39, column: 9, scope: !87)
!87 = distinct !DILexicalBlock(scope: !58, file: !1, line: 39, column: 9)
!88 = !DILocation(line: 39, column: 11, scope: !87)
!89 = !DILocation(line: 39, column: 9, scope: !58)
!90 = !DILocalVariable(name: "goo_ptr", scope: !58, file: !1, line: 36, type: !91)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!92 = !DILocation(line: 36, column: 20, scope: !58)
!93 = !DILocation(line: 41, column: 5, scope: !94)
!94 = distinct !DILexicalBlock(scope: !87, file: !1, line: 39, column: 19)
!95 = !DILocation(line: 42, column: 14, scope: !96)
!96 = distinct !DILexicalBlock(scope: !87, file: !1, line: 42, column: 14)
!97 = !DILocation(line: 42, column: 16, scope: !96)
!98 = !DILocation(line: 42, column: 14, scope: !87)
!99 = !DILocation(line: 45, column: 5, scope: !100)
!100 = distinct !DILexicalBlock(scope: !96, file: !1, line: 42, column: 24)
!101 = !DILocation(line: 47, column: 14, scope: !58)
!102 = !DILocation(line: 48, column: 13, scope: !58)
!103 = !DILocation(line: 48, column: 5, scope: !58)
!104 = !DILocation(line: 50, column: 5, scope: !58)


// 47 : foo, clever
// 48 : plus, minus