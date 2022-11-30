from functools import wraps
from gui.impl import backport
from gui.impl.gen import R

def createBackportTooltipDecorator():

    def decorator(method):

        @wraps(method)
        def wrapper(self, event, *args, **kwargs):
            if event.contentID != R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
                return method(self, event, *args, **kwargs)
            else:
                tooltipData = self.getTooltipData(event)
                if tooltipData is None:
                    return
                window = backport.BackportTooltipWindow(tooltipData, self.getParentWindow())
                if window is None:
                    return
                window.load()
                return window

        return wrapper

    return decorator