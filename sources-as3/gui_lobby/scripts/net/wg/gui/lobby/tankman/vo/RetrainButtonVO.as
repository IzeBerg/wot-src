package net.wg.gui.lobby.tankman.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.PriceVO;
   
   public class RetrainButtonVO extends DAAPIDataClass
   {
      
      private static const PRICE_DATA_FIELD_NAME:String = "price";
       
      
      public var enabled:Boolean;
      
      public var isMoneyEnough:Boolean;
      
      public var isNativeVehicle:Boolean;
      
      public var showAction:Boolean;
      
      public var level:String = "";
      
      public var nation:String = "";
      
      public var price:PriceVO = null;
      
      public function RetrainButtonVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case PRICE_DATA_FIELD_NAME:
               this.price = new PriceVO(param2 as Array);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         this.price = null;
         super.onDispose();
      }
   }
}
