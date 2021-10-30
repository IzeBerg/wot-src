from .. import pytree
from ..pgen2 import token
from .. import fixer_base

class FixNe(fixer_base.BaseFix):
    _accept_type = token.NOTEQUAL

    def match(self, node):
        return node.value == '<>'

    def transform(self, node, results):
        new = pytree.Leaf(token.NOTEQUAL, '!=', prefix=node.prefix)
        return new