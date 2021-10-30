from gui.impl.gen_utils import DynAccessor

class Entries(DynAccessor):
    __slots__ = ()
    battle = DynAccessor(1)
    lobby = DynAccessor(2)