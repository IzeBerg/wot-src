from collections import namedtuple
AnimatorInstanceProperties = namedtuple('AnimatorInstanceProperties', ('delay', 'speed',
                                                                       'loopCount',
                                                                       'loop'))
AnimatorInstanceProperties.__new__.__defaults__ = (0.0, 1.0, -1, True)