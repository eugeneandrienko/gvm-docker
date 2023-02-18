FROM oraclelinux:6

# Install supplementary packages:
RUN yum install -y wget \
                   unzip \
                   tar \
                   glibc.i686 \
                   gtk2.i686 \
                   alsa-lib.i686 \
                   dejavu-sans-fonts \
                   xhost

RUN adduser -m gvm && \
    mkdir /home/gvm/images

VOLUME /home/gvm/images
USER gvm
WORKDIR /home/gvm

# Download and install Garnet VM:
RUN wget -c --no-check-certificate \
        https://palmdb.net/content/files/tools-emu/garnet-vm/gvm_dev_kit.zip && \
    unzip gvm_dev_kit.zip && \
    tar xf gvm_dev_kit.tar && \
    rm -fv gvm_dev_kit.zip gvm_dev_kit.tar

CMD ["/home/gvm/bin/linux_rel/gvm", "-G", "/home/gvm/bin/linux_rel/LINUX_X86_GVM_EFIGS_All_Dev_Release.rom"]
HEALTHCHECK --interval=10s --timeout=10s --start-period=10s --retries=2 \
    CMD pgrep gvm
