

class MarkerSymbolName(object):
    GO_TO_POSITION = 'RTSMoveOrderMarkerUI'
    CAPTURE_BASE = 'RTSCaptureBaseOrderMarkerUI'
    DEFEND_BASE = 'RTSDefendBaseOrderMarkerUI'
    BERSERK_GO = 'RTSMoveBerserkOrderMarkerUI'
    CHASING_TARGET = 'RTSChaseOrderMarkerUI'
    BERSERK_CHASING_TARGET = 'RTSChaseBerserkOrderMarkerUI'


class DAMAGE_TYPE(object):
    FROM_UNKNOWN = 0
    FROM_ALLY = 1
    FROM_ENEMY = 2
    FROM_SQUAD = 3
    FROM_PLAYER = 4