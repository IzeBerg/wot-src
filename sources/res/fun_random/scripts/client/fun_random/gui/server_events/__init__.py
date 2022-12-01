from fun_random.gui.server_events.event_items import FunProgressionTriggerQuestBuilder
from gui.shared.system_factory import registerQuestBuilder

def registerFunRandomQuests():
    registerQuestBuilder(FunProgressionTriggerQuestBuilder)