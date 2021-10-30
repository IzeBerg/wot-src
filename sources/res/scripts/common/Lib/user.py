from warnings import warnpy3k
warnpy3k('the user module has been removed in Python 3.0', stacklevel=2)
del warnpy3k
import os
home = os.curdir
if 'HOME' in os.environ:
    home = os.environ['HOME']
else:
    if os.name == 'posix':
        home = os.path.expanduser('~/')
    elif os.name == 'nt':
        if 'HOMEPATH' in os.environ:
            if 'HOMEDRIVE' in os.environ:
                home = os.environ['HOMEDRIVE'] + os.environ['HOMEPATH']
            else:
                home = os.environ['HOMEPATH']
    pythonrc = os.path.join(home, '.pythonrc.py')
    try:
        f = open(pythonrc)
    except IOError:
        pass

    f.close()
    execfile(pythonrc)