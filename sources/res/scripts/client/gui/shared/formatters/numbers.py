from typing import Optional, Callable
from gui.impl import backport

def formatInt(value, negativeOrZero=None, formatter=backport.getIntegralFormat):
    if value <= 0 and negativeOrZero is not None:
        result = negativeOrZero
    else:
        result = formatter(value)
    return result


def makeStringWithThousandSymbol(value, digitLimit=4, formatter=backport.getIntegralFormat, defaultFormatter=None):
    limitValue = 10 ** digitLimit - 1
    if value > limitValue:
        result = formatter(int(value * 0.001)) + 'K'
    elif defaultFormatter is not None:
        result = defaultFormatter(value)
    else:
        result = formatInt(value, '-', formatter)
    return result