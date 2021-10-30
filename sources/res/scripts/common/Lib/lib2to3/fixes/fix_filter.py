from ..pgen2 import token
from .. import fixer_base
from ..fixer_util import Name, Call, ListComp, in_special_context

class FixFilter(fixer_base.ConditionalFix):
    BM_compatible = True
    PATTERN = "\n    filter_lambda=power<\n        'filter'\n        trailer<\n            '('\n            arglist<\n                lambdef< 'lambda'\n                         (fp=NAME | vfpdef< '(' fp=NAME ')'> ) ':' xp=any\n                >\n                ','\n                it=any\n            >\n            ')'\n        >\n    >\n    |\n    power<\n        'filter'\n        trailer< '(' arglist< none='None' ',' seq=any > ')' >\n    >\n    |\n    power<\n        'filter'\n        args=trailer< '(' [any] ')' >\n    >\n    "
    skip_on = 'future_builtins.filter'

    def transform(self, node, results):
        if self.should_skip(node):
            return None
        else:
            if 'filter_lambda' in results:
                new = ListComp(results.get('fp').clone(), results.get('fp').clone(), results.get('it').clone(), results.get('xp').clone())
            elif 'none' in results:
                new = ListComp(Name('_f'), Name('_f'), results['seq'].clone(), Name('_f'))
            else:
                if in_special_context(node):
                    return None
                new = node.clone()
                new.prefix = ''
                new = Call(Name('list'), [new])
            new.prefix = node.prefix
            return new