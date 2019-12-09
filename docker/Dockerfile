FROM archlinux/base
ADD mirrorlist /etc/pacman.d/mirrorlist
WORKDIR /project
RUN pacman --noconfirm -Syu && pacman -S --noconfirm --needed make dlang python-pip nanomsg clang && pip install pytest && dub fetch dpp --version=0.4.0 && dub fetch autowrap --version=0.5.1
