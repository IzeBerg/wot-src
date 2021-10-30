from __future__ import print_function, unicode_literals
import os, abc, codecs, warnings, errno
try:
    from thread import allocate_lock as Lock
except ImportError:
    from dummy_thread import allocate_lock as Lock

import io
from io import __all__, SEEK_SET, SEEK_CUR, SEEK_END
from errno import EINTR
__metaclass__ = type
DEFAULT_BUFFER_SIZE = 8 * 1024

class BlockingIOError(IOError):

    def __init__(self, errno, strerror, characters_written=0):
        super(IOError, self).__init__(errno, strerror)
        if not isinstance(characters_written, (int, long)):
            raise TypeError(b'characters_written must be a integer')
        self.characters_written = characters_written


def open(file, mode=b'r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True):
    if not isinstance(file, (basestring, int, long)):
        raise TypeError(b'invalid file: %r' % file)
    if not isinstance(mode, basestring):
        raise TypeError(b'invalid mode: %r' % mode)
    if not isinstance(buffering, (int, long)):
        raise TypeError(b'invalid buffering: %r' % buffering)
    if encoding is not None and not isinstance(encoding, basestring):
        raise TypeError(b'invalid encoding: %r' % encoding)
    if errors is not None and not isinstance(errors, basestring):
        raise TypeError(b'invalid errors: %r' % errors)
    modes = set(mode)
    if modes - set(b'arwb+tU') or len(mode) > len(modes):
        raise ValueError(b'invalid mode: %r' % mode)
    reading = b'r' in modes
    writing = b'w' in modes
    appending = b'a' in modes
    updating = b'+' in modes
    text = b't' in modes
    binary = b'b' in modes
    if b'U' in modes:
        if writing or appending:
            raise ValueError(b"can't use U and writing mode at once")
        reading = True
    if text and binary:
        raise ValueError(b"can't have text and binary mode at once")
    if reading + writing + appending > 1:
        raise ValueError(b"can't have read/write/append mode at once")
    if not (reading or writing or appending):
        raise ValueError(b'must have exactly one of read/write/append mode')
    if binary and encoding is not None:
        raise ValueError(b"binary mode doesn't take an encoding argument")
    if binary and errors is not None:
        raise ValueError(b"binary mode doesn't take an errors argument")
    if binary and newline is not None:
        raise ValueError(b"binary mode doesn't take a newline argument")
    raw = FileIO(file, (reading and b'r' or b'') + (writing and b'w' or b'') + (appending and b'a' or b'') + (updating and b'+' or b''), closefd)
    line_buffering = False
    if buffering == 1 or buffering < 0 and raw.isatty():
        buffering = -1
        line_buffering = True
    if buffering < 0:
        buffering = DEFAULT_BUFFER_SIZE
        try:
            bs = os.fstat(raw.fileno()).st_blksize
        except (os.error, AttributeError):
            pass
        else:
            if bs > 1:
                buffering = bs
    if buffering < 0:
        raise ValueError(b'invalid buffering size')
    if buffering == 0:
        if binary:
            return raw
        raise ValueError(b"can't have unbuffered text I/O")
    if updating:
        buffer = BufferedRandom(raw, buffering)
    elif writing or appending:
        buffer = BufferedWriter(raw, buffering)
    elif reading:
        buffer = BufferedReader(raw, buffering)
    else:
        raise ValueError(b'unknown mode: %r' % mode)
    if binary:
        return buffer
    else:
        text = TextIOWrapper(buffer, encoding, errors, newline, line_buffering)
        text.mode = mode
        return text


class DocDescriptor():

    def __get__(self, obj, typ):
        return b"open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True)\n\n" + open.__doc__


class OpenWrapper():
    __doc__ = DocDescriptor()

    def __new__(cls, *args, **kwargs):
        return open(*args, **kwargs)


class UnsupportedOperation(ValueError, IOError):
    pass


class IOBase():
    __metaclass__ = abc.ABCMeta

    def _unsupported(self, name):
        raise UnsupportedOperation(b'%s.%s() not supported' % (
         self.__class__.__name__, name))

    def seek(self, pos, whence=0):
        self._unsupported(b'seek')

    def tell(self):
        return self.seek(0, 1)

    def truncate(self, pos=None):
        self._unsupported(b'truncate')

    def flush(self):
        self._checkClosed()

    __closed = False

    def close(self):
        if not self.__closed:
            try:
                self.flush()
            finally:
                self.__closed = True

    def __del__(self):
        try:
            self.close()
        except:
            pass

    def seekable(self):
        return False

    def _checkSeekable(self, msg=None):
        if not self.seekable():
            raise IOError(b'File or stream is not seekable.' if msg is None else msg)
        return

    def readable(self):
        return False

    def _checkReadable(self, msg=None):
        if not self.readable():
            raise IOError(b'File or stream is not readable.' if msg is None else msg)
        return

    def writable(self):
        return False

    def _checkWritable(self, msg=None):
        if not self.writable():
            raise IOError(b'File or stream is not writable.' if msg is None else msg)
        return

    @property
    def closed(self):
        return self.__closed

    def _checkClosed(self, msg=None):
        if self.closed:
            raise ValueError(b'I/O operation on closed file.' if msg is None else msg)
        return

    def __enter__(self):
        self._checkClosed()
        return self

    def __exit__(self, *args):
        self.close()

    def fileno(self):
        self._unsupported(b'fileno')

    def isatty(self):
        self._checkClosed()
        return False

    def readline(self, limit=-1):
        if hasattr(self, b'peek'):

            def nreadahead():
                readahead = self.peek(1)
                if not readahead:
                    return 1
                n = readahead.find(b'\n') + 1 or len(readahead)
                if limit >= 0:
                    n = min(n, limit)
                return n

        else:

            def nreadahead():
                return 1

        if limit is None:
            limit = -1
        else:
            if not isinstance(limit, (int, long)):
                raise TypeError(b'limit must be an integer')
            res = bytearray()
            while limit < 0 or len(res) < limit:
                b = self.read(nreadahead())
                if not b:
                    break
                res += b
                if res.endswith(b'\n'):
                    break

        return bytes(res)

    def __iter__(self):
        self._checkClosed()
        return self

    def next(self):
        line = self.readline()
        if not line:
            raise StopIteration
        return line

    def readlines(self, hint=None):
        if hint is not None and not isinstance(hint, (int, long)):
            raise TypeError(b'integer or None expected')
        if hint is None or hint <= 0:
            return list(self)
        else:
            n = 0
            lines = []
            for line in self:
                lines.append(line)
                n += len(line)
                if n >= hint:
                    break

            return lines

    def writelines(self, lines):
        self._checkClosed()
        for line in lines:
            self.write(line)


io.IOBase.register(IOBase)

class RawIOBase(IOBase):

    def read(self, n=-1):
        if n is None:
            n = -1
        if n < 0:
            return self.readall()
        else:
            b = bytearray(n.__index__())
            n = self.readinto(b)
            if n is None:
                return
            del b[n:]
            return bytes(b)

    def readall(self):
        res = bytearray()
        while True:
            data = self.read(DEFAULT_BUFFER_SIZE)
            if not data:
                break
            res += data

        if res:
            return bytes(res)
        else:
            return data

    def readinto(self, b):
        self._unsupported(b'readinto')

    def write(self, b):
        self._unsupported(b'write')


io.RawIOBase.register(RawIOBase)
from _io import FileIO
RawIOBase.register(FileIO)

class BufferedIOBase(IOBase):

    def read(self, n=None):
        self._unsupported(b'read')

    def read1(self, n=None):
        self._unsupported(b'read1')

    def readinto(self, b):
        data = self.read(len(b))
        n = len(data)
        try:
            b[:n] = data
        except TypeError as err:
            import array
            if not isinstance(b, array.array):
                raise err
            b[:n] = array.array(b'b', data)

        return n

    def write(self, b):
        self._unsupported(b'write')

    def detach(self):
        self._unsupported(b'detach')


io.BufferedIOBase.register(BufferedIOBase)

class _BufferedIOMixin(BufferedIOBase):

    def __init__(self, raw):
        self._raw = raw

    def seek(self, pos, whence=0):
        new_position = self.raw.seek(pos, whence)
        if new_position < 0:
            raise IOError(b'seek() returned an invalid position')
        return new_position

    def tell(self):
        pos = self.raw.tell()
        if pos < 0:
            raise IOError(b'tell() returned an invalid position')
        return pos

    def truncate(self, pos=None):
        self.flush()
        if pos is None:
            pos = self.tell()
        return self.raw.truncate(pos)

    def flush(self):
        if self.closed:
            raise ValueError(b'flush of closed file')
        self.raw.flush()

    def close(self):
        if self.raw is not None and not self.closed:
            try:
                self.flush()
            finally:
                self.raw.close()

        return

    def detach(self):
        if self.raw is None:
            raise ValueError(b'raw stream already detached')
        self.flush()
        raw = self._raw
        self._raw = None
        return raw

    def seekable(self):
        return self.raw.seekable()

    def readable(self):
        return self.raw.readable()

    def writable(self):
        return self.raw.writable()

    @property
    def raw(self):
        return self._raw

    @property
    def closed(self):
        return self.raw.closed

    @property
    def name(self):
        return self.raw.name

    @property
    def mode(self):
        return self.raw.mode

    def __repr__(self):
        clsname = self.__class__.__name__
        try:
            name = self.name
        except AttributeError:
            return (b'<_pyio.{0}>').format(clsname)

        return (b'<_pyio.{0} name={1!r}>').format(clsname, name)

    def fileno(self):
        return self.raw.fileno()

    def isatty(self):
        return self.raw.isatty()


class BytesIO(BufferedIOBase):

    def __init__(self, initial_bytes=None):
        buf = bytearray()
        if initial_bytes is not None:
            buf.extend(initial_bytes)
        self._buffer = buf
        self._pos = 0
        return

    def __getstate__(self):
        if self.closed:
            raise ValueError(b'__getstate__ on closed file')
        return self.__dict__.copy()

    def getvalue(self):
        if self.closed:
            raise ValueError(b'getvalue on closed file')
        return bytes(self._buffer)

    def read(self, n=None):
        if self.closed:
            raise ValueError(b'read from closed file')
        if n is None:
            n = -1
        if not isinstance(n, (int, long)):
            raise TypeError((b'integer argument expected, got {0!r}').format(type(n)))
        if n < 0:
            n = len(self._buffer)
        if len(self._buffer) <= self._pos:
            return b''
        else:
            newpos = min(len(self._buffer), self._pos + n)
            b = self._buffer[self._pos:newpos]
            self._pos = newpos
            return bytes(b)

    def read1(self, n):
        return self.read(n)

    def write(self, b):
        if self.closed:
            raise ValueError(b'write to closed file')
        if isinstance(b, unicode):
            raise TypeError(b"can't write unicode to binary stream")
        n = len(b)
        if n == 0:
            return 0
        pos = self._pos
        if pos > len(self._buffer):
            padding = b'\x00' * (pos - len(self._buffer))
            self._buffer += padding
        self._buffer[pos:(pos + n)] = b
        self._pos += n
        return n

    def seek(self, pos, whence=0):
        if self.closed:
            raise ValueError(b'seek on closed file')
        try:
            pos.__index__
        except AttributeError:
            raise TypeError(b'an integer is required')

        if whence == 0:
            if pos < 0:
                raise ValueError(b'negative seek position %r' % (pos,))
            self._pos = pos
        elif whence == 1:
            self._pos = max(0, self._pos + pos)
        elif whence == 2:
            self._pos = max(0, len(self._buffer) + pos)
        else:
            raise ValueError(b'invalid whence value')
        return self._pos

    def tell(self):
        if self.closed:
            raise ValueError(b'tell on closed file')
        return self._pos

    def truncate(self, pos=None):
        if self.closed:
            raise ValueError(b'truncate on closed file')
        if pos is None:
            pos = self._pos
        else:
            try:
                pos.__index__
            except AttributeError:
                raise TypeError(b'an integer is required')

        if pos < 0:
            raise ValueError(b'negative truncate position %r' % (pos,))
        del self._buffer[pos:]
        return pos

    def readable(self):
        if self.closed:
            raise ValueError(b'I/O operation on closed file.')
        return True

    def writable(self):
        if self.closed:
            raise ValueError(b'I/O operation on closed file.')
        return True

    def seekable(self):
        if self.closed:
            raise ValueError(b'I/O operation on closed file.')
        return True


class BufferedReader(_BufferedIOMixin):

    def __init__(self, raw, buffer_size=DEFAULT_BUFFER_SIZE):
        if not raw.readable():
            raise IOError(b'"raw" argument must be readable.')
        _BufferedIOMixin.__init__(self, raw)
        if buffer_size <= 0:
            raise ValueError(b'invalid buffer size')
        self.buffer_size = buffer_size
        self._reset_read_buf()
        self._read_lock = Lock()

    def _reset_read_buf(self):
        self._read_buf = b''
        self._read_pos = 0

    def read(self, n=None):
        if n is not None and n < -1:
            raise ValueError(b'invalid number of bytes to read')
        with self._read_lock:
            return self._read_unlocked(n)
        return

    def _read_unlocked(self, n=None):
        nodata_val = b''
        empty_values = ('', None)
        buf = self._read_buf
        pos = self._read_pos
        if n is None or n == -1:
            self._reset_read_buf()
            chunks = [buf[pos:]]
            current_size = 0
            while True:
                try:
                    chunk = self.raw.read()
                except IOError as e:
                    if e.errno != EINTR:
                        raise
                    continue

                if chunk in empty_values:
                    nodata_val = chunk
                    break
                current_size += len(chunk)
                chunks.append(chunk)

            return (b'').join(chunks) or nodata_val
        else:
            avail = len(buf) - pos
            if n <= avail:
                self._read_pos += n
                return buf[pos:pos + n]
            chunks = [
             buf[pos:]]
            wanted = max(self.buffer_size, n)
            while avail < n:
                try:
                    chunk = self.raw.read(wanted)
                except IOError as e:
                    if e.errno != EINTR:
                        raise
                    continue

                if chunk in empty_values:
                    nodata_val = chunk
                    break
                avail += len(chunk)
                chunks.append(chunk)

            n = min(n, avail)
            out = (b'').join(chunks)
            self._read_buf = out[n:]
            self._read_pos = 0
            if out:
                return out[:n]
            return nodata_val

    def peek(self, n=0):
        with self._read_lock:
            return self._peek_unlocked(n)

    def _peek_unlocked(self, n=0):
        want = min(n, self.buffer_size)
        have = len(self._read_buf) - self._read_pos
        if have < want or have <= 0:
            to_read = self.buffer_size - have
            while True:
                try:
                    current = self.raw.read(to_read)
                except IOError as e:
                    if e.errno != EINTR:
                        raise
                    continue

                break

            if current:
                self._read_buf = self._read_buf[self._read_pos:] + current
                self._read_pos = 0
        return self._read_buf[self._read_pos:]

    def read1(self, n):
        if n < 0:
            raise ValueError(b'number of bytes to read must be positive')
        if n == 0:
            return b''
        with self._read_lock:
            self._peek_unlocked(1)
            return self._read_unlocked(min(n, len(self._read_buf) - self._read_pos))

    def tell(self):
        return _BufferedIOMixin.tell(self) - len(self._read_buf) + self._read_pos

    def seek(self, pos, whence=0):
        if not 0 <= whence <= 2:
            raise ValueError(b'invalid whence value')
        with self._read_lock:
            if whence == 1:
                pos -= len(self._read_buf) - self._read_pos
            pos = _BufferedIOMixin.seek(self, pos, whence)
            self._reset_read_buf()
            return pos


class BufferedWriter(_BufferedIOMixin):
    _warning_stack_offset = 2

    def __init__(self, raw, buffer_size=DEFAULT_BUFFER_SIZE, max_buffer_size=None):
        if not raw.writable():
            raise IOError(b'"raw" argument must be writable.')
        _BufferedIOMixin.__init__(self, raw)
        if buffer_size <= 0:
            raise ValueError(b'invalid buffer size')
        if max_buffer_size is not None:
            warnings.warn(b'max_buffer_size is deprecated', DeprecationWarning, self._warning_stack_offset)
        self.buffer_size = buffer_size
        self._write_buf = bytearray()
        self._write_lock = Lock()
        return

    def write(self, b):
        if self.closed:
            raise ValueError(b'write to closed file')
        if isinstance(b, unicode):
            raise TypeError(b"can't write unicode to binary stream")
        with self._write_lock:
            if len(self._write_buf) > self.buffer_size:
                self._flush_unlocked()
            before = len(self._write_buf)
            self._write_buf.extend(b)
            written = len(self._write_buf) - before
            if len(self._write_buf) > self.buffer_size:
                try:
                    self._flush_unlocked()
                except BlockingIOError as e:
                    if len(self._write_buf) > self.buffer_size:
                        overage = len(self._write_buf) - self.buffer_size
                        written -= overage
                        self._write_buf = self._write_buf[:self.buffer_size]
                        raise BlockingIOError(e.errno, e.strerror, written)

            return written

    def truncate(self, pos=None):
        with self._write_lock:
            self._flush_unlocked()
            if pos is None:
                pos = self.raw.tell()
            return self.raw.truncate(pos)
        return

    def flush(self):
        with self._write_lock:
            self._flush_unlocked()

    def _flush_unlocked(self):
        if self.closed:
            raise ValueError(b'flush of closed file')
        while self._write_buf:
            try:
                n = self.raw.write(self._write_buf)
            except BlockingIOError:
                raise RuntimeError(b'self.raw should implement RawIOBase: it should not raise BlockingIOError')
            except IOError as e:
                if e.errno != EINTR:
                    raise
                continue

            if n is None:
                raise BlockingIOError(errno.EAGAIN, b'write could not complete without blocking', 0)
            if n > len(self._write_buf) or n < 0:
                raise IOError(b'write() returned incorrect number of bytes')
            del self._write_buf[:n]

        return

    def tell(self):
        return _BufferedIOMixin.tell(self) + len(self._write_buf)

    def seek(self, pos, whence=0):
        if not 0 <= whence <= 2:
            raise ValueError(b'invalid whence')
        with self._write_lock:
            self._flush_unlocked()
            return _BufferedIOMixin.seek(self, pos, whence)


class BufferedRWPair(BufferedIOBase):

    def __init__(self, reader, writer, buffer_size=DEFAULT_BUFFER_SIZE, max_buffer_size=None):
        if max_buffer_size is not None:
            warnings.warn(b'max_buffer_size is deprecated', DeprecationWarning, 2)
        if not reader.readable():
            raise IOError(b'"reader" argument must be readable.')
        if not writer.writable():
            raise IOError(b'"writer" argument must be writable.')
        self.reader = BufferedReader(reader, buffer_size)
        self.writer = BufferedWriter(writer, buffer_size)
        return

    def read(self, n=None):
        if n is None:
            n = -1
        return self.reader.read(n)

    def readinto(self, b):
        return self.reader.readinto(b)

    def write(self, b):
        return self.writer.write(b)

    def peek(self, n=0):
        return self.reader.peek(n)

    def read1(self, n):
        return self.reader.read1(n)

    def readable(self):
        return self.reader.readable()

    def writable(self):
        return self.writer.writable()

    def flush(self):
        return self.writer.flush()

    def close(self):
        self.writer.close()
        self.reader.close()

    def isatty(self):
        return self.reader.isatty() or self.writer.isatty()

    @property
    def closed(self):
        return self.writer.closed


class BufferedRandom(BufferedWriter, BufferedReader):
    _warning_stack_offset = 3

    def __init__(self, raw, buffer_size=DEFAULT_BUFFER_SIZE, max_buffer_size=None):
        raw._checkSeekable()
        BufferedReader.__init__(self, raw, buffer_size)
        BufferedWriter.__init__(self, raw, buffer_size, max_buffer_size)

    def seek(self, pos, whence=0):
        if not 0 <= whence <= 2:
            raise ValueError(b'invalid whence')
        self.flush()
        if self._read_buf:
            with self._read_lock:
                self.raw.seek(self._read_pos - len(self._read_buf), 1)
        pos = self.raw.seek(pos, whence)
        with self._read_lock:
            self._reset_read_buf()
        if pos < 0:
            raise IOError(b'seek() returned invalid position')
        return pos

    def tell(self):
        if self._write_buf:
            return BufferedWriter.tell(self)
        else:
            return BufferedReader.tell(self)

    def truncate(self, pos=None):
        if pos is None:
            pos = self.tell()
        return BufferedWriter.truncate(self, pos)

    def read(self, n=None):
        if n is None:
            n = -1
        self.flush()
        return BufferedReader.read(self, n)

    def readinto(self, b):
        self.flush()
        return BufferedReader.readinto(self, b)

    def peek(self, n=0):
        self.flush()
        return BufferedReader.peek(self, n)

    def read1(self, n):
        self.flush()
        return BufferedReader.read1(self, n)

    def write(self, b):
        if self._read_buf:
            with self._read_lock:
                self.raw.seek(self._read_pos - len(self._read_buf), 1)
                self._reset_read_buf()
        return BufferedWriter.write(self, b)


class TextIOBase(IOBase):

    def read(self, n=-1):
        self._unsupported(b'read')

    def write(self, s):
        self._unsupported(b'write')

    def truncate(self, pos=None):
        self._unsupported(b'truncate')

    def readline(self):
        self._unsupported(b'readline')

    def detach(self):
        self._unsupported(b'detach')

    @property
    def encoding(self):
        return

    @property
    def newlines(self):
        return

    @property
    def errors(self):
        return


io.TextIOBase.register(TextIOBase)

class IncrementalNewlineDecoder(codecs.IncrementalDecoder):

    def __init__(self, decoder, translate, errors=b'strict'):
        codecs.IncrementalDecoder.__init__(self, errors=errors)
        self.translate = translate
        self.decoder = decoder
        self.seennl = 0
        self.pendingcr = False

    def decode(self, input, final=False):
        if self.decoder is None:
            output = input
        else:
            output = self.decoder.decode(input, final=final)
        if self.pendingcr and (output or final):
            output = b'\r' + output
            self.pendingcr = False
        if output.endswith(b'\r') and not final:
            output = output[:-1]
            self.pendingcr = True
        crlf = output.count(b'\r\n')
        cr = output.count(b'\r') - crlf
        lf = output.count(b'\n') - crlf
        self.seennl |= (lf and self._LF) | (cr and self._CR) | (crlf and self._CRLF)
        if self.translate:
            if crlf:
                output = output.replace(b'\r\n', b'\n')
            if cr:
                output = output.replace(b'\r', b'\n')
        return output

    def getstate(self):
        if self.decoder is None:
            buf = b''
            flag = 0
        else:
            buf, flag = self.decoder.getstate()
        flag <<= 1
        if self.pendingcr:
            flag |= 1
        return (
         buf, flag)

    def setstate(self, state):
        buf, flag = state
        self.pendingcr = bool(flag & 1)
        if self.decoder is not None:
            self.decoder.setstate((buf, flag >> 1))
        return

    def reset(self):
        self.seennl = 0
        self.pendingcr = False
        if self.decoder is not None:
            self.decoder.reset()
        return

    _LF = 1
    _CR = 2
    _CRLF = 4

    @property
    def newlines(self):
        return (None,
         b'\n',
         b'\r',
         ('\r', '\n'),
         b'\r\n',
         ('\n', '\r\n'),
         ('\r', '\r\n'),
         ('\r', '\n', '\r\n'))[self.seennl]


class TextIOWrapper(TextIOBase):
    _CHUNK_SIZE = 2048

    def __init__(self, buffer, encoding=None, errors=None, newline=None, line_buffering=False):
        if newline is not None and not isinstance(newline, basestring):
            raise TypeError(b'illegal newline type: %r' % (type(newline),))
        if newline not in (None, '', '\n', '\r', '\r\n'):
            raise ValueError(b'illegal newline value: %r' % (newline,))
        if encoding is None:
            try:
                import locale
            except ImportError:
                encoding = b'ascii'
            else:
                encoding = locale.getpreferredencoding()

        if not isinstance(encoding, basestring):
            raise ValueError(b'invalid encoding: %r' % encoding)
        if errors is None:
            errors = b'strict'
        elif not isinstance(errors, basestring):
            raise ValueError(b'invalid errors: %r' % errors)
        self._buffer = buffer
        self._line_buffering = line_buffering
        self._encoding = encoding
        self._errors = errors
        self._readuniversal = not newline
        self._readtranslate = newline is None
        self._readnl = newline
        self._writetranslate = newline != b''
        self._writenl = newline or os.linesep
        self._encoder = None
        self._decoder = None
        self._decoded_chars = b''
        self._decoded_chars_used = 0
        self._snapshot = None
        self._seekable = self._telling = self.buffer.seekable()
        if self._seekable and self.writable():
            position = self.buffer.tell()
            if position != 0:
                try:
                    self._get_encoder().setstate(0)
                except LookupError:
                    pass

        return

    def __repr__(self):
        try:
            name = self.name
        except AttributeError:
            return (b"<_pyio.TextIOWrapper encoding='{0}'>").format(self.encoding)

        return (b"<_pyio.TextIOWrapper name={0!r} encoding='{1}'>").format(name, self.encoding)

    @property
    def encoding(self):
        return self._encoding

    @property
    def errors(self):
        return self._errors

    @property
    def line_buffering(self):
        return self._line_buffering

    @property
    def buffer(self):
        return self._buffer

    def seekable(self):
        if self.closed:
            raise ValueError(b'I/O operation on closed file.')
        return self._seekable

    def readable(self):
        return self.buffer.readable()

    def writable(self):
        return self.buffer.writable()

    def flush(self):
        self.buffer.flush()
        self._telling = self._seekable

    def close(self):
        if self.buffer is not None and not self.closed:
            try:
                self.flush()
            finally:
                self.buffer.close()

        return

    @property
    def closed(self):
        return self.buffer.closed

    @property
    def name(self):
        return self.buffer.name

    def fileno(self):
        return self.buffer.fileno()

    def isatty(self):
        return self.buffer.isatty()

    def write(self, s):
        if self.closed:
            raise ValueError(b'write to closed file')
        if not isinstance(s, unicode):
            raise TypeError(b"can't write %s to text stream" % s.__class__.__name__)
        length = len(s)
        haslf = (self._writetranslate or self._line_buffering) and b'\n' in s
        if haslf and self._writetranslate and self._writenl != b'\n':
            s = s.replace(b'\n', self._writenl)
        encoder = self._encoder or self._get_encoder()
        b = encoder.encode(s)
        self.buffer.write(b)
        if self._line_buffering and (haslf or b'\r' in s):
            self.flush()
        self._snapshot = None
        if self._decoder:
            self._decoder.reset()
        return length

    def _get_encoder(self):
        make_encoder = codecs.getincrementalencoder(self._encoding)
        self._encoder = make_encoder(self._errors)
        return self._encoder

    def _get_decoder(self):
        make_decoder = codecs.getincrementaldecoder(self._encoding)
        decoder = make_decoder(self._errors)
        if self._readuniversal:
            decoder = IncrementalNewlineDecoder(decoder, self._readtranslate)
        self._decoder = decoder
        return decoder

    def _set_decoded_chars(self, chars):
        self._decoded_chars = chars
        self._decoded_chars_used = 0

    def _get_decoded_chars(self, n=None):
        offset = self._decoded_chars_used
        if n is None:
            chars = self._decoded_chars[offset:]
        else:
            chars = self._decoded_chars[offset:offset + n]
        self._decoded_chars_used += len(chars)
        return chars

    def _rewind_decoded_chars(self, n):
        if self._decoded_chars_used < n:
            raise AssertionError(b'rewind decoded_chars out of bounds')
        self._decoded_chars_used -= n

    def _read_chunk(self):
        if self._decoder is None:
            raise ValueError(b'no decoder')
        if self._telling:
            dec_buffer, dec_flags = self._decoder.getstate()
        input_chunk = self.buffer.read1(self._CHUNK_SIZE)
        eof = not input_chunk
        self._set_decoded_chars(self._decoder.decode(input_chunk, eof))
        if self._telling:
            self._snapshot = (
             dec_flags, dec_buffer + input_chunk)
        return not eof

    def _pack_cookie(self, position, dec_flags=0, bytes_to_feed=0, need_eof=0, chars_to_skip=0):
        return position | dec_flags << 64 | bytes_to_feed << 128 | chars_to_skip << 192 | bool(need_eof) << 256

    def _unpack_cookie(self, bigint):
        rest, position = divmod(bigint, 18446744073709551616)
        rest, dec_flags = divmod(rest, 18446744073709551616)
        rest, bytes_to_feed = divmod(rest, 18446744073709551616)
        need_eof, chars_to_skip = divmod(rest, 18446744073709551616)
        return (position, dec_flags, bytes_to_feed, need_eof, chars_to_skip)

    def tell(self):
        if not self._seekable:
            raise IOError(b'underlying stream is not seekable')
        if not self._telling:
            raise IOError(b'telling position disabled by next() call')
        self.flush()
        position = self.buffer.tell()
        decoder = self._decoder
        if decoder is None or self._snapshot is None:
            if self._decoded_chars:
                raise AssertionError(b'pending decoded text')
            return position
        dec_flags, next_input = self._snapshot
        position -= len(next_input)
        chars_to_skip = self._decoded_chars_used
        if chars_to_skip == 0:
            return self._pack_cookie(position, dec_flags)
        else:
            saved_state = decoder.getstate()
            try:
                decoder.setstate((b'', dec_flags))
                start_pos = position
                start_flags, bytes_fed, chars_decoded = dec_flags, 0, 0
                need_eof = 0
                for next_byte in next_input:
                    bytes_fed += 1
                    chars_decoded += len(decoder.decode(next_byte))
                    dec_buffer, dec_flags = decoder.getstate()
                    if not dec_buffer and chars_decoded <= chars_to_skip:
                        start_pos += bytes_fed
                        chars_to_skip -= chars_decoded
                        start_flags, bytes_fed, chars_decoded = dec_flags, 0, 0
                    if chars_decoded >= chars_to_skip:
                        break
                else:
                    chars_decoded += len(decoder.decode(b'', final=True))
                    need_eof = 1
                    if chars_decoded < chars_to_skip:
                        raise IOError(b"can't reconstruct logical file position")
                    return self._pack_cookie(start_pos, start_flags, bytes_fed, need_eof, chars_to_skip)

            finally:
                decoder.setstate(saved_state)

            return

    def truncate(self, pos=None):
        self.flush()
        if pos is None:
            pos = self.tell()
        return self.buffer.truncate(pos)

    def detach(self):
        if self.buffer is None:
            raise ValueError(b'buffer is already detached')
        self.flush()
        buffer = self._buffer
        self._buffer = None
        return buffer

    def seek(self, cookie, whence=0):
        if self.closed:
            raise ValueError(b'tell on closed file')
        if not self._seekable:
            raise IOError(b'underlying stream is not seekable')
        if whence == 1:
            if cookie != 0:
                raise IOError(b"can't do nonzero cur-relative seeks")
            whence = 0
            cookie = self.tell()
        if whence == 2:
            if cookie != 0:
                raise IOError(b"can't do nonzero end-relative seeks")
            self.flush()
            position = self.buffer.seek(0, 2)
            self._set_decoded_chars(b'')
            self._snapshot = None
            if self._decoder:
                self._decoder.reset()
            return position
        if whence != 0:
            raise ValueError(b'invalid whence (%r, should be 0, 1 or 2)' % (
             whence,))
        if cookie < 0:
            raise ValueError(b'negative seek position %r' % (cookie,))
        self.flush()
        start_pos, dec_flags, bytes_to_feed, need_eof, chars_to_skip = self._unpack_cookie(cookie)
        self.buffer.seek(start_pos)
        self._set_decoded_chars(b'')
        self._snapshot = None
        if cookie == 0 and self._decoder:
            self._decoder.reset()
        else:
            if self._decoder or dec_flags or chars_to_skip:
                self._decoder = self._decoder or self._get_decoder()
                self._decoder.setstate((b'', dec_flags))
                self._snapshot = (dec_flags, b'')
            if chars_to_skip:
                input_chunk = self.buffer.read(bytes_to_feed)
                self._set_decoded_chars(self._decoder.decode(input_chunk, need_eof))
                self._snapshot = (dec_flags, input_chunk)
                if len(self._decoded_chars) < chars_to_skip:
                    raise IOError(b"can't restore logical file position")
                self._decoded_chars_used = chars_to_skip
            try:
                encoder = self._encoder or self._get_encoder()
            except LookupError:
                pass

            if cookie != 0:
                encoder.setstate(0)
            else:
                encoder.reset()
        return cookie

    def read(self, n=None):
        self._checkReadable()
        if n is None:
            n = -1
        decoder = self._decoder or self._get_decoder()
        try:
            n.__index__
        except AttributeError:
            raise TypeError(b'an integer is required')

        if n < 0:
            result = self._get_decoded_chars() + decoder.decode(self.buffer.read(), final=True)
            self._set_decoded_chars(b'')
            self._snapshot = None
            return result
        else:
            eof = False
            result = self._get_decoded_chars(n)
            while len(result) < n and not eof:
                eof = not self._read_chunk()
                result += self._get_decoded_chars(n - len(result))

            return result
            return

    def next(self):
        self._telling = False
        line = self.readline()
        if not line:
            self._snapshot = None
            self._telling = self._seekable
            raise StopIteration
        return line

    def readline(self, limit=None):
        if self.closed:
            raise ValueError(b'read from closed file')
        if limit is None:
            limit = -1
        else:
            if not isinstance(limit, (int, long)):
                raise TypeError(b'limit must be an integer')
            line = self._get_decoded_chars()
            start = 0
            if not self._decoder:
                self._get_decoder()
            pos = endpos = None
            while True:
                if self._readtranslate:
                    pos = line.find(b'\n', start)
                    if pos >= 0:
                        endpos = pos + 1
                        break
                    else:
                        start = len(line)
                else:
                    if self._readuniversal:
                        nlpos = line.find(b'\n', start)
                        crpos = line.find(b'\r', start)
                        if crpos == -1:
                            if nlpos == -1:
                                start = len(line)
                            else:
                                endpos = nlpos + 1
                                break
                        elif nlpos == -1:
                            endpos = crpos + 1
                            break
                        elif nlpos < crpos:
                            endpos = nlpos + 1
                            break
                        elif nlpos == crpos + 1:
                            endpos = crpos + 2
                            break
                        else:
                            endpos = crpos + 1
                            break
                    else:
                        pos = line.find(self._readnl)
                        if pos >= 0:
                            endpos = pos + len(self._readnl)
                            break
                    if limit >= 0 and len(line) >= limit:
                        endpos = limit
                        break
                    while self._read_chunk():
                        if self._decoded_chars:
                            break

                if self._decoded_chars:
                    line += self._get_decoded_chars()
                else:
                    self._set_decoded_chars(b'')
                    self._snapshot = None
                    return line

        if limit >= 0 and endpos > limit:
            endpos = limit
        self._rewind_decoded_chars(len(line) - endpos)
        return line[:endpos]

    @property
    def newlines(self):
        if self._decoder:
            return self._decoder.newlines
        else:
            return


class StringIO(TextIOWrapper):

    def __init__(self, initial_value=b'', newline=b'\n'):
        super(StringIO, self).__init__(BytesIO(), encoding=b'utf-8', errors=b'strict', newline=newline)
        if newline is None:
            self._writetranslate = False
        if initial_value:
            if not isinstance(initial_value, unicode):
                initial_value = unicode(initial_value)
            self.write(initial_value)
            self.seek(0)
        return

    def getvalue(self):
        self.flush()
        decoder = self._decoder or self._get_decoder()
        old_state = decoder.getstate()
        decoder.reset()
        try:
            return decoder.decode(self.buffer.getvalue(), final=True)
        finally:
            decoder.setstate(old_state)

    def __repr__(self):
        return object.__repr__(self)

    @property
    def errors(self):
        return

    @property
    def encoding(self):
        return

    def detach(self):
        self._unsupported(b'detach')