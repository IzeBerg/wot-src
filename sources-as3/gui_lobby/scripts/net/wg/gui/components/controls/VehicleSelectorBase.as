package net.wg.gui.components.controls
{
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.interfaces.IVehicleSelector;
   import net.wg.gui.components.interfaces.IVehicleSelectorFilter;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VehicleSelectorBase extends UIComponentEx implements IVehicleSelector
   {
       
      
      public var filtersView:IVehicleSelectorFilter;
      
      public var table:ISortableTable = null;
      
      protected var dataProvider:IDataProvider = null;
      
      public function VehicleSelectorBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.table.dispose();
         this.table = null;
         this.filtersView.dispose();
         this.filtersView = null;
         this.dataProvider = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.listDP = this.dataProvider;
      }
      
      public function getListDP() : IDataProvider
      {
         return this.dataProvider;
      }
      
      public function setFiltersData(param1:IVehicleSelectorFilterVO) : void
      {
         this.filtersView.setData(param1);
         this.filtersView.validateNow();
      }
      
      public function setHeaderDP(param1:IDataProvider) : void
      {
         this.table.headerDP = param1;
      }
      
      public function updateTableSortField(param1:String, param2:String) : void
      {
         this.table.setSelectedField(param1,param2);
      }
   }
}
