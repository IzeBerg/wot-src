package net.wg.gui.lobby.settings.feedback.ribbons
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.gui.lobby.settings.events.SettingsGroupEvent;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   
   public class ControlsContainer extends GroupContent implements IContentSize
   {
      
      private static const HEIGHT_OFFSET:int = 8;
       
      
      public var battleEventsLabel:TextField = null;
      
      public var battleEventsShowInBattleCheckbox:CheckBox = null;
      
      public var battleEventsEventNameCheckbox:CheckBox = null;
      
      public var battleEventsVehicleInfoCheckbox:CheckBox = null;
      
      public var damageControlsGroup:ControlsGroup;
      
      public var battleEfficiencyControlsGroup:ControlsGroup;
      
      public function ControlsContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleEventsLabel.text = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_LABEL_BATTLEEVENTS;
         this.battleEventsShowInBattleCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_SHOWINBATTLE;
         this.battleEventsEventNameCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_EVENTNAME;
         this.battleEventsVehicleInfoCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_VEHICLEINFO;
         this.damageControlsGroup.title = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_LABEL_NEGATIVE;
         this.battleEfficiencyControlsGroup.title = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_LABEL_POSITIVE;
         this.addEventListener(SettingsGroupEvent.ON_GROUP_STATE_CHANGE,this.onGroupStateChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(SettingsGroupEvent.ON_GROUP_STATE_CHANGE,this.onGroupStateChangeHandler);
         this.battleEventsShowInBattleCheckbox.dispose();
         this.battleEventsShowInBattleCheckbox = null;
         this.battleEventsLabel = null;
         this.battleEventsEventNameCheckbox.dispose();
         this.battleEventsEventNameCheckbox = null;
         this.battleEventsVehicleInfoCheckbox.dispose();
         this.battleEventsVehicleInfoCheckbox = null;
         super.onDispose();
      }
      
      public function getControlByName(param1:String) : IDisplayObject
      {
         return this[param1] || this.damageControlsGroup.getControlByName(param1) || this.battleEfficiencyControlsGroup.getControlByName(param1);
      }
      
      private function onGroupStateChangeHandler(param1:SettingsGroupEvent) : void
      {
         invalidateLayout();
      }
      
      public function get contentWidth() : Number
      {
         return this.width;
      }
      
      public function get contentHeight() : Number
      {
         return this.height + HEIGHT_OFFSET;
      }
   }
}
