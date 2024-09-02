import typing
from fun_random_common.fun_constants import FunSubModeImpl
from fun_random.gui.feature.sub_modes.base_sub_mode import FunBaseSubMode
from fun_random.gui.feature.sub_modes.dev_sub_mode import FunDevSubMode
if typing.TYPE_CHECKING:
    from fun_random.gui.feature.sub_modes.base_sub_mode import IFunSubMode
    from fun_random.helpers.server_settings import FunSubModeConfig
_SUB_MODE_IMPLS_MAP = {FunSubModeImpl.DEV_TEST: FunDevSubMode}

def createFunSubMode(subModeSettings):
    return _SUB_MODE_IMPLS_MAP.get(subModeSettings.client.subModeImpl, FunBaseSubMode)(subModeSettings)