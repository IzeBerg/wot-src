from gui.impl.gen_utils import DynAccessor

class Areas(DynAccessor):
    __slots__ = ()
    context_menu = DynAccessor(3)
    default = DynAccessor(4)
    pop_over = DynAccessor(5)
    restored = DynAccessor(6)
    specific = DynAccessor(7)