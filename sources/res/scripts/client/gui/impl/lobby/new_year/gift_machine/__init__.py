import math
from helpers import time_utils

def getRentDaysLeftByExpiryTime(rentExpiryTime):
    currentTime = time_utils.getCurrentTimestamp()
    rentLeftTime = rentExpiryTime - currentTime if rentExpiryTime > currentTime else 0
    return int(math.ceil(rentLeftTime / time_utils.ONE_DAY))


def getVehicleRewardSpecialArg(reward, index, default=None):
    specialArgs = reward.get('specialArgs', [])
    argsLen = len(specialArgs)
    value = specialArgs[index] if index < argsLen else None
    if value is None:
        return default
    else:
        return value