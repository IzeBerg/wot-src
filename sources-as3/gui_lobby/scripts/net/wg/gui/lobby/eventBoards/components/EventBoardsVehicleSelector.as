package net.wg.gui.lobby.eventBoards.components
{
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.lobby.components.VehicleSelectorFilter;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.eventBoards.data.VehicleRendererItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class EventBoardsVehicleSelector extends UIComponentEx
   {
       
      
      public var filtersView:VehicleSelectorFilter;
      
      public var table:ISortableTable = null;
      
      private var _dataProvider:IDataProvider = null;
      
      public function EventBoardsVehicleSelector()
      {
         super();
         this._dataProvider = new SortableVoDAAPIDataProvider(VehicleRendererItemVO);
         this.filtersView.mode = VehicleSelectorFilter.MODE_USER_VEHICLES;
      }
      
      override protected function onDispose() : void
      {
         this.table.removeEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onListVehicleRendererClickHandler);
         this.table.dispose();
         this.table = null;
         this.filtersView.dispose();
         this.filtersView = null;
         this._dataProvider = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.listDP = this._dataProvider;
         this.table.isListSelectable = true;
         this.table.addEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onListVehicleRendererClickHandler);
      }
      
      public function getListDP() : IDataProvider
      {
         return this._dataProvider;
      }
      
      public function getSelectedItem() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:VehicleRendererItemVO = null;
         if(this._dataProvider)
         {
            _loc1_ = this._dataProvider.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._dataProvider.requestItemAt(_loc2_) as VehicleRendererItemVO;
               if(_loc3_.selected)
               {
                  return _loc3_.dbID;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      public function setFiltersData(param1:VehicleSelectorFilterVO) : void
      {
         this.filtersView.setData(param1);
         this.filtersView.validateNow();
         this.filtersView.compatibleOnlyCheckBox.label = VEH_COMPARE.ADDVEHPOPOVER_SHOWONLYMYVAHICLES;
      }
      
      public function setHeaderDP(param1:IDataProvider) : void
      {
         this.table.headerDP = param1;
      }
      
      public function updateTableSortField(param1:String, param2:String) : void
      {
         this.table.setSelectedField(param1,param2);
      }
      
      private function onListVehicleRendererClickHandler(param1:VehicleSelectRendererEvent) : void
      {
         var _loc4_:VehicleRendererItemVO = null;
         var _loc2_:int = this._dataProvider.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = this._dataProvider.requestItemAt(_loc3_) as VehicleRendererItemVO;
            if(_loc4_.dbID == param1.dbID)
            {
               this.table.listSelectedIndex = _loc3_;
               this.table.validateNow();
            }
            _loc3_++;
         }
      }
   }
}
