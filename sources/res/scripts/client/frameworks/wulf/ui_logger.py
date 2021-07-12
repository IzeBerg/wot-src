from .py_object_binder import PyObjectEntity

class UILogger(PyObjectEntity):

    @classmethod
    def create(cls, proxy, model):
        manager = UILogger()
        manager.bind(proxy)
        proxy.setModel(model.proxy)
        return manager

    def getModel(self):
        return self.proxy.getModel()

    def destroy(self):
        if self.proxy is not None:
            self.proxy.clear()
        self.unbind()
        return