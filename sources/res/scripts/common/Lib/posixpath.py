import os, sys, stat, genericpath, warnings
from genericpath import *
from genericpath import _unicode
__all__ = [
 'normcase', 'isabs', 'join', 'splitdrive', 'split', 'splitext',
 'basename', 'dirname', 'commonprefix', 'getsize', 'getmtime',
 'getatime', 'getctime', 'islink', 'exists', 'lexists', 'isdir', 'isfile',
 'ismount', 'walk', 'expanduser', 'expandvars', 'normpath', 'abspath',
 'samefile', 'sameopenfile', 'samestat',
 'curdir', 'pardir', 'sep', 'pathsep', 'defpath', 'altsep', 'extsep',
 'devnull', 'realpath', 'supports_unicode_filenames', 'relpath']
curdir = '.'
pardir = '..'
extsep = '.'
sep = '/'
pathsep = ':'
defpath = ':/bin:/usr/bin'
altsep = None
devnull = '/dev/null'

def normcase(s):
    return s


def isabs(s):
    return s.startswith('/')


def join(a, *p):
    path = a
    for b in p:
        if b.startswith('/'):
            path = b
        elif path == '' or path.endswith('/'):
            path += b
        else:
            path += '/' + b

    return path


def split(p):
    i = p.rfind('/') + 1
    head, tail = p[:i], p[i:]
    if head and head != '/' * len(head):
        head = head.rstrip('/')
    return (
     head, tail)


def splitext(p):
    return genericpath._splitext(p, sep, altsep, extsep)


splitext.__doc__ = genericpath._splitext.__doc__

def splitdrive(p):
    return (
     '', p)


def basename(p):
    i = p.rfind('/') + 1
    return p[i:]


def dirname(p):
    i = p.rfind('/') + 1
    head = p[:i]
    if head and head != '/' * len(head):
        head = head.rstrip('/')
    return head


def islink(path):
    try:
        st = os.lstat(path)
    except (os.error, AttributeError):
        return False

    return stat.S_ISLNK(st.st_mode)


def lexists(path):
    try:
        os.lstat(path)
    except os.error:
        return False

    return True


def samefile(f1, f2):
    s1 = os.stat(f1)
    s2 = os.stat(f2)
    return samestat(s1, s2)


def sameopenfile(fp1, fp2):
    s1 = os.fstat(fp1)
    s2 = os.fstat(fp2)
    return samestat(s1, s2)


def samestat(s1, s2):
    return s1.st_ino == s2.st_ino and s1.st_dev == s2.st_dev


def ismount(path):
    if islink(path):
        return False
    try:
        s1 = os.lstat(path)
        s2 = os.lstat(realpath(join(path, '..')))
    except os.error:
        return False

    dev1 = s1.st_dev
    dev2 = s2.st_dev
    if dev1 != dev2:
        return True
    ino1 = s1.st_ino
    ino2 = s2.st_ino
    if ino1 == ino2:
        return True
    return False


def walk(top, func, arg):
    warnings.warnpy3k('In 3.x, os.path.walk is removed in favor of os.walk.', stacklevel=2)
    try:
        names = os.listdir(top)
    except os.error:
        return

    func(arg, top, names)
    for name in names:
        name = join(top, name)
        try:
            st = os.lstat(name)
        except os.error:
            continue

        if stat.S_ISDIR(st.st_mode):
            walk(name, func, arg)


def expanduser(path):
    if not path.startswith('~'):
        return path
    i = path.find('/', 1)
    if i < 0:
        i = len(path)
    if i == 1:
        if 'HOME' not in os.environ:
            import pwd
            try:
                userhome = pwd.getpwuid(os.getuid()).pw_dir
            except KeyError:
                return path

        else:
            userhome = os.environ['HOME']
    else:
        import pwd
        try:
            pwent = pwd.getpwnam(path[1:i])
        except KeyError:
            return path

        userhome = pwent.pw_dir
    userhome = userhome.rstrip('/')
    return userhome + path[i:] or '/'


_varprog = None
_uvarprog = None

def expandvars(path):
    global _uvarprog
    global _varprog
    if '$' not in path:
        return path
    else:
        if isinstance(path, _unicode):
            if not _uvarprog:
                import re
                _uvarprog = re.compile('\\$(\\w+|\\{[^}]*\\})', re.UNICODE)
            varprog = _uvarprog
            encoding = sys.getfilesystemencoding()
        else:
            if not _varprog:
                import re
                _varprog = re.compile('\\$(\\w+|\\{[^}]*\\})')
            varprog = _varprog
            encoding = None
        i = 0
        while True:
            m = varprog.search(path, i)
            if not m:
                break
            i, j = m.span(0)
            name = m.group(1)
            if name.startswith('{') and name.endswith('}'):
                name = name[1:-1]
            if encoding:
                name = name.encode(encoding)
            if name in os.environ:
                tail = path[j:]
                value = os.environ[name]
                if encoding:
                    value = value.decode(encoding)
                path = path[:i] + value
                i = len(path)
                path += tail
            else:
                i = j

        return path


def normpath(path):
    slash, dot = ('/', '.') if isinstance(path, _unicode) else ('/', '.')
    if path == '':
        return dot
    initial_slashes = path.startswith('/')
    if initial_slashes and path.startswith('//') and not path.startswith('///'):
        initial_slashes = 2
    comps = path.split('/')
    new_comps = []
    for comp in comps:
        if comp in ('', '.'):
            continue
        if comp != '..' or not initial_slashes and not new_comps or new_comps and new_comps[(-1)] == '..':
            new_comps.append(comp)
        elif new_comps:
            new_comps.pop()

    comps = new_comps
    path = slash.join(comps)
    if initial_slashes:
        path = slash * initial_slashes + path
    return path or dot


def abspath(path):
    if not isabs(path):
        if isinstance(path, _unicode):
            cwd = os.getcwdu()
        else:
            cwd = os.getcwd()
        path = join(cwd, path)
    return normpath(path)


def realpath(filename):
    path, ok = _joinrealpath('', filename, {})
    return abspath(path)


def _joinrealpath(path, rest, seen):
    if isabs(rest):
        rest = rest[1:]
        path = sep
    while rest:
        name, _, rest = rest.partition(sep)
        if not name or name == curdir:
            continue
        if name == pardir:
            if path:
                path, name = split(path)
                if name == pardir:
                    path = join(path, pardir, pardir)
            else:
                path = pardir
            continue
        newpath = join(path, name)
        if not islink(newpath):
            path = newpath
            continue
        if newpath in seen:
            path = seen[newpath]
            if path is not None:
                continue
            return (
             join(newpath, rest), False)
        seen[newpath] = None
        path, ok = _joinrealpath(path, os.readlink(newpath), seen)
        if not ok:
            return (join(path, rest), False)
        seen[newpath] = path

    return (path, True)


supports_unicode_filenames = sys.platform == 'darwin'

def relpath(path, start=curdir):
    if not path:
        raise ValueError('no path specified')
    start_list = [ x for x in abspath(start).split(sep) if x ]
    path_list = [ x for x in abspath(path).split(sep) if x ]
    i = len(commonprefix([start_list, path_list]))
    rel_list = [
     pardir] * (len(start_list) - i) + path_list[i:]
    if not rel_list:
        return curdir
    return join(*rel_list)