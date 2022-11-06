from gui.Scaleform.daapi.view.lobby.inputChecker.InputChecker import InputChecker
from gui.Scaleform.framework import ScopeTemplates, ComponentSettings

class INPUT_CHECKER_ALIASES(object):
    INPUT_CHECKER = 'inputCheckerComponent'


def getContextMenuHandlers():
    return ()


def getViewSettings():
    return (
     ComponentSettings(INPUT_CHECKER_ALIASES.INPUT_CHECKER, InputChecker, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()