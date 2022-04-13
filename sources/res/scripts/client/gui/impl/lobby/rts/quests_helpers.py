

def filterCompletedProgressionQuests(quests, maxLength):
    if len(quests) > maxLength:
        quests = [ quest for quest in quests if ':progression:' not in quest.getID() ]
    return quests