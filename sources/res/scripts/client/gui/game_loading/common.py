import os, json, typing, logging
_logger = logging.getLogger(__name__)

def loadDictFromJsonFile(filePath):
    loaded = None
    try:
        _logger.debug('Loading data from json file: [%s].', filePath)
        if os.path.isfile(filePath):
            with open(filePath, 'rb') as (jsonFile):
                _loaded = json.load(jsonFile)
            if not isinstance(_loaded, dict):
                _logger.error('Json: [%s] data type mismatch. %s != %s.', filePath, type(_loaded), dict)
            else:
                loaded = _loaded
        else:
            _logger.debug('[%s] does not exist or is not a file.', filePath)
    except Exception:
        _logger.exception('Load json file: [%s] error.', filePath)

    return loaded


def saveDictToJsonFile(filePath, data):
    try:
        _logger.debug('Saving data to json file: [%s].', filePath)
        with open(filePath, 'wb') as (jsonFile):
            json.dump(data, jsonFile)
    except Exception:
        _logger.exception('Save json file: [%s] error.', filePath)


def deleteFile(filePath):
    try:
        if not os.path.isfile(filePath):
            _logger.debug('File: [%s] already deleted.', filePath)
            return True
        else:
            os.remove(filePath)
            return True

    except Exception:
        _logger.exception('Deleting file: [%s] error.', filePath)
        return False