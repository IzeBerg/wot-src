package net.wg.gui.lobby.storage.categories.forsell
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.PriceVO;
   
   public class StorageCategoryForSellVO extends DAAPIDataClass
   {
      
      private static const PRICE_DATA_FIELD_NAME:String = "price";
       
      
      public var allItemsSelected:Boolean;
      
      public var sellButtonEnabled:Boolean;
      
      public var price:PriceVO = null;
      
      public function StorageCategoryForSellVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PRICE_DATA_FIELD_NAME && param2 is Array)
         {
            this.price = new PriceVO(param2 as Array);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.price != null)
         {
            this.price = null;
         }
         super.onDispose();
      }
   }
}
