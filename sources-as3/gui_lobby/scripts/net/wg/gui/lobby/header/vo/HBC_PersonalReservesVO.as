package net.wg.gui.lobby.header.vo
{
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   
   public class HBC_PersonalReservesVO extends HBC_AbstractVO
   {
       
      
      public function HBC_PersonalReservesVO(param1:Object = null)
      {
         super(param1);
         tooltip = TOOLTIPS_CONSTANTS.PERSONAL_RESERVES_WIDGET;
         tooltipType = TOOLTIP_WULF;
      }
      
      override protected function onDispose() : void
      {
         super.onDispose();
      }
   }
}
