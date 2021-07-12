from gui.impl import backport
from gui.impl.gen import R
from gui.prb_control.entities.mapbox.pre_queue.actions_validator import MapboxVehicleValidator
from gui.Scaleform.daapi.view.lobby.hangar.carousels.battle_pass.carousel_data_provider import BattlePassCarouselDataProvider
from gui.prb_control.settings import PRE_QUEUE_RESTRICTION
from gui.shared.formatters import text_styles
from gui.shared.formatters.ranges import toRomanRangeString
from gui.shared.gui_items.Vehicle import Vehicle, getTypeUserName
from gui.shared.utils.functions import makeTooltip

class MapboxCarouselDataProvider(BattlePassCarouselDataProvider):

    @classmethod
    def _vehicleComparisonKey(cls, vehicle):
        result = [
         cls._isSuitableForQueue(vehicle)]
        result.extend(super(MapboxCarouselDataProvider, cls)._vehicleComparisonKey(vehicle))
        return result

    def _buildVehicle(self, vehicle):
        result = super(MapboxCarouselDataProvider, self)._buildVehicle(vehicle)
        state, _ = vehicle.getState()
        if state == Vehicle.VEHICLE_STATE.UNSUITABLE_TO_QUEUE:
            validationResult = MapboxVehicleValidator.validateForMapbox(vehicle)
            if validationResult is not None:
                header, body = ('', '')
                resPath = R.strings.mapbox.mapboxCarousel.lockedTooltip
                if validationResult.restriction == PRE_QUEUE_RESTRICTION.LIMIT_LEVEL:
                    levelStr = toRomanRangeString(validationResult.ctx['levels'])
                    levelSubStr = backport.text(resPath.vehLvl.levelSubStr(), levels=levelStr)
                    header = backport.text(resPath.vehLvl.header())
                    body = backport.text(resPath.vehLvl.body(), levelSubStr=levelSubStr)
                elif validationResult.restriction == PRE_QUEUE_RESTRICTION.LIMIT_VEHICLE_TYPE:
                    typeSubStr = text_styles.neutral(validationResult.ctx['forbiddenType'])
                    header = backport.text(resPath.vehType.header())
                    body = backport.text(resPath.vehType.body(), forbiddenType=typeSubStr)
                elif validationResult.restriction == PRE_QUEUE_RESTRICTION.LIMIT_VEHICLE_CLASS:
                    classSubStr = text_styles.neutral(getTypeUserName(validationResult.ctx['forbiddenClass'], False))
                    header = backport.text(resPath.vehClass.header())
                    body = backport.text(resPath.vehClass.body(), forbiddenClass=classSubStr)
                result['lockedTooltip'] = makeTooltip(header, body)
        return result