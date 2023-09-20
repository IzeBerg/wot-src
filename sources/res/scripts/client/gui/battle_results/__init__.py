from gui.battle_results.service import BattleResultsService
from gui.battle_results.context import RequestResultsContext
from gui.battle_results.context import RequestEmblemContext
from gui.battle_results.br_constants import EmblemType, ProgressAction
from skeletons.gui.battle_results import IBattleResultsService
__all__ = ('getBattleResultsServiceConfig', 'RequestResultsContext', 'RequestEmblemContext',
           'EmblemType', 'ProgressAction')

def getBattleResultsServiceConfig(manager):
    instance = BattleResultsService()
    instance.init()
    manager.addInstance(IBattleResultsService, instance, finalizer='fini')