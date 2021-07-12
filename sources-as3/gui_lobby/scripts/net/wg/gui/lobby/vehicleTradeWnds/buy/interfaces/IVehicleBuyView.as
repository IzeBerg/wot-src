package net.wg.gui.lobby.vehicleTradeWnds.buy.interfaces
{
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuySubmitVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IVehicleBuyView extends IUIComponentEx
   {
       
      
      function update(param1:VehicleBuyContentVo) : void;
      
      function updateTotalCredits(param1:Number) : void;
      
      function updateTotalGold(param1:Number) : void;
      
      function updateTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void;
      
      function getSubmitData() : VehicleBuySubmitVo;
      
      function memberTradeInIntCD(param1:Number) : void;
      
      function getActualHeight() : Number;
      
      function setTradeInWarningMessagege(param1:String) : void;
      
      function setTrainingButtonsEnableState(param1:Boolean, param2:Boolean, param3:Boolean) : void;
   }
}
