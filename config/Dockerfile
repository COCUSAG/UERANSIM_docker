FROM ubuntu:bionic

RUN apt-get update -y && \
    apt-get upgrade -y &&\
    apt install make g++ libsctp-dev lksctp-tools iproute2 wget git vim -y
RUN wget -qO- "https://cmake.org/files/v3.19/cmake-3.19.0-Linux-x86_64.tar.gz" | tar --strip-components=1 -xz -C /usr/local

RUN apt-get update && \
    apt-get upgrade -y

#Clone and build UERANSIM
RUN git clone https://github.com/aligungr/UERANSIM.git
WORKDIR /UERANSIM
RUN make

RUN apt-get install iputils-ping -y

CMD /mnt/ueransim/ueransim_init.sh --allow-root


