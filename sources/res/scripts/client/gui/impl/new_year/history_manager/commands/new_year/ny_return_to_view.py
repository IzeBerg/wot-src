from gui.impl.new_year.history_manager.commands.return_to_view import ReturnToView
from gui.impl.new_year.navigation import NewYearNavigation

class NyReturnToView(ReturnToView):

    def execute(self):
        context = self.getContext()
        NewYearNavigation.switchToView(**context)