package net.wg.gui.lobby.vehicleTradeWnds.sell.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class SellVehicleItemBaseVo extends DAAPIDataClass
   {
      
      private static const REMOVE_ACTION_PRICE_LBL:String = "removeActionPrice";
       
      
      public var itemID:Number = -1;
      
      public var toInventory:Boolean = false;
      
      public var sellPrice:Array = null;
      
      public var removePrice:Object = null;
      
      public var removeCurrency:String = "";
      
      public var removeActionPrice:ActionPriceVO = null;
      
      public var count:Number = 1;
      
      public var onlyToInventory:Boolean = false;
      
      public var userName:String = "";
      
      public function SellVehicleItemBaseVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == REMOVE_ACTION_PRICE_LBL && param2 != null)
         {
            this.removeActionPrice = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.sellPrice)
         {
            this.sellPrice.splice(0,this.sellPrice.length);
            this.sellPrice = null;
         }
         if(this.removePrice)
         {
            App.utils.data.cleanupDynamicObject(this.removePrice);
            this.removePrice = null;
         }
         if(this.removeActionPrice)
         {
            this.removeActionPrice.dispose();
            this.removeActionPrice = null;
         }
         super.onDispose();
      }
   }
}
