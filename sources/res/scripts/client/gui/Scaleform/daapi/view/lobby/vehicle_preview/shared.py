EXT_PREVIEW_ITEMS = dict()

def tryGetExternalAvailablePreviewAlias():
    for alias, conditionFunc in EXT_PREVIEW_ITEMS.items():
        if conditionFunc():
            return alias

    return