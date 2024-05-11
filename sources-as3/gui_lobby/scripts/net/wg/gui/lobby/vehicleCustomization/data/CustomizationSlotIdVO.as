package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationSlotIdVO extends DAAPIDataClass
   {
       
      
      public var areaId:int = -1;
      
      public var slotType:int = -1;
      
      public var regionIdx:int = -1;
      
      public function CustomizationSlotIdVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:CustomizationSlotIdVO = param1 as CustomizationSlotIdVO;
         if(_loc2_ == null)
         {
            return false;
         }
         return this.regionIdx == _loc2_.regionIdx && this.slotType == _loc2_.slotType && this.areaId == _loc2_.areaId;
      }
      
      public function isEmpty() : Boolean
      {
         return this.regionIdx == Values.DEFAULT_INT && this.slotType == Values.DEFAULT_INT && this.areaId == Values.DEFAULT_INT;
      }
   }
}
