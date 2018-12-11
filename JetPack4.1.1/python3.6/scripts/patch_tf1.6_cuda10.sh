#!/bin/bash
#https://github.com/tensorflow/tensorflow/issues/19203
#./tensorflow/core/kernels/gather_functor_gpu.cu.h(57): error: calling a __host__ function("__builtin_expect") from a __global__ function("tensorflow::GatherOpKernel< ::Eigen::half, int, (bool)1> ") is not allowed

# sed
# input escape characters \'$.*/[]^
# 1. Write the regex between single quotes.
# 2. \ -> \\
# 3. ' -> '\''
# 4. Put a backslash before $.*/[]^ and only those characters.
# output escape characters &|
# 1. Put a backslash before &| and only those characters.



# before:
#  __shared__ value_type partial_sums[32 * 33];
# after:
#  value_type partial_sums[32 * 33];

TARGET=/compile/tensorflow/tensorflow/core/kernels/reduction_gpu_kernels.cu.h

BEFORE="  __shared__ value_type partial_sums\[32 \* 33\];"
AFTER="  value_type partial_sums[32 * 33];"

sed -i 's/^'"${BEFORE}"'$/'"${AFTER}"'/g' $TARGET
