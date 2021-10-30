from . import fix_imports
MAPPING = {'whichdb': 'dbm', 
   'anydbm': 'dbm'}

class FixImports2(fix_imports.FixImports):
    run_order = 7
    mapping = MAPPING