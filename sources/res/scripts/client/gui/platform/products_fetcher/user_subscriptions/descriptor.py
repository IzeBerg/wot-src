

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
    def platform(self):
        return self._params.get('platform')

    @property
    def hasNextBillingTime(self):
        return bool(self._params.get('next_billing_time'))