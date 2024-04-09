from enum import Enum
from frameworks.wulf import ViewModel

class DateTimeFormatsEnum(Enum):
    DAYMONTHNUMERIC = 'dayMonthNumeric'
    DAYMONTHFULL = 'dayMonthFull'
    DAYMONTHFULLTIME = 'dayMonthFullTime'
    DAYMONTHABBREVIATED = 'dayMonthAbbreviated'
    DAYMONTHABBREVIATEDTIME = 'dayMonthAbbreviatedTime'
    SHORTDATE = 'shortDate'
    SHORTTIME = 'ShortTime'
    SHORTDATETIME = 'ShortDateTime'
    FULLDATE = 'fullDate'
    FULLTIME = 'fullTime'
    FULLDATETIME = 'fullDateTime'


class DateTimeFormats(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(DateTimeFormats, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(DateTimeFormats, self)._initialize()