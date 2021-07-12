package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class CustomizationPopoverItemRendererVO extends DAAPIDataClass
   {
      
      private static const FIELD_PRICE:String = "price";
       
      
      public var id:int = -1;
      
      public var icon:String = "";
      
      public var userName:String = "";
      
      public var numItems:String = "";
      
      public var isWide:Boolean = false;
      
      public var isDim:Boolean = false;
      
      public var isApplied:Boolean = false;
      
      public var isHistoric:Boolean = false;
      
      public var price:ItemPriceVO = null;
      
      public var itemsList:Object = null;
      
      public var isTitle:Boolean = false;
      
      public var progressionLevel:int = -1;
      
      public function CustomizationPopoverItemRendererVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FIELD_PRICE && param2 != null)
         {
            this.price = new ItemPriceVO(param2);
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
