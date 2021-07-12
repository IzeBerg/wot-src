from lib2to3 import fixer_base
from lib2to3.fixer_util import is_probably_builtin

class FixLong(fixer_base.BaseFix):
    BM_compatible = True
    PATTERN = "'long'"

    def transform(self, node, results):
        if is_probably_builtin(node):
            node.value = 'int'
            node.changed()