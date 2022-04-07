package net.wg.gui.lobby.battleRoyale.vehicleInfoView.data
{
   import net.wg.gui.components.controls.tabs.OrangeTabsMenuVO;
   
   public class TabbedViewDataVO extends OrangeTabsMenuVO
   {
       
      
      public var tipText:String = "";
      
      public var tooltipComplexStr:String = "";
      
      public var tooltipSpecialId:String = "";
      
      public function TabbedViewDataVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[TabbedViewDataVO > " + "tipText: " + this.tipText + ", tooltipComplexStr: " + this.tooltipComplexStr + ", tooltipSpecialId: " + this.tooltipSpecialId + ", superClass: " + super.toString() + "]";
      }
   }
}
