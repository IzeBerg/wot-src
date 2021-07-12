from .. import fixer_base
from ..fixer_util import Name, Call, in_special_context

class FixZip(fixer_base.ConditionalFix):
    BM_compatible = True
    PATTERN = "\n    power< 'zip' args=trailer< '(' [any] ')' >\n    >\n    "
    skip_on = 'future_builtins.zip'

    def transform(self, node, results):
        if self.should_skip(node):
            return None
        else:
            if in_special_context(node):
                return None
            new = node.clone()
            new.prefix = ''
            new = Call(Name('list'), [new])
            new.prefix = node.prefix
            return new