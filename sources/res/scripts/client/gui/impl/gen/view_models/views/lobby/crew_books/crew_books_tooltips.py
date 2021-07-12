from frameworks.wulf import ViewModel

class CrewBooksTooltips(ViewModel):
    __slots__ = ()
    TOOLTIP_CREW_BOOK_RESTRICTED = 'crewBookRestricted'
    TOOLTIP_TANKMAN = 'tankman'
    TOOLTIP_TANKMAN_NEW_SKILL = 'tankmanNewSkill'
    TOOLTIP_TANKMAN_SKILL = 'tankmanSkill'

    def __init__(self, properties=0, commands=0):
        super(CrewBooksTooltips, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(CrewBooksTooltips, self)._initialize()