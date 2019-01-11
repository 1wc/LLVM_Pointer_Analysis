#include <stdlib.h>
int plus(int a, int b) {
   return a+b;
}

int minus(int a, int b) {
   return a-b;
}

int (*foo(int a, int b, int (*a_fptr)(int, int), int(*b_fptr)(int, int) ))(int, int) {
   return a_fptr;
}
int (*clever(int a, int b, int (*a_fptr)(int, int), int(*b_fptr)(int, int) ))(int, int) {
   return b_fptr;
}
int moo(char x, int op1, int op2) {
    int (*a_fptr)(int, int) = plus;
    int (*s_fptr)(int, int) = minus;
    int (* (*goo_ptr)(int, int, int (*)(int, int), int(*)(int, int)))(int, int)=foo;
    int (*t_fptr)(int, int) = 0;

    if(x == '+')
    {
        t_fptr = goo_ptr(op1, op2, a_fptr, s_fptr);
    }else
    {
        goo_ptr=clever;
        t_fptr = goo_ptr(op1, op2, s_fptr, a_fptr);
    }
    t_fptr(op1, op2);   
    return 0;
}


// 24 : foo
// 28 : clever  
// 30 : plus


le = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !7 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !11, metadata !12), !dbg !13
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !14, metadata !12), !dbg !15
  %add = add nsw i32 %a, %b, !dbg !16
  ret i32 %add, !dbg !17
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !18 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !19, metadata !12), !dbg !20
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !21, metadata !12), !dbg !22
  %sub = sub nsw i32 %a, %b, !dbg !23
  ret i32 %sub, !dbg !24
}

; Function Attrs: noinline nounwind uwtable
define i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !25 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !29, metadata !12), !dbg !30
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !31, metadata !12), !dbg !32
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %a_fptr, i64 0, metadata !33, metadata !12), !dbg !34
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %b_fptr, i64 0, metadata !35, metadata !12), !dbg !36
  ret i32 (i32, i32)* %a_fptr, !dbg !37
}

; Function Attrs: noinline nounwind uwtable
define i32 (i32, i32)* @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !38 {
entry:
  call void @llvm.dbg.value(metadata i32 %a, i64 0, metadata !39, metadata !12), !dbg !40
  call void @llvm.dbg.value(metadata i32 %b, i64 0, metadata !41, metadata !12), !dbg !42
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %a_fptr, i64 0, metadata !43, metadata !12), !dbg !44
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %b_fptr, i64 0, metadata !45, metadata !12), !dbg !46
  ret i32 (i32, i32)* %b_fptr, !dbg !47
}

; Function Attrs: noinline nounwind uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !48 {
entry:
  call void @llvm.dbg.value(metadata i8 %x, i64 0, metadata !52, metadata !12), !dbg !53
  call void @llvm.dbg.value(metadata i32 %op1, i64 0, metadata !54, metadata !12), !dbg !55
  call void @llvm.dbg.value(metadata i32 %op2, i64 0, metadata !56, metadata !12), !dbg !57
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @plus, i64 0, metadata !58, metadata !12), !dbg !59
  call void @llvm.dbg.value(metadata i32 (i32, i32)* @minus, i64 0, metadata !60, metadata !12), !dbg !61
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @foo, i64 0, metadata !62, metadata !12), !dbg !64
  call void @llvm.dbg.value(metadata i32 (i32, i32)* null, i64 0, metadata !65, metadata !12), !dbg !66
  %conv = sext i8 %x to i32, !dbg !67
  %cmp = icmp eq i32 %conv, 43, !dbg !69
  br i1 %cmp, label %if.then, label %if.else, !dbg !70

if.then:                                          ; preds = %entry
  %call = call i32 (i32, i32)* @foo(i32 %op1, i32 %op2, i32 (i32, i32)* @plus, i32 (i32, i32)* @minus), !dbg !71
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %call, i64 0, metadata !65, metadata !12), !dbg !66
  br label %if.end, !dbg !73

if.else:                                          ; preds = %entry
  call void @llvm.dbg.value(metadata i32 (i32, i32)* (i32, i32, i32 (i32, i32)*, i32 (i32, i32)*)* @clever, i64 0, metadata !62, metadata !12), !dbg !64
  %call2 = call i32 (i32, i32)* @clever(i32 %op1, i32 %op2, i32 (i32, i32)* @minus, i32 (i32, i32)* @plus), !dbg !74
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %call2, i64 0, metadata !65, metadata !12), !dbg !66
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %t_fptr.0 = phi i32 (i32, i32)* [ %call, %if.then ], [ %call2, %if.else ]
  call void @llvm.dbg.value(metadata i32 (i32, i32)* %t_fptr.0, i64 0, metadata !65, metadata !12), !dbg !66
  %call3 = call i32 %t_fptr.0(i32 %op1, i32 %op2), !dbg !76
  ret i32 0, !dbg !77
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.value(metadata, i64, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test19.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !8, isLocal: false, isDefinition: true, scopeLine: 2, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 2, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 2, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 2, type: !10)
!15 = !DILocation(line: 2, column: 21, scope: !7)
!16 = !DILocation(line: 3, column: 12, scope: !7)
!17 = !DILocation(line: 3, column: 4, scope: !7)
!18 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!19 = !DILocalVariable(name: "a", arg: 1, scope: !18, file: !1, line: 6, type: !10)
!20 = !DILocation(line: 6, column: 15, scope: !18)
!21 = !DILocalVariable(name: "b", arg: 2, scope: !18, file: !1, line: 6, type: !10)
!22 = !DILocation(line: 6, column: 22, scope: !18)
!23 = !DILocation(line: 7, column: 12, scope: !18)
!24 = !DILocation(line: 7, column: 4, scope: !18)
!25 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !26, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!28, !10, !10, !28, !28}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!29 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 10, type: !10)
!30 = !DILocation(line: 10, column: 15, scope: !25)
!31 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 10, type: !10)
!32 = !DILocation(line: 10, column: 22, scope: !25)
!33 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !25, file: !1, line: 10, type: !28)
!34 = !DILocation(line: 10, column: 31, scope: !25)
!35 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !25, file: !1, line: 10, type: !28)
!36 = !DILocation(line: 10, column: 55, scope: !25)
!37 = !DILocation(line: 11, column: 4, scope: !25)
!38 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !26, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!39 = !DILocalVariable(name: "a", arg: 1, scope: !38, file: !1, line: 13, type: !10)
!40 = !DILocation(line: 13, column: 18, scope: !38)
!41 = !DILocalVariable(name: "b", arg: 2, scope: !38, file: !1, line: 13, type: !10)
!42 = !DILocation(line: 13, column: 25, scope: !38)
!43 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !38, file: !1, line: 13, type: !28)
!44 = !DILocation(line: 13, column: 34, scope: !38)
!45 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !38, file: !1, line: 13, type: !28)
!46 = !DILocation(line: 13, column: 58, scope: !38)
!47 = !DILocation(line: 14, column: 4, scope: !38)
!48 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 16, type: !49, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!49 = !DISubroutineType(types: !50)
!50 = !{!10, !51, !10, !10}
!51 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!52 = !DILocalVariable(name: "x", arg: 1, scope: !48, file: !1, line: 16, type: !51)
!53 = !DILocation(line: 16, column: 14, scope: !48)
!54 = !DILocalVariable(name: "op1", arg: 2, scope: !48, file: !1, line: 16, type: !10)
!55 = !DILocation(line: 16, column: 21, scope: !48)
!56 = !DILocalVariable(name: "op2", arg: 3, scope: !48, file: !1, line: 16, type: !10)
!57 = !DILocation(line: 16, column: 30, scope: !48)
!58 = !DILocalVariable(name: "a_fptr", scope: !48, file: !1, line: 17, type: !28)
!59 = !DILocation(line: 17, column: 11, scope: !48)
!60 = !DILocalVariable(name: "s_fptr", scope: !48, file: !1, line: 18, type: !28)
!61 = !DILocation(line: 18, column: 11, scope: !48)
!62 = !DILocalVariable(name: "goo_ptr", scope: !48, file: !1, line: 19, type: !63)
!63 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !26, size: 64)
!64 = !DILocation(line: 19, column: 14, scope: !48)
!65 = !DILocalVariable(name: "t_fptr", scope: !48, file: !1, line: 20, type: !28)
!66 = !DILocation(line: 20, column: 11, scope: !48)
!67 = !DILocation(line: 22, column: 8, scope: !68)
!68 = distinct !DILexicalBlock(scope: !48, file: !1, line: 22, column: 8)
!69 = !DILocation(line: 22, column: 10, scope: !68)
!70 = !DILocation(line: 22, column: 8, scope: !48)
!71 = !DILocation(line: 24, column: 18, scope: !72)
!72 = distinct !DILexicalBlock(scope: !68, file: !1, line: 23, column: 5)
!73 = !DILocation(line: 25, column: 5, scope: !72)
!74 = !DILocation(line: 28, column: 18, scope: !75)
!75 = distinct !DILexicalBlock(scope: !68, file: !1, line: 26, column: 5)
!76 = !DILocation(line: 30, column: 5, scope: !48)
!77 = !DILocation(line: 31, column: 5, scope: !48)