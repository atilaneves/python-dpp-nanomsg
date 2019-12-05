def test_push_pull():
    from nanomsg import (nn_socket, nn_close, nn_bind, nn_connect,
                         nn_send, nn_recv,
                         AF_SP, NN_PUSH, NN_PULL)
    import time

    uri = "inproc://test"

    pull = nn_socket(AF_SP, NN_PULL)
    raise_on_nanomsg_error(pull)
    raise_on_nanomsg_error(nn_bind(pull, uri))
    time.sleep(0.05)

    push = nn_socket(AF_SP, NN_PUSH)
    raise_on_nanomsg_error(push)
    raise_on_nanomsg_error(nn_connect(push, uri))
    msg = b'abc'
    assert nn_send(push, msg, len(msg), 0) == len(msg)

    time.sleep(0.05)
    # horrible but works, essentially unsigned char buf[100]
    buf = 100 * b'o'
    assert nn_recv(pull, buf, len(buf), 0) == len(msg)
    assert buf[0:len(msg)] == msg

    raise_on_nanomsg_error(nn_close(push))
    raise_on_nanomsg_error(nn_close(pull))


def raise_on_nanomsg_error(errorcode):
    from nanomsg import nn_strerror
    import ctypes

    if errorcode < 0:
        raise RuntimeError(nn_strerror(ctypes.get_errno()))
