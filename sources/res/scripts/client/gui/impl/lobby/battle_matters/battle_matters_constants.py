from enum import Enum
CARDS_CONFIG_XML_PATH = 'gui/battle_matters_cards.xml'

class QuestCardSections(Enum):
    ID = 'id'
    SWF_PATH = 'swfPath'
    LESSON_ID = 'lessonId'


class SequenceNumber(Enum):
    SINGLE = 0
    FIRST = 1
    MIDDLE = 2
    LAST = 3