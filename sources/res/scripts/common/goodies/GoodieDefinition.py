import time
from typing import TYPE_CHECKING
from Goodie import Goodie
from goodie_constants import GOODIE_VARIETY, GOODIE_STATE
from soft_exception import SoftException
if TYPE_CHECKING:
    from typing import Optional, Dict
    from goodies.GoodieConditions import GoodieConditionType
    from goodies.GoodieTargets import GoodieTargetType
    from goodies.GoodieValue import GoodieValueType
    from goodies.GoodieResources import GoodieResourceType

class OverLimitException(SoftException):
    pass


class ExpirationCountException(SoftException):

    def __init__(self, state):
        msg = ('The number of expirations does not match the total number of goodies. {}').format(state)
        super(ExpirationCountException, self).__init__(msg)


class GoodieDefinition(object):
    __slots__ = [
     'uid', 'variety', 'target', 'enabled', 'lifetime', 'useby', 'counter', 'autostart',
     'resource', 'value', 'condition', 'expireAfter', 'roundToEndOfGameDay']

    def __init__(self, uid, variety, target, enabled, lifetime, useby, counter, autostart, resource, value, condition, expireAfter, roundToEndOfGameDay):
        self.uid = uid
        self.variety = variety
        self.target = target
        self.enabled = enabled
        self.lifetime = lifetime
        self.useby = useby
        self.counter = counter
        self.autostart = autostart
        self.resource = resource
        self.value = value
        self.condition = condition
        self.expireAfter = expireAfter
        self.roundToEndOfGameDay = roundToEndOfGameDay

    def __repr__(self):
        return ('{}, {}, {}, {}, {}, {}, {}, {}').format(self.uid, self.enabled, self.lifetime, self.useby, self.counter, self.resource, self.value, self.expireAfter, self.roundToEndOfGameDay)

    def isActivatable(self):
        return self.lifetime is not None

    def isExpirable(self):
        return bool(self.expireAfter)

    def isTimeLimited(self):
        return self.lifetime is not None or self.useby is not None

    def isCountable(self):
        return self.counter != 0

    def isPastUseBy(self):
        if self.useby is not None and self.useby < time.time():
            return True
        else:
            return False
            return

    def apply(self, resources, applyToZero):
        if not isinstance(resources, set):
            resources = {
             resources}
        for resource in resources:
            if resource.value == 0 and not applyToZero:
                continue
            if resource.__class__ == self.resource:
                if self.variety in GOODIE_VARIETY.DISCOUNT_LIKE:
                    result = self.value.reduce(resource.value)
                    if self.target.limit is not None and resource.value - result > self.target.limit:
                        raise OverLimitException('Discount is over the limit' % self.target.limit)
                    else:
                        return resource.__class__(result)
                else:
                    if self.variety == GOODIE_VARIETY.BOOSTER:
                        return resource.__class__(self.value.increase(resource.value))
                    raise SoftException('Programming error, Goodie is not a discount or booster' % self.variety)

        return

    def apply_delta(self, resource, applyToZero):
        if resource.value == 0 and not applyToZero:
            return
        else:
            if resource.__class__ == self.resource:
                return resource.__class__(self.value.delta(resource.value))
            return

    def createGoodie(self, state=None, finishTime=None, counter=None, expirations=None):
        if not self.enabled:
            return
        else:
            if self.expireAfter is not None:
                if expirations is None or sum(expirations.itervalues()) != counter:
                    raise ExpirationCountException((state, finishTime, counter, expirations))
            if state is None:
                if self.autostart:
                    state = GOODIE_STATE.ACTIVE
                else:
                    state = GOODIE_STATE.INACTIVE
            if self.isTimeLimited():
                if finishTime is None:
                    if state == GOODIE_STATE.ACTIVE:
                        if self.useby is None:
                            finishTime = time.time() + self.lifetime
                        else:
                            finishTime = min(time.time() + self.lifetime, self.useby)
                    else:
                        finishTime = 0
            else:
                finishTime = 0
            if counter is None:
                counter = self.counter
            return Goodie(self.uid, state, finishTime, counter, expirations)

    def createDisabledGoodie(self, counter, expirations):
        return Goodie(self.uid, GOODIE_STATE.INACTIVE, 0, counter, expirations)