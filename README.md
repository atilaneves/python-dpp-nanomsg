#  Call nanomsg from Python using D as the glue layer

This repository is an example of using D's powerful metaprogramming features
to enable calling C code from Python without having to write any code at all.

To package all needed dependencies to build and run the example, there is
a [Dockerfile](docker/Dockerfile) but the container doesn't need to be manually
built. Just:

* Run `docker/docker-run.sh`. This will build the Docker container and run bash within it.
* Run `make` as soon as you get a bash prompt in the container. This
will build a Python extension then run [Python
tests](tests/test_nanomsg.py) that call into the nanomsg C library.

That's it. The user code that enables the magic seen in that Python file is 4 lines in
[two](source/app.d) [files](source/nanomsg.dpp).

The library code that enables it is in two [dub](https://code.dlang.org) packages:
[autowrap](https://github.com/symmetryinvestments/autowrap) and
[dpp](https://github.com/atilaneves/dpp).
