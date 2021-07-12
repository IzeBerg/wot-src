from collections import namedtuple
from shared_utils import CONST_CONTAINER
from soft_exception import SoftException

class Currency(CONST_CONTAINER):
    CREDITS = 'credits'
    GOLD = 'gold'
    CRYSTAL = 'crystal'
    EVENT_COIN = 'eventCoin'
    BPCOIN = 'bpcoin'
    ALL = (
     CREDITS, GOLD, CRYSTAL, EVENT_COIN, BPCOIN)
    BY_WEIGHT = (
     GOLD, CRYSTAL, CREDITS, EVENT_COIN, BPCOIN)
    GUI_ALL = (
     CRYSTAL, GOLD, CREDITS)
    __INDEXES = {c:i for i, c in enumerate(ALL)}
    _CURRENCY_EXTERNAL_MAP = {CREDITS: 'credits', 
       GOLD: 'gold', 
       CRYSTAL: 'crystal', 
       EVENT_COIN: 'event_coin', 
       BPCOIN: 'bpcoin'}

    @classmethod
    def getCurrencyIndex(cls, currency):
        return cls.__INDEXES.get(currency, None)

    @classmethod
    def currencyExternalName(cls, currencyName):
        return Currency._CURRENCY_EXTERNAL_MAP[currencyName]


__Money = namedtuple('_Money', Currency.ALL)
__Money.__new__.__defaults__ = len(Currency.ALL) * (0,)

class _Money(__Money):

    def get(self, currency):
        return getattr(self, currency)


_ALL = Currency.ALL
_CREDITS = Currency.CREDITS
_GOLD = Currency.GOLD
_CRYSTAL = Currency.CRYSTAL
_EVENT_COIN = Currency.EVENT_COIN
_BPCOIN = Currency.BPCOIN

class Money(object):
    __slots__ = ('__values', )

    def __init__(self, credits=None, gold=None, crystal=None, eventCoin=None, bpcoin=None, *args, **kwargs):
        super(Money, self).__init__()
        values = self.__values = {}
        if credits is not None:
            values[_CREDITS] = credits
        if gold is not None:
            values[_GOLD] = gold
        if crystal is not None:
            values[_CRYSTAL] = crystal
        if eventCoin is not None:
            values[_EVENT_COIN] = eventCoin
        if bpcoin is not None:
            values[_BPCOIN] = bpcoin
        return

    @property
    def credits(self):
        try:
            return self.__values[_CREDITS]
        except KeyError:
            return

        return

    @property
    def gold(self):
        try:
            return self.__values[_GOLD]
        except KeyError:
            return

        return

    @property
    def crystal(self):
        try:
            return self.__values[_CRYSTAL]
        except KeyError:
            return

        return

    @property
    def eventCoin(self):
        try:
            return self.__values[_EVENT_COIN]
        except KeyError:
            return

        return

    @property
    def bpcoin(self):
        try:
            return self.__values[_BPCOIN]
        except KeyError:
            return

        return

    @classmethod
    def makeFrom(cls, currency, value):
        return MONEY_UNDEFINED.replace(currency, value)

    @classmethod
    def hasMoney(cls, data):
        for c in _ALL:
            if c in data:
                return True

        return False

    @classmethod
    def extractMoneyDict(cls, data):
        return {c:data[c] for c in _ALL if c in data}

    def get(self, currency, default=None):
        if currency in self.__values:
            return self.__values[currency]
        return default

    def replace(self, currency, value):
        copy = self.__values.copy()
        self.__setValue(copy, currency, value)
        return Money(**copy)

    def replaceAll(self, values):
        copy = self.__values.copy()
        for currency, value in values.iteritems():
            self.__setValue(copy, currency, value)

        return Money(**copy)

    def copy(self):
        return Money(**self.__values)

    def exchange(self, currency, toCurrency, rate, default=None):
        if currency == toCurrency:
            raise SoftException(('Currencies are same: {}').format(toCurrency))
        if currency not in self.__values:
            raise SoftException(('Current is not found: {}').format(currency))
        value = self.get(toCurrency, 0) + self.get(currency) * rate
        copy = self.__values.copy()
        self.__setValue(copy, currency, default)
        self.__setValue(copy, toCurrency, value)
        return Money(**copy)

    def isDefined(self):
        return bool(self.__values)

    def isCurrencyDefined(self, currency):
        return currency in self.__values

    def isSet(self, currency):
        return currency in self and self.get(currency) != 0

    def isCompound(self):
        return len(self.__values) > 1

    def getSetCurrencies(self, byWeight=True):
        return [ c for c in self.__getCurrenciesIterator(byWeight) if self.__values[c] != 0 ]

    def getCurrency(self, byWeight=True):
        currency = None
        if self.__values:
            for c in self.__getCurrenciesIterator(byWeight):
                if self.__values[c] != 0:
                    return c
                if currency is None:
                    currency = c

        return currency or _CREDITS

    def toNonNegative(self):
        return self.apply(lambda v: max(0, v))

    def toAbs(self):
        return self.apply(abs)

    def toDict(self):
        return {c:v for c, v in self.__values.iteritems()}

    def toSignDict(self):
        return {c:v for c, v in self.__values.iteritems() if v != 0 if v != 0}

    def toMoneySet(self):
        return MoneySet((self,))

    def toDictsList(self):
        return [
         self.toSignDict()]

    def iteritems(self, byWeight=False):
        for c in self.__getCurrenciesIterator(byWeight=byWeight):
            yield (
             c, self.__values.get(c))

    def apply(self, formatter):
        return self.__convert(lambda c, v, o: formatter(v), None)

    def getShortage(self, price):
        shortage = MONEY_UNDEFINED
        for c in price.__getCurrenciesIterator(byWeight=True):
            delta = price.get(c) - self.get(c, 0)
            if delta > 0:
                shortage = shortage.replace(c, delta)

        return shortage

    def getNegative(self):
        return [ (c, v) for c, v in self.iteritems() if v < 0 ]

    def getPositive(self):
        return [ (c, v) for c, v in self.iteritems() if v > 0 ]

    @classmethod
    def makeMoney(cls, data):
        if isinstance(data, Money):
            return data
        else:
            if isinstance(data, (tuple, list)):
                return Money.makeFromMoneyTuple(data)
            if isinstance(data, dict):
                return Money(**data)
            return

    @classmethod
    def makeFromMoneyTuple(cls, moneyTuple):
        setValues = {_ALL[index]:v for index, v in enumerate(moneyTuple) if v != 0 if v != 0}
        return Money(**setValues)

    def toMoneyTuple(self):
        return _Money(**self.__values)

    def getSignValue(self, currency):
        return self.get(currency, 0)

    def iterallitems(self, byWeight=False):
        order = Currency.BY_WEIGHT if byWeight else Currency.ALL
        for c in order:
            yield (
             c, self.__values.get(c, 0))

    def __getitem__(self, index):
        return self.get(_ALL[index], 0)

    def __repr__(self):
        return ('Money({})').format((', ').join([ ('{}').format(self.get(c)) for c in _ALL ]))

    def __iter__(self):
        for c in self.__getCurrenciesIterator(byWeight=False):
            yield self.__values[c]

    def __contains__(self, currency):
        return currency in self.__values

    def __add__(self, other):
        copy = self.copy()
        for c, _ in other.iteritems():
            if c in copy:
                copy.__values[c] += other.get(c)
            else:
                copy.__values[c] = other.get(c)

        return copy

    def __iadd__(self, other):
        return self.__add__(other)

    def __sub__(self, other):
        copy = self.copy()
        for c, _ in other.iteritems():
            if c in copy:
                copy.__values[c] -= other.get(c)
            else:
                copy.__values[c] = -other.get(c)

        return copy

    def __isub__(self, other):
        return self.__sub__(other)

    def __mul__(self, n):
        return self.__convert(lambda c, v, o: v * o, n)

    def __rmul__(self, n):
        return self.__mul__(n)

    def __div__(self, n):
        return self.__convert(lambda c, v, o: float(v) / o, n)

    def __rdiv__(self, n):
        return self.__div__(n)

    def __lt__(self, other):
        for c, v in self.iteritems():
            if c not in other or v >= other.get(c):
                return False

        return other.isDefined()

    def __le__(self, other):
        for c, v in self.iteritems():
            if c not in other or v > other.get(c):
                return False

        return True

    def __gt__(self, other):
        for c, v in self.iteritems():
            if v <= other.get(c):
                return False

        return self.isDefined()

    def __ge__(self, other):
        if other.isDefined():
            if self.isDefined():
                for c, v in self.iteritems():
                    if v < other.get(c):
                        return False

                return True
            return False
        return True

    def __eq__(self, other):
        for c in _ALL:
            if self.get(c) != other.get(c):
                return False

        return True

    def __ne__(self, other):
        for c in _ALL:
            if self.get(c) != other.get(c):
                return True

        return False

    def __nonzero__(self):
        for v in self:
            if v != 0:
                return True

        return False

    def __len__(self):
        return len(self.__values)

    def __convert(self, function, other):
        kwargs = {c:function(c, v, other) for c, v in self.__values.iteritems()}
        return Money(**kwargs)

    def __getCurrenciesIterator(self, byWeight=True):
        order = Currency.BY_WEIGHT if byWeight else _ALL
        for c in order:
            if c in self.__values:
                yield c

    @classmethod
    def __setValue(cls, values, currency, value):
        if value is None:
            if currency in values:
                del values[currency]
        else:
            values[currency] = value
        return


MONEY_UNDEFINED = Money()
MONEY_ZERO_CREDITS = Money(credits=0)
MONEY_ZERO_GOLD = Money(gold=0)
MONEY_ZERO_CRYSTAL = Money(crystal=0)
MONEY_ZERO_EVENT_COIN = Money(eventCoin=0)
MONEY_ZERO_BPCOIN = Money(bpcoin=0)
ZERO_MONEY = Money(**{c:0 for c in Currency.ALL})

class MoneySet(tuple):

    def __new__(cls, *moneys):
        return super(MoneySet, cls).__new__(cls, moneys)

    def toDictsList(self):
        return [ money.toSignDict() for money in self ]

    def getSum(self):
        money = MONEY_UNDEFINED
        for m in self:
            money += m

        return money

    def toMoneyTuple(self):
        return self.getSum().toMoneyTuple()

    @classmethod
    def makeFromMoneyTuple(cls, moneyTuple):
        return MoneySet([ Money.makeFrom(Currency.ALL[index], v) for index, v in enumerate(moneyTuple) if v != 0 ])


_CurrencyCollection = namedtuple('CurrencyCollection', Currency.ALL)
_CurrencyCollection.__new__.__defaults__ = len(Currency.ALL) * (None,)

class CurrencyCollection(_CurrencyCollection):

    def get(self, currency):
        return getattr(self, currency)

    def replace(self, currency, value):
        return self.replaceAll({currency: value})

    def replaceAll(self, values):
        return self._replace(**values)

    def copy(self):
        return CurrencyCollection(*self)

    def iteritems(self):
        for c in Currency.ALL:
            yield (
             c, self.get(c))

    def toDict(self):
        return {c:v for c, v in self.iteritems()}

    def __iter__(self):
        for c in Currency.ALL:
            yield self.get(c)