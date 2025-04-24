FROM nvidia/cuda:12.8.1-devel-ubuntu22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl wget \
        ocl-icd-libopencl1 \
        opencl-headers \
        nano \
        build-essential \
        clinfo pkg-config && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

RUN ln -s /usr/local/cuda/lib64/libOpenCL.so.1 /usr/lib/libOpenCL.so

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH=/usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
