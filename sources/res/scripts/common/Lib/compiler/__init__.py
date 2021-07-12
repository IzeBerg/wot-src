import warnings
warnings.warn('The compiler package is deprecated and removed in Python 3.x.', DeprecationWarning, stacklevel=2)
from compiler.transformer import parse, parseFile
from compiler.visitor import walk
from compiler.pycodegen import compile, compileFile