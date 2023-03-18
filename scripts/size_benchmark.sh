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

export RESULT_FOLDER=../results/datasize

mkdir -p ${RESULT_FOLDER}

# all_reduce_perf 8 GPU 
NCCL_ALGO=Ring ../build/all_reduce_perf -b 8 -e 512M -f 2 -g 8 > ./${RESULT_FOLDER}/ring_allreduce_8_GPU.txt

# all_reduce_perf 8 GPU 
NCCL_ALGO=Tree ../build/all_reduce_perf -b 8 -e 512M -f 2 -g 8 > ./${RESULT_FOLDER}/tree_allreduce_8_GPU.txt


