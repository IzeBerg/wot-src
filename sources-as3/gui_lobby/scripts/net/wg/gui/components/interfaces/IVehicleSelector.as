package net.wg.gui.components.interfaces
{
   import flash.events.IEventDispatcher;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.interfaces.IDataProvider;
   
   public interface IVehicleSelector extends IDisposable, IEventDispatcher
   {
       
      
      function setHeaderDP(param1:IDataProvider) : void;
      
      function setFiltersData(param1:IVehicleSelectorFilterVO) : void;
      
      function getListDP() : IDataProvider;
      
      function updateTableSortField(param1:String, param2:String) : void;
   }
}
