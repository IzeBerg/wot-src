__all__ = ('makeIndexes', 'makePath')
_SEPARATOR = '/'
_chains = []

def makeIndexes(path):
    chains = path.split(_SEPARATOR)
    for chain in chains:
        if chain not in _chains:
            yield len(_chains)
            _chains.append(chain)
        else:
            yield _chains.index(chain)


def makePath(*indexes):
    chains = []
    for index in indexes:
        chains.append(_chains[index])

    return _SEPARATOR.join(chains)