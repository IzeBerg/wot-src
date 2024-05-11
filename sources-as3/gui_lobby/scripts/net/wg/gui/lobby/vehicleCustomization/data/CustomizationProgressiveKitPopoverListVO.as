package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationProgressiveKitPopoverListVO extends DAAPIDataClass
   {
      
      private static const ITEMS_FIELD_NAME:String = "items";
       
      
      private var _items:DataProvider = null;
      
      public function CustomizationProgressiveKitPopoverListVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == ITEMS_FIELD_NAME)
         {
            this._items = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._items.push(new CustomizationPopoverProgressiveItemRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._items != null)
         {
            for each(_loc1_ in this._items)
            {
               _loc1_.dispose();
            }
            this._items.cleanUp();
            this._items = null;
         }
         super.onDispose();
      }
      
      public function get items() : DataProvider
      {
         return this._items;
      }
   }
}
