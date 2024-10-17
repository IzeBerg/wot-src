from collections import namedtuple
EmissionParams = namedtuple('EmissionParams', ('emissionTexture', 'emissionDeferredPower',
                                               'emissionForwardPower'))
EmissionParams.__new__.__defaults__ = ('', 1.0, 1.0)

def getEmissionParams(item):
    if item is not None and item.emissionParams is not None and item.emissionParams.emissionTexture:
        return EmissionParams(emissionTexture=item.emissionParams.emissionTexture, emissionDeferredPower=item.emissionParams.emissionDeferredPower, emissionForwardPower=item.emissionParams.emissionForwardPower)
    else:
        return