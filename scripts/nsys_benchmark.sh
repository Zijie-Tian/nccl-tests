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

export RESULT_FOLDER=../results/nsys

mkdir -p ${RESULT_FOLDER}

# # all_reduce_perf 8 GPU 
# NCCL_ALGO=Ring nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/ring_nsys \
#     ../build/all_reduce_perf -g 8 > ./${RESULT_FOLDER}/ring_allreduce_8_GPU.txt

# # all_reduce_perf 8 GPU 
# NCCL_ALGO=Tree nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/tree_nsys \
#     ../build/all_reduce_perf -g 8 > ./${RESULT_FOLDER}/tree_allreduce_8_GPU.txt

# all_reduce_perf 8 GPU 
NCCL_ALGO=Ring nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/ring_fact_8_nsys \
    mpirun.openmpi -np 8 ../build/all_reduce_perf -g 1 -b 1M -e 16M -f 2 > ./${RESULT_FOLDER}/ring_allreduce_fact_8_GPU.txt

# all_reduce_perf 8 GPU 
NCCL_ALGO=Tree nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/tree_fact_8_nsys \
    mpirun.openmpi -np 8 ../build/all_reduce_perf -g 1 -b 1M -e 16M -f 2 > ./${RESULT_FOLDER}/tree_allreduce_fact_8_GPU.txt

# all_reduce_perf 4 GPU 
NCCL_ALGO=Ring nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/ring_fact_4_nsys \
    mpirun.openmpi -np 4 ../build/all_reduce_perf -g 1 -b 1M -e 16M -f 2 > ./${RESULT_FOLDER}/ring_allreduce_fact_4_GPU.txt

# all_reduce_perf 4 GPU 
NCCL_ALGO=Tree nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/tree_fact_4_nsys \
    mpirun.openmpi -np 4 ../build/all_reduce_perf -g 1 -b 1M -e 16M -f 2 > ./${RESULT_FOLDER}/tree_allreduce_fact_4_GPU.txt

# all_reduce_perf 2 GPU 
NCCL_ALGO=Ring nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/ring_fact_2_nsys \
    mpirun.openmpi -np 2 ../build/all_reduce_perf -g 1 -b 1M -e 16M -f 2 > ./${RESULT_FOLDER}/ring_allreduce_fact_2_GPU.txt

# all_reduce_perf 2 GPU 
NCCL_ALGO=Tree nsys profile --wait primary --force-overwrite true -o ${RESULT_FOLDER}/tree_fact_2_nsys \
    mpirun.openmpi -np 2 ../build/all_reduce_perf -g 1 -b 1M -e 16M -f 2 > ./${RESULT_FOLDER}/tree_allreduce_fact_2_GPU.txt




