import BigWorld

def findMarkerEntity():
    return [ e for e in BigWorld.entities.valuesOfType('EmptyEntity') if any(c.__class__.__name__ == 'EntityMarkerComponent' for c in e.dynamicComponents.itervalues())
           ]