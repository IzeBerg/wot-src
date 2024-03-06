import logging
LOGGER_NAME = 'NewbieBattleHints'

def getLogger(*names):
    return logging.getLogger(('{}').format((':').join((LOGGER_NAME,) + names)))