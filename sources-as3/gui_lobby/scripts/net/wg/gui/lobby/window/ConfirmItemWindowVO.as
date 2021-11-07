package net.wg.gui.lobby.window
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.VO.CompoundPriceVO;
   
   public class ConfirmItemWindowVO extends ConfirmItemWindowBaseVO
   {
      
      private static const FIELD_PRICE:String = "price";
      
      private static const ACTION_PRICE_DATA:String = "actionPriceData";
       
      
      public var id:int;
      
      public var currency:String = "";
      
      public var price:CompoundPriceVO;
      
      public var maxAvailableCount:Array;
      
      public var hasSeveralPrices:Boolean;
      
      public var actionPriceData:ActionPriceVO = null;
      
      public var stepSize:uint = 1;
      
      public function ConfirmItemWindowVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ACTION_PRICE_DATA && param2 != null)
         {
            this.actionPriceData = new ActionPriceVO(param2);
            return false;
         }
         if(param1 == FIELD_PRICE && param2 != null)
         {
            this.price = new CompoundPriceVO(param2 as Array);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.actionPriceData != null)
         {
            this.actionPriceData.dispose();
            this.actionPriceData = null;
         }
         if(this.price)
         {
            this.price.dispose();
            this.price = null;
         }
         this.maxAvailableCount.splice(0);
         this.maxAvailableCount = null;
         super.onDispose();
      }
   }
}
