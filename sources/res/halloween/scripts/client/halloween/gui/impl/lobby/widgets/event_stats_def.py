from gui.impl.wrappers.function_helpers import replaceNoneKwargsModel
from halloween.gui.impl.gen.view_models.views.common.stat_column_settings_model import ColumnEnum
from halloween.gui.impl.lobby.widgets.event_stats import EventStats

class EventStatsDef(EventStats):

    @replaceNoneKwargsModel
    def _updateColumns(self, model=None):
        columns = model.columnSettings.getVisibleColumns()
        columns.clear()
        columns.addString(ColumnEnum.DAMAGE.value)
        columns.addString(ColumnEnum.KILLS.value)
        columns.invalidate()