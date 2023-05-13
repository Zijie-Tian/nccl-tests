#! /bin/bash

# USAGE: all_reduce_perf
#         [-t,--nthreads <num threads>]
#         [-g,--ngpus <gpus per thread>]
#         [-b,--minbytes <min size in bytes>]
#         [-e,--maxbytes <max size in bytes>]
#         [-i,--stepbytes <increment size>]
#         [-f,--stepfactor <increment factor>]
#         [-n,--iters <iteration count>]
#         [-m,--agg_iters <aggregated iteration count>]
#         [-w,--warmup_iters <warmup iteration count>]
#         [-p,--parallel_init <0/1>]
#         [-c,--check <0/1>]
#         [-o,--op <sum/prod/min/max/avg/mulsum/all>]
#         [-d,--datatype <nccltype/all>]
#         [-r,--root <root>]
#         [-z,--blocking <0/1>]
#         [-y,--stream_null <0/1>]
#         [-T,--timeout <time in seconds>]
#         [-G,--cudagraph <num graph launches>]
#         [-C,--report_cputime <0/1>]
#         [-a,--average <0/1/2/3> report average iteration time <0=RANK0/1=AVG/2=MIN/3=MAX>]
#         [-h,--help]

export RESULT_FOLDER=../results/protocol

mkdir -p ${RESULT_FOLDER}

# all_reduce_perf 8 GPU 
NCCL_ALGO=Ring NCCL_PROTO=Simple nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/simple_nsys \
    ../build/all_reduce_perf -g 4 > ./${RESULT_FOLDER}/simple_4_GPU.txt

# all_reduce_perf 8 GPU 
NCCL_ALGO=Ring NCCL_PROTO=LL nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/LL_nsys \
    ../build/all_reduce_perf -g 4 > ./${RESULT_FOLDER}/LL_4_GPU.txt

# all_reduce_perf 8 GPU 
NCCL_ALGO=Ring NCCL_PROTO=LL128 nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/LL128_nsys \
    ../build/all_reduce_perf -g 4 > ./${RESULT_FOLDER}/LL128_4_GPU.txt



