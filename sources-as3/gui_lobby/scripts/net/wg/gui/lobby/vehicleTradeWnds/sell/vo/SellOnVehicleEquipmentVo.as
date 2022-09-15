package net.wg.gui.lobby.vehicleTradeWnds.sell.vo
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class SellOnVehicleEquipmentVo extends SellVehicleItemBaseVo
   {
       
      
      public var action:Object = null;
      
      public var actionVo:ActionPriceVO = null;
      
      public function SellOnVehicleEquipmentVo(param1:Object)
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
