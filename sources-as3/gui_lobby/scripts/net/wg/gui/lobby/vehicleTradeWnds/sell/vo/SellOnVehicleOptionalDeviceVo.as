package net.wg.gui.lobby.vehicleTradeWnds.sell.vo
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class SellOnVehicleOptionalDeviceVo extends SellVehicleItemBaseVo
   {
       
      
      public var isRemovable:Boolean = false;
      
      public var isModernized:Boolean = false;
      
      public var action:Object = null;
      
      public var actionVo:ActionPriceVO = null;
      
      public var alertIconDataID:String = "";
      
      public var isAlertVisible:Boolean = false;
      
      public function SellOnVehicleOptionalDeviceVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         App.utils.data.cleanupDynamicObject(this.action);
         this.action = null;
         if(this.actionVo)
         {
            this.actionVo.dispose();
            this.actionVo = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == "action")
         {
            this.action = param2;
            if(this.action)
            {
               this.actionVo = new ActionPriceVO(this.action);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
