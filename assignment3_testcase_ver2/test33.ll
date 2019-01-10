; ModuleID = 'test33.bc'
source_filename = "test33.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }

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
define %struct.fptr* @foo(i32 %a, i32 %b, %struct.wfsptr* %a_fptr, %struct.wfsptr* %b_fptr) #0 !dbg !29 {
entry:
  %retval = alloca %struct.fptr*, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.wfsptr*, align 8
  %temp = alloca %struct.fsptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !45, metadata !12), !dbg !46
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !47, metadata !12), !dbg !48
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !49, metadata !12), !dbg !50
  store %struct.wfsptr* %b_fptr, %struct.wfsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %b_fptr.addr, metadata !51, metadata !12), !dbg !52
  %0 = load i32, i32* %a.addr, align 4, !dbg !53
  %cmp = icmp sgt i32 %0, 0, !dbg !55
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !56

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %b.addr, align 4, !dbg !57
  %cmp1 = icmp slt i32 %1, 0, !dbg !58
  br i1 %cmp1, label %if.then, label %if.end, !dbg !59

if.then:                                          ; preds = %land.lhs.true
  call void @llvm.dbg.declare(metadata %struct.fsptr** %temp, metadata !60, metadata !12), !dbg !62
  %2 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !63
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %2, i32 0, i32 0, !dbg !64
  %3 = load %struct.fsptr*, %struct.fsptr** %wfptr, align 8, !dbg !64
  store %struct.fsptr* %3, %struct.fsptr** %temp, align 8, !dbg !62
  %4 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !65
  %wfptr2 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %4, i32 0, i32 0, !dbg !66
  %5 = load %struct.fsptr*, %struct.fsptr** %wfptr2, align 8, !dbg !66
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %5, i32 0, i32 0, !dbg !67
  %6 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !67
  %7 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !68
  %wfptr3 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %7, i32 0, i32 0, !dbg !69
  %8 = load %struct.fsptr*, %struct.fsptr** %wfptr3, align 8, !dbg !69
  %sptr4 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %8, i32 0, i32 0, !dbg !70
  store %struct.fptr* %6, %struct.fptr** %sptr4, align 8, !dbg !71
  %9 = load %struct.fsptr*, %struct.fsptr** %temp, align 8, !dbg !72
  %sptr5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %9, i32 0, i32 0, !dbg !73
  %10 = load %struct.fptr*, %struct.fptr** %sptr5, align 8, !dbg !73
  %11 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !74
  %wfptr6 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %11, i32 0, i32 0, !dbg !75
  %12 = load %struct.fsptr*, %struct.fsptr** %wfptr6, align 8, !dbg !75
  %sptr7 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %12, i32 0, i32 0, !dbg !76
  store %struct.fptr* %10, %struct.fptr** %sptr7, align 8, !dbg !77
  %13 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !78
  %wfptr8 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %13, i32 0, i32 0, !dbg !79
  %14 = load %struct.fsptr*, %struct.fsptr** %wfptr8, align 8, !dbg !79
  %sptr9 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %14, i32 0, i32 0, !dbg !80
  %15 = load %struct.fptr*, %struct.fptr** %sptr9, align 8, !dbg !80
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %15, i32 0, i32 0, !dbg !81
  %16 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !81
  %17 = load i32, i32* %a.addr, align 4, !dbg !82
  %18 = load i32, i32* %b.addr, align 4, !dbg !83
  %call = call i32 %16(i32 %17, i32 %18), !dbg !78
  %19 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !84
  %wfptr10 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %19, i32 0, i32 0, !dbg !85
  %20 = load %struct.fsptr*, %struct.fsptr** %wfptr10, align 8, !dbg !85
  %sptr11 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %20, i32 0, i32 0, !dbg !86
  %21 = load %struct.fptr*, %struct.fptr** %sptr11, align 8, !dbg !86
  store %struct.fptr* %21, %struct.fptr** %retval, align 8, !dbg !87
  br label %return, !dbg !87

if.end:                                           ; preds = %land.lhs.true, %entry
  %22 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !88
  %wfptr12 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %22, i32 0, i32 0, !dbg !89
  %23 = load %struct.fsptr*, %struct.fsptr** %wfptr12, align 8, !dbg !89
  %sptr13 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %23, i32 0, i32 0, !dbg !90
  %24 = load %struct.fptr*, %struct.fptr** %sptr13, align 8, !dbg !90
  store %struct.fptr* %24, %struct.fptr** %retval, align 8, !dbg !91
  br label %return, !dbg !91

return:                                           ; preds = %if.end, %if.then
  %25 = load %struct.fptr*, %struct.fptr** %retval, align 8, !dbg !92
  ret %struct.fptr* %25, !dbg !92
}

; Function Attrs: noinline nounwind optnone uwtable
define %struct.fptr* @clever(i32 %a, i32 %b, %struct.fsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !93 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.fsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  %t1_fptr = alloca %struct.wfsptr, align 8
  %t2_fptr = alloca %struct.wfsptr, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !96, metadata !12), !dbg !97
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !98, metadata !12), !dbg !99
  store %struct.fsptr* %a_fptr, %struct.fsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a_fptr.addr, metadata !100, metadata !12), !dbg !101
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !102, metadata !12), !dbg !103
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %t1_fptr, metadata !104, metadata !12), !dbg !105
  %0 = load %struct.fsptr*, %struct.fsptr** %a_fptr.addr, align 8, !dbg !106
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %t1_fptr, i32 0, i32 0, !dbg !107
  store %struct.fsptr* %0, %struct.fsptr** %wfptr, align 8, !dbg !108
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %t2_fptr, metadata !109, metadata !12), !dbg !110
  %1 = load %struct.fsptr*, %struct.fsptr** %b_fptr.addr, align 8, !dbg !111
  %wfptr1 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %t2_fptr, i32 0, i32 0, !dbg !112
  store %struct.fsptr* %1, %struct.fsptr** %wfptr1, align 8, !dbg !113
  %2 = load i32, i32* %a.addr, align 4, !dbg !114
  %3 = load i32, i32* %b.addr, align 4, !dbg !115
  %call = call %struct.fptr* @foo(i32 %2, i32 %3, %struct.wfsptr* %t1_fptr, %struct.wfsptr* %t2_fptr), !dbg !116
  ret %struct.fptr* %call, !dbg !117
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_simple_alias(%struct.wfsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !118 {
entry:
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !121, metadata !12), !dbg !122
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !123, metadata !12), !dbg !124
  %0 = load %struct.fsptr*, %struct.fsptr** %b_fptr.addr, align 8, !dbg !125
  %1 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !126
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %1, i32 0, i32 0, !dbg !127
  store %struct.fsptr* %0, %struct.fsptr** %wfptr, align 8, !dbg !128
  ret void, !dbg !129
}

; Function Attrs: noinline nounwind optnone uwtable
define void @make_alias(%struct.wfsptr* %a_fptr, %struct.wfsptr* %b_fptr) #0 !dbg !130 {
entry:
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.wfsptr*, align 8
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !133, metadata !12), !dbg !134
  store %struct.wfsptr* %b_fptr, %struct.wfsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %b_fptr.addr, metadata !135, metadata !12), !dbg !136
  %0 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !137
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %0, i32 0, i32 0, !dbg !138
  %1 = load %struct.fsptr*, %struct.fsptr** %wfptr, align 8, !dbg !138
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %1, i32 0, i32 0, !dbg !139
  %2 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !139
  %3 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !140
  %wfptr1 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !141
  %4 = load %struct.fsptr*, %struct.fsptr** %wfptr1, align 8, !dbg !141
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !142
  store %struct.fptr* %2, %struct.fptr** %sptr2, align 8, !dbg !143
  ret void, !dbg !144
}

; Function Attrs: noinline nounwind optnone uwtable
define void @swap_w(%struct.wfsptr* %a_fptr, %struct.wfsptr* %b_fptr) #0 !dbg !145 {
entry:
  %a_fptr.addr = alloca %struct.wfsptr*, align 8
  %b_fptr.addr = alloca %struct.wfsptr*, align 8
  %wftemp = alloca %struct.wfsptr, align 8
  store %struct.wfsptr* %a_fptr, %struct.wfsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a_fptr.addr, metadata !146, metadata !12), !dbg !147
  store %struct.wfsptr* %b_fptr, %struct.wfsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %b_fptr.addr, metadata !148, metadata !12), !dbg !149
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %wftemp, metadata !150, metadata !12), !dbg !151
  %0 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !152
  %1 = bitcast %struct.wfsptr* %wftemp to i8*, !dbg !153
  %2 = bitcast %struct.wfsptr* %0 to i8*, !dbg !153
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %2, i64 8, i32 8, i1 false), !dbg !153
  %3 = load %struct.wfsptr*, %struct.wfsptr** %a_fptr.addr, align 8, !dbg !154
  %4 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !155
  %5 = bitcast %struct.wfsptr* %3 to i8*, !dbg !156
  %6 = bitcast %struct.wfsptr* %4 to i8*, !dbg !156
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 8, i32 8, i1 false), !dbg !156
  %7 = load %struct.wfsptr*, %struct.wfsptr** %b_fptr.addr, align 8, !dbg !157
  %8 = bitcast %struct.wfsptr* %7 to i8*, !dbg !158
  %9 = bitcast %struct.wfsptr* %wftemp to i8*, !dbg !158
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* %9, i64 8, i32 8, i1 false), !dbg !158
  ret void, !dbg !159
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !160 {
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
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !164, metadata !12), !dbg !165
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !166, metadata !12), !dbg !167
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !168, metadata !12), !dbg !169
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !170, metadata !12), !dbg !171
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !172
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !173
  call void @llvm.dbg.declare(metadata %struct.fptr* %s_fptr, metadata !174, metadata !12), !dbg !175
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %s_fptr, i32 0, i32 0, !dbg !176
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !177
  call void @llvm.dbg.declare(metadata %struct.fsptr* %m_fptr, metadata !178, metadata !12), !dbg !179
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !180
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !181
  call void @llvm.dbg.declare(metadata %struct.fsptr* %n_fptr, metadata !182, metadata !12), !dbg !183
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %n_fptr, i32 0, i32 0, !dbg !184
  store %struct.fptr* %s_fptr, %struct.fptr** %sptr2, align 8, !dbg !185
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %w_fptr, metadata !186, metadata !12), !dbg !187
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %w_fptr, i32 0, i32 0, !dbg !188
  store %struct.fsptr* %m_fptr, %struct.fsptr** %wfptr, align 8, !dbg !189
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %x_fptr, metadata !190, metadata !12), !dbg !191
  call void @make_simple_alias(%struct.wfsptr* %x_fptr, %struct.fsptr* %n_fptr), !dbg !192
  call void @llvm.dbg.declare(metadata %struct.fsptr* %k_fptr, metadata !193, metadata !12), !dbg !194
  call void @llvm.dbg.declare(metadata %struct.wfsptr* %y_fptr, metadata !195, metadata !12), !dbg !196
  %wfptr3 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %y_fptr, i32 0, i32 0, !dbg !197
  store %struct.fsptr* %k_fptr, %struct.fsptr** %wfptr3, align 8, !dbg !198
  call void @make_alias(%struct.wfsptr* %y_fptr, %struct.wfsptr* %x_fptr), !dbg !199
  %sptr4 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %n_fptr, i32 0, i32 0, !dbg !200
  store %struct.fptr* %s_fptr, %struct.fptr** %sptr4, align 8, !dbg !201
  call void @llvm.dbg.declare(metadata %struct.fptr** %t_fptr, metadata !202, metadata !12), !dbg !203
  store %struct.fptr* null, %struct.fptr** %t_fptr, align 8, !dbg !203
  %0 = load i32, i32* %op1.addr, align 4, !dbg !204
  %1 = load i32, i32* %op2.addr, align 4, !dbg !205
  %wfptr5 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %y_fptr, i32 0, i32 0, !dbg !206
  %2 = load %struct.fsptr*, %struct.fsptr** %wfptr5, align 8, !dbg !206
  %call = call %struct.fptr* @clever(i32 %0, i32 %1, %struct.fsptr* %m_fptr, %struct.fsptr* %2), !dbg !207
  store %struct.fptr* %call, %struct.fptr** %t_fptr, align 8, !dbg !208
  %3 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !209
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !210
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr6, align 8, !dbg !210
  %5 = load i32, i32* %op1.addr, align 4, !dbg !211
  %6 = load i32, i32* %op2.addr, align 4, !dbg !212
  %call7 = call i32 %4(i32 %5, i32 %6), !dbg !209
  %sptr8 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !213
  %7 = load %struct.fptr*, %struct.fptr** %sptr8, align 8, !dbg !213
  %p_fptr9 = getelementptr inbounds %struct.fptr, %struct.fptr* %7, i32 0, i32 0, !dbg !214
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr9, align 8, !dbg !214
  %9 = load i32, i32* %op1.addr, align 4, !dbg !215
  %10 = load i32, i32* %op2.addr, align 4, !dbg !216
  %call10 = call i32 %8(i32 %9, i32 %10), !dbg !217
  call void @swap_w(%struct.wfsptr* %x_fptr, %struct.wfsptr* %w_fptr), !dbg !218
  %wfptr11 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %w_fptr, i32 0, i32 0, !dbg !219
  %11 = load %struct.fsptr*, %struct.fsptr** %wfptr11, align 8, !dbg !219
  %sptr12 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %11, i32 0, i32 0, !dbg !220
  %12 = load %struct.fptr*, %struct.fptr** %sptr12, align 8, !dbg !220
  %p_fptr13 = getelementptr inbounds %struct.fptr, %struct.fptr* %12, i32 0, i32 0, !dbg !221
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr13, align 8, !dbg !221
  %14 = load i32, i32* %op1.addr, align 4, !dbg !222
  %15 = load i32, i32* %op2.addr, align 4, !dbg !223
  %call14 = call i32 %13(i32 %14, i32 %15), !dbg !224
  ret i32 0, !dbg !225
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "test33.c", directory: "/home/liwc/llvm-assignment/assignment3_testcase_ver2")
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
!29 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 21, type: !30, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32, !10, !10, !37, !37}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !34)
!34 = !{!35}
!35 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !33, file: !1, line: 4, baseType: !36, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !38, size: 64)
!38 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !39)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !38, file: !1, line: 12, baseType: !41, size: 64)
!41 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !42, size: 64)
!42 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !43)
!43 = !{!44}
!44 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !42, file: !1, line: 8, baseType: !32, size: 64)
!45 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 21, type: !10)
!46 = !DILocation(line: 21, column: 23, scope: !29)
!47 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 21, type: !10)
!48 = !DILocation(line: 21, column: 30, scope: !29)
!49 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !29, file: !1, line: 21, type: !37)
!50 = !DILocation(line: 21, column: 49, scope: !29)
!51 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !29, file: !1, line: 21, type: !37)
!52 = !DILocation(line: 21, column: 73, scope: !29)
!53 = !DILocation(line: 22, column: 7, scope: !54)
!54 = distinct !DILexicalBlock(scope: !29, file: !1, line: 22, column: 7)
!55 = !DILocation(line: 22, column: 8, scope: !54)
!56 = !DILocation(line: 22, column: 11, scope: !54)
!57 = !DILocation(line: 22, column: 14, scope: !54)
!58 = !DILocation(line: 22, column: 15, scope: !54)
!59 = !DILocation(line: 22, column: 7, scope: !29)
!60 = !DILocalVariable(name: "temp", scope: !61, file: !1, line: 24, type: !41)
!61 = distinct !DILexicalBlock(scope: !54, file: !1, line: 23, column: 4)
!62 = !DILocation(line: 24, column: 20, scope: !61)
!63 = !DILocation(line: 24, column: 25, scope: !61)
!64 = !DILocation(line: 24, column: 33, scope: !61)
!65 = !DILocation(line: 25, column: 27, scope: !61)
!66 = !DILocation(line: 25, column: 35, scope: !61)
!67 = !DILocation(line: 25, column: 42, scope: !61)
!68 = !DILocation(line: 25, column: 5, scope: !61)
!69 = !DILocation(line: 25, column: 13, scope: !61)
!70 = !DILocation(line: 25, column: 20, scope: !61)
!71 = !DILocation(line: 25, column: 25, scope: !61)
!72 = !DILocation(line: 26, column: 26, scope: !61)
!73 = !DILocation(line: 26, column: 32, scope: !61)
!74 = !DILocation(line: 26, column: 5, scope: !61)
!75 = !DILocation(line: 26, column: 13, scope: !61)
!76 = !DILocation(line: 26, column: 20, scope: !61)
!77 = !DILocation(line: 26, column: 25, scope: !61)
!78 = !DILocation(line: 27, column: 5, scope: !61)
!79 = !DILocation(line: 27, column: 13, scope: !61)
!80 = !DILocation(line: 27, column: 20, scope: !61)
!81 = !DILocation(line: 27, column: 26, scope: !61)
!82 = !DILocation(line: 27, column: 33, scope: !61)
!83 = !DILocation(line: 27, column: 35, scope: !61)
!84 = !DILocation(line: 28, column: 12, scope: !61)
!85 = !DILocation(line: 28, column: 20, scope: !61)
!86 = !DILocation(line: 28, column: 27, scope: !61)
!87 = !DILocation(line: 28, column: 5, scope: !61)
!88 = !DILocation(line: 30, column: 11, scope: !29)
!89 = !DILocation(line: 30, column: 19, scope: !29)
!90 = !DILocation(line: 30, column: 26, scope: !29)
!91 = !DILocation(line: 30, column: 4, scope: !29)
!92 = !DILocation(line: 31, column: 1, scope: !29)
!93 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 33, type: !94, isLocal: false, isDefinition: true, scopeLine: 33, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!94 = !DISubroutineType(types: !95)
!95 = !{!32, !10, !10, !41, !41}
!96 = !DILocalVariable(name: "a", arg: 1, scope: !93, file: !1, line: 33, type: !10)
!97 = !DILocation(line: 33, column: 26, scope: !93)
!98 = !DILocalVariable(name: "b", arg: 2, scope: !93, file: !1, line: 33, type: !10)
!99 = !DILocation(line: 33, column: 33, scope: !93)
!100 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !93, file: !1, line: 33, type: !41)
!101 = !DILocation(line: 33, column: 51, scope: !93)
!102 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !93, file: !1, line: 33, type: !41)
!103 = !DILocation(line: 33, column: 74, scope: !93)
!104 = !DILocalVariable(name: "t1_fptr", scope: !93, file: !1, line: 34, type: !38)
!105 = !DILocation(line: 34, column: 18, scope: !93)
!106 = !DILocation(line: 35, column: 18, scope: !93)
!107 = !DILocation(line: 35, column: 12, scope: !93)
!108 = !DILocation(line: 35, column: 17, scope: !93)
!109 = !DILocalVariable(name: "t2_fptr", scope: !93, file: !1, line: 36, type: !38)
!110 = !DILocation(line: 36, column: 18, scope: !93)
!111 = !DILocation(line: 37, column: 18, scope: !93)
!112 = !DILocation(line: 37, column: 12, scope: !93)
!113 = !DILocation(line: 37, column: 17, scope: !93)
!114 = !DILocation(line: 38, column: 15, scope: !93)
!115 = !DILocation(line: 38, column: 17, scope: !93)
!116 = !DILocation(line: 38, column: 11, scope: !93)
!117 = !DILocation(line: 38, column: 4, scope: !93)
!118 = distinct !DISubprogram(name: "make_simple_alias", scope: !1, file: !1, line: 41, type: !119, isLocal: false, isDefinition: true, scopeLine: 42, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!119 = !DISubroutineType(types: !120)
!120 = !{null, !37, !41}
!121 = !DILocalVariable(name: "a_fptr", arg: 1, scope: !118, file: !1, line: 41, type: !37)
!122 = !DILocation(line: 41, column: 40, scope: !118)
!123 = !DILocalVariable(name: "b_fptr", arg: 2, scope: !118, file: !1, line: 41, type: !41)
!124 = !DILocation(line: 41, column: 62, scope: !118)
!125 = !DILocation(line: 43, column: 17, scope: !118)
!126 = !DILocation(line: 43, column: 3, scope: !118)
!127 = !DILocation(line: 43, column: 11, scope: !118)
!128 = !DILocation(line: 43, column: 16, scope: !118)
!129 = !DILocation(line: 44, column: 1, scope: !118)
!130 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 45, type: !131, isLocal: false, isDefinition: true, scopeLine: 46, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!131 = !DISubroutineType(types: !132)
!132 = !{null, !37, !37}
!133 = !DILocalVariable(name: "a_fptr", arg: 1, scope: !130, file: !1, line: 45, type: !37)
!134 = !DILocation(line: 45, column: 32, scope: !130)
!135 = !DILocalVariable(name: "b_fptr", arg: 2, scope: !130, file: !1, line: 45, type: !37)
!136 = !DILocation(line: 45, column: 55, scope: !130)
!137 = !DILocation(line: 47, column: 23, scope: !130)
!138 = !DILocation(line: 47, column: 31, scope: !130)
!139 = !DILocation(line: 47, column: 38, scope: !130)
!140 = !DILocation(line: 47, column: 3, scope: !130)
!141 = !DILocation(line: 47, column: 11, scope: !130)
!142 = !DILocation(line: 47, column: 18, scope: !130)
!143 = !DILocation(line: 47, column: 22, scope: !130)
!144 = !DILocation(line: 48, column: 1, scope: !130)
!145 = distinct !DISubprogram(name: "swap_w", scope: !1, file: !1, line: 49, type: !131, isLocal: false, isDefinition: true, scopeLine: 50, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!146 = !DILocalVariable(name: "a_fptr", arg: 1, scope: !145, file: !1, line: 49, type: !37)
!147 = !DILocation(line: 49, column: 29, scope: !145)
!148 = !DILocalVariable(name: "b_fptr", arg: 2, scope: !145, file: !1, line: 49, type: !37)
!149 = !DILocation(line: 49, column: 52, scope: !145)
!150 = !DILocalVariable(name: "wftemp", scope: !145, file: !1, line: 51, type: !38)
!151 = !DILocation(line: 51, column: 20, scope: !145)
!152 = !DILocation(line: 51, column: 28, scope: !145)
!153 = !DILocation(line: 51, column: 27, scope: !145)
!154 = !DILocation(line: 52, column: 7, scope: !145)
!155 = !DILocation(line: 52, column: 15, scope: !145)
!156 = !DILocation(line: 52, column: 14, scope: !145)
!157 = !DILocation(line: 53, column: 7, scope: !145)
!158 = !DILocation(line: 53, column: 14, scope: !145)
!159 = !DILocation(line: 54, column: 1, scope: !145)
!160 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 55, type: !161, isLocal: false, isDefinition: true, scopeLine: 55, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!161 = !DISubroutineType(types: !162)
!162 = !{!10, !163, !10, !10}
!163 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!164 = !DILocalVariable(name: "x", arg: 1, scope: !160, file: !1, line: 55, type: !163)
!165 = !DILocation(line: 55, column: 14, scope: !160)
!166 = !DILocalVariable(name: "op1", arg: 2, scope: !160, file: !1, line: 55, type: !10)
!167 = !DILocation(line: 55, column: 21, scope: !160)
!168 = !DILocalVariable(name: "op2", arg: 3, scope: !160, file: !1, line: 55, type: !10)
!169 = !DILocation(line: 55, column: 30, scope: !160)
!170 = !DILocalVariable(name: "a_fptr", scope: !160, file: !1, line: 56, type: !33)
!171 = !DILocation(line: 56, column: 17, scope: !160)
!172 = !DILocation(line: 57, column: 12, scope: !160)
!173 = !DILocation(line: 57, column: 18, scope: !160)
!174 = !DILocalVariable(name: "s_fptr", scope: !160, file: !1, line: 58, type: !33)
!175 = !DILocation(line: 58, column: 17, scope: !160)
!176 = !DILocation(line: 59, column: 12, scope: !160)
!177 = !DILocation(line: 59, column: 18, scope: !160)
!178 = !DILocalVariable(name: "m_fptr", scope: !160, file: !1, line: 61, type: !42)
!179 = !DILocation(line: 61, column: 18, scope: !160)
!180 = !DILocation(line: 62, column: 12, scope: !160)
!181 = !DILocation(line: 62, column: 16, scope: !160)
!182 = !DILocalVariable(name: "n_fptr", scope: !160, file: !1, line: 63, type: !42)
!183 = !DILocation(line: 63, column: 18, scope: !160)
!184 = !DILocation(line: 64, column: 12, scope: !160)
!185 = !DILocation(line: 64, column: 16, scope: !160)
!186 = !DILocalVariable(name: "w_fptr", scope: !160, file: !1, line: 66, type: !38)
!187 = !DILocation(line: 66, column: 19, scope: !160)
!188 = !DILocation(line: 67, column: 12, scope: !160)
!189 = !DILocation(line: 67, column: 17, scope: !160)
!190 = !DILocalVariable(name: "x_fptr", scope: !160, file: !1, line: 69, type: !38)
!191 = !DILocation(line: 69, column: 19, scope: !160)
!192 = !DILocation(line: 70, column: 5, scope: !160)
!193 = !DILocalVariable(name: "k_fptr", scope: !160, file: !1, line: 72, type: !42)
!194 = !DILocation(line: 72, column: 18, scope: !160)
!195 = !DILocalVariable(name: "y_fptr", scope: !160, file: !1, line: 73, type: !38)
!196 = !DILocation(line: 73, column: 19, scope: !160)
!197 = !DILocation(line: 74, column: 12, scope: !160)
!198 = !DILocation(line: 74, column: 17, scope: !160)
!199 = !DILocation(line: 75, column: 5, scope: !160)
!200 = !DILocation(line: 77, column: 12, scope: !160)
!201 = !DILocation(line: 77, column: 16, scope: !160)
!202 = !DILocalVariable(name: "t_fptr", scope: !160, file: !1, line: 79, type: !32)
!203 = !DILocation(line: 79, column: 18, scope: !160)
!204 = !DILocation(line: 81, column: 21, scope: !160)
!205 = !DILocation(line: 81, column: 26, scope: !160)
!206 = !DILocation(line: 81, column: 47, scope: !160)
!207 = !DILocation(line: 81, column: 14, scope: !160)
!208 = !DILocation(line: 81, column: 12, scope: !160)
!209 = !DILocation(line: 82, column: 5, scope: !160)
!210 = !DILocation(line: 82, column: 13, scope: !160)
!211 = !DILocation(line: 82, column: 20, scope: !160)
!212 = !DILocation(line: 82, column: 25, scope: !160)
!213 = !DILocation(line: 83, column: 12, scope: !160)
!214 = !DILocation(line: 83, column: 18, scope: !160)
!215 = !DILocation(line: 83, column: 25, scope: !160)
!216 = !DILocation(line: 83, column: 29, scope: !160)
!217 = !DILocation(line: 83, column: 5, scope: !160)
!218 = !DILocation(line: 84, column: 5, scope: !160)
!219 = !DILocation(line: 85, column: 12, scope: !160)
!220 = !DILocation(line: 85, column: 19, scope: !160)
!221 = !DILocation(line: 85, column: 25, scope: !160)
!222 = !DILocation(line: 85, column: 32, scope: !160)
!223 = !DILocation(line: 85, column: 36, scope: !160)
!224 = !DILocation(line: 85, column: 5, scope: !160)
!225 = !DILocation(line: 87, column: 5, scope: !160)
