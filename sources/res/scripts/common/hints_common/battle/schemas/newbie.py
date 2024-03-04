from dict2model import models, fields
from base_schema_manager import GameParamsSchema

class NewbieBattleHintsConfigModel(models.Model):
    __slots__ = ('enabled', )

    def __init__(self, enabled):
        super(NewbieBattleHintsConfigModel, self).__init__()
        self.enabled = enabled

    def _reprArgs(self):
        return ('enabled={}').format(self.enabled)


configSchema = GameParamsSchema[NewbieBattleHintsConfigModel](gameParamsKey='newbie_battle_hints_config', fields={'enabled': fields.Boolean(required=True)}, modelClass=NewbieBattleHintsConfigModel)