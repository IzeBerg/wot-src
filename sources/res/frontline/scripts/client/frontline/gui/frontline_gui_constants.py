from gui.limited_ui.lui_rules_storage import LUI_RULES
_LUI_RULE_ENTRY_POINT = 'EpicBattlesEntryPoint'
_LUI_RULES = [_LUI_RULE_ENTRY_POINT]

def initFLLimitedUIIDs():
    LUI_RULES.inject(_LUI_RULES)