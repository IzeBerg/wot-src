package net.wg.gui.components.carousels
{
   import flash.events.Event;
   import net.wg.data.constants.VehicleTypes;
   import net.wg.gui.components.carousels.controls.RolesContainer;
   import net.wg.gui.components.carousels.data.FilterRoleItemData;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   
   public class FilterPopoverContent extends VehiclesFilterPopoverContent
   {
       
      
      public var rolesContainer:RolesContainer = null;
      
      private var _rolesData:FilterRoleItemData = null;
      
      private var _selectedVehType:String = null;
      
      private var _setListState:Boolean = false;
      
      public function FilterPopoverContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rolesContainer.addEventListener(Event.RESIZE,this.onRolesContainerResizeHandler);
         this.rolesContainer.addEventListener(Event.COMPLETE,this.onRolesContainerCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.rolesContainer.removeEventListener(Event.RESIZE,this.onRolesContainerResizeHandler);
         this.rolesContainer.removeEventListener(Event.COMPLETE,this.onRolesContainerCompleteHandler);
         this.rolesContainer.dispose();
         this.rolesContainer = null;
         if(this._rolesData != null)
         {
            this._rolesData.dispose();
            this._rolesData = null;
         }
         super.onDispose();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = listVehicleType.y + listVehicleType.height + LIST_OFFSET;
         if(this.rolesContainer.visible)
         {
            this.rolesContainer.y = _loc1_;
            _loc1_ += this.rolesContainer.height;
         }
         setSize(width,getNewHeight(_loc1_));
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      override protected function updateState() : void
      {
         super.updateState();
         var _loc1_:Boolean = stateData.rolesSectionVisible;
         this.rolesContainer.setAnimVisibility(_loc1_);
         this._setListState = _loc1_;
         if(_loc1_)
         {
            this.updateRolesContainerData(false);
         }
         else
         {
            this.rolesContainer.clearList();
         }
         invalidateSize();
      }
      
      override protected function updateData() : void
      {
         var _loc1_:Boolean = false;
         super.updateData();
         _loc1_ = initData.rolesSectionVisible;
         this.rolesContainer.visible = _loc1_;
         if(_loc1_)
         {
            this.updateRolesContainerData(true);
         }
         invalidateSize();
      }
      
      private function updateRolesContainerData(param1:Boolean) : void
      {
         var _loc2_:String = !!param1 ? initData.rolesLabel : stateData.rolesLabel;
         var _loc3_:int = this.getSelectedVehTypeIdx(param1);
         this._selectedVehType = VehicleTypes.CAROUSEL_FILTER_ORDER[_loc3_];
         if(this._rolesData)
         {
            this._rolesData.dispose();
         }
         this._rolesData = new FilterRoleItemData(initData.rolesSectionId,_loc2_,initData.roles.getDataProvider(this._selectedVehType),_loc3_);
         this.rolesContainer.setData(this._rolesData);
      }
      
      private function getSelectedVehTypeIdx(param1:Boolean) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:SimpleRendererVO = null;
         if(param1)
         {
            _loc3_ = initData.vehicleTypes.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc4_ = initData.vehicleTypes[_loc2_];
               if(_loc4_.selected)
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         else
         {
            _loc3_ = stateData.vehicleTypesSelected.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(stateData.vehicleTypesSelected[_loc2_])
               {
                  return _loc2_;
               }
               _loc2_++;
            }
         }
         return -1;
      }
      
      private function onRolesContainerCompleteHandler(param1:Event) : void
      {
         if(this._setListState)
         {
            this._setListState = false;
            listSetState(this.rolesContainer.listRoles,stateData.rolesStates.getStates(this._selectedVehType));
         }
      }
      
      private function onRolesContainerResizeHandler(param1:Event) : void
      {
         invalidateSize();
         validateNow();
      }
   }
}
