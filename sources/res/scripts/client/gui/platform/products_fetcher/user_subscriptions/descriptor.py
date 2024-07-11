import time, calendar

class UserSubscriptionDescriptor(object):

    def __init__(self, data):
        self._params = data

    @property
    def productCode(self):
        return self._params.get('product_code')

    @property
    def status(self):
        return self._params.get('status')

    @property
    def nextBilling(self):
        if self._params.get('next_billing_time') is None:
            return 0
        else:
            return int(calendar.timegm(time.strptime(self._params.get('next_billing_time'), '%Y-%m-%dT%H:%M:%SZ')))