FROM tensorflow/tensorflow:2.2.1-gpu-py3-jupyter
LABEL maintainer="JS"

# 无需等待用户输入
ENV DEBIAN_FRONTEND noninteractive

ENV USERNAME="user"
ENV USER_HOME="/home/${USERNAME}"

# 创建用户
RUN apt-get update &&  \
    apt-get install -y sudo tree && \
    adduser --disabled-password --gecos '' ${USERNAME} && \
    adduser ${USERNAME} sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

WORKDIR ${USER_HOME}

# 安装 深度学习包
RUN pip3 install numpy pandas sklearn matplotlib seaborn pyyaml h5py && \
    pip3 install keras --no-deps && \
    pip3 install opencv-python && \
    pip3 install imutils && \
    mkdir notebooks

# jupyter config
COPY conf/.jupyter ${USER_HOME}/.jupyter
COPY run_jupyter.sh /

# Jupyter and Tensorboard ports
EXPOSE 8888 6006

# Store $USER_HOME in this mounted directory
VOLUME "$USER_HOME"

USER "${USERNAME}"

CMD ["/run_jupyter.sh"]