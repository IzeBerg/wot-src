package net.wg.gui.lobby.vehicleCompare.interfaces
{
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface ITopPanel extends IUIComponentEx
   {
       
      
      function setVehiclesData(param1:IDataProvider) : void;
      
      function setVehiclesCountText(param1:String) : void;
   }
}
