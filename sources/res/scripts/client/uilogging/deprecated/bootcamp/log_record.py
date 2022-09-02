from uilogging.core.log import LogRecord

class BootcampLogRecord(LogRecord):
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        super(BootcampLogRecord, self).__init__(*args, **kwargs)
        if self._properties:
            self._properties.setdefault('is_newbie', None)
            self._properties.setdefault('lesson_id', None)
            self._properties.setdefault('finishReason', None)
            self._properties.setdefault('item_id', None)
            self._properties.setdefault('skipped', None)
            self._properties.setdefault('page', None)
            self._properties.setdefault('tooltip', None)
        return