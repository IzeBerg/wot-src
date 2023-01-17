from survey.gui.game_control.SurveyChannelHandler import SurveyChannelHandler
from gui.shared.system_factory import registerAwardControllerHandler

def preInit():
    registerAwardControllerHandler(SurveyChannelHandler)


def init():
    pass


def start():
    pass


def fini():
    pass