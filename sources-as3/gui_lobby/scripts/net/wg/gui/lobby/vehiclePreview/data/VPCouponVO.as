package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPCouponVO extends DAAPIDataClass
   {
       
      
      public var label:String = "";
      
      public var tooltip:String = "";
      
      public var icon:String = "";
      
      public var isSelected:Boolean = false;
      
      public var tooltipBonusesData:Array;
      
      public function VPCouponVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.tooltipBonusesData = null;
         super.onDispose();
      }
   }
}
