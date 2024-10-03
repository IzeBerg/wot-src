from gui.impl import backport
from gui.impl.gen import R
from helpers.time_utils import getTimeStructInLocal

class TechTreeFormatters(object):

    @staticmethod
    def getActionInfoStr(title, finishTime):
        return backport.text(R.strings.tutorial.techtree.nationDiscount.title(), name=title, time=TechTreeFormatters.__getDateTimeText(finishTime))

    @staticmethod
    def __getDateTimeText(dateTime):
        localDateTime = getTimeStructInLocal(dateTime)
        monthName = backport.text(R.strings.menu.dateTime.months.dyn(('c_{}').format(localDateTime.tm_mon))())
        dateTimeText = backport.text(R.strings.tutorial.techtree.nationDiscount.dateTime(), day=localDateTime.tm_mday, monthName=monthName, year=localDateTime.tm_year)
        return dateTimeText