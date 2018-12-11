########################################
# patch CUDA GL ARM for OpenCV Build
########################################
# https://devtalk.nvidia.com/default/topic/1007290/building-opencv-with-opengl-support-/
# #error Please include the appropriate gl headers before including cuda_gl_interop.h
# OpenCV make中にエラーが発生するため、cudaヘッダを書き換える
patch -u -p0 /usr/local/cuda/include/cuda_gl_interop.h < patch_cuda_gl.patch 
