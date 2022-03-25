

def searchRankForSlot(slotIdx, slotEventsConfig):
    for rank, updateSet in enumerate(slotEventsConfig):
        if slotIdx in updateSet:
            return rank

    return