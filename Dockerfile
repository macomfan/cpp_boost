FROM centos:7.6.1810

MAINTAINER Wenrui Ma <macomfan@163.com>
# Install openssl ssh
RUN yum install -y openssl openssl-devel && \
    yum install -y openssh-server net-tools && \
    yum clean all -y

RUN yum install -y wget git && \
    yum clean all -y

# Config ssh
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key &&\
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_ed25519_key && \
    echo "password" | passwd --stdin root
    
# Install devtoolset-8, python
RUN yum install -y centos-release-scl && \
    yum install -y devtoolset-8 && \
    yum install -y python-devel && \
    yum clean all -y
    
# Install CMake v3.14.7
RUN cd /usr &&\
    wget https://cmake.org/files/v3.14/cmake-3.14.7-Linux-x86_64.sh && \
    sh /usr/cmake-3.14.7-Linux-x86_64.sh --skip-license &&\
    rm -f /usr/cmake-3.14.7-Linux-x86_64.sh
ENV PATH=$PATH:/bin/:/usr/bin/

# Install Boost v1.71.0
RUN wget https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz && \
    tar -xzvf boost_1_71_0.tar.gz && rm -f boost_1_71_0.tar.gz && \
    scl enable devtoolset-8 bash && \
    cd boost_1_71_0 && \
    sh bootstrap.sh && \
    ./b2 install --build-dir=/tmp/build-boost && \
    rm -rf /tmp/build-boost

# Install gtest
RUN scl enable devtoolset-8 bash && \
    git clone --branch release-1.10.0 https://github.com/google/googletest.git /root/googletest-1.10.0 && \
    cd /root/googletest-1.10.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && make install && \
    cd .. && rm -rf build
    
WORKDIR /root
COPY run.sh /usr/local/bin/run.sh
RUN echo "scl enable devtoolset-8 bash" >> /root/.bashrc

EXPOSE 22
ENTRYPOINT ["sh", "run.sh"]