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

export NCCL_ALGO=Ring
export DEBUG_LEVEL=DEBUG
export RESULT_FOLDER=../results/topo_size
export MSG_SIZE=1G

mkdir -p ${RESULT_FOLDER}

# rm -f ${RESULT_FOLDER}/*

# all_reduce_perf 2 GPU 
CUDA_VISIBLE_DEVICES=0,1 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 2 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_2_${MSG_SIZE}_GPU.txt

# all_reduce_perf 3 GPU 
CUDA_VISIBLE_DEVICES=0,1,2 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 3 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_3_${MSG_SIZE}_GPU.txt

# all_reduce_perf 4 GPU 
CUDA_VISIBLE_DEVICES=0,1,2,3 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 4 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_4_${MSG_SIZE}_GPU.txt

# all_reduce_perf 5 GPU 
CUDA_VISIBLE_DEVICES=0,1,2,3,4 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 5 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_5_${MSG_SIZE}_GPU.txt

# all_reduce_perf 6 GPU 
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 6 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_6_${MSG_SIZE}_GPU.txt

# all_reduce_perf 7 GPU 
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 7 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_7_${MSG_SIZE}_GPU.txt

# all_reduce_perf 8 GPU 
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 NCCL_DEBUG=${DEBUG_LEVEL} NCCL_DEBUG_SUBSYS=GRAPH NCCL_ALGO=Ring \
    mpirun.openmpi -np 8 ../build/all_reduce_perf -b ${MSG_SIZE} -e ${MSG_SIZE} -g 1 > ./${RESULT_FOLDER}/ring_allreduce_8_${MSG_SIZE}_GPU.txt



