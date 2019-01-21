#include <stdlib.h>
struct fptr
{
  int (*p_fptr)(int, int);
};

int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int (*foo(int a, int b, struct fptr * c_fptr, struct fptr * d_fptr))(int, int) {
   return c_fptr->p_fptr;
}

int (*clever(int a, int b, struct fptr * c_fptr, struct fptr * d_fptr))(int, int) {
  if(a>0 && b<0)
  {
   return d_fptr->p_fptr;
  }

  return c_fptr->p_fptr;
}

int moo(char x, int op1, int op2) {
    struct fptr a_fptr;
    a_fptr.p_fptr= plus;
    struct fptr s_fptr;
    s_fptr.p_fptr= minus;

    int (* (*goo_ptr)(int, int, struct fptr *,struct fptr *))(int, int)=foo;
    int (*t_fptr)(int, int) = 0;

    if(x == '+')
    {
        t_fptr = goo_ptr(op1, op2, &a_fptr, &s_fptr);
        t_fptr(op1, op2); 
    }else
    {
        goo_ptr=clever;
        t_fptr = goo_ptr(op1, op2, &s_fptr, &a_fptr);
        t_fptr(op1, op2); 
    }
    t_fptr(op1, op2);   
    return 0;
}

; ModuleID = 'test31.bc'
source_filename = "test31.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

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
define i32 (i32, i32)* @foo(i32, i32, %struct.fptr*, %struct.fptr*) #0 !dbg !25 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !33, metadata !12), !dbg !34
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !35, metadata !12), !dbg !36
  call void @llvm.dbg.value(metadata %struct.fptr* %2, i64 0, metadata !37, metadata !12), !dbg !38
  call void @llvm.dbg.value(metadata %struct.fptr* %3, i64 0, metadata !39, metadata !12), !dbg !40
  %5 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !41
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %5, align 8, !dbg !41
  ret i32 (i32, i32)* %6, !dbg !42
}

; Function Attrs: noinline nounwind uwtable
define i32 (i32, i32)* @clever(i32, i32, %struct.fptr*, %struct.fptr*) #0 !dbg !43 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !44, metadata !12), !dbg !45
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !46, metadata !12), !dbg !47
  call void @llvm.dbg.value(metadata %struct.fptr* %2, i64 0, metadata !48, metadata !12), !dbg !49
  call void @llvm.dbg.value(metadata %struct.fptr* %3, i64 0, metadata !50, metadata !12), !dbg !51
  %5 = icmp sgt i32 %0, 0, !dbg !52
  br i1 %5, label %6, label %11, !dbg !54

; <label>:6:                                      ; preds = %4
  %7 = icmp slt i32 %1, 0, !dbg !55
  br i1 %7, label %8, label %11, !dbg !56

; <label>:8:                                      ; preds = %6
  %9 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !57
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %9, align 8, !dbg !57
  br label %14, !dbg !59

; <label>:11:                                     ; preds = %6, %4
  %12 = getelementptr inbounds %struct.fptr, %struct.fptr* %2, i32 0, i32 0, !dbg !60
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %12, align 8, !dbg !60
  br label %14, !dbg !61

; <label>:14:                                     ; preds = %11, %8
  %.0 = phi i32 (i32, i32)* [ %10, %8 ], [ %13, %11 ]
  ret i32 (i32, i32)* %.0, !dbg !62
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !63 {
  %4 = alloca %struct.fptr, align 8
  %5 = alloca %struct.fptr, align 8
  call void @llvm.dbg.value(metadata i8 %0, i64 0, metadata !67, metadata !12), !dbg !68
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !69, metadata !12), !dbg !70
  call void @llvm.dbg.value(metadata i32 %2, i64 0, metadata !71, metadata !12), !dbg !72
  call void @llvm.dbg.declare(metadata %struct.fptr* %4, metadata !73, metadata !12), !dbg !74
  %6 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !75
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %6, align 8, !dbg !76
  call void @llvm.dbg.declare(metadata %struct.fptr* %5, metadata !77, metadata !12), !dbg !78
  %7 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !79
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %7, align 8, !dbg !80
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)* @foo, i64 0, metadata !81, metadata !12), !dbg !83
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, i64 0, metadata !84, metadata !12), !dbg !85
  %8 = sext i8 %0 to i32, !dbg !86
  %9 = icmp eq i32 %8, 43, !dbg !88
  br i1 %9, label %10, label %13, !dbg !89

; <label>:10:                                     ; preds = %3
  %11 = call i32 (i32, i32)* @foo(i32 %1, i32 %2, %struct.fptr* %4, %struct.fptr* %5), !dbg !90
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %11, i64 0, metadata !84, metadata !12), !dbg !85
  %12 = call i32 %11(i32 %1, i32 %2), !dbg !92
  br label %16, !dbg !93

; <label>:13:                                     ; preds = %3
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, %struct.fptr*, %struct.fptr*)* @clever, i64 0, metadata !81, metadata !12), !dbg !83
  %14 = call i32 (i32, i32)* @clever(i32 %1, i32 %2, %struct.fptr* %5, %struct.fptr* %4), !dbg !94
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %14, i64 0, metadata !84, metadata !12), !dbg !85
  %15 = call i32 %14(i32 %1, i32 %2), !dbg !96
  br label %16

; <label>:16:                                     ; preds = %13, %10
  %.0 = phi i32 (i32, i32)* [ %11, %10 ], [ %14, %13 ]
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.0, i64 0, metadata !84, metadata !12), !dbg !85
  %17 = call i32 %.0(i32 %1, i32 %2), !dbg !97
  ret i32 0, !dbg !98
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test31.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 7, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 7, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 7, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 7, type: !10)
!15 = !DILocation(line: 7, column: 21, scope: !7)
!16 = !DILocation(line: 8, column: 12, scope: !7)
!17 = !DILocation(line: 8, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 11, type: !8, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 11, type: !10)
!20 = !DILocation(line: 11, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 11, type: !10)
!22 = !DILocation(line: 11, column: 22, scope: !18)
!23 = !DILocation(line: 12, column: 12, scope: !18)
!24 = !DILocation(line: 12, column: 4, scope: !18)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 15, type: !26, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!28, !10, !10, !29, !29}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!29 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !30, size: 64)
!30 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !31)
!31 = !{!32}
!32 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !30, file: !1, line: 4, baseType: !28, size: 64)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 15, type: !10)
!34 = !DILocation(line: 15, column: 15, scope: !25)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 15, type: !10)
!36 = !DILocation(line: 15, column: 22, scope: !25)
!37 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !25, file: !1, line: 15, type: !29)
!38 = !DILocation(line: 15, column: 39, scope: !25)
!39 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !25, file: !1, line: 15, type: !29)
!40 = !DILocation(line: 15, column: 61, scope: !25)
!41 = !DILocation(line: 16, column: 19, scope: !25)
!42 = !DILocation(line: 16, column: 4, scope: !25)
!43 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 19, type: !26, isLocal: false, isDefinition: true, scopeLine: 19, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!44 = !DILocalVariable(name: "a", arg: 1, scope: !43, file: !1, line: 19, type: !10)
!45 = !DILocation(line: 19, column: 18, scope: !43)
!46 = !DILocalVariable(name: "b", arg: 2, scope: !43, file: !1, line: 19, type: !10)
!47 = !DILocation(line: 19, column: 25, scope: !43)
!48 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !43, file: !1, line: 19, type: !29)
!49 = !DILocation(line: 19, column: 42, scope: !43)
!50 = !DILocalVariable(name: "d_fptr", arg: 4, scope: !43, file: !1, line: 19, type: !29)
!51 = !DILocation(line: 19, column: 64, scope: !43)
!52 = !DILocation(line: 20, column: 7, scope: !53)
!53 = distinct !DILexicalBlock(scope: !43, file: !1, line: 20, column: 6)
!54 = !DILocation(line: 20, column: 10, scope: !53)
!55 = !DILocation(line: 20, column: 14, scope: !53)
!56 = !DILocation(line: 20, column: 6, scope: !43)
!57 = !DILocation(line: 22, column: 19, scope: !58)
!58 = distinct !DILexicalBlock(scope: !53, file: !1, line: 21, column: 3)
!59 = !DILocation(line: 22, column: 4, scope: !58)
!60 = !DILocation(line: 25, column: 18, scope: !43)
!61 = !DILocation(line: 25, column: 3, scope: !43)
!62 = !DILocation(line: 26, column: 1, scope: !43)
!63 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 28, type: !64, isLocal: false, isDefinition: true, scopeLine: 28, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!64 = !DISubroutineType(types: !65)
!65 = !{!10, !66, !10, !10}
!66 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!67 = !DILocalVariable(name: "x", arg: 1, scope: !63, file: !1, line: 28, type: !66)
!68 = !DILocation(line: 28, column: 14, scope: !63)
!69 = !DILocalVariable(name: "op1", arg: 2, scope: !63, file: !1, line: 28, type: !10)
!70 = !DILocation(line: 28, column: 21, scope: !63)
!71 = !DILocalVariable(name: "op2", arg: 3, scope: !63, file: !1, line: 28, type: !10)
!72 = !DILocation(line: 28, column: 30, scope: !63)
!73 = !DILocalVariable(name: "a_fptr", scope: !63, file: !1, line: 29, type: !30)
!74 = !DILocation(line: 29, column: 17, scope: !63)
!75 = !DILocation(line: 30, column: 12, scope: !63)
!76 = !DILocation(line: 30, column: 18, scope: !63)
!77 = !DILocalVariable(name: "s_fptr", scope: !63, file: !1, line: 31, type: !30)
!78 = !DILocation(line: 31, column: 17, scope: !63)
!79 = !DILocation(line: 32, column: 12, scope: !63)
!80 = !DILocation(line: 32, column: 18, scope: !63)
!81 = !DILocalVariable(name: "goo_ptr", scope: !63, file: !1, line: 34, type: !82)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!83 = !DILocation(line: 34, column: 14, scope: !63)
!84 = !DILocalVariable(name: "t_fptr", scope: !63, file: !1, line: 35, type: !28)
!85 = !DILocation(line: 35, column: 11, scope: !63)
!86 = !DILocation(line: 37, column: 8, scope: !87)
!87 = distinct !DILexicalBlock(scope: !63, file: !1, line: 37, column: 8)
!88 = !DILocation(line: 37, column: 10, scope: !87)
!89 = !DILocation(line: 37, column: 8, scope: !63)
!90 = !DILocation(line: 39, column: 18, scope: !91)
!91 = distinct !DILexicalBlock(scope: !87, file: !1, line: 38, column: 5)
!92 = !DILocation(line: 40, column: 9, scope: !91)
!93 = !DILocation(line: 41, column: 5, scope: !91)
!94 = !DILocation(line: 44, column: 18, scope: !95)
!95 = distinct !DILexicalBlock(scope: !87, file: !1, line: 42, column: 5)
!96 = !DILocation(line: 45, column: 9, scope: !95)
!97 = !DILocation(line: 47, column: 5, scope: !63)
!98 = !DILocation(line: 48, column: 5, scope: !63)


// 39 : foo
// 40 : plus
// 44 : clever
// 45 : plus, minus
// 47 : plus, minus

