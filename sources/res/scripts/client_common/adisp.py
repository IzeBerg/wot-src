import os, types
from functools import partial, wraps
from debug_utils import LOG_WRAPPED_CURRENT_EXCEPTION, LOG_ERROR
from soft_exception import SoftException
CLEAR_TRACE = True

class CallbackDispatcher(object):

    def __init__(self, generator, stepCallback):
        self.g = generator
        self.stepCallback = stepCallback
        try:
            self.call(self.g.next())
        except StopIteration:
            self.stepCallback(True)

    def call(self, callers):
        single = not hasattr(callers, '__iter__')
        if single:
            callers = [
             callers]
        self.call_count = len(list(callers))
        self.results = [None] * self.call_count
        for count, caller in enumerate(callers):
            caller(callback=partial(self.callback, count, single))

        return

    def callback(self, index, single, arg):
        self.stepCallback(False)
        self.call_count -= 1
        self.results[index] = arg
        if self.call_count > 0:
            return
        try:
            result = self.results[0] if single else self.results
            self.call(self.g.send(result))
        except StopIteration:
            self.stepCallback(True)


if CLEAR_TRACE:

    class AdispException(SoftException):
        pass


    def doCall(func, processor):
        try:
            return processor()
        except AdispException as e:
            raise e
        except Exception as e:
            funcName = func.__name__
            LOG_WRAPPED_CURRENT_EXCEPTION('adisp', funcName, func.func_code.co_filename, func.func_code.co_firstlineno + 1)
            raise AdispException('There was an error during %s adisp_async call.' % funcName, e)


else:

    def doCall(func, processor):
        return processor()


def adisp_process(func, stepCallback=lambda stop: None):

    @wraps(func)
    def wrapper(*args, **kwargs):
        generator = func(*args, **kwargs)
        if not isinstance(generator, types.GeneratorType):
            LOG_ERROR('Method %s from %s marked as adisp_process is not a generator!' % (
             func.__name__, os.path.relpath(func.func_code.co_filename)))
            return generator
        doCall(func, partial(CallbackDispatcher, generator, stepCallback))

    return wrapper


def adisp_async(func, cbname='callback', cbwrapper=lambda x: x):

    @wraps(func)
    def wrapper(*args, **kwargs):

        def caller(callback):
            kwargs[cbname] = cbwrapper(callback)
            func(*args, **kwargs)

        return caller

    wrapper.__is_async__ = True
    return wrapper


def isAsync(func):
    return hasattr(func, '__is_async__')