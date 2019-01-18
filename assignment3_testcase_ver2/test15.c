int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int foo(int a, int b, int (*a_fptr)(int, int), int(*b_fptr)(int, int) ) {
   int (*s_fptr)(int, int);
   if (a > 0) 
      s_fptr = a_fptr;
   else
      s_fptr = b_fptr;
   return s_fptr(a, b);
}

int clever(int a, int b, int (*a_fptr)(int, int), int(*b_fptr)(int, int)) {
    return foo(a, b, a_fptr, b_fptr);
}


int moo(char x, int op1, int op2) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    int (*t_fptr)(int, int) = 0;

    if (x == '+') {
       t_fptr = a_fptr;
    } 
    else if (x == '-') {
       t_fptr = s_fptr;
    }

    unsigned result = clever(op1, op2, a_fptr, t_fptr);
    return 0;
}

; ModuleID = 'test15.bc'
source_filename = "test15.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

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
define i32 @foo(i32, i32, i32 (i32, i32)*, i32 (i32, i32)*) #0 !dbg !25 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !29, metadata !12), !dbg !30
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !31, metadata !12), !dbg !32
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %2, i64 0, metadata !33, metadata !12), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %3, i64 0, metadata !35, metadata !12), !dbg !36
  %5 = icmp sgt i32 %0, 0, !dbg !37
  br i1 %5, label %6, label %7, !dbg !39

; <label>:6:                                      ; preds = %4
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %2, i64 0, metadata !40, metadata !12), !dbg !41
  br label %8, !dbg !42

; <label>:7:                                      ; preds = %4
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %3, i64 0, metadata !40, metadata !12), !dbg !41
  br label %8

; <label>:8:                                      ; preds = %7, %6
  %.0 = phi i32 (i32, i32)* [ %2, %6 ], [ %3, %7 ]
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.0, i64 0, metadata !40, metadata !12), !dbg !41
  %9 = call i32 %.0(i32 %0, i32 %1), !dbg !43
  ret i32 %9, !dbg !44
}

; Function Attrs: noinline nounwind uwtable
define i32 @clever(i32, i32, i32 (i32, i32)*, i32 (i32, i32)*) #0 !dbg !45 {
  call void @llvm.dbg.value(metadata i32 %0, i64 0, metadata !46, metadata !12), !dbg !47
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !48, metadata !12), !dbg !49
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %2, i64 0, metadata !50, metadata !12), !dbg !51
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %3, i64 0, metadata !52, metadata !12), !dbg !53
  %5 = call i32 @foo(i32 %0, i32 %1, i32 (i32, i32)* %2, i32 (i32, i32)* %3), !dbg !54
  ret i32 %5, !dbg !55
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext, i32, i32) #0 !dbg !56 {
  call void @llvm.dbg.value(metadata i8 %0, i64 0, metadata !60, metadata !12), !dbg !61
  call void @llvm.dbg.value(metadata i32 %1, i64 0, metadata !62, metadata !12), !dbg !63
  call void @llvm.dbg.value(metadata i32 %2, i64 0, metadata !64, metadata !12), !dbg !65
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !66, metadata !12), !dbg !67
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !68, metadata !12), !dbg !69
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, i64 0, metadata !70, metadata !12), !dbg !71
  %4 = sext i8 %0 to i32, !dbg !72
  %5 = icmp eq i32 %4, 43, !dbg !74
  br i1 %5, label %6, label %7, !dbg !75

; <label>:6:                                      ; preds = %3
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !70, metadata !12), !dbg !71
  br label %12, !dbg !76

; <label>:7:                                      ; preds = %3
  %8 = sext i8 %0 to i32, !dbg !78
  %9 = icmp eq i32 %8, 45, !dbg !80
  br i1 %9, label %10, label %11, !dbg !81

; <label>:10:                                     ; preds = %7
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !70, metadata !12), !dbg !71
  br label %11, !dbg !82

; <label>:11:                                     ; preds = %10, %7
  %.0 = phi i32 (i32, i32)* [ @minus, %10 ], [ null, %7 ]
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.0, i64 0, metadata !70, metadata !12), !dbg !71
  br label %12

; <label>:12:                                     ; preds = %11, %6
  %.1 = phi i32 (i32, i32)* [ @plus, %6 ], [ %.0, %11 ]
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %.1, i64 0, metadata !70, metadata !12), !dbg !71
  %13 = call i32 @clever(i32 %1, i32 %2, i32 (i32, i32)* @plus, i32 (i32, i32)* %.1), !dbg !84
  call void @llvm.dbg.value(metadata i32 %13, i64 0, metadata !85, metadata !12), !dbg !87
  ret i32 0, !dbg !88
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test15.c", directory: "/home/nevv/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 1, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 1, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 1, type: !10)
!15 = !DILocation(line: 1, column: 21, scope: !7)
!16 = !DILocation(line: 2, column: 12, scope: !7)
!17 = !DILocation(line: 2, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 5, type: !10)
!20 = !DILocation(line: 5, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 5, type: !10)
!22 = !DILocation(line: 5, column: 22, scope: !18)
!23 = !DILocation(line: 6, column: 12, scope: !18)
!24 = !DILocation(line: 6, column: 4, scope: !18)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !26, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!10, !10, !10, !28, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!29 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 9, type: !10)
!30 = !DILocation(line: 9, column: 13, scope: !25)
!31 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 9, type: !10)
!32 = !DILocation(line: 9, column: 20, scope: !25)
!33 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !25, file: !1, line: 9, type: !28)
!34 = !DILocation(line: 9, column: 29, scope: !25)
!35 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !25, file: !1, line: 9, type: !28)
!36 = !DILocation(line: 9, column: 53, scope: !25)
!37 = !DILocation(line: 11, column: 10, scope: !38)
!38 = distinct !DILexicalBlock(scope: !25, file: !1, line: 11, column: 8)
!39 = !DILocation(line: 11, column: 8, scope: !25)
!40 = !DILocalVariable(name: "s_fptr", scope: !25, file: !1, line: 10, type: !28)
!41 = !DILocation(line: 10, column: 10, scope: !25)
!42 = !DILocation(line: 12, column: 7, scope: !38)
!43 = !DILocation(line: 15, column: 11, scope: !25)
!44 = !DILocation(line: 15, column: 4, scope: !25)
!45 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 18, type: !26, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!46 = !DILocalVariable(name: "a", arg: 1, scope: !45, file: !1, line: 18, type: !10)
!47 = !DILocation(line: 18, column: 16, scope: !45)
!48 = !DILocalVariable(name: "b", arg: 2, scope: !45, file: !1, line: 18, type: !10)
!49 = !DILocation(line: 18, column: 23, scope: !45)
!50 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !45, file: !1, line: 18, type: !28)
!51 = !DILocation(line: 18, column: 32, scope: !45)
!52 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !45, file: !1, line: 18, type: !28)
!53 = !DILocation(line: 18, column: 56, scope: !45)
!54 = !DILocation(line: 19, column: 12, scope: !45)
!55 = !DILocation(line: 19, column: 5, scope: !45)
!56 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 23, type: !57, isLocal: false, isDefinition: true, scopeLine: 23, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!57 = !DISubroutineType(types: !58)
!58 = !{!10, !59, !10, !10}
!59 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!60 = !DILocalVariable(name: "x", arg: 1, scope: !56, file: !1, line: 23, type: !59)
!61 = !DILocation(line: 23, column: 14, scope: !56)
!62 = !DILocalVariable(name: "op1", arg: 2, scope: !56, file: !1, line: 23, type: !10)
!63 = !DILocation(line: 23, column: 21, scope: !56)
!64 = !DILocalVariable(name: "op2", arg: 3, scope: !56, file: !1, line: 23, type: !10)
!65 = !DILocation(line: 23, column: 30, scope: !56)
!66 = !DILocalVariable(name: "a_fptr", scope: !56, file: !1, line: 24, type: !28)
!67 = !DILocation(line: 24, column: 11, scope: !56)
!68 = !DILocalVariable(name: "s_fptr", scope: !56, file: !1, line: 25, type: !28)
!69 = !DILocation(line: 25, column: 11, scope: !56)
!70 = !DILocalVariable(name: "t_fptr", scope: !56, file: !1, line: 26, type: !28)
!71 = !DILocation(line: 26, column: 11, scope: !56)
!72 = !DILocation(line: 28, column: 9, scope: !73)
!73 = distinct !DILexicalBlock(scope: !56, file: !1, line: 28, column: 9)
!74 = !DILocation(line: 28, column: 11, scope: !73)
!75 = !DILocation(line: 28, column: 9, scope: !56)
!76 = !DILocation(line: 30, column: 5, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 28, column: 19)
!78 = !DILocation(line: 31, column: 14, scope: !79)
!79 = distinct !DILexicalBlock(scope: !73, file: !1, line: 31, column: 14)
!80 = !DILocation(line: 31, column: 16, scope: !79)
!81 = !DILocation(line: 31, column: 14, scope: !73)
!82 = !DILocation(line: 33, column: 5, scope: !83)
!83 = distinct !DILexicalBlock(scope: !79, file: !1, line: 31, column: 24)
!84 = !DILocation(line: 35, column: 23, scope: !56)
!85 = !DILocalVariable(name: "result", scope: !56, file: !1, line: 35, type: !86)
!86 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!87 = !DILocation(line: 35, column: 14, scope: !56)
!88 = !DILocation(line: 36, column: 5, scope: !56)


/// 15 : plus, minus
/// 19 : foo
/// 35 : clever
