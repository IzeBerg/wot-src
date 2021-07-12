package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPSetItemsVO extends DAAPIDataClass
   {
      
      private static const ITEMS_DATA_FIELD_NAME:String = "items";
       
      
      public var blocks:Vector.<VPSetItemsBlockVO>;
      
      public function VPSetItemsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ITEMS_DATA_FIELD_NAME)
         {
            this.blocks = Vector.<VPSetItemsBlockVO>(App.utils.data.convertVOArrayToVector(param1,param2,VPSetItemsBlockVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
