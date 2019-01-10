; ModuleID = 'test34.bc'
source_filename = "test34.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }
%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32 %a, i32 %b) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !11, metadata !12), !dbg !13
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !14, metadata !12), !dbg !15
  %0 = load i32, i32* %a.addr, align 4, !dbg !16
  %1 = load i32, i32* %b.addr, align 4, !dbg !17
  %add = add nsw i32 %0, %1, !dbg !18
  ret i32 %add, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32 %a, i32 %b) #0 !dbg !20 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !21, metadata !12), !dbg !22
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !23, metadata !12), !dbg !24
  %0 = load i32, i32* %a.addr, align 4, !dbg !25
  %1 = load i32, i32* %b.addr, align 4, !dbg !26
  %sub = sub nsw i32 %0, %1, !dbg !27
  ret i32 %sub, !dbg !28
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_simple_alias(%struct.wfsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !29 {
entry:
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !45, metadata !12), !dbg !46
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !47, metadata !12), !dbg !48
  %0 = load %struct.fsptr*, %struct.fsptr** %b_fptr.addr, align 8, !dbg !49
  %1 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !50
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %1, i32 0, i32 0, !dbg !51
  store %struct.fsptr* %0, %struct.fsptr** %wfptr, align 8, !dbg !52
  ret void, !dbg !53
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_alias(%struct.wfsptr* %a_fptr, %struct.wfsptr* %b_fptr) #0 !dbg !54 {
entry:
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.wfsptr*, align 8
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !57, metadata !12), !dbg !58
  store %struct.wfsptr* %b_fptr, %struct.wfsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %b_fptr.addr, metadata !59, metadata !12), !dbg !60
  %0 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !61
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %0, i32 0, i32 0, !dbg !62
  %1 = load %struct.fsptr*, %struct.fsptr** %wfptr, align 8, !dbg !62
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %1, i32 0, i32 0, !dbg !63
  %2 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !63
  %3 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !64
  %wfptr1 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !65
  %4 = load %struct.fsptr*, %struct.fsptr** %wfptr1, align 8, !dbg !65
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !66
  store %struct.fptr* %2, %struct.fptr** %sptr2, align 8, !dbg !67
  ret void, !dbg !68
}

; Function Attrs: noinline nounwind optnone uwtable
define void @swap_w(%struct.wfsptr* %a_fptr, %struct.wfsptr* %b_fptr) #0 !dbg !69 {
entry:
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.wfsptr*, align 8
  %wftemp = alloca %struct.wfsptr, align 8
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !70, metadata !12), !dbg !71
  store %struct.wfsptr* %b_fptr, %struct.wfsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %b_fptr.addr, metadata !72, metadata !12), !dbg !73
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %wftemp, metadata !74, metadata !12), !dbg !75
  %0 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !76
  %1 = bitcast %struct.wfsptr* %wftemp to i8*, !dbg !77
  %2 = bitcast %struct.wfsptr* %0 to i8*, !dbg !77
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 8, i32 8, i1 false), !dbg !77
  %3 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !78
  %4 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !79
  %5 = bitcast %struct.wfsptr* %3 to i8*, !dbg !80
  %6 = bitcast %struct.wfsptr* %4 to i8*, !dbg !80
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 8, i32 8, i1 false), !dbg !80
  %7 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !81
  %8 = bitcast %struct.wfsptr* %7 to i8*, !dbg !82
  %9 = bitcast %struct.wfsptr* %wftemp to i8*, !dbg !82
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* %9, i64 8, i32 8, i1 false), !dbg !82
  ret void, !dbg !83
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind optnone uwtable
define %struct.fptr* @foo(i32 %a, i32 %b, %struct.wfsptr* %a_fptr, %struct.wfsptr* %b_fptr) #0 !dbg !84 {
entry:
  %retval = alloca %struct.fptr*, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.wfsptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !87, metadata !12), !dbg !88
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !89, metadata !12), !dbg !90
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !91, metadata !12), !dbg !92
  store %struct.wfsptr* %b_fptr, %struct.wfsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %b_fptr.addr, metadata !93, metadata !12), !dbg !94
  %0 = load i32, i32* %a.addr, align 4, !dbg !95
  %cmp = icmp sgt i32 %0, 0, !dbg !97
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !98

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %b.addr, align 4, !dbg !99
  %cmp1 = icmp slt i32 %1, 0, !dbg !100
  br i1 %cmp1, label %if.then, label %if.end, !dbg !101

if.then:                                          ; preds = %land.lhs.true
  %2 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !102
  %3 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !104
  call void @swap_w(%struct.wfsptr* %2, %struct.wfsptr* %3), !dbg !105
  %4 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !106
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %4, i32 0, i32 0, !dbg !107
  %5 = load %struct.fsptr*, %struct.fsptr** %wfptr, align 8, !dbg !107
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !108
  %6 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !108
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %6, i32 0, i32 0, !dbg !109
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !109
  %8 = load i32, i32* %a.addr, align 4, !dbg !110
  %9 = load i32, i32* %b.addr, align 4, !dbg !111
  %call = call i32 %7(i32 %8, i32 %9), !dbg !106
  %10 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !112
  %wfptr2 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %10, i32 0, i32 0, !dbg !113
  %11 = load %struct.fsptr*, %struct.fsptr** %wfptr2, align 8, !dbg !113
  %sptr3 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %11, i32 0, i32 0, !dbg !114
  %12 = load %struct.fptr*, %struct.fptr** %sptr3, align 8, !dbg !114
  store %struct.fptr* %12, %struct.fptr** %retval, align 8, !dbg !115
  br label %return, !dbg !115

if.end:                                           ; preds = %land.lhs.true, %entry
  %13 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !116
  %wfptr4 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %13, i32 0, i32 0, !dbg !117
  %14 = load %struct.fsptr*, %struct.fsptr** %wfptr4, align 8, !dbg !117
  %sptr5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %14, i32 0, i32 0, !dbg !118
  %15 = load %struct.fptr*, %struct.fptr** %sptr5, align 8, !dbg !118
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %15, i32 0, i32 0, !dbg !119
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr6, align 8, !dbg !120
  %16 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !121
  %wfptr7 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %16, i32 0, i32 0, !dbg !122
  %17 = load %struct.fsptr*, %struct.fsptr** %wfptr7, align 8, !dbg !122
  %sptr8 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %17, i32 0, i32 0, !dbg !123
  %18 = load %struct.fptr*, %struct.fptr** %sptr8, align 8, !dbg !123
  store %struct.fptr* %18, %struct.fptr** %retval, align 8, !dbg !124
  br label %return, !dbg !124

return:                                           ; preds = %if.end, %if.then
  %19 = load %struct.fptr*, %struct.fptr** %retval, align 8, !dbg !125
  ret %struct.fptr* %19, !dbg !125
}

; Function Attrs: noinline nounwind optnone uwtable
define %struct.fptr* @clever(i32 %a, i32 %b, %struct.fsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !126 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.fsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  %t1_fptr = alloca %struct.wfsptr, align 8
  %t2_fptr = alloca %struct.wfsptr, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !129, metadata !12), !dbg !130
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !131, metadata !12), !dbg !132
  store %struct.fsptr* %a_fptr, %struct.fsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a_fptr.addr, metadata !133, metadata !12), !dbg !134
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !135, metadata !12), !dbg !136
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %t1_fptr, metadata !137, metadata !12), !dbg !138
  %0 = load %struct.fsptr*, %struct.fsptr** %a_fptr.addr, align 8, !dbg !139
  call void @make_simple_alias(%struct.wfsptr* %t1_fptr, %struct.fsptr* %0), !dbg !140
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %t2_fptr, metadata !141, metadata !12), !dbg !142
  %1 = load %struct.fsptr*, %struct.fsptr** %b_fptr.addr, align 8, !dbg !143
  call void @make_simple_alias(%struct.wfsptr* %t2_fptr, %struct.fsptr* %1), !dbg !144
  %2 = load i32, i32* %a.addr, align 4, !dbg !145
  %3 = load i32, i32* %b.addr, align 4, !dbg !146
  %call = call %struct.fptr* @foo(i32 %2, i32 %3, %struct.wfsptr* %t1_fptr, %struct.wfsptr* %t2_fptr), !dbg !147
  ret %struct.fptr* %call, !dbg !148
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !149 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fptr, align 8
  %m_fptr = alloca %struct.fsptr, align 8
  %n_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.wfsptr, align 8
  %x_fptr = alloca %struct.wfsptr, align 8
  %k_fptr = alloca %struct.fsptr, align 8
  %y_fptr = alloca %struct.wfsptr, align 8
  %t_fptr = alloca %struct.fptr*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !153, metadata !12), !dbg !154
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !155, metadata !12), !dbg !156
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !157, metadata !12), !dbg !158
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !159, metadata !12), !dbg !160
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !161
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !162
  call void @llvm.dbg.declare(metadata %struct.fptr* %s_fptr, metadata !163, metadata !12), !dbg !164
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %s_fptr, i32 0, i32 0, !dbg !165
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !166
  call void @llvm.dbg.declare(metadata %struct.fsptr* %m_fptr, metadata !167, metadata !12), !dbg !168
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !169
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !170
  call void @llvm.dbg.declare(metadata %struct.fsptr* %n_fptr, metadata !171, metadata !12), !dbg !172
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %n_fptr, i32 0, i32 0, !dbg !173
  store %struct.fptr* %s_fptr, %struct.fptr** %sptr2, align 8, !dbg !174
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %w_fptr, metadata !175, metadata !12), !dbg !176
  call void @make_simple_alias(%struct.wfsptr* %w_fptr, %struct.fsptr* %m_fptr), !dbg !177
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %x_fptr, metadata !178, metadata !12), !dbg !179
  call void @make_simple_alias(%struct.wfsptr* %x_fptr, %struct.fsptr* %n_fptr), !dbg !180
  call void @llvm.dbg.declare(metadata %struct.fsptr* %k_fptr, metadata !181, metadata !12), !dbg !182
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %y_fptr, metadata !183, metadata !12), !dbg !184
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %y_fptr, i32 0, i32 0, !dbg !185
  store %struct.fsptr* %k_fptr, %struct.fsptr** %wfptr, align 8, !dbg !186
  call void @make_alias(%struct.wfsptr* %y_fptr, %struct.wfsptr* %x_fptr), !dbg !187
  call void @llvm.dbg.declare(metadata %struct.fptr** %t_fptr, metadata !188, metadata !12), !dbg !189
  store %struct.fptr* null, %struct.fptr** %t_fptr, align 8, !dbg !189
  %0 = load i32, i32* %op1.addr, align 4, !dbg !190
  %1 = load i32, i32* %op2.addr, align 4, !dbg !191
  %wfptr3 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %y_fptr, i32 0, i32 0, !dbg !192
  %2 = load %struct.fsptr*, %struct.fsptr** %wfptr3, align 8, !dbg !192
  %call = call %struct.fptr* @clever(i32 %0, i32 %1, %struct.fsptr* %m_fptr, %struct.fsptr* %2), !dbg !193
  %3 = load i32, i32* %op1.addr, align 4, !dbg !194
  %4 = load i32, i32* %op2.addr, align 4, !dbg !195
  %wfptr4 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %y_fptr, i32 0, i32 0, !dbg !196
  %5 = load %struct.fsptr*, %struct.fsptr** %wfptr4, align 8, !dbg !196
  %wfptr5 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %x_fptr, i32 0, i32 0, !dbg !197
  %6 = load %struct.fsptr*, %struct.fsptr** %wfptr5, align 8, !dbg !197
  %call6 = call %struct.fptr* @clever(i32 %3, i32 %4, %struct.fsptr* %5, %struct.fsptr* %6), !dbg !198
  store %struct.fptr* %call6, %struct.fptr** %t_fptr, align 8, !dbg !199
  %7 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !200
  %p_fptr7 = getelementptr inbounds %struct.fptr, %struct.fptr* %7, i32 0, i32 0, !dbg !201
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr7, align 8, !dbg !201
  %9 = load i32, i32* %op1.addr, align 4, !dbg !202
  %10 = load i32, i32* %op2.addr, align 4, !dbg !203
  %call8 = call i32 %8(i32 %9, i32 %10), !dbg !200
  ret i32 0, !dbg !204
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test34.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.0 (tags/RELEASE_500/final)"}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 14, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 14, column: 14, scope: !7)
!14 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 14, type: !10)
!15 = !DILocation(line: 14, column: 21, scope: !7)
!16 = !DILocation(line: 15, column: 11, scope: !7)
!17 = !DILocation(line: 15, column: 13, scope: !7)
!18 = !DILocation(line: 15, column: 12, scope: !7)
!19 = !DILocation(line: 15, column: 4, scope: !7)
!20 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !8, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 18, type: !10)
!22 = !DILocation(line: 18, column: 15, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 18, type: !10)
!24 = !DILocation(line: 18, column: 22, scope: !20)
!25 = !DILocation(line: 19, column: 11, scope: !20)
!26 = !DILocation(line: 19, column: 13, scope: !20)
!27 = !DILocation(line: 19, column: 12, scope: !20)
!28 = !DILocation(line: 19, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "make_simple_alias", scope: !1, file: !1, line: 21, type: !30, isLocal: false, isDefinition: true, scopeLine: 22, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !32, !36}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !33, file: !1, line: 12, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !38)
!38 = !{!39}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !37, file: !1, line: 8, baseType: !40, size: 64)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !41, size: 64)
!41 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !42)
!42 = !{!43}
!43 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !41, file: !1, line: 4, baseType: !44, size: 64)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!45 = !DILocalVariable(name: "a_fptr", arg: 1, scope: !29, file: !1, line: 21, type: !32)
!46 = !DILocation(line: 21, column: 40, scope: !29)
!47 = !DILocalVariable(name: "b_fptr", arg: 2, scope: !29, file: !1, line: 21, type: !36)
!48 = !DILocation(line: 21, column: 62, scope: !29)
!49 = !DILocation(line: 23, column: 17, scope: !29)
!50 = !DILocation(line: 23, column: 3, scope: !29)
!51 = !DILocation(line: 23, column: 11, scope: !29)
!52 = !DILocation(line: 23, column: 16, scope: !29)
!53 = !DILocation(line: 24, column: 1, scope: !29)
!54 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 25, type: !55, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!55 = !DISubroutineType(types: !56)
!56 = !{null, !32, !32}
!57 = !DILocalVariable(name: "a_fptr", arg: 1, scope: !54, file: !1, line: 25, type: !32)
!58 = !DILocation(line: 25, column: 32, scope: !54)
!59 = !DILocalVariable(name: "b_fptr", arg: 2, scope: !54, file: !1, line: 25, type: !32)
!60 = !DILocation(line: 25, column: 55, scope: !54)
!61 = !DILocation(line: 27, column: 23, scope: !54)
!62 = !DILocation(line: 27, column: 31, scope: !54)
!63 = !DILocation(line: 27, column: 38, scope: !54)
!64 = !DILocation(line: 27, column: 3, scope: !54)
!65 = !DILocation(line: 27, column: 11, scope: !54)
!66 = !DILocation(line: 27, column: 18, scope: !54)
!67 = !DILocation(line: 27, column: 22, scope: !54)
!68 = !DILocation(line: 28, column: 1, scope: !54)
!69 = distinct !DISubprogram(name: "swap_w", scope: !1, file: !1, line: 29, type: !55, isLocal: false, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!70 = !DILocalVariable(name: "a_fptr", arg: 1, scope: !69, file: !1, line: 29, type: !32)
!71 = !DILocation(line: 29, column: 29, scope: !69)
!72 = !DILocalVariable(name: "b_fptr", arg: 2, scope: !69, file: !1, line: 29, type: !32)
!73 = !DILocation(line: 29, column: 52, scope: !69)
!74 = !DILocalVariable(name: "wftemp", scope: !69, file: !1, line: 31, type: !33)
!75 = !DILocation(line: 31, column: 20, scope: !69)
!76 = !DILocation(line: 31, column: 28, scope: !69)
!77 = !DILocation(line: 31, column: 27, scope: !69)
!78 = !DILocation(line: 32, column: 7, scope: !69)
!79 = !DILocation(line: 32, column: 15, scope: !69)
!80 = !DILocation(line: 32, column: 14, scope: !69)
!81 = !DILocation(line: 33, column: 7, scope: !69)
!82 = !DILocation(line: 33, column: 14, scope: !69)
!83 = !DILocation(line: 34, column: 1, scope: !69)
!84 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 36, type: !85, isLocal: false, isDefinition: true, scopeLine: 36, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!85 = !DISubroutineType(types: !86)
!86 = !{!40, !10, !10, !32, !32}
!87 = !DILocalVariable(name: "a", arg: 1, scope: !84, file: !1, line: 36, type: !10)
!88 = !DILocation(line: 36, column: 23, scope: !84)
!89 = !DILocalVariable(name: "b", arg: 2, scope: !84, file: !1, line: 36, type: !10)
!90 = !DILocation(line: 36, column: 30, scope: !84)
!91 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !84, file: !1, line: 36, type: !32)
!92 = !DILocation(line: 36, column: 49, scope: !84)
!93 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !84, file: !1, line: 36, type: !32)
!94 = !DILocation(line: 36, column: 73, scope: !84)
!95 = !DILocation(line: 37, column: 7, scope: !96)
!96 = distinct !DILexicalBlock(scope: !84, file: !1, line: 37, column: 7)
!97 = !DILocation(line: 37, column: 8, scope: !96)
!98 = !DILocation(line: 37, column: 11, scope: !96)
!99 = !DILocation(line: 37, column: 14, scope: !96)
!100 = !DILocation(line: 37, column: 15, scope: !96)
!101 = !DILocation(line: 37, column: 7, scope: !84)
!102 = !DILocation(line: 39, column: 12, scope: !103)
!103 = distinct !DILexicalBlock(scope: !96, file: !1, line: 38, column: 4)
!104 = !DILocation(line: 39, column: 19, scope: !103)
!105 = !DILocation(line: 39, column: 5, scope: !103)
!106 = !DILocation(line: 40, column: 5, scope: !103)
!107 = !DILocation(line: 40, column: 13, scope: !103)
!108 = !DILocation(line: 40, column: 20, scope: !103)
!109 = !DILocation(line: 40, column: 26, scope: !103)
!110 = !DILocation(line: 40, column: 33, scope: !103)
!111 = !DILocation(line: 40, column: 35, scope: !103)
!112 = !DILocation(line: 41, column: 12, scope: !103)
!113 = !DILocation(line: 41, column: 20, scope: !103)
!114 = !DILocation(line: 41, column: 27, scope: !103)
!115 = !DILocation(line: 41, column: 5, scope: !103)
!116 = !DILocation(line: 43, column: 4, scope: !84)
!117 = !DILocation(line: 43, column: 12, scope: !84)
!118 = !DILocation(line: 43, column: 19, scope: !84)
!119 = !DILocation(line: 43, column: 25, scope: !84)
!120 = !DILocation(line: 43, column: 31, scope: !84)
!121 = !DILocation(line: 44, column: 11, scope: !84)
!122 = !DILocation(line: 44, column: 19, scope: !84)
!123 = !DILocation(line: 44, column: 26, scope: !84)
!124 = !DILocation(line: 44, column: 4, scope: !84)
!125 = !DILocation(line: 45, column: 1, scope: !84)
!126 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 47, type: !127, isLocal: false, isDefinition: true, scopeLine: 47, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!127 = !DISubroutineType(types: !128)
!128 = !{!40, !10, !10, !36, !36}
!129 = !DILocalVariable(name: "a", arg: 1, scope: !126, file: !1, line: 47, type: !10)
!130 = !DILocation(line: 47, column: 26, scope: !126)
!131 = !DILocalVariable(name: "b", arg: 2, scope: !126, file: !1, line: 47, type: !10)
!132 = !DILocation(line: 47, column: 33, scope: !126)
!133 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !126, file: !1, line: 47, type: !36)
!134 = !DILocation(line: 47, column: 51, scope: !126)
!135 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !126, file: !1, line: 47, type: !36)
!136 = !DILocation(line: 47, column: 74, scope: !126)
!137 = !DILocalVariable(name: "t1_fptr", scope: !126, file: !1, line: 48, type: !33)
!138 = !DILocation(line: 48, column: 18, scope: !126)
!139 = !DILocation(line: 49, column: 31, scope: !126)
!140 = !DILocation(line: 49, column: 4, scope: !126)
!141 = !DILocalVariable(name: "t2_fptr", scope: !126, file: !1, line: 50, type: !33)
!142 = !DILocation(line: 50, column: 18, scope: !126)
!143 = !DILocation(line: 51, column: 31, scope: !126)
!144 = !DILocation(line: 51, column: 4, scope: !126)
!145 = !DILocation(line: 52, column: 15, scope: !126)
!146 = !DILocation(line: 52, column: 17, scope: !126)
!147 = !DILocation(line: 52, column: 11, scope: !126)
!148 = !DILocation(line: 52, column: 4, scope: !126)
!149 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 56, type: !150, isLocal: false, isDefinition: true, scopeLine: 56, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!150 = !DISubroutineType(types: !151)
!151 = !{!10, !152, !10, !10}
!152 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!153 = !DILocalVariable(name: "x", arg: 1, scope: !149, file: !1, line: 56, type: !152)
!154 = !DILocation(line: 56, column: 14, scope: !149)
!155 = !DILocalVariable(name: "op1", arg: 2, scope: !149, file: !1, line: 56, type: !10)
!156 = !DILocation(line: 56, column: 21, scope: !149)
!157 = !DILocalVariable(name: "op2", arg: 3, scope: !149, file: !1, line: 56, type: !10)
!158 = !DILocation(line: 56, column: 30, scope: !149)
!159 = !DILocalVariable(name: "a_fptr", scope: !149, file: !1, line: 57, type: !41)
!160 = !DILocation(line: 57, column: 17, scope: !149)
!161 = !DILocation(line: 58, column: 12, scope: !149)
!162 = !DILocation(line: 58, column: 18, scope: !149)
!163 = !DILocalVariable(name: "s_fptr", scope: !149, file: !1, line: 59, type: !41)
!164 = !DILocation(line: 59, column: 17, scope: !149)
!165 = !DILocation(line: 60, column: 12, scope: !149)
!166 = !DILocation(line: 60, column: 18, scope: !149)
!167 = !DILocalVariable(name: "m_fptr", scope: !149, file: !1, line: 62, type: !37)
!168 = !DILocation(line: 62, column: 18, scope: !149)
!169 = !DILocation(line: 63, column: 12, scope: !149)
!170 = !DILocation(line: 63, column: 16, scope: !149)
!171 = !DILocalVariable(name: "n_fptr", scope: !149, file: !1, line: 64, type: !37)
!172 = !DILocation(line: 64, column: 18, scope: !149)
!173 = !DILocation(line: 65, column: 12, scope: !149)
!174 = !DILocation(line: 65, column: 16, scope: !149)
!175 = !DILocalVariable(name: "w_fptr", scope: !149, file: !1, line: 67, type: !33)
!176 = !DILocation(line: 67, column: 19, scope: !149)
!177 = !DILocation(line: 68, column: 5, scope: !149)
!178 = !DILocalVariable(name: "x_fptr", scope: !149, file: !1, line: 69, type: !33)
!179 = !DILocation(line: 69, column: 19, scope: !149)
!180 = !DILocation(line: 70, column: 5, scope: !149)
!181 = !DILocalVariable(name: "k_fptr", scope: !149, file: !1, line: 72, type: !37)
!182 = !DILocation(line: 72, column: 18, scope: !149)
!183 = !DILocalVariable(name: "y_fptr", scope: !149, file: !1, line: 73, type: !33)
!184 = !DILocation(line: 73, column: 19, scope: !149)
!185 = !DILocation(line: 74, column: 12, scope: !149)
!186 = !DILocation(line: 74, column: 17, scope: !149)
!187 = !DILocation(line: 75, column: 5, scope: !149)
!188 = !DILocalVariable(name: "t_fptr", scope: !149, file: !1, line: 77, type: !40)
!189 = !DILocation(line: 77, column: 18, scope: !149)
!190 = !DILocation(line: 79, column: 12, scope: !149)
!191 = !DILocation(line: 79, column: 17, scope: !149)
!192 = !DILocation(line: 79, column: 38, scope: !149)
!193 = !DILocation(line: 79, column: 5, scope: !149)
!194 = !DILocation(line: 80, column: 21, scope: !149)
!195 = !DILocation(line: 80, column: 25, scope: !149)
!196 = !DILocation(line: 80, column: 36, scope: !149)
!197 = !DILocation(line: 80, column: 49, scope: !149)
!198 = !DILocation(line: 80, column: 14, scope: !149)
!199 = !DILocation(line: 80, column: 12, scope: !149)
!200 = !DILocation(line: 81, column: 5, scope: !149)
!201 = !DILocation(line: 81, column: 13, scope: !149)
!202 = !DILocation(line: 81, column: 20, scope: !149)
!203 = !DILocation(line: 81, column: 24, scope: !149)
!204 = !DILocation(line: 83, column: 5, scope: !149)
