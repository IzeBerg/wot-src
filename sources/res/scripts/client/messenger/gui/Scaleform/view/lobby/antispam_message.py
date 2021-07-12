from constants import IS_CHINA
from account_helpers.settings_core.ServerSettingsManager import SETTINGS_SECTIONS
from account_helpers.settings_core.settings_constants import CONTACTS
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
MAX_ANTISPAM_MESSAGES = 3
_isClosed = False

def isShown--- This code section failed: ---

 L.  19         0  LOAD_GLOBAL           0  'IS_CHINA'
                3  POP_JUMP_IF_TRUE     26  'to 26'
                6  LOAD_GLOBAL           1  '_getCounter'
                9  CALL_FUNCTION_0       0  None
               12  LOAD_GLOBAL           2  'MAX_ANTISPAM_MESSAGES'
               15  COMPARE_OP            0  <
               18  JUMP_IF_FALSE_OR_POP    29  'to 29'
               21  LOAD_GLOBAL           3  '_isClosed'
               24  UNARY_NOT        
               25  RETURN_END_IF    
             26_0  COME_FROM            18  '18'
             26_1  COME_FROM             3  '3'
               26  LOAD_GLOBAL           4  'False'
               29  RETURN_VALUE     
               -1  RETURN_LAST      

Parse error at or near `None' instruction at offset -1


def close():
    global _isClosed
    counter = _getCounter()
    newCounter = min(counter + 1, MAX_ANTISPAM_MESSAGES)
    _isClosed = True
    if newCounter != counter:
        _setCounter(newCounter)


def reset():
    global _isClosed
    _isClosed = False


@dependency.replace_none_kwargs(settingsCore=ISettingsCore)
def _getCounter(settingsCore=None):
    return settingsCore.serverSettings.getSectionSettings(SETTINGS_SECTIONS.CONTACTS, CONTACTS.ANTISPAM_MESSAGES_COUNTER, default=0)


@dependency.replace_none_kwargs(settingsCore=ISettingsCore)
def _setCounter(counter, settingsCore=None):
    return settingsCore.serverSettings.setSectionSettings(SETTINGS_SECTIONS.CONTACTS, {CONTACTS.ANTISPAM_MESSAGES_COUNTER: counter})