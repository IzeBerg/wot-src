from __future__ import unicode_literals
import time
from datetime import datetime
from gui.impl import backport
from gui.impl.gen import R
from gui.prb_control import prb_getters
from helpers import html, i18n
from helpers.time_utils import makeLocalServerTime
DETACHMENT_IS_NOT_SET = -1

def makePrebattleWaitingID(requestName):
    return (b'{0:>s}/{1:>s}').format(prb_getters.getPrebattleTypeName().lower(), requestName)


def getPrebattleLocalizedString(string, led=None, escapeHtml=False):
    result = b''
    if led:
        result = led.get(string, b'')
        if escapeHtml:
            html.escape(result)
    return result


def getPrebattleEventName(extraData=None, escapeHtml=False):
    led = prb_getters.getPrebattleLocalizedData(extraData)
    if led:
        return getPrebattleLocalizedString(b'event_name', led, escapeHtml)
    return b''


def getPrebattleSessionName(extraData=None, escapeHtml=False):
    led = prb_getters.getPrebattleLocalizedData(extraData)
    if led:
        return getPrebattleLocalizedString(b'session_name', led, escapeHtml)
    return b''


def getPrebattleDescription(extraData=None, escapeHtml=False):
    led = prb_getters.getPrebattleLocalizedData(extraData)
    if led:
        return getPrebattleLocalizedString(b'desc', led, escapeHtml)
    return b''


def getPrebattleFullDescription(extraData=None, escapeHtml=False):
    led = prb_getters.getPrebattleLocalizedData(extraData)
    description = b''
    if led:
        eventName = getPrebattleLocalizedString(b'event_name', led, escapeHtml)
        sessionName = getPrebattleLocalizedString(b'session_name', led, escapeHtml)
        description = (b'{0:>s}: {1:>s}').format(eventName, sessionName)
    return description


def getPrebattleOpponents(extraData, escapeHtml=False):
    first = b''
    second = b''
    if b'opponents' in extraData:
        opponents = extraData[b'opponents']
        first = opponents.get(b'1', {}).get(b'name', b'')
        second = opponents.get(b'2', {}).get(b'name', b'')
        if escapeHtml:
            first = html.escape(first)
            second = html.escape(second)
    return (
     first, second)


def getPrebattleOpponentsString(extraData, escapeHtml=False):
    first, second = getPrebattleOpponents(extraData, escapeHtml=escapeHtml)
    result = b''
    if first and second:
        result = i18n.makeString(b'#menu:opponents', firstOpponent=first, secondOpponent=second)
    elif b'type' in extraData:
        result = extraData[b'type']
    return result


def getPrebattleStartTimeString(startTime):
    startTimeString = backport.getLongTimeFormat(startTime)
    if startTime - time.time() > 86400:
        startTimeString = (b'{0:>s} {1:>s}').format(backport.getLongDateFormat(startTime), startTimeString)
    return startTimeString


def getBattleSessionStartTimeString(startTime):
    startTimeString = getPrebattleStartTimeString(startTime)
    return (b'{} {}').format(backport.text(R.strings.prebattle.title.battleSession.startTime()), startTimeString)


def getStartTimeLeft(startTime):
    if startTime:
        startTime = makeLocalServerTime(startTime)
        if datetime.utcfromtimestamp(startTime) > datetime.utcnow():
            return (datetime.utcfromtimestamp(startTime) - datetime.utcnow()).seconds
    return 0


def getBattleSessionDetachment(extraData, clanDBID):
    detachment = DETACHMENT_IS_NOT_SET
    vehicleLvl = extraData.get(b'front_level', 0)
    teamIndex = 0
    for opponentIndex, opponentData in extraData.get(b'opponents', {}).items():
        if opponentData.get(b'id') == clanDBID:
            prebattleDetachmentId = opponentData.get(b'detachment')
            detachment = prebattleDetachmentId if prebattleDetachmentId is not None else DETACHMENT_IS_NOT_SET
            teamIndex = int(opponentIndex)

    return (
     detachment, vehicleLvl, teamIndex)