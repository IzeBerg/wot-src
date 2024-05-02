import importlib
artefacts = importlib.import_module('items.artefacts')

class CosmicEventGravityFieldEquipment(artefacts.VisualScriptEquipment, object):
    __slots__ = ('duration', 'radius', 'gravityFactor', 'impulsePerSecond')

    @property
    def tooltipParams(self):
        params = super(CosmicEventGravityFieldEquipment, self).tooltipParams
        params['radius'] = self.radius
        params['gravityFactor'] = self.gravityFactor
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventGravityFieldEquipment, self)._readConfig(xmlCtx, section)
        self.duration = section.readFloat('duration')
        self.radius = section.readFloat('radius')
        self.gravityFactor = section.readFloat('gravityFactor')
        self.impulsePerSecond = section.readFloat('impulsePerSecond')
        self._exportSlotsToVSE()


class CosmicEventRocketBoosterEquipment(artefacts.VisualScriptEquipment, object):
    __slots__ = ('duration', 'cooldownSeconds', 'startingDelay')

    @property
    def tooltipParams(self):
        params = super(CosmicEventRocketBoosterEquipment, self).tooltipParams
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventRocketBoosterEquipment, self)._readConfig(xmlCtx, section)
        self.duration = section.readFloat('duration')
        self.cooldownSeconds = section.readFloat('cooldownSeconds')
        self.startingDelay = section.readFloat('startingDelay')
        self._exportSlotsToVSE()


class CosmicEventVortexEquipment(artefacts.VisualScriptEquipment, artefacts.AreaMarkerConfigReader, artefacts.ArcadeEquipmentConfigReader, object):
    __slots__ = ('duration', 'impulse', 'gravityFactor', 'radius', 'deploymentDelay',
                 'angle') + artefacts.AreaMarkerConfigReader._MARKER_SLOTS_ + artefacts.ArcadeEquipmentConfigReader._SHARED_ARCADE_SLOTS

    def __init__(self):
        super(CosmicEventVortexEquipment, self).__init__()
        self.initMarkerInformation()
        self.initArcadeInformation()

    @property
    def tooltipParams(self):
        params = super(CosmicEventVortexEquipment, self).tooltipParams
        params['duration'] = self.duration
        params['impulse'] = self.impulse
        params['gravityFactor'] = self.gravityFactor
        params['radius'] = self.radius
        params['deploymentDelay'] = self.deploymentDelay
        params['angle'] = self.angle
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventVortexEquipment, self)._readConfig(xmlCtx, section)
        self.readMarkerConfig(xmlCtx, section)
        self.readArcadeInformation(xmlCtx, section)
        self.duration = section.readFloat('duration')
        self.impulse = section.readFloat('impulse')
        self.gravityFactor = section.readFloat('gravityFactor')
        self.radius = section.readFloat('radius')
        self.deploymentDelay = section.readFloat('deploymentDelay')
        self.angle = section.readFloat('angle')
        self._exportSlotsToVSE()


class CosmicEventHookShotEquipment(artefacts.VisualScriptEquipment, object):
    __slots__ = ('duration', )

    @property
    def tooltipParams(self):
        params = super(CosmicEventHookShotEquipment, self).tooltipParams
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventHookShotEquipment, self)._readConfig(xmlCtx, section)
        self.duration = section.readFloat('duration')
        self._exportSlotsToVSE()


class CosmicEventShieldEquipment(artefacts.VisualScriptEquipment, object):
    __slots__ = ('duration', 'gravityFactor', 'cooldownSeconds', 'radius', 'startingDelay')

    @property
    def tooltipParams(self):
        params = super(CosmicEventShieldEquipment, self).tooltipParams
        params['cooldown'] = self.cooldownSeconds
        params['duration'] = self.duration
        params['cooldownSeconds'] = self.cooldownSeconds
        params['radius'] = self.radius
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventShieldEquipment, self)._readConfig(xmlCtx, section)
        self.duration = section.readFloat('duration')
        self.gravityFactor = section.readFloat('gravityFactor')
        self.cooldownSeconds = section.readFloat('cooldownSeconds')
        self.startingDelay = section.readFloat('startingDelay')
        self.radius = section.readFloat('radius')
        self._exportSlotsToVSE()


class CosmicEventRepulsorEquipment(artefacts.VisualScriptEquipment, artefacts.AreaMarkerConfigReader, artefacts.ArcadeEquipmentConfigReader, object):
    __slots__ = artefacts.AreaMarkerConfigReader._MARKER_SLOTS_ + artefacts.ArcadeEquipmentConfigReader._SHARED_ARCADE_SLOTS

    def __init__(self):
        super(CosmicEventRepulsorEquipment, self).__init__()
        self.initMarkerInformation()
        self.initArcadeInformation()

    @property
    def tooltipParams(self):
        params = super(CosmicEventRepulsorEquipment, self).tooltipParams
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventRepulsorEquipment, self)._readConfig(xmlCtx, section)
        self.readMarkerConfig(xmlCtx, section)
        self.readArcadeInformation(xmlCtx, section)
        self._exportSlotsToVSE()


class CosmicEventJumpAbilityEquipment(artefacts.VisualScriptEquipment, artefacts.AreaMarkerConfigReader, artefacts.ArcadeEquipmentConfigReader, object):
    __slots__ = artefacts.AreaMarkerConfigReader._MARKER_SLOTS_ + artefacts.ArcadeEquipmentConfigReader._SHARED_ARCADE_SLOTS

    def __init__(self):
        super(CosmicEventJumpAbilityEquipment, self).__init__()
        self.initMarkerInformation()
        self.initArcadeInformation()

    @property
    def tooltipParams(self):
        params = super(CosmicEventJumpAbilityEquipment, self).tooltipParams
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventJumpAbilityEquipment, self)._readConfig(xmlCtx, section)
        self.readMarkerConfig(xmlCtx, section)
        self.readArcadeInformation(xmlCtx, section)
        self._exportSlotsToVSE()


class CosmicEventMinesEquipment(artefacts.VisualScriptEquipment, object):
    __slots__ = ('armingTime', 'lifeTime', 'triggerRadius', 'triggerDelay', 'deploymentCooldown',
                 'explosionRadius', 'deploymentOffset')

    @property
    def tooltipParams(self):
        params = super(CosmicEventMinesEquipment, self).tooltipParams
        return params

    def _readConfig(self, xmlCtx, section):
        super(CosmicEventMinesEquipment, self)._readConfig(xmlCtx, section)
        self.armingTime = section.readFloat('armingTime')
        self.lifeTime = section.readFloat('lifeTime')
        self.triggerRadius = section.readFloat('triggerRadius')
        self.triggerDelay = section.readFloat('triggerDelay')
        self.deploymentCooldown = section.readFloat('deploymentCooldown')
        self.explosionRadius = section.readFloat('explosionRadius')
        self.deploymentOffset = section.readFloat('deploymentOffset')
        self._exportSlotsToVSE()