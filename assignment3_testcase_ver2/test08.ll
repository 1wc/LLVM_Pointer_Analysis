; ModuleID = 'test08.bc'
source_filename = "test08.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @plus(i32, i32) #0 !dbg !7 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !11, metadata !12), !dbg !13
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !14, metadata !12), !dbg !15
  %5 = load i32, i32* %3, align 4, !dbg !16
  %6 = load i32, i32* %4, align 4, !dbg !17
  %7 = add nsw i32 %5, %6, !dbg !18
  ret i32 %7, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @minus(i32, i32) #0 !dbg !20 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !21, metadata !12), !dbg !22
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !23, metadata !12), !dbg !24
  %5 = load i32, i32* %3, align 4, !dbg !25
  %6 = load i32, i32* %4, align 4, !dbg !26
  %7 = sub nsw i32 %5, %6, !dbg !27
  ret i32 %7, !dbg !28
}

; Function Attrs: noinline nounwind optnone uwtable
define void @foo(i32) #0 !dbg !29 {
  %2 = alloca i32, align 4
  %3 = alloca %struct.fptr, align 8
  %4 = alloca %struct.fsptr, align 8
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !32, metadata !12), !dbg !33
  call void @llvm.dbg.declare(metadata %struct.fptr* %3, metadata !34, metadata !12), !dbg !39
  call void @llvm.dbg.declare(metadata %struct.fsptr* %4, metadata !40, metadata !12), !dbg !45
  %5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !46
  store %struct.fptr* %3, %struct.fptr** %5, align 8, !dbg !47
  %6 = load i32, i32* %2, align 4, !dbg !48
  %7 = icmp sgt i32 %6, 1, !dbg !50
  br i1 %7, label %8, label %17, !dbg !51

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !52
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %9, align 8, !dbg !54
  %10 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !55
  %11 = load %struct.fptr*, %struct.fptr** %10, align 8, !dbg !55
  %12 = getelementptr inbounds %struct.fptr, %struct.fptr* %11, i32 0, i32 0, !dbg !56
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %12, align 8, !dbg !56
  %14 = load i32, i32* %2, align 4, !dbg !57
  %15 = call i32 %13(i32 1, i32 %14), !dbg !58
  store i32 %15, i32* %2, align 4, !dbg !59
  %16 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !60
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %16, align 8, !dbg !61
  br label %21, !dbg !62

; <label>:17:                                     ; preds = %1
  %18 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !63
  %19 = load %struct.fptr*, %struct.fptr** %18, align 8, !dbg !63
  %20 = getelementptr inbounds %struct.fptr, %struct.fptr* %19, i32 0, i32 0, !dbg !65
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %20, align 8, !dbg !66
  br label %21

; <label>:21:                                     ; preds = %17, %8
  %22 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !67
  %23 = load i32 (i32, i32)*, i32 (i32, i32)** %22, align 8, !dbg !67
  %24 = load i32, i32* %2, align 4, !dbg !68
  %25 = call i32 %23(i32 1, i32 %24), !dbg !69
  store i32 %25, i32* %2, align 4, !dbg !70
  ret void, !dbg !71
}
