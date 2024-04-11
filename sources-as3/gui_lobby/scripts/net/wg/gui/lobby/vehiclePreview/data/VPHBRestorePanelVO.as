package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class VPHBRestorePanelVO extends DAAPIDataClass
   {
      
      private static const ITEM_PRICE_DATA_FIELD_NAME:String = "price";
       
      
      public var uniqueVehicleTitle:String = "";
      
      public var isMoneyEnough:Boolean = false;
      
      public var shortage:int = -1;
      
      public var buyButtonEnabled:Boolean = false;
      
      public var buyButtonLabel:String = "";
      
      public var price:ItemPriceVO = null;
      
      public function VPHBRestorePanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ITEM_PRICE_DATA_FIELD_NAME && param2 is Array)
         {
            this.price = new ItemPriceVO(param2[0]);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.price)
         {
            this.price.dispose();
            this.price = null;
         }
         super.onDispose();
      }
   }
}
