import logging
from gui.impl.gen import R
_logger = logging.getLogger(__name__)

def getVehicleParameterText(paramName, isTTC=False, isLong=False, isPositive=False):
    res = default = R.strings.tank_setup.kpi.bonus
    if isTTC:
        res = res.ttc
    else:
        if isLong:
            res = res.longDescr
        if isPositive:
            res = res.positive
            default = default.positive
        else:
            res = res.negative
            default = default.negative
        result = res.dyn(paramName) or default.dyn(paramName)
        if not result:
            _logger.debug('Text for vehicle parameter is not found: name=%s, isTTC=%s, isLong=%s, isPositive=%s', paramName, isTTC, isLong, isPositive)
            return R.invalid()
    return result()