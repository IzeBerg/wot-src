from notification_base import NotificationBase
from gui.impl.gen.view_models.views.lobby.notifications.notification_model import NotificationModel

class SimpleNotification(NotificationBase):
    __slots__ = ()

    def __init__(self, resId, *args, **kwargs):
        model = NotificationModel()
        super(SimpleNotification, self).__init__(resId, model, *args, **kwargs)

    @property
    def viewModel(self):
        return super(SimpleNotification, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(SimpleNotification, self)._onLoading(*args, **kwargs)
        with self.viewModel.transaction() as (model):
            model.setIsPopUp(self._isPopUp)