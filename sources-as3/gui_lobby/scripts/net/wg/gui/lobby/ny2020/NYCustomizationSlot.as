package net.wg.gui.lobby.ny2020
{
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class NYCustomizationSlot extends SoundButtonEx
   {
       
      
      public function NYCustomizationSlot()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabledOnDisabled = true;
         tooltip = TOOLTIPS_CONSTANTS.NY_VEHICLE_BONUS;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
      }
      
      override protected function showTooltip() : void
      {
         if(_tooltip && App.toolTipMgr)
         {
            _isTooltipShown = true;
            App.toolTipMgr.showWulfTooltip(_tooltip);
         }
      }
   }
}
