## CPP development environment

### Overview
It is based on CentOS 7.6.1810  

Installed:
* devtoolset-8 (gcc v8.3.1)  
* openssl  
* CMake v3.14.7
* boost v1.71.0
* gtest v1.10.0
* git
* ssh

### Build tool collections
* gcc : /opt/rh/devtoolset-8/root/usr/bin/gcc
* g++ : /opt/rh/devtoolset-8/root/usr/bin/g++
* as : /opt/rh/devtoolset-8/root/usr/bin/as
* make : /opt/rh/devtoolset-8/root/usr/bin/make
* gdb : /opt/rh/devtoolset-8/root/usr/bin/gdb
* cmake : /usr/bin/cmake

### Usage

#### Pull form docker hub
```
docker pull macomfan/cpp_boost
```

#### Start the container
```
docker run -it -v <Your local folder>:<Container folder> -p <Your local IP>:<Port>:22 macomfan/cpp_boost
```

#### Connect the container via SSH
```
ssh root@<Your local IP> -p <Port>
```
Please use root as the login name and the password is "huobi" (quotation mark is not included)
