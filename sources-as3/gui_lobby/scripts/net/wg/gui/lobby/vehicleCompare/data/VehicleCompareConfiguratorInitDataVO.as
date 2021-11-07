package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleCompareConfiguratorInitDataVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var resetBtnLabel:String = "";
      
      public var cancelBtnLabel:String = "";
      
      public var applyBtnLabel:String = "";
      
      public var resetBtnTooltip:String = "";
      
      public var cancelBtnTooltip:String = "";
      
      public var applyBtnTooltip:String = "";
      
      public function VehicleCompareConfiguratorInitDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
