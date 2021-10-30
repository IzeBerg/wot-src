from .. import fixer_base
from ..fixer_util import Name

class FixGetcwdu(fixer_base.BaseFix):
    BM_compatible = True
    PATTERN = "\n              power< 'os' trailer< dot='.' name='getcwdu' > any* >\n              "

    def transform(self, node, results):
        name = results['name']
        name.replace(Name('getcwd', prefix=name.prefix))