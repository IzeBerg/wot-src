package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationAnchorIdVO extends DAAPIDataClass
   {
       
      
      public var areaId:Number = -1;
      
      public var propertySheetAlias:String = "";
      
      public var regionId:Number = -1;
      
      public function CustomizationAnchorIdVO(param1:Object)
      {
         super(param1);
      }
      
      public function equals(param1:DAAPIDataClass) : Boolean
      {
         return param1 is CustomizationAnchorIdVO && this.regionId == CustomizationAnchorIdVO(param1).regionId && this.propertySheetAlias == CustomizationAnchorIdVO(param1).propertySheetAlias && this.areaId == CustomizationAnchorIdVO(param1).areaId;
      }
   }
}
