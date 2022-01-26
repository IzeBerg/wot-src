package net.wg.gui.lobby.storage.categories.cards
{
   import net.wg.gui.components.controls.VO.ItemPriceVO;
   
   public class VehicleCardVO extends BaseCardVO
   {
      
      private static const TRADE_OFF_PRICE_FIELD:String = "tradeOffPrice";
       
      
      public var infoImgSrc:String = "";
      
      public var infoText:String = "";
      
      public var timerText:String = "";
      
      public var timerIcon:String = "";
      
      public var rentText:String = "";
      
      public var rentIcon:String = "";
      
      public var tradeOffPrice:ItemPriceVO = null;
      
      public function VehicleCardVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEqual(param1:BaseCardVO) : Boolean
      {
         var _loc2_:VehicleCardVO = param1 as VehicleCardVO;
         if(_loc2_ == null)
         {
            return false;
         }
         return super.isEqual(_loc2_) && this.infoImgSrc == _loc2_.infoImgSrc && this.infoText == _loc2_.infoText && this.timerText == _loc2_.timerText && this.timerIcon == _loc2_.timerIcon && this.rentText == _loc2_.rentText && this.rentIcon == _loc2_.rentIcon && (this.tradeOffPrice == _loc2_.tradeOffPrice || this.tradeOffPrice && this.tradeOffPrice.isEqual(_loc2_.tradeOffPrice));
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TRADE_OFF_PRICE_FIELD && param2 != null)
         {
            this.tradeOffPrice = new ItemPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.tradeOffPrice)
         {
            this.tradeOffPrice.dispose();
            this.tradeOffPrice = null;
         }
         super.onDispose();
      }
      
      override public function toString() : String
      {
         return "[VehicleCardVO > id: " + id + ", image: " + image + "]";
      }
   }
}
