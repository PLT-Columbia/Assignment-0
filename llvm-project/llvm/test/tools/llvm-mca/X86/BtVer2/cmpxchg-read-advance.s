# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -iterations=1 -timeline < %s | FileCheck %s

# LLVM-MCA-BEGIN
imul %rax, %rax
cmpxchgq %rcx, (%rdx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %rcx, %rcx
cmpxchgq %rcx, (%rdx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %rax, %rax
lock cmpxchgq %rcx, (%rdx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %rcx, %rcx
lock cmpxchgq %rcx, (%rdx)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %eax, %eax
imul %edx, %edx
cmpxchg8b (%rsp)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %eax, %eax
imul %edx, %edx
cmpxchg16b (%rsp)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %ebx, %ebx
imul %ecx, %ecx
lock cmpxchg8b (%rsp)
# LLVM-MCA-END

# LLVM-MCA-BEGIN
imul %ebx, %ebx
imul %ecx, %ecx
lock cmpxchg16b (%rsp)
# LLVM-MCA-END

# CHECK:      [0] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      2
# CHECK-NEXT: Total Cycles:      17
# CHECK-NEXT: Total uOps:        7

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.41
# CHECK-NEXT: IPC:               0.12
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      6     4.00                        imulq	%rax, %rax
# CHECK-NEXT:  6      11    1.50    *      *            cmpxchgq	%rcx, (%rdx)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 3.00   1.00    -      -      -      -      -     1.00   4.00   1.00    -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     4.00    -      -      -      -      -     imulq	%rax, %rax
# CHECK-NEXT: 3.00    -      -      -      -      -      -     1.00    -     1.00    -      -      -      -     cmpxchgq	%rcx, (%rdx)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DeeeeeeER .    ..   imulq	%rax, %rax
# CHECK-NEXT: [0,1]     .D==eeeeeeeeeeeER   cmpxchgq	%rcx, (%rdx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imulq	%rax, %rax
# CHECK-NEXT: 1.     1     3.0    0.0    0.0       cmpxchgq	%rcx, (%rdx)
# CHECK-NEXT:        1     2.0    0.5    0.0       <total>

# CHECK:      [1] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      2
# CHECK-NEXT: Total Cycles:      17
# CHECK-NEXT: Total uOps:        7

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.41
# CHECK-NEXT: IPC:               0.12
# CHECK-NEXT: Block RThroughput: 4.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      6     4.00                        imulq	%rcx, %rcx
# CHECK-NEXT:  6      11    1.50    *      *            cmpxchgq	%rcx, (%rdx)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 3.00   1.00    -      -      -      -      -     1.00   4.00   1.00    -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     4.00    -      -      -      -      -     imulq	%rcx, %rcx
# CHECK-NEXT: 3.00    -      -      -      -      -      -     1.00    -     1.00    -      -      -      -     cmpxchgq	%rcx, (%rdx)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DeeeeeeER .    ..   imulq	%rcx, %rcx
# CHECK-NEXT: [0,1]     .D==eeeeeeeeeeeER   cmpxchgq	%rcx, (%rdx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imulq	%rcx, %rcx
# CHECK-NEXT: 1.     1     3.0    0.0    0.0       cmpxchgq	%rcx, (%rdx)
# CHECK-NEXT:        1     2.0    0.5    0.0       <total>

# CHECK:      [2] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      2
# CHECK-NEXT: Total Cycles:      23
# CHECK-NEXT: Total uOps:        7

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.30
# CHECK-NEXT: IPC:               0.09
# CHECK-NEXT: Block RThroughput: 17.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      6     4.00                        imulq	%rax, %rax
# CHECK-NEXT:  6      17    17.00   *      *            lock		cmpxchgq	%rcx, (%rdx)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 3.00   1.00    -      -      -      -      -     17.00  4.00   17.00   -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     4.00    -      -      -      -      -     imulq	%rax, %rax
# CHECK-NEXT: 3.00    -      -      -      -      -      -     17.00   -     17.00   -      -      -      -     lock		cmpxchgq	%rcx, (%rdx)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          012

# CHECK:      [0,0]     DeeeeeeER .    .    . .   imulq	%rax, %rax
# CHECK-NEXT: [0,1]     .D==eeeeeeeeeeeeeeeeeER   lock		cmpxchgq	%rcx, (%rdx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imulq	%rax, %rax
# CHECK-NEXT: 1.     1     3.0    0.0    0.0       lock		cmpxchgq	%rcx, (%rdx)
# CHECK-NEXT:        1     2.0    0.5    0.0       <total>

# CHECK:      [3] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      2
# CHECK-NEXT: Total Cycles:      23
# CHECK-NEXT: Total uOps:        7

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.30
# CHECK-NEXT: IPC:               0.09
# CHECK-NEXT: Block RThroughput: 17.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      6     4.00                        imulq	%rcx, %rcx
# CHECK-NEXT:  6      17    17.00   *      *            lock		cmpxchgq	%rcx, (%rdx)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 3.00   1.00    -      -      -      -      -     17.00  4.00   17.00   -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     4.00    -      -      -      -      -     imulq	%rcx, %rcx
# CHECK-NEXT: 3.00    -      -      -      -      -      -     17.00   -     17.00   -      -      -      -     lock		cmpxchgq	%rcx, (%rdx)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          012

# CHECK:      [0,0]     DeeeeeeER .    .    . .   imulq	%rcx, %rcx
# CHECK-NEXT: [0,1]     .D==eeeeeeeeeeeeeeeeeER   lock		cmpxchgq	%rcx, (%rdx)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imulq	%rcx, %rcx
# CHECK-NEXT: 1.     1     3.0    0.0    0.0       lock		cmpxchgq	%rcx, (%rdx)
# CHECK-NEXT:        1     2.0    0.5    0.0       <total>

# CHECK:      [4] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      3
# CHECK-NEXT: Total Cycles:      15
# CHECK-NEXT: Total uOps:        20

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    1.33
# CHECK-NEXT: IPC:               0.20
# CHECK-NEXT: Block RThroughput: 10.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%eax, %eax
# CHECK-NEXT:  1      3     1.00                        imull	%edx, %edx
# CHECK-NEXT:  18     11    1.50    *      *            cmpxchg8b	(%rsp)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 3.00   2.00    -      -      -      -      -     1.00   2.00   1.00    -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%eax, %eax
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%edx, %edx
# CHECK-NEXT: 3.00    -      -      -      -      -      -     1.00    -     1.00    -      -      -      -     cmpxchg8b	(%rsp)

# CHECK:      Timeline view:
# CHECK-NEXT:                     01234
# CHECK-NEXT: Index     0123456789

# CHECK:      [0,0]     DeeeER    .   .   imull	%eax, %eax
# CHECK-NEXT: [0,1]     D=eeeER   .   .   imull	%edx, %edx
# CHECK-NEXT: [0,2]     .DeeeeeeeeeeeER   cmpxchg8b	(%rsp)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imull	%eax, %eax
# CHECK-NEXT: 1.     1     2.0    2.0    0.0       imull	%edx, %edx
# CHECK-NEXT: 2.     1     1.0    0.0    0.0       cmpxchg8b	(%rsp)
# CHECK-NEXT:        1     1.3    1.0    0.0       <total>

# CHECK:      [5] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      3
# CHECK-NEXT: Total Cycles:      36
# CHECK-NEXT: Total uOps:        30

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.83
# CHECK-NEXT: IPC:               0.08
# CHECK-NEXT: Block RThroughput: 15.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%eax, %eax
# CHECK-NEXT:  1      3     1.00                        imull	%edx, %edx
# CHECK-NEXT:  28     32    3.00    *      *            cmpxchg16b	(%rsp)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 6.00   2.00    -      -      -      -      -     1.00   2.00   1.00    -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%eax, %eax
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%edx, %edx
# CHECK-NEXT: 6.00    -      -      -      -      -      -     1.00    -     1.00    -      -      -      -     cmpxchg16b	(%rsp)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          012345
# CHECK-NEXT: Index     0123456789          0123456789

# CHECK:      [0,0]     DeeeER    .    .    .    .    .    .   imull	%eax, %eax
# CHECK-NEXT: [0,1]     D=eeeER   .    .    .    .    .    .   imull	%edx, %edx
# CHECK-NEXT: [0,2]     .DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeER   cmpxchg16b	(%rsp)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imull	%eax, %eax
# CHECK-NEXT: 1.     1     2.0    2.0    0.0       imull	%edx, %edx
# CHECK-NEXT: 2.     1     1.0    0.0    0.0       cmpxchg16b	(%rsp)
# CHECK-NEXT:        1     1.3    1.0    0.0       <total>

# CHECK:      [6] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      3
# CHECK-NEXT: Total Cycles:      23
# CHECK-NEXT: Total uOps:        20

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.87
# CHECK-NEXT: IPC:               0.13
# CHECK-NEXT: Block RThroughput: 19.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%ebx, %ebx
# CHECK-NEXT:  1      3     1.00                        imull	%ecx, %ecx
# CHECK-NEXT:  18     19    19.00   *      *            lock		cmpxchg8b	(%rsp)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 3.00   2.00    -      -      -      -      -     19.00  2.00   19.00   -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%ebx, %ebx
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%ecx, %ecx
# CHECK-NEXT: 3.00    -      -      -      -      -      -     19.00   -     19.00   -      -      -      -     lock		cmpxchg8b	(%rsp)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789
# CHECK-NEXT: Index     0123456789          012

# CHECK:      [0,0]     DeeeER    .    .    . .   imull	%ebx, %ebx
# CHECK-NEXT: [0,1]     D=eeeER   .    .    . .   imull	%ecx, %ecx
# CHECK-NEXT: [0,2]     .DeeeeeeeeeeeeeeeeeeeER   lock		cmpxchg8b	(%rsp)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imull	%ebx, %ebx
# CHECK-NEXT: 1.     1     2.0    2.0    0.0       imull	%ecx, %ecx
# CHECK-NEXT: 2.     1     1.0    0.0    0.0       lock		cmpxchg8b	(%rsp)
# CHECK-NEXT:        1     1.3    1.0    0.0       <total>

# CHECK:      [7] Code Region

# CHECK:      Iterations:        1
# CHECK-NEXT: Instructions:      3
# CHECK-NEXT: Total Cycles:      42
# CHECK-NEXT: Total uOps:        30

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.71
# CHECK-NEXT: IPC:               0.07
# CHECK-NEXT: Block RThroughput: 38.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  1      3     1.00                        imull	%ebx, %ebx
# CHECK-NEXT:  1      3     1.00                        imull	%ecx, %ecx
# CHECK-NEXT:  28     38    38.00   *      *            lock		cmpxchg16b	(%rsp)

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT: 6.00   2.00    -      -      -      -      -     38.00  2.00   38.00   -      -      -      -

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%ebx, %ebx
# CHECK-NEXT:  -     1.00    -      -      -      -      -      -     1.00    -      -      -      -      -     imull	%ecx, %ecx
# CHECK-NEXT: 6.00    -      -      -      -      -      -     38.00   -     38.00   -      -      -      -     lock		cmpxchg16b	(%rsp)

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0123456789
# CHECK-NEXT: Index     0123456789          0123456789          01

# CHECK:      [0,0]     DeeeER    .    .    .    .    .    .    ..   imull	%ebx, %ebx
# CHECK-NEXT: [0,1]     D=eeeER   .    .    .    .    .    .    ..   imull	%ecx, %ecx
# CHECK-NEXT: [0,2]     .DeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeER   lock		cmpxchg16b	(%rsp)

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     1     1.0    1.0    0.0       imull	%ebx, %ebx
# CHECK-NEXT: 1.     1     2.0    2.0    0.0       imull	%ecx, %ecx
# CHECK-NEXT: 2.     1     1.0    0.0    0.0       lock		cmpxchg16b	(%rsp)
# CHECK-NEXT:        1     1.3    1.0    0.0       <total>
