#! /bin/bash

# USAGE: all_gather_perf
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

export NCCL_ALGO=RING
export RESULT_FOLDER=../results/topo_size

mkdir -p ${RESULT_FOLDER}

rm -f ${RESULT_FOLDER}/*

../build/all_gather_perf -g 8 -b 512 -e 1M -f 2 > ./${RESULT_FOLDER}/ring_allreduce_8_GPU.txt




