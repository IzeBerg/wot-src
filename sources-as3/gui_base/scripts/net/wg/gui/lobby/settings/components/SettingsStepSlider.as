package net.wg.gui.lobby.settings.components
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.StepSlider;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   
   [InspectableList("valueLabel")]
   public class SettingsStepSlider extends StepSlider
   {
      
      private static const SUPPORTED_STR:String = "supported";
      
      private static const ADVANCED_STR:String = "advanced";
       
      
      private var _inAdvancedMode:Boolean = true;
      
      public function SettingsStepSlider()
      {
         super();
      }
      
      override protected function checkIsItemDisabled(param1:Object) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = !!param1.hasOwnProperty(SUPPORTED_STR) ? Boolean(param1[SUPPORTED_STR]) : Boolean(true);
         if(_loc3_)
         {
            if(!this._inAdvancedMode && param1.hasOwnProperty(ADVANCED_STR))
            {
               _loc2_ = param1[ADVANCED_STR];
            }
         }
         else
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      override protected function updateValueLabel() : void
      {
         if(valueLabelControl && !this._inAdvancedMode && name == SettingsConfigHelper.SHADOWS_QUALITY + SettingsConfigHelper.TYPE_STEP_SLIDER)
         {
            LabelControl(valueLabelControl).text = SETTINGS.GRAPHICSSETTINGSOPTIONS_OFF;
         }
         else
         {
            super.updateValueLabel();
         }
      }
      
      override protected function getItemTooltip(param1:Object) : String
      {
         return App.utils.locale.makeString(getItemLabel(param1));
      }
      
      public function set inAdvancedMode(param1:Boolean) : void
      {
         this._inAdvancedMode = param1;
         invalidateData();
      }
      
      override protected function onScrollWheel(param1:MouseEvent) : void
      {
      }
   }
}
