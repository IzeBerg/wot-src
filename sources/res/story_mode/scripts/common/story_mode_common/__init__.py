import constants
from constants_utils import initCommonTypes
from story_mode_common import story_mode_constants
from story_mode_common.configs.story_mode_settings import settingsSchema

def injectConsts(personality):
    initCommonTypes(story_mode_constants, personality)
    story_mode_constants.FINISH_REASON.inject(personality)
    constants.FINISH_REASON_NAMES.update((v, k) for k, v in story_mode_constants.FINISH_REASON.getExtraAttrs().iteritems())
    constants.INBATTLE_CONFIGS.append(settingsSchema.gpKey)