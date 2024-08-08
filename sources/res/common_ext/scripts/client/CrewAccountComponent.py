from BaseAccountExtensionComponent import BaseAccountExtensionComponent
from helpers.events_handler import EventsHandler
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from gui.shared.gui_items import GUI_ITEM_TYPE

class CrewAccountComponent(BaseAccountExtensionComponent, EventsHandler):
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        self._subscribe()
        self.tankmanIdxSkillsUnlockAnimation = {}
        self.tankmanLearnedSkillsAnimanion = {}
        self.tankmanVeteranAnimanion = {}

    def getSkillsCrewBooksConversion(self):
        crewBooks = {}
        for book in self.skillsCrewBooksConversion:
            crewBooks.update({book['compDescr']: book['count']})

        return crewBooks

    def getSkillsCrewBoostersReplacement(self):
        return self.skillsCrewBoostersReplacement

    def clearTankmanAnimanions(self, tankmaninvID):
        if tankmaninvID in self.tankmanVeteranAnimanion:
            del self.tankmanVeteranAnimanion[tankmaninvID]
        if tankmaninvID in self.tankmanIdxSkillsUnlockAnimation:
            del self.tankmanIdxSkillsUnlockAnimation[tankmaninvID]

    def getTankmanVeteranAnimanion(self, tankmaninvID):
        tankman = self.__itemsCache.items.getTankman(tankmaninvID)
        concurrent = not bool(tankman.descriptor.needXpForVeteran)
        before = self.tankmanVeteranAnimanion.get(tankmaninvID)
        return before is not None and not before and concurrent

    def setLearnedSkillsAnimanion(self, tankmaninvID, learnedSkills):
        skills = self.tankmanLearnedSkillsAnimanion.setdefault(tankmaninvID, [])
        skills += learnedSkills

    def hasLearnedSkillAnimation(self, tankmaninvID, skillName):
        skills = self.tankmanLearnedSkillsAnimanion.get(tankmaninvID, [])
        if skillName in skills:
            skills.remove(skillName)
            return True

    def indexSkillsUnlockAnimation(self, tankmaninvID):
        return self.tankmanIdxSkillsUnlockAnimation.get(tankmaninvID)

    def _getEvents(self):
        onStartSynchronize = ((self.account.inventory.onStartSynchronize, self.__onStartSynchronizeInventory),) if hasattr(self.account, 'inventory') else ()
        return (
         (
          self.account.connectionMgr.onDisconnected, self.__destroy),) + onStartSynchronize

    def __onStartSynchronizeInventory(self, isFullSync, diff):
        if isFullSync:
            return
        descriptors = diff.get('inventory', {}).get(GUI_ITEM_TYPE.TANKMAN, {}).get('compDescr', {})
        for invID in descriptors.iterkeys():
            tankman = self.__itemsCache.items.getTankman(invID)
            if tankman:
                self.tankmanIdxSkillsUnlockAnimation.setdefault(invID, 0)
                self.tankmanIdxSkillsUnlockAnimation[invID], _ = tankman.descriptor.getTotalSkillsProgress(True)
                self.tankmanVeteranAnimanion.setdefault(invID, False)
                self.tankmanVeteranAnimanion[invID] = not bool(tankman.descriptor.needXpForVeteran)

    def __destroy(self):
        self._unsubscribe()