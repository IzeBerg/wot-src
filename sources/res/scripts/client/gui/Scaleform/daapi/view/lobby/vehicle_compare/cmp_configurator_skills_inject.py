from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.lobby.vehicle_compare.skills_panel import CompareSkillsPanelView

class VehicleCompareConfiguratorSkillsInject(InjectComponentAdaptor):

    def _makeInjectView(self):
        skillsPanel = CompareSkillsPanelView()
        return skillsPanel

    def onCrewSkillUpdated(self):
        self.getInjectView().onCrewSkillUpdated()