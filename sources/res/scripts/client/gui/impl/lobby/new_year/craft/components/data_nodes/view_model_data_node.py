from helpers import dependency
from skeletons.new_year import INewYearCraftMachineController
from .abstract_data_node import IAbstractDataNode

class ViewModelDataNode(IAbstractDataNode):
    _craftCtrl = dependency.descriptor(INewYearCraftMachineController)

    def __init__(self, viewModel):
        super(ViewModelDataNode, self).__init__()
        self._viewModel = viewModel

    def destroy(self):
        super(ViewModelDataNode, self).destroy()
        self._viewModel = None
        return

    def _onInit(self):
        self._initData(self._craftCtrl)
        self.updateData()

    def _onDestroy(self):
        if self._craftCtrl.isConnected:
            self._saveData(self._craftCtrl)

    def _initData(self, ctrl):
        pass

    def _saveData(self, ctrl):
        pass