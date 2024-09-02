from BaseAccountExtensionComponent import BaseAccountExtensionComponent

class CrewAccountComponent(BaseAccountExtensionComponent):

    def getSkillsCrewBooksConversion(self):
        crewBooks = {}
        for book in self.skillsCrewBooksConversion:
            crewBooks.update({book['compDescr']: book['count']})

        return crewBooks

    def getSkillsCrewBoostersReplacement(self):
        return self.skillsCrewBoostersReplacement