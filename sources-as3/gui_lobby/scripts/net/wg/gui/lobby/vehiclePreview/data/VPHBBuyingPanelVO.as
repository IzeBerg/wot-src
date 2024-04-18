package net.wg.gui.lobby.vehiclePreview.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class VPHBBuyingPanelVO extends DAAPIDataClass
   {
      
      private static const PRICE_DATA_FIELD_NAME:String = "price";
       
      
      public var title:String = "";
      
      public var acceptBtnLabel:String = "";
      
      public var secondaryBtnLabel:String = "";
      
      public var price:ItemPriceVO = null;
      
      public var isFree:Boolean = false;
      
      public var shortage:int = -1;
      
      public function VPHBBuyingPanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PRICE_DATA_FIELD_NAME && param2 is Array)
         {
            this.price = new ItemPriceVO(param2[0]);
            if(this.price.action && this.price.action.getPriceVO())
            {
               this.price.action.getPriceVO().value = -this.price.action.getPriceVO().value;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.price != null)
         {
            this.price.dispose();
            this.price = null;
         }
         super.onDispose();
      }
   }
}
