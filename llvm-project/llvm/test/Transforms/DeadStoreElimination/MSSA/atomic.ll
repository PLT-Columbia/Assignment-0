; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -basic-aa -dse -enable-dse-memoryssa -S < %s | FileCheck %s

target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-macosx10.7.0"

; Sanity tests for atomic stores.
; Note that it turns out essentially every transformation DSE does is legal on
; atomic ops, just some transformations are not allowed across release-acquire pairs.

@x = common global i32 0, align 4
@y = common global i32 0, align 4

declare void @randomop(i32*)

; DSE across unordered store (allowed)
define void @test1() {
; CHECK-LABEL: @test1(
; CHECK-NEXT:    store atomic i32 0, i32* @y unordered, align 4
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, i32* @x
  store atomic i32 0, i32* @y unordered, align 4
  store i32 1, i32* @x
  ret void
}

; DSE remove unordered store (allowed)
define void @test4() {
; CHECK-LABEL: @test4(
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 0, i32* @x unordered, align 4
  store i32 1, i32* @x
  ret void
}

; DSE unordered store overwriting non-atomic store (allowed)
define void @test5() {
; CHECK-LABEL: @test5(
; CHECK-NEXT:    store atomic i32 1, i32* @x unordered, align 4
; CHECK-NEXT:    ret void
;
  store i32 0, i32* @x
  store atomic i32 1, i32* @x unordered, align 4
  ret void
}

; DSE no-op unordered atomic store (allowed)
define void @test6() {
; CHECK-LABEL: @test6(
; CHECK-NEXT:    ret void
;
  %x = load atomic i32, i32* @x unordered, align 4
  store atomic i32 %x, i32* @x unordered, align 4
  ret void
}

; DSE seq_cst store (be conservative; DSE doesn't have infrastructure
; to reason about atomic operations).
define void @test7() {
; CHECK-LABEL: @test7(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    store atomic i32 0, i32* [[A]] seq_cst, align 4
; CHECK-NEXT:    ret void
;
  %a = alloca i32
  store atomic i32 0, i32* %a seq_cst, align 4
  ret void
}

; DSE and seq_cst load (be conservative; DSE doesn't have infrastructure
; to reason about atomic operations).
define i32 @test8() {
; CHECK-LABEL: @test8(
; CHECK-NEXT:    [[A:%.*]] = alloca i32, align 4
; CHECK-NEXT:    call void @randomop(i32* [[A]])
; CHECK-NEXT:    store i32 0, i32* [[A]], align 4
; CHECK-NEXT:    [[X:%.*]] = load atomic i32, i32* @x seq_cst, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
  %a = alloca i32
  call void @randomop(i32* %a)
  store i32 0, i32* %a, align 4
  %x = load atomic i32, i32* @x seq_cst, align 4
  ret i32 %x
}

; DSE across monotonic load (forbidden since the eliminated store is atomic)
define i32 @test11() {
; CHECK-LABEL: @test11(
; CHECK-NEXT:    store atomic i32 0, i32* @x monotonic, align 4
; CHECK-NEXT:    [[X:%.*]] = load atomic i32, i32* @y monotonic, align 4
; CHECK-NEXT:    store atomic i32 1, i32* @x monotonic, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
  store atomic i32 0, i32* @x monotonic, align 4
  %x = load atomic i32, i32* @y monotonic, align 4
  store atomic i32 1, i32* @x monotonic, align 4
  ret i32 %x
}

; DSE across monotonic store (forbidden since the eliminated store is atomic)
define void @test12() {
; CHECK-LABEL: @test12(
; CHECK-NEXT:    store atomic i32 0, i32* @x monotonic, align 4
; CHECK-NEXT:    store atomic i32 42, i32* @y monotonic, align 4
; CHECK-NEXT:    store atomic i32 1, i32* @x monotonic, align 4
; CHECK-NEXT:    ret void
;
  store atomic i32 0, i32* @x monotonic, align 4
  store atomic i32 42, i32* @y monotonic, align 4
  store atomic i32 1, i32* @x monotonic, align 4
  ret void
}

; But DSE is not allowed across a release-acquire pair.
define i32 @test15() {
; CHECK-LABEL: @test15(
; CHECK-NEXT:    store i32 0, i32* @x, align 4
; CHECK-NEXT:    store atomic i32 0, i32* @y release, align 4
; CHECK-NEXT:    [[X:%.*]] = load atomic i32, i32* @y acquire, align 4
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    ret i32 [[X]]
;
  store i32 0, i32* @x
  store atomic i32 0, i32* @y release, align 4
  %x = load atomic i32, i32* @y acquire, align 4
  store i32 1, i32* @x
  ret i32 %x
}

@z = common global i64 0, align 4
@a = common global i64 0, align 4

; Be conservative, do not kill regular store.
define i64 @test_atomicrmw_0() {
; CHECK-LABEL: @test_atomicrmw_0(
; CHECK-NEXT:    store i64 1, i64* @z, align 8
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add i64* @z, i64 -1 monotonic
; CHECK-NEXT:    ret i64 [[RES]]
;
  store i64 1, i64* @z
  %res = atomicrmw add i64* @z, i64 -1 monotonic
  ret i64 %res
}

; Be conservative, do not kill regular store.
define i64 @test_atomicrmw_1() {
; CHECK-LABEL: @test_atomicrmw_1(
; CHECK-NEXT:    store i64 1, i64* @z, align 8
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add i64* @z, i64 -1 acq_rel
; CHECK-NEXT:    ret i64 [[RES]]
;
  store i64 1, i64* @z
  %res = atomicrmw add i64* @z, i64 -1 acq_rel
  ret i64 %res
}

; Monotonic atomicrmw should not block eliminating no-aliasing stores.
define i64 @test_atomicrmw_2() {
; CHECK-LABEL: @test_atomicrmw_2(
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add i64* @a, i64 -1 monotonic
; CHECK-NEXT:    store i64 2, i64* @z, align 8
; CHECK-NEXT:    ret i64 [[RES]]
;
  store i64 1, i64* @z
  %res = atomicrmw add i64* @a, i64 -1 monotonic
  store i64 2, i64* @z
  ret i64 %res
}

; Be conservative, do not eliminate stores across atomic operations > monotonic.
define i64 @test_atomicrmw_3() {
; CHECK-LABEL: @test_atomicrmw_3(
; CHECK-NEXT:    store i64 1, i64* @z, align 8
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add i64* @a, i64 -1 release
; CHECK-NEXT:    store i64 2, i64* @z, align 8
; CHECK-NEXT:    ret i64 [[RES]]
;
  store i64 1, i64* @z
  %res = atomicrmw add i64* @a, i64 -1 release
  store i64 2, i64* @z
  ret i64 %res
}

; Be conservative, do not eliminate may-alias stores.
define i64 @test_atomicrmw_4(i64* %ptr) {
; CHECK-LABEL: @test_atomicrmw_4(
; CHECK-NEXT:    store i64 1, i64* @z, align 8
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add i64* [[PTR:%.*]], i64 -1 monotonic
; CHECK-NEXT:    store i64 2, i64* @z, align 8
; CHECK-NEXT:    ret i64 [[RES]]
;
  store i64 1, i64* @z
  %res = atomicrmw add i64* %ptr, i64 -1 monotonic
  store i64 2, i64* @z
  ret i64 %res
}

; Be conservative, do not eliminate aliasing stores.
define i64 @test_atomicrmw_5() {
; CHECK-LABEL: @test_atomicrmw_5(
; CHECK-NEXT:    store i64 1, i64* @z, align 8
; CHECK-NEXT:    [[RES:%.*]] = atomicrmw add i64* @z, i64 -1 monotonic
; CHECK-NEXT:    store i64 2, i64* @z, align 8
; CHECK-NEXT:    ret i64 [[RES]]
;
  store i64 1, i64* @z
  %res = atomicrmw add i64* @z, i64 -1 monotonic
  store i64 2, i64* @z
  ret i64 %res
}

; Be conservative, do not eliminate non-monotonic cmpxchg.
define { i32, i1} @test_cmpxchg_1() {
; CHECK-LABEL: @test_cmpxchg_1(
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    [[RET:%.*]] = cmpxchg volatile i32* @x, i32 10, i32 20 seq_cst monotonic
; CHECK-NEXT:    store i32 2, i32* @x, align 4
; CHECK-NEXT:    ret { i32, i1 } [[RET]]
;
  store i32 1, i32* @x
  %ret = cmpxchg volatile i32* @x, i32 10, i32 20 seq_cst monotonic
  store i32 2, i32* @x
  ret { i32, i1 } %ret
}

; Monotonic cmpxchg should not block DSE for non-aliasing stores.
define { i32, i1} @test_cmpxchg_2() {
; CHECK-LABEL: @test_cmpxchg_2(
; CHECK-NEXT:    [[RET:%.*]] = cmpxchg volatile i32* @y, i32 10, i32 20 monotonic monotonic
; CHECK-NEXT:    store i32 2, i32* @x, align 4
; CHECK-NEXT:    ret { i32, i1 } [[RET]]
;
  store i32 1, i32* @x
  %ret = cmpxchg volatile i32* @y, i32 10, i32 20 monotonic monotonic
  store i32 2, i32* @x
  ret { i32, i1 } %ret
}

; Be conservative, do not eliminate non-monotonic cmpxchg.
define { i32, i1} @test_cmpxchg_3() {
; CHECK-LABEL: @test_cmpxchg_3(
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    [[RET:%.*]] = cmpxchg volatile i32* @y, i32 10, i32 20 seq_cst seq_cst
; CHECK-NEXT:    store i32 2, i32* @x, align 4
; CHECK-NEXT:    ret { i32, i1 } [[RET]]
;
  store i32 1, i32* @x
  %ret = cmpxchg volatile i32* @y, i32 10, i32 20 seq_cst seq_cst
  store i32 2, i32* @x
  ret { i32, i1 } %ret
}

; Be conservative, do not eliminate may-alias stores.
define { i32, i1} @test_cmpxchg_4(i32* %ptr) {
; CHECK-LABEL: @test_cmpxchg_4(
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    [[RET:%.*]] = cmpxchg volatile i32* [[PTR:%.*]], i32 10, i32 20 monotonic monotonic
; CHECK-NEXT:    store i32 2, i32* @x, align 4
; CHECK-NEXT:    ret { i32, i1 } [[RET]]
;
  store i32 1, i32* @x
  %ret = cmpxchg volatile i32* %ptr, i32 10, i32 20 monotonic monotonic
  store i32 2, i32* @x
  ret { i32, i1 } %ret
}

; Be conservative, do not eliminate alias stores.
define { i32, i1} @test_cmpxchg_5(i32* %ptr) {
; CHECK-LABEL: @test_cmpxchg_5(
; CHECK-NEXT:    store i32 1, i32* @x, align 4
; CHECK-NEXT:    [[RET:%.*]] = cmpxchg volatile i32* @x, i32 10, i32 20 monotonic monotonic
; CHECK-NEXT:    store i32 2, i32* @x, align 4
; CHECK-NEXT:    ret { i32, i1 } [[RET]]
;
  store i32 1, i32* @x
  %ret = cmpxchg volatile i32* @x, i32 10, i32 20 monotonic monotonic
  store i32 2, i32* @x
  ret { i32, i1 } %ret
}

; **** Noop load->store tests **************************************************

; We can optimize unordered atomic loads or stores.
define void @test_load_atomic(i32* %Q) {
; CHECK-LABEL: @test_load_atomic(
; CHECK-NEXT:    ret void
;
  %a = load atomic i32, i32* %Q unordered, align 4
  store atomic i32 %a, i32* %Q unordered, align 4
  ret void
}

; We can optimize unordered atomic loads or stores.
define void @test_store_atomic(i32* %Q) {
; CHECK-LABEL: @test_store_atomic(
; CHECK-NEXT:    ret void
;
  %a = load i32, i32* %Q
  store atomic i32 %a, i32* %Q unordered, align 4
  ret void
}

; We can NOT optimize release atomic loads or stores.
define void @test_store_atomic_release(i32* %Q) {
; CHECK-LABEL: @test_store_atomic_release(
; CHECK-NEXT:    [[A:%.*]] = load i32, i32* [[Q:%.*]], align 4
; CHECK-NEXT:    store atomic i32 [[A]], i32* [[Q]] release, align 4
; CHECK-NEXT:    ret void
;
  %a = load i32, i32* %Q
  store atomic i32 %a, i32* %Q release, align 4
  ret void
}