import logging, traceback, sys, ResMgr

def formatException(excType, excValue, excTraceback):
    extracted = traceback.extract_tb(excTraceback)
    converted = []
    for filename, lineno, name, line in extracted:
        if filename.endswith('.py'):
            converted.append((
             ResMgr.resolveToAbsolutePath(filename), lineno, name, line))
        else:
            converted.append((filename, lineno, name, line))

    converted = traceback.format_list(converted)
    converted += traceback.format_exception(excType, excValue, None)
    return ('').join(converted)


def setupUserExceptionHook():

    def exceptionHook(excType, excValue, excTraceback):
        logging.critical(formatException(excType, excValue, excTraceback))

    sys.excepthook = exceptionHook