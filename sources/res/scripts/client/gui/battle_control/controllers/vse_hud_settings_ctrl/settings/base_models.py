import typing
from helpers import i18n
from pve_battle_hud import getPveHudLogger
_logger = getPveHudLogger()

def validateTemplateKey(func):

    def wrapper(self, templateKey, *args, **kwargs):
        if templateKey is None:
            result = ''
        elif i18n.isValidKey(templateKey):
            result = func(self, templateKey, *args, **kwargs)
        else:
            _logger.error('Text for key=%s not found.', templateKey)
            result = templateKey.replace('\\n', '\n')
        return result

    return wrapper


class BaseClientModel(object):
    pass


class TextClientModel(BaseClientModel):

    @validateTemplateKey
    def _getText(self, templateKey):
        return i18n.makeString(templateKey)

    @validateTemplateKey
    def _getPluralText(self, templateKey, params):
        validParams = self._normalizeParams(templateKey, params)
        pluralTemplate = templateKey.replace(':', ':plural/')
        pluralNumber = validParams[0] if validParams else 0
        return i18n.makePluralString(templateKey, pluralTemplate, pluralNumber, *validParams)

    @staticmethod
    def _normalizeParams(templateKey, params):
        text = i18n.makeString(templateKey)
        places = text.count('%')
        parameters = len(params)
        emptyPlaces = places - parameters
        if emptyPlaces > 0:
            _logger.error('Not enough params. text=%s, params=%s', text, params)
            params = list(params) + [''] * emptyPlaces
        elif emptyPlaces < 0:
            _logger.error('Too much params for template. text=%s, params=%s', text, params)
            params = params[:emptyPlaces]
        return params