from gui.battle_results.components.style import getIntegralFormatIfNoEmpty
from gui.shared.formatters.numbers import makeStringWithThousandSymbol

def formatter(value):
    return ('{:,}').format(value).replace(',', ' ')


def formatOneValue(value, digitLimit=9):
    return makeStringWithThousandSymbol(value, digitLimit, formatter, getIntegralFormatIfNoEmpty)


def formatTwoValues(values, digitLimit=5):
    result = []
    for value in values:
        if value > 0:
            result.append(makeStringWithThousandSymbol(value, digitLimit, formatter=str))
        else:
            result.append(value)

    return result