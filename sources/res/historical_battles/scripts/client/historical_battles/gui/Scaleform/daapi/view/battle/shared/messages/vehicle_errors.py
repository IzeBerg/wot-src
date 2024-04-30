from gui.doc_loaders import messages_panel_reader
from gui.Scaleform.daapi.view.battle.shared.messages import vehicle_errors
_HB_VEHICLE_ERROR_MESSAGES_PATH = 'historical_battles/gui/vehicle_errors_panel.xml'

class HistoricalBattlesVehicleErrorMessages(vehicle_errors.VehicleErrorMessages):

    def _populate(self):
        super(HistoricalBattlesVehicleErrorMessages, self)._populate()
        _, _, messages = messages_panel_reader.readXML(_HB_VEHICLE_ERROR_MESSAGES_PATH)
        self._messages.update(messages)