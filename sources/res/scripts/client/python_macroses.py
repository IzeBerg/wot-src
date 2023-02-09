import ResMgr
from debug_utils import LOG_ERROR
_MACROSES_XML = 'scripts/python_macroses.xml'
g_macroses = {}

def init():
    global g_macroses
    section = ResMgr.openSection(_MACROSES_XML)
    if section is not None:
        for macros in section.values():
            command = macros['id'].asString
            if command in g_macroses:
                LOG_ERROR(('Command "{}" duplicated in python_macroses.xml. Also check in extensions').format(command))
            else:
                g_macroses[command] = macros.asString

    return