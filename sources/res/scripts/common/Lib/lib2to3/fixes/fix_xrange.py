from .. import fixer_base
from ..fixer_util import Name, Call, consuming_calls
from .. import patcomp

class FixXrange(fixer_base.BaseFix):
    BM_compatible = True
    PATTERN = "\n              power<\n                 (name='range'|name='xrange') trailer< '(' args=any ')' >\n              rest=any* >\n              "

    def start_tree(self, tree, filename):
        super(FixXrange, self).start_tree(tree, filename)
        self.transformed_xranges = set()

    def finish_tree(self, tree, filename):
        self.transformed_xranges = None
        return

    def transform(self, node, results):
        name = results['name']
        if name.value == 'xrange':
            return self.transform_xrange(node, results)
        if name.value == 'range':
            return self.transform_range(node, results)
        raise ValueError(repr(name))

    def transform_xrange(self, node, results):
        name = results['name']
        name.replace(Name('range', prefix=name.prefix))
        self.transformed_xranges.add(id(node))

    def transform_range(self, node, results):
        if id(node) not in self.transformed_xranges and not self.in_special_context(node):
            range_call = Call(Name('range'), [results['args'].clone()])
            list_call = Call(Name('list'), [range_call], prefix=node.prefix)
            for n in results['rest']:
                list_call.append_child(n)

            return list_call

    P1 = "power< func=NAME trailer< '(' node=any ')' > any* >"
    p1 = patcomp.compile_pattern(P1)
    P2 = "for_stmt< 'for' any 'in' node=any ':' any* >\n            | comp_for< 'for' any 'in' node=any any* >\n            | comparison< any 'in' node=any any*>\n         "
    p2 = patcomp.compile_pattern(P2)

    def in_special_context(self, node):
        if node.parent is None:
            return False
        else:
            results = {}
            if node.parent.parent is not None and self.p1.match(node.parent.parent, results) and results['node'] is node:
                return results['func'].value in consuming_calls
            return self.p2.match(node.parent, results) and results['node'] is node