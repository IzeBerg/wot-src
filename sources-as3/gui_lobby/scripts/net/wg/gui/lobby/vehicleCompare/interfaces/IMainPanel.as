package net.wg.gui.lobby.vehicleCompare.interfaces
{
   import net.wg.gui.lobby.vehicleCompare.data.VehCompareParamsDeltaVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface IMainPanel extends IUIComponentEx
   {
       
      
      function setVehicleParams(param1:IDataProvider) : void;
      
      function setVehiclesData(param1:IDataProvider) : void;
      
      function setParamsDelta(param1:VehCompareParamsDeltaVO) : void;
   }
}
