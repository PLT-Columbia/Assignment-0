; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-arm-none-eabi -mattr=+mve -verify-machineinstrs %s -o - | FileCheck %s --check-prefix=CHECK

define arm_aapcs_vfpcc <2 x i32> @vmulhs_v2i32(<2 x i32> %s0, <2 x i32> %s1) {
; CHECK-LABEL: vmulhs_v2i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.s32 q2, q0, q1
; CHECK-NEXT:    vmov r0, s9
; CHECK-NEXT:    vmov.32 q0[0], r0
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    vmov.32 q0[1], r0
; CHECK-NEXT:    vmov r0, s11
; CHECK-NEXT:    vmov.32 q0[2], r0
; CHECK-NEXT:    asrs r0, r0, #31
; CHECK-NEXT:    vmov.32 q0[3], r0
; CHECK-NEXT:    bx lr
entry:
  %s0s = sext <2 x i32> %s0 to <2 x i64>
  %s1s = sext <2 x i32> %s1 to <2 x i64>
  %m = mul <2 x i64> %s0s, %s1s
  %s = ashr <2 x i64> %m, <i64 32, i64 32>
  %s2 = trunc <2 x i64> %s to <2 x i32>
  ret <2 x i32> %s2
}

define arm_aapcs_vfpcc <2 x i32> @vmulhu_v2i32(<2 x i32> %s0, <2 x i32> %s1) {
; CHECK-LABEL: vmulhu_v2i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.u32 q2, q0, q1
; CHECK-NEXT:    vldr s1, .LCPI1_0
; CHECK-NEXT:    vmov.f32 s0, s9
; CHECK-NEXT:    vmov.f32 s2, s11
; CHECK-NEXT:    vmov.f32 s3, s1
; CHECK-NEXT:    bx lr
; CHECK-NEXT:    .p2align 2
; CHECK-NEXT:  @ %bb.1:
; CHECK-NEXT:  .LCPI1_0:
; CHECK-NEXT:    .long 0x00000000 @ float 0
entry:
  %s0s = zext <2 x i32> %s0 to <2 x i64>
  %s1s = zext <2 x i32> %s1 to <2 x i64>
  %m = mul <2 x i64> %s0s, %s1s
  %s = lshr <2 x i64> %m, <i64 32, i64 32>
  %s2 = trunc <2 x i64> %s to <2 x i32>
  ret <2 x i32> %s2
}

define arm_aapcs_vfpcc <4 x i32> @vmulhs_v4i32(<4 x i32> %s0, <4 x i32> %s1) {
; CHECK-LABEL: vmulhs_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.f32 s8, s4
; CHECK-NEXT:    vmov.f32 s12, s0
; CHECK-NEXT:    vmov.f32 s14, s1
; CHECK-NEXT:    vmov.f32 s10, s5
; CHECK-NEXT:    vmov r2, s12
; CHECK-NEXT:    vmov r1, s14
; CHECK-NEXT:    vmov r0, s10
; CHECK-NEXT:    vmov.f32 s12, s6
; CHECK-NEXT:    vmov.f32 s14, s7
; CHECK-NEXT:    vmov.f32 s4, s2
; CHECK-NEXT:    vmov.f32 s6, s3
; CHECK-NEXT:    vmullb.s32 q0, q1, q3
; CHECK-NEXT:    smmul r0, r1, r0
; CHECK-NEXT:    vmov r1, s8
; CHECK-NEXT:    smmul r1, r2, r1
; CHECK-NEXT:    vmov.32 q2[0], r1
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %s0s = sext <4 x i32> %s0 to <4 x i64>
  %s1s = sext <4 x i32> %s1 to <4 x i64>
  %m = mul <4 x i64> %s0s, %s1s
  %s = ashr <4 x i64> %m, <i64 32, i64 32, i64 32, i64 32>
  %s2 = trunc <4 x i64> %s to <4 x i32>
  ret <4 x i32> %s2
}

define arm_aapcs_vfpcc <4 x i32> @vmulhu_v4i32(<4 x i32> %s0, <4 x i32> %s1) {
; CHECK-LABEL: vmulhu_v4i32:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .vsave {d8, d9}
; CHECK-NEXT:    vpush {d8, d9}
; CHECK-NEXT:    vmov.f32 s12, s6
; CHECK-NEXT:    vmov.f32 s16, s2
; CHECK-NEXT:    vmov.f32 s14, s7
; CHECK-NEXT:    vmov.f32 s18, s3
; CHECK-NEXT:    vmov.f32 s6, s5
; CHECK-NEXT:    vmullb.u32 q2, q4, q3
; CHECK-NEXT:    vmov.f32 s2, s1
; CHECK-NEXT:    vmullb.u32 q3, q0, q1
; CHECK-NEXT:    vmov.f32 s0, s13
; CHECK-NEXT:    vmov.f32 s1, s15
; CHECK-NEXT:    vmov.f32 s2, s9
; CHECK-NEXT:    vmov.f32 s3, s11
; CHECK-NEXT:    vpop {d8, d9}
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <4 x i32> %s0 to <4 x i64>
  %s1s = zext <4 x i32> %s1 to <4 x i64>
  %m = mul <4 x i64> %s0s, %s1s
  %s = lshr <4 x i64> %m, <i64 32, i64 32, i64 32, i64 32>
  %s2 = trunc <4 x i64> %s to <4 x i32>
  ret <4 x i32> %s2
}

define arm_aapcs_vfpcc <4 x i16> @vmulhs_v4i16(<4 x i16> %s0, <4 x i16> %s1) {
; CHECK-LABEL: vmulhs_v4i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.s16 q0, q0, q1
; CHECK-NEXT:    vshr.s32 q0, q0, #16
; CHECK-NEXT:    bx lr
entry:
  %s0s = sext <4 x i16> %s0 to <4 x i32>
  %s1s = sext <4 x i16> %s1 to <4 x i32>
  %m = mul <4 x i32> %s0s, %s1s
  %s = ashr <4 x i32> %m, <i32 16, i32 16, i32 16, i32 16>
  %s2 = trunc <4 x i32> %s to <4 x i16>
  ret <4 x i16> %s2
}

define arm_aapcs_vfpcc <4 x i16> @vmulhu_v4i16(<4 x i16> %s0, <4 x i16> %s1) {
; CHECK-LABEL: vmulhu_v4i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.u16 q0, q0, q1
; CHECK-NEXT:    vshr.u32 q0, q0, #16
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <4 x i16> %s0 to <4 x i32>
  %s1s = zext <4 x i16> %s1 to <4 x i32>
  %m = mul <4 x i32> %s0s, %s1s
  %s = lshr <4 x i32> %m, <i32 16, i32 16, i32 16, i32 16>
  %s2 = trunc <4 x i32> %s to <4 x i16>
  ret <4 x i16> %s2
}

define arm_aapcs_vfpcc <8 x i16> @vmulhs_v8i16(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: vmulhs_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q1[0]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q1[1]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u16 r0, q1[2]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u16 r0, q1[3]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vmullb.s16 q2, q3, q2
; CHECK-NEXT:    vshr.s32 q3, q2, #16
; CHECK-NEXT:    vmov r0, s12
; CHECK-NEXT:    vmov.16 q2[0], r0
; CHECK-NEXT:    vmov r0, s13
; CHECK-NEXT:    vmov.16 q2[1], r0
; CHECK-NEXT:    vmov r0, s14
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov r0, s15
; CHECK-NEXT:    vmov.16 q2[3], r0
; CHECK-NEXT:    vmov.u16 r0, q1[4]
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u16 r0, q1[5]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u16 r0, q1[6]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u16 r0, q1[7]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.32 q1[3], r0
; CHECK-NEXT:    vmullb.s16 q0, q1, q3
; CHECK-NEXT:    vshr.s32 q0, q0, #16
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmov.16 q2[4], r0
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vmov.16 q2[5], r0
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vmov.16 q2[6], r0
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov.16 q2[7], r0
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %s0s = sext <8 x i16> %s0 to <8 x i32>
  %s1s = sext <8 x i16> %s1 to <8 x i32>
  %m = mul <8 x i32> %s0s, %s1s
  %s = ashr <8 x i32> %m, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %s2 = trunc <8 x i32> %s to <8 x i16>
  ret <8 x i16> %s2
}

define arm_aapcs_vfpcc <8 x i16> @vmulhu_v8i16(<8 x i16> %s0, <8 x i16> %s1) {
; CHECK-LABEL: vmulhu_v8i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u16 r0, q1[0]
; CHECK-NEXT:    vmov.32 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q1[1]
; CHECK-NEXT:    vmov.32 q2[1], r0
; CHECK-NEXT:    vmov.u16 r0, q1[2]
; CHECK-NEXT:    vmov.32 q2[2], r0
; CHECK-NEXT:    vmov.u16 r0, q1[3]
; CHECK-NEXT:    vmov.32 q2[3], r0
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vmullb.u16 q2, q3, q2
; CHECK-NEXT:    vshr.u32 q3, q2, #16
; CHECK-NEXT:    vmov r0, s12
; CHECK-NEXT:    vmov.16 q2[0], r0
; CHECK-NEXT:    vmov r0, s13
; CHECK-NEXT:    vmov.16 q2[1], r0
; CHECK-NEXT:    vmov r0, s14
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov r0, s15
; CHECK-NEXT:    vmov.16 q2[3], r0
; CHECK-NEXT:    vmov.u16 r0, q1[4]
; CHECK-NEXT:    vmov.32 q3[0], r0
; CHECK-NEXT:    vmov.u16 r0, q1[5]
; CHECK-NEXT:    vmov.32 q3[1], r0
; CHECK-NEXT:    vmov.u16 r0, q1[6]
; CHECK-NEXT:    vmov.32 q3[2], r0
; CHECK-NEXT:    vmov.u16 r0, q1[7]
; CHECK-NEXT:    vmov.32 q3[3], r0
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.32 q1[0], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.32 q1[1], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.32 q1[2], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.32 q1[3], r0
; CHECK-NEXT:    vmullb.u16 q0, q1, q3
; CHECK-NEXT:    vshr.u32 q0, q0, #16
; CHECK-NEXT:    vmov r0, s0
; CHECK-NEXT:    vmov.16 q2[4], r0
; CHECK-NEXT:    vmov r0, s1
; CHECK-NEXT:    vmov.16 q2[5], r0
; CHECK-NEXT:    vmov r0, s2
; CHECK-NEXT:    vmov.16 q2[6], r0
; CHECK-NEXT:    vmov r0, s3
; CHECK-NEXT:    vmov.16 q2[7], r0
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <8 x i16> %s0 to <8 x i32>
  %s1s = zext <8 x i16> %s1 to <8 x i32>
  %m = mul <8 x i32> %s0s, %s1s
  %s = lshr <8 x i32> %m, <i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16, i32 16>
  %s2 = trunc <8 x i32> %s to <8 x i16>
  ret <8 x i16> %s2
}

define arm_aapcs_vfpcc <8 x i8> @vmulhs_v8i8(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: vmulhs_v8i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.s8 q0, q0, q1
; CHECK-NEXT:    vshr.s16 q0, q0, #8
; CHECK-NEXT:    bx lr
entry:
  %s0s = sext <8 x i8> %s0 to <8 x i16>
  %s1s = sext <8 x i8> %s1 to <8 x i16>
  %m = mul <8 x i16> %s0s, %s1s
  %s = ashr <8 x i16> %m, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %s2 = trunc <8 x i16> %s to <8 x i8>
  ret <8 x i8> %s2
}

define arm_aapcs_vfpcc <8 x i8> @vmulhu_v8i8(<8 x i8> %s0, <8 x i8> %s1) {
; CHECK-LABEL: vmulhu_v8i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmullb.u8 q0, q0, q1
; CHECK-NEXT:    vshr.u16 q0, q0, #8
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <8 x i8> %s0 to <8 x i16>
  %s1s = zext <8 x i8> %s1 to <8 x i16>
  %m = mul <8 x i16> %s0s, %s1s
  %s = lshr <8 x i16> %m, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %s2 = trunc <8 x i16> %s to <8 x i8>
  ret <8 x i8> %s2
}

define arm_aapcs_vfpcc <16 x i8> @vmulhs_v16i8(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: vmulhs_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q1[0]
; CHECK-NEXT:    vmov.16 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q1[1]
; CHECK-NEXT:    vmov.16 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q1[2]
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q1[3]
; CHECK-NEXT:    vmov.16 q2[3], r0
; CHECK-NEXT:    vmov.u8 r0, q1[4]
; CHECK-NEXT:    vmov.16 q2[4], r0
; CHECK-NEXT:    vmov.u8 r0, q1[5]
; CHECK-NEXT:    vmov.16 q2[5], r0
; CHECK-NEXT:    vmov.u8 r0, q1[6]
; CHECK-NEXT:    vmov.16 q2[6], r0
; CHECK-NEXT:    vmov.u8 r0, q1[7]
; CHECK-NEXT:    vmov.16 q2[7], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.16 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.16 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[2]
; CHECK-NEXT:    vmov.16 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[3]
; CHECK-NEXT:    vmov.16 q3[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.16 q3[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.16 q3[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[6]
; CHECK-NEXT:    vmov.16 q3[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    vmov.16 q3[7], r0
; CHECK-NEXT:    vmullb.s8 q2, q3, q2
; CHECK-NEXT:    vshr.s16 q3, q2, #8
; CHECK-NEXT:    vmov.u16 r0, q3[0]
; CHECK-NEXT:    vmov.8 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q3[1]
; CHECK-NEXT:    vmov.8 q2[1], r0
; CHECK-NEXT:    vmov.u16 r0, q3[2]
; CHECK-NEXT:    vmov.8 q2[2], r0
; CHECK-NEXT:    vmov.u16 r0, q3[3]
; CHECK-NEXT:    vmov.8 q2[3], r0
; CHECK-NEXT:    vmov.u16 r0, q3[4]
; CHECK-NEXT:    vmov.8 q2[4], r0
; CHECK-NEXT:    vmov.u16 r0, q3[5]
; CHECK-NEXT:    vmov.8 q2[5], r0
; CHECK-NEXT:    vmov.u16 r0, q3[6]
; CHECK-NEXT:    vmov.8 q2[6], r0
; CHECK-NEXT:    vmov.u16 r0, q3[7]
; CHECK-NEXT:    vmov.8 q2[7], r0
; CHECK-NEXT:    vmov.u8 r0, q1[8]
; CHECK-NEXT:    vmov.16 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q1[9]
; CHECK-NEXT:    vmov.16 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q1[10]
; CHECK-NEXT:    vmov.16 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q1[11]
; CHECK-NEXT:    vmov.16 q3[3], r0
; CHECK-NEXT:    vmov.u8 r0, q1[12]
; CHECK-NEXT:    vmov.16 q3[4], r0
; CHECK-NEXT:    vmov.u8 r0, q1[13]
; CHECK-NEXT:    vmov.16 q3[5], r0
; CHECK-NEXT:    vmov.u8 r0, q1[14]
; CHECK-NEXT:    vmov.16 q3[6], r0
; CHECK-NEXT:    vmov.u8 r0, q1[15]
; CHECK-NEXT:    vmov.16 q3[7], r0
; CHECK-NEXT:    vmov.u8 r0, q0[8]
; CHECK-NEXT:    vmov.16 q1[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[9]
; CHECK-NEXT:    vmov.16 q1[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[10]
; CHECK-NEXT:    vmov.16 q1[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[11]
; CHECK-NEXT:    vmov.16 q1[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[12]
; CHECK-NEXT:    vmov.16 q1[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[13]
; CHECK-NEXT:    vmov.16 q1[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.16 q1[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.16 q1[7], r0
; CHECK-NEXT:    vmullb.s8 q0, q1, q3
; CHECK-NEXT:    vshr.s16 q0, q0, #8
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.8 q2[8], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.8 q2[9], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.8 q2[10], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.8 q2[11], r0
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.8 q2[12], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.8 q2[13], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.8 q2[14], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.8 q2[15], r0
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %s0s = sext <16 x i8> %s0 to <16 x i16>
  %s1s = sext <16 x i8> %s1 to <16 x i16>
  %m = mul <16 x i16> %s0s, %s1s
  %s = ashr <16 x i16> %m, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %s2 = trunc <16 x i16> %s to <16 x i8>
  ret <16 x i8> %s2
}

define arm_aapcs_vfpcc <16 x i8> @vmulhu_v16i8(<16 x i8> %s0, <16 x i8> %s1) {
; CHECK-LABEL: vmulhu_v16i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.u8 r0, q1[0]
; CHECK-NEXT:    vmov.16 q2[0], r0
; CHECK-NEXT:    vmov.u8 r0, q1[1]
; CHECK-NEXT:    vmov.16 q2[1], r0
; CHECK-NEXT:    vmov.u8 r0, q1[2]
; CHECK-NEXT:    vmov.16 q2[2], r0
; CHECK-NEXT:    vmov.u8 r0, q1[3]
; CHECK-NEXT:    vmov.16 q2[3], r0
; CHECK-NEXT:    vmov.u8 r0, q1[4]
; CHECK-NEXT:    vmov.16 q2[4], r0
; CHECK-NEXT:    vmov.u8 r0, q1[5]
; CHECK-NEXT:    vmov.16 q2[5], r0
; CHECK-NEXT:    vmov.u8 r0, q1[6]
; CHECK-NEXT:    vmov.16 q2[6], r0
; CHECK-NEXT:    vmov.u8 r0, q1[7]
; CHECK-NEXT:    vmov.16 q2[7], r0
; CHECK-NEXT:    vmov.u8 r0, q0[0]
; CHECK-NEXT:    vmov.16 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[1]
; CHECK-NEXT:    vmov.16 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[2]
; CHECK-NEXT:    vmov.16 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[3]
; CHECK-NEXT:    vmov.16 q3[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[4]
; CHECK-NEXT:    vmov.16 q3[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[5]
; CHECK-NEXT:    vmov.16 q3[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[6]
; CHECK-NEXT:    vmov.16 q3[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[7]
; CHECK-NEXT:    vmov.16 q3[7], r0
; CHECK-NEXT:    vmullb.u8 q2, q3, q2
; CHECK-NEXT:    vshr.u16 q3, q2, #8
; CHECK-NEXT:    vmov.u16 r0, q3[0]
; CHECK-NEXT:    vmov.8 q2[0], r0
; CHECK-NEXT:    vmov.u16 r0, q3[1]
; CHECK-NEXT:    vmov.8 q2[1], r0
; CHECK-NEXT:    vmov.u16 r0, q3[2]
; CHECK-NEXT:    vmov.8 q2[2], r0
; CHECK-NEXT:    vmov.u16 r0, q3[3]
; CHECK-NEXT:    vmov.8 q2[3], r0
; CHECK-NEXT:    vmov.u16 r0, q3[4]
; CHECK-NEXT:    vmov.8 q2[4], r0
; CHECK-NEXT:    vmov.u16 r0, q3[5]
; CHECK-NEXT:    vmov.8 q2[5], r0
; CHECK-NEXT:    vmov.u16 r0, q3[6]
; CHECK-NEXT:    vmov.8 q2[6], r0
; CHECK-NEXT:    vmov.u16 r0, q3[7]
; CHECK-NEXT:    vmov.8 q2[7], r0
; CHECK-NEXT:    vmov.u8 r0, q1[8]
; CHECK-NEXT:    vmov.16 q3[0], r0
; CHECK-NEXT:    vmov.u8 r0, q1[9]
; CHECK-NEXT:    vmov.16 q3[1], r0
; CHECK-NEXT:    vmov.u8 r0, q1[10]
; CHECK-NEXT:    vmov.16 q3[2], r0
; CHECK-NEXT:    vmov.u8 r0, q1[11]
; CHECK-NEXT:    vmov.16 q3[3], r0
; CHECK-NEXT:    vmov.u8 r0, q1[12]
; CHECK-NEXT:    vmov.16 q3[4], r0
; CHECK-NEXT:    vmov.u8 r0, q1[13]
; CHECK-NEXT:    vmov.16 q3[5], r0
; CHECK-NEXT:    vmov.u8 r0, q1[14]
; CHECK-NEXT:    vmov.16 q3[6], r0
; CHECK-NEXT:    vmov.u8 r0, q1[15]
; CHECK-NEXT:    vmov.16 q3[7], r0
; CHECK-NEXT:    vmov.u8 r0, q0[8]
; CHECK-NEXT:    vmov.16 q1[0], r0
; CHECK-NEXT:    vmov.u8 r0, q0[9]
; CHECK-NEXT:    vmov.16 q1[1], r0
; CHECK-NEXT:    vmov.u8 r0, q0[10]
; CHECK-NEXT:    vmov.16 q1[2], r0
; CHECK-NEXT:    vmov.u8 r0, q0[11]
; CHECK-NEXT:    vmov.16 q1[3], r0
; CHECK-NEXT:    vmov.u8 r0, q0[12]
; CHECK-NEXT:    vmov.16 q1[4], r0
; CHECK-NEXT:    vmov.u8 r0, q0[13]
; CHECK-NEXT:    vmov.16 q1[5], r0
; CHECK-NEXT:    vmov.u8 r0, q0[14]
; CHECK-NEXT:    vmov.16 q1[6], r0
; CHECK-NEXT:    vmov.u8 r0, q0[15]
; CHECK-NEXT:    vmov.16 q1[7], r0
; CHECK-NEXT:    vmullb.u8 q0, q1, q3
; CHECK-NEXT:    vshr.u16 q0, q0, #8
; CHECK-NEXT:    vmov.u16 r0, q0[0]
; CHECK-NEXT:    vmov.8 q2[8], r0
; CHECK-NEXT:    vmov.u16 r0, q0[1]
; CHECK-NEXT:    vmov.8 q2[9], r0
; CHECK-NEXT:    vmov.u16 r0, q0[2]
; CHECK-NEXT:    vmov.8 q2[10], r0
; CHECK-NEXT:    vmov.u16 r0, q0[3]
; CHECK-NEXT:    vmov.8 q2[11], r0
; CHECK-NEXT:    vmov.u16 r0, q0[4]
; CHECK-NEXT:    vmov.8 q2[12], r0
; CHECK-NEXT:    vmov.u16 r0, q0[5]
; CHECK-NEXT:    vmov.8 q2[13], r0
; CHECK-NEXT:    vmov.u16 r0, q0[6]
; CHECK-NEXT:    vmov.8 q2[14], r0
; CHECK-NEXT:    vmov.u16 r0, q0[7]
; CHECK-NEXT:    vmov.8 q2[15], r0
; CHECK-NEXT:    vmov q0, q2
; CHECK-NEXT:    bx lr
entry:
  %s0s = zext <16 x i8> %s0 to <16 x i16>
  %s1s = zext <16 x i8> %s1 to <16 x i16>
  %m = mul <16 x i16> %s0s, %s1s
  %s = lshr <16 x i16> %m, <i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8, i16 8>
  %s2 = trunc <16 x i16> %s to <16 x i8>
  ret <16 x i8> %s2
}
