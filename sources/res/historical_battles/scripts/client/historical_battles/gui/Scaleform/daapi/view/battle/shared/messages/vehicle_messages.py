from gui.Scaleform.daapi.view.battle.shared.messages import vehicle_messages

class HistoricalBattleVehicleMessages(vehicle_messages.VehicleMessages):

    def _formatEntity(self, entityID):
        ctx = self.sessionProvider.getCtx()
        vTypeInfoVO = ctx.getArenaDP().getVehicleInfo(entityID).vehicleType
        entityInfo = self._styleFormatter.format(vTypeInfoVO.shortNameWithPrefix)
        return entityInfo