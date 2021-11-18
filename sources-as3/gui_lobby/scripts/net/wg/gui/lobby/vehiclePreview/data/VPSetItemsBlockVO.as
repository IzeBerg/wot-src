package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VPSetItemsBlockVO extends DAAPIDataClass
   {
      
      private static const ITEMS_DATA_FIELD_NAME:String = "items";
       
      
      public var items:Vector.<VPSetItemVO>;
      
      public var isEnabled:Boolean = true;
      
      public var topTitle:String = "";
      
      public var topTitleSmall:String = "";
      
      public function VPSetItemsBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ITEMS_DATA_FIELD_NAME)
         {
            this.items = Vector.<VPSetItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,VPSetItemVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VPSetItemVO = null;
         for each(_loc1_ in this.items)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this.items.splice(0,this.items.length);
         this.items = null;
         super.onDispose();
      }
   }
}
