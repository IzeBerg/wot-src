package net.wg.gui.lobby.vehicleCompare.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleCompareCartItemVO extends DAAPIDataClass
   {
       
      
      public var id:Number = NaN;
      
      public var index:int = -1;
      
      public var typeStr:String = "";
      
      public var nation:String = "";
      
      public var level:int = -1;
      
      public var vehicleName:String = "";
      
      public var complectation:String = "";
      
      public var smallIconPath:String = "";
      
      public var removeBtnTooltip:String = "";
      
      public var removeBtnEnabled:Boolean = true;
      
      public function VehicleCompareCartItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
