import typing
from helpers.time_utils import ONE_MINUTE
from gui.impl.backport import getTillTimeStringByRClass
from gui.impl.gen import R
if typing.TYPE_CHECKING:
    from gui.impl.gen_utils import DynAccessor
TIMER_TYPE_3 = R.strings.hb_time.timeLeft.short

def getFormattedTimeLeft(timeLeft, timerType, minTime=0):
    prefix = '<' if timeLeft < minTime else ''
    time = max(ONE_MINUTE, timeLeft, minTime)
    return prefix + getTillTimeStringByRClass(time, timerType)