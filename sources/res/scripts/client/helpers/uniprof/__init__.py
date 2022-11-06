import BigWorld
__all__ = ('regionDecorator', 'enterToRegion', 'exitFromRegion')

def _isRegionSupported():
    if not hasattr(BigWorld, 'uniprofRegionEnter'):
        return False
    if not hasattr(BigWorld, 'uniprofRegionExit'):
        return False
    return True


_IS_REGION_SUPPORTED = _isRegionSupported()
if _IS_REGION_SUPPORTED:
    from .regions import regionDecorator
    from .regions import enterToRegion, exitFromRegion
else:

    class _DummyDecorator(object):
        __slots__ = ()

        def __call__(self, func):
            return func


    def enterToRegion(*_):
        pass


    def exitFromRegion(*_):
        pass


    def regionDecorator(*_, **__):
        return _DummyDecorator()