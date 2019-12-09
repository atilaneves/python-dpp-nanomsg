FROM archlinux/base
ADD mirrorlist /etc/pacman.d/mirrorlist
RUN pacman --noconfirm -Syu && pacman -S --noconfirm --needed make dlang python-pip nanomsg clang && pip install pytest
