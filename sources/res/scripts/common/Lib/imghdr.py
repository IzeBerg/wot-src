__all__ = [
 'what']

def what(file, h=None):
    f = None
    try:
        if h is None:
            if isinstance(file, basestring):
                f = open(file, 'rb')
                h = f.read(32)
            else:
                location = file.tell()
                h = file.read(32)
                file.seek(location)
        for tf in tests:
            res = tf(h, f)
            if res:
                return res

    finally:
        if f:
            f.close()

    return


tests = []

def test_jpeg(h, f):
    if h[6:10] == 'JFIF':
        return 'jpeg'


tests.append(test_jpeg)

def test_exif(h, f):
    if h[6:10] == 'Exif':
        return 'jpeg'


tests.append(test_exif)

def test_png(h, f):
    if h[:8] == b'\x89PNG\r\n\x1a\n':
        return 'png'


tests.append(test_png)

def test_gif(h, f):
    if h[:6] in ('GIF87a', 'GIF89a'):
        return 'gif'


tests.append(test_gif)

def test_tiff(h, f):
    if h[:2] in ('MM', 'II'):
        return 'tiff'


tests.append(test_tiff)

def test_rgb(h, f):
    if h[:2] == b'\x01\xda':
        return 'rgb'


tests.append(test_rgb)

def test_pbm(h, f):
    if len(h) >= 3 and h[0] == 'P' and h[1] in '14' and h[2] in ' \t\n\r':
        return 'pbm'


tests.append(test_pbm)

def test_pgm(h, f):
    if len(h) >= 3 and h[0] == 'P' and h[1] in '25' and h[2] in ' \t\n\r':
        return 'pgm'


tests.append(test_pgm)

def test_ppm(h, f):
    if len(h) >= 3 and h[0] == 'P' and h[1] in '36' and h[2] in ' \t\n\r':
        return 'ppm'


tests.append(test_ppm)

def test_rast(h, f):
    if h[:4] == b'Y\xa6j\x95':
        return 'rast'


tests.append(test_rast)

def test_xbm(h, f):
    s = '#define '
    if h[:len(s)] == s:
        return 'xbm'


tests.append(test_xbm)

def test_bmp(h, f):
    if h[:2] == 'BM':
        return 'bmp'


tests.append(test_bmp)

def test():
    import sys
    recursive = 0
    if sys.argv[1:] and sys.argv[1] == '-r':
        del sys.argv[1:2]
        recursive = 1
    try:
        if sys.argv[1:]:
            testall(sys.argv[1:], recursive, 1)
        else:
            testall(['.'], recursive, 1)
    except KeyboardInterrupt:
        sys.stderr.write('\n[Interrupted]\n')
        sys.exit(1)


def testall(list, recursive, toplevel):
    import sys, os
    for filename in list:
        if os.path.isdir(filename):
            print filename + '/:',
            if recursive or toplevel:
                print 'recursing down:'
                import glob
                names = glob.glob(os.path.join(filename, '*'))
                testall(names, recursive, 0)
            else:
                print '*** directory (use -r) ***'
        else:
            print filename + ':',
            sys.stdout.flush()
            try:
                print what(filename)
            except IOError:
                print '*** not found ***'