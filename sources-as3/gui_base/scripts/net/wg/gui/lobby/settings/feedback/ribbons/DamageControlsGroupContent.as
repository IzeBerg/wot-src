package net.wg.gui.lobby.settings.feedback.ribbons
{
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.InfoIcon;
   
   public class DamageControlsGroupContent extends GroupContent
   {
       
      
      public var battleEventsReceivedDamageCheckbox:CheckBox = null;
      
      public var battleEventsReceivedCritsCheckbox:CheckBox = null;
      
      public var battleEventsBlockedDamageCheckbox:CheckBox = null;
      
      public function DamageControlsGroupContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleEventsBlockedDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_BLOCKEDDAMAGE;
         this.battleEventsReceivedDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_RECEIVEDDAMAGE;
         this.battleEventsReceivedDamageCheckbox.toolTip = TOOLTIPS.SETTINGS_RIBBONS_RECEIVEDDAMAGE;
         this.battleEventsReceivedDamageCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.battleEventsReceivedCritsCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_RECEIVEDCRITS;
      }
      
      override protected function onDispose() : void
      {
         this.battleEventsBlockedDamageCheckbox.dispose();
         this.battleEventsBlockedDamageCheckbox = null;
         this.battleEventsReceivedDamageCheckbox.dispose();
         this.battleEventsReceivedDamageCheckbox = null;
         this.battleEventsReceivedCritsCheckbox.dispose();
         this.battleEventsReceivedCritsCheckbox = null;
         super.onDispose();
      }
   }
}
