package net.wg.gui.lobby.settings
{
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   
   public class SettingsSniperForm extends SettingsArcadeForm
   {
      
      private static const CROSSHAIR_SNIPER_COUNTER_CONTAINER_ID:String = "CROSSHAIR_SNIPER_COUNTER_CONTAINER_ID";
       
      
      public var zoomIndicatorLabel:LabelControl = null;
      
      public var zoomIndicatorValue:LabelControl = null;
      
      public var zoomIndicatorSlider:Slider = null;
      
      public function SettingsSniperForm()
      {
         super();
      }
      
      override protected function getContainerId() : String
      {
         return CROSSHAIR_SNIPER_COUNTER_CONTAINER_ID;
      }
      
      override protected function onDispose() : void
      {
         this.zoomIndicatorLabel.dispose();
         this.zoomIndicatorLabel = null;
         this.zoomIndicatorValue.dispose();
         this.zoomIndicatorValue = null;
         this.zoomIndicatorSlider.dispose();
         this.zoomIndicatorSlider = null;
         super.onDispose();
      }
      
      override protected function disableAllControls() : void
      {
         super.disableAllControls();
         this.zoomIndicatorLabel.enabled = false;
         this.zoomIndicatorValue.enabled = false;
         this.zoomIndicatorSlider.enabled = false;
      }
   }
}
