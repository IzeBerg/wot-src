_focusedComponent = None

def getFocusedComponent():
    global _focusedComponent
    return _focusedComponent


def setFocusedComponent(newFocus):
    global _focusedComponent
    if newFocus != _focusedComponent:
        if _focusedComponent is not None:
            _focusedComponent.focus = False
        _focusedComponent = newFocus
        if newFocus is not None:
            newFocus.focus = True
    return


def isFocusedComponent(component):
    if _focusedComponent is None or component is None:
        return _focusedComponent is component
    else:
        return _focusedComponent.__str__() == component.__str__()