import items.artefacts as artefacts

class SPGZoneEquipment(artefacts.AreaOfEffectEquipment):
    __slots__ = ('yawHitPrediction', 'hitPredictionDuration')

    def _readConfig(self, xmlCtx, section):
        super(SPGZoneEquipment, self)._readConfig(xmlCtx, section)
        self.yawHitPrediction = section.readInt('yawHitPrediction', 0)
        self.hitPredictionDuration = section.readFloat('hitPredictionDuration', 0)