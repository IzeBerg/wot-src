from gui import SystemMessages
from gui.shared.formatters import text_styles

class IDevMessagesPusher(object):

    @classmethod
    def _formatMessage(cls, message):
        return text_styles.stats(message)

    @classmethod
    def _pushClientMessage(cls, message):
        SystemMessages.pushMessage(cls._formatMessage(message), SystemMessages.SM_TYPE.MediumInfo)