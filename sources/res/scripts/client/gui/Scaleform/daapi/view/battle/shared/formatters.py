import math
from debug_utils import LOG_ERROR, LOG_WARNING

def normalizeHealth(health):
    return max(0.0, health)


def getHealthPercent(health, maxHealth):
    if not (maxHealth > 0 and maxHealth >= health):
        LOG_WARNING(('Maximum health is not valid! health={}, maxHealth={}').format(health, maxHealth))
        return 0.0
    return float(normalizeHealth(health)) / maxHealth


def normalizeHealthPercent(health, maxHealth):
    return int(math.ceil(getHealthPercent(health, maxHealth) * 100))


def formatHealthProgress(health, maxHealth):
    if not (maxHealth > 0 and maxHealth >= health):
        LOG_ERROR(('Maximum health is not valid! health={}, maxHealth={}').format(health, maxHealth))
    return '%d/%d' % (normalizeHealth(health), maxHealth)