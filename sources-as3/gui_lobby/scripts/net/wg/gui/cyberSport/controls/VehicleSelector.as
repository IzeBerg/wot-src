package net.wg.gui.cyberSport.controls
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SortingInfo;
   import net.wg.data.constants.generated.VEHICLE_SELECTOR_CONSTANTS;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.advanced.SortingButton;
   import net.wg.gui.components.advanced.SortingButtonVO;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.ScrollingListWithDisRenderers;
   import net.wg.gui.components.controls.events.SortableScrollingListEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorEvent;
   import net.wg.gui.cyberSport.controls.events.VehicleSelectorItemEvent;
   import net.wg.gui.cyberSport.vo.VehicleSelectorItemVO;
   import net.wg.gui.events.SortingEvent;
   import net.wg.gui.lobby.components.VehicleSelectorFilter;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.rally.vo.VehicleAlertVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class VehicleSelector extends UIComponentEx implements IViewStackContent
   {
      
      private static const INVALID_SELECTION_MODE:String = "invalidSelectionMode";
      
      private static const INVALID_FILTERS_MODE:String = "invalidFiltersMode";
      
      private static const BTNS_HEADER_HEIGHT:int = 30;
      
      private static const HEADER_SELECTED_ID:String = "selected";
      
      private static const HEADER_SELECTED_WIDTH:int = 39;
      
      private static const HEADER_SELECTED_SORT_ORDER:int = 4;
      
      private static const HEADER_NATION_ORDER_IDX_ID:String = "nationOrderIdx";
      
      private static const HEADER_NATION_ORDER_IDX_MULTI_WIDTH:int = 29;
      
      private static const HEADER_NATION_ORDER_IDX_WIDTH:int = 39;
      
      private static const HEADER_NATION_ORDER_IDX_SORT_ORDER:int = 0;
      
      private static const HEADER_TYPE_INDEX_ID:String = "typeIndex";
      
      private static const HEADER_TYPE_INDEX_WIDTH:int = 40;
      
      private static const HEADER_TYPE_INDEX_SORT_ORDER:int = 1;
      
      private static const HEADER_LEVEL_ID:String = "level";
      
      private static const HEADER_LEVEL_WIDTH:int = 28;
      
      private static const HEADER_LEVEL_SORT_ORDER:int = 2;
      
      private static const HEADER_SHORT_USER_NAME_ID:String = "shortUserName";
      
      private static const HEADER_SHORT_USER_NAME_MULTI_WIDTH:int = 207;
      
      private static const HEADER_SHORT_USER_NAME_WIDTH:int = 237;
      
      private static const HEADER_SHORT_USER_NAME_SORT_ORDER:int = 3;
      
      private static const HEADER_PRICE_ID:String = "price";
      
      private static const HEADER_PRICE_WIDTH:int = 170;
      
      private static const HEADER_PRICE_SORT_ORDER:int = 5;
      
      private static const LIST_MULTI_OFFSET:int = 35;
      
      private static const HEADER_NO_FILTERS_Y:int = -5;
      
      private static const HEADER_DEFAULT_Y:int = 61;
      
      private static const LIST_OFFSET:int = 31;
      
      private static const LIST_DEFAULT_WIDTH:int = 342;
      
      private static const HEADER_WIDTH_OFFSET:int = 2;
       
      
      public var filtersView:VehicleSelectorFilter;
      
      public var allCheckBox:CheckBox;
      
      public var header:SortableHeaderButtonBar;
      
      public var list:ScrollingListWithDisRenderers;
      
      private var _multiSelection:Boolean = false;
      
      private var _filtersMode:String = "allVehicles";
      
      private var _selectedItemVO:VehicleSelectorItemVO;
      
      private var _ignoreAllCheckBoxChange:Boolean = false;
      
      private var _isOverridesInitialized:Boolean = false;
      
      private var _localSelectionOverrides:Vector.<SelectionInfo>;
      
      private var _filtersCBVisible:Boolean = true;
      
      private var _filtersDDsVisible:Boolean = true;
      
      private var _classFactory:IClassFactory;
      
      private var _listHeight:Number;
      
      public function VehicleSelector()
      {
         this._localSelectionOverrides = new Vector.<SelectionInfo>();
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.allCheckBox.label = CYBERSPORT.WINDOW_VEHICLESELECTOR_FILTERS_ALL;
         this.allCheckBox.addEventListener(Event.SELECT,this.onAllCheckBoxSelectHandler);
         this.list.smartScrollBar = true;
         this.list.setSelectionNavigator(new VehicleSelectorNavigator());
         this.list.addEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.onListSelectVehicleHandler);
         this.list.addEventListener(SortableScrollingListEvent.SORT_APPLIED,this.onListSortAppliedHandler);
         this.header.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onHeaderSortDirectionChangedHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_SELECTION_MODE))
         {
            this.header.dataProvider = this.getHeaderDP();
            this.list.columnsData = this.header.dataProvider;
            this.allCheckBox.visible = this._multiSelection;
         }
         if(isInvalid(INVALID_FILTERS_MODE))
         {
            this.filtersView.mode = this.filtersMode;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            setActualSize(_width,_height);
            this.header.y = !this._filtersCBVisible && !this._filtersDDsVisible ? Number(HEADER_NO_FILTERS_Y) : Number(HEADER_DEFAULT_Y);
            this.list.y = this.header.y + LIST_OFFSET;
            this.list.width = LIST_DEFAULT_WIDTH;
            this.header.width = this.list.width + HEADER_WIDTH_OFFSET;
            if(isNaN(this._listHeight))
            {
               this.list.height = _height - this.list.y - (!!this._multiSelection ? LIST_MULTI_OFFSET : 0);
            }
            else
            {
               this.list.height = this._listHeight;
            }
            setActualScale(1,1);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.allCheckBox.removeEventListener(Event.SELECT,this.onAllCheckBoxSelectHandler);
         this.allCheckBox.dispose();
         this.allCheckBox = null;
         this.filtersView.dispose();
         this.filtersView = null;
         this.list.removeEventListener(VehicleSelectorItemEvent.SELECT_VEHICLE,this.onListSelectVehicleHandler);
         this.list.removeEventListener(SortableScrollingListEvent.SORT_APPLIED,this.onListSortAppliedHandler);
         this.list.dispose();
         this.list = null;
         this.header.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onHeaderSortDirectionChangedHandler,false);
         this.header.dispose();
         this.header = null;
         this._localSelectionOverrides.splice(0,this._localSelectionOverrides.length);
         this._localSelectionOverrides = null;
         this._selectedItemVO = null;
         this._classFactory = null;
         super.onDispose();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function getSelectedDescriptors() : Array
      {
         var _loc2_:VehicleSelectorItemVO = null;
         var _loc3_:SelectionInfo = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.list.dataProvider)
         {
            if(_loc2_.selected)
            {
               _loc1_.push(_loc2_.intCD);
            }
         }
         for each(_loc3_ in this._localSelectionOverrides)
         {
            if(_loc3_.selected && _loc1_.indexOf(_loc3_.vehicle.intCD) == -1)
            {
               _loc1_.push(_loc3_.vehicle.intCD);
            }
         }
         return _loc1_;
      }
      
      public function getSelectedVehicles() : Array
      {
         var _loc3_:VehicleSelectorItemVO = null;
         var _loc4_:SelectionInfo = null;
         var _loc1_:Array = [];
         var _loc2_:Vector.<uint> = new Vector.<uint>();
         for each(_loc3_ in this.list.dataProvider)
         {
            if(_loc3_.selected)
            {
               _loc1_.push(_loc3_);
               _loc2_.push(_loc3_.intCD);
            }
         }
         for each(_loc4_ in this._localSelectionOverrides)
         {
            if(_loc4_.selected && _loc2_.indexOf(_loc4_.vehicle.intCD) == -1)
            {
               _loc1_.push(_loc4_.vehicle);
            }
         }
         return _loc1_;
      }
      
      public function setFiltersData(param1:VehicleSelectorFilterVO) : void
      {
         this.filtersView.setData(param1);
         var _loc2_:int = param1.visibility;
         this._filtersCBVisible = Boolean(_loc2_ & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_COMPATIBLE_ONLY);
         this._filtersDDsVisible = Boolean(_loc2_ & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_LEVEL) || Boolean(_loc2_ & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_NATION) || Boolean(_loc2_ & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_VEHICLE_TYPE) || Boolean(_loc2_ & VEHICLE_SELECTOR_CONSTANTS.VISIBLE_IS_MAIN);
         invalidateSize();
      }
      
      public function setListItems(param1:DataProvider) : void
      {
         if(this.list.dataProvider)
         {
            this._selectedItemVO = null;
         }
         this.applyOverrides(param1);
         this.list.dataProvider = param1;
         this.header.selectedIndex = !!this.multiSelection ? int(HEADER_SHORT_USER_NAME_SORT_ORDER) : int(HEADER_LEVEL_SORT_ORDER);
         this.list.sortByField(HEADER_LEVEL_ID,false);
         this.dispatchUpdate();
      }
      
      public function setListRenderer(param1:String) : void
      {
         this.list.itemRenderer = this._classFactory.getClass(param1);
         invalidateSize();
      }
      
      public function setupSelectionOverrides(param1:Array) : void
      {
         var _loc2_:VehicleAlertVO = null;
         if(!this._isOverridesInitialized)
         {
            for each(_loc2_ in param1)
            {
               this.updateOverride(_loc2_,true);
            }
            this._isOverridesInitialized = true;
         }
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:DataProvider = param1 as DataProvider;
         App.utils.asserter.assertNotNull(_loc2_,"items " + Errors.CANT_NULL);
         this.setListItems(_loc2_);
      }
      
      private function getOverride(param1:VehicleAlertVO) : SelectionInfo
      {
         var _loc2_:SelectionInfo = null;
         var _loc3_:SelectionInfo = null;
         for each(_loc3_ in this._localSelectionOverrides)
         {
            if(_loc3_.vehicle.intCD == param1.intCD)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
      
      private function updateOverride(param1:VehicleAlertVO, param2:Boolean) : void
      {
         var _loc3_:SelectionInfo = this.getOverride(param1);
         if(_loc3_)
         {
            _loc3_.selected = param2;
         }
         else
         {
            _loc3_ = new SelectionInfo(param1,param2);
            this._localSelectionOverrides.push(_loc3_);
         }
      }
      
      private function applyOverrides(param1:Array) : void
      {
         var _loc2_:VehicleSelectorItemVO = null;
         var _loc3_:SelectionInfo = null;
         for each(_loc2_ in param1)
         {
            _loc3_ = this.getOverride(_loc2_);
            if(_loc3_)
            {
               if(this._multiSelection)
               {
                  _loc2_.selected = _loc3_.selected;
               }
               else
               {
                  this._selectedItemVO = _loc2_;
               }
            }
         }
      }
      
      private function checkAllSelected() : void
      {
         var _loc3_:VehicleSelectorItemVO = null;
         var _loc4_:Boolean = false;
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         for each(_loc3_ in this.list.dataProvider)
         {
            _loc1_ += int(_loc3_.enabled);
            _loc2_ += int(_loc3_.selected);
         }
         _loc4_ = _loc1_ > 0 && _loc1_ == _loc2_;
         if(this.allCheckBox.selected != _loc4_)
         {
            this._ignoreAllCheckBoxChange = true;
            this.allCheckBox.selected = _loc4_;
            this._ignoreAllCheckBoxChange = false;
         }
      }
      
      private function getHeaderDP() : IDataProvider
      {
         var _loc2_:SortingButtonVO = null;
         var _loc1_:Array = [];
         if(this.multiSelection)
         {
            _loc2_ = new SortingButtonVO({});
            _loc2_.id = HEADER_SELECTED_ID;
            _loc2_.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_OK;
            _loc2_.buttonWidth = HEADER_SELECTED_WIDTH;
            _loc2_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
            _loc2_.sortOrder = HEADER_SELECTED_SORT_ORDER;
            _loc1_.push(_loc2_);
         }
         _loc2_ = new SortingButtonVO({});
         _loc2_.id = HEADER_NATION_ORDER_IDX_ID;
         _loc2_.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_NATIONS_ALL;
         _loc2_.buttonWidth = !!this.multiSelection ? Number(HEADER_NATION_ORDER_IDX_MULTI_WIDTH) : Number(HEADER_NATION_ORDER_IDX_WIDTH);
         _loc2_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         _loc2_.inverted = true;
         _loc2_.sortOrder = HEADER_NATION_ORDER_IDX_SORT_ORDER;
         _loc2_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_NATION;
         _loc1_.push(_loc2_);
         _loc2_ = new SortingButtonVO({});
         _loc2_.id = HEADER_TYPE_INDEX_ID;
         _loc2_.iconSource = RES_ICONS.MAPS_ICONS_FILTERS_TANKS_ALL;
         _loc2_.buttonWidth = HEADER_TYPE_INDEX_WIDTH;
         _loc2_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         _loc2_.sortOrder = HEADER_TYPE_INDEX_SORT_ORDER;
         _loc2_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_VEHTYPE;
         _loc1_.push(_loc2_);
         _loc2_ = new SortingButtonVO({});
         _loc2_.id = HEADER_LEVEL_ID;
         _loc2_.iconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_LEVEL;
         _loc2_.buttonWidth = HEADER_LEVEL_WIDTH;
         _loc2_.defaultSortDirection = SortingInfo.DESCENDING_SORT;
         _loc2_.sortOrder = HEADER_LEVEL_SORT_ORDER;
         _loc2_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_VEHLVL;
         _loc1_.push(_loc2_);
         _loc2_ = new SortingButtonVO({});
         _loc2_.id = HEADER_SHORT_USER_NAME_ID;
         _loc2_.label = PROFILE.SECTION_TECHNIQUE_BUTTONBAR_VEHICLENAME;
         _loc2_.buttonWidth = !!this.multiSelection ? Number(HEADER_SHORT_USER_NAME_MULTI_WIDTH) : Number(HEADER_SHORT_USER_NAME_WIDTH);
         _loc2_.defaultSortDirection = SortingInfo.ASCENDING_SORT;
         _loc2_.sortOrder = HEADER_SHORT_USER_NAME_SORT_ORDER;
         _loc2_.toolTip = TOOLTIPS.VEHICLESELECTOR_SORTING_VEHNAME;
         _loc2_.sortType = SortingButtonVO.SORT_STRING;
         _loc1_.push(_loc2_);
         var _loc3_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _loc1_[_loc4_];
            _loc2_.ascendingIconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_ASCPROFILESORTARROW;
            _loc2_.descendingIconSource = RES_ICONS.MAPS_ICONS_BUTTONS_TAB_SORT_BUTTON_DESCPROFILESORTARROW;
            _loc2_.buttonHeight = BTNS_HEADER_HEIGHT;
            _loc2_.enabled = true;
            _loc4_++;
         }
         return new DataProvider(_loc1_);
      }
      
      private function dispatchUpdate(param1:VehicleSelectorItemVO = null, param2:Boolean = false) : void
      {
         if(!this._multiSelection)
         {
            if(param1)
            {
               if(this._selectedItemVO && this._selectedItemVO.intCD != param1.intCD)
               {
                  this._selectedItemVO.selected = false;
               }
               this._selectedItemVO = param1;
            }
         }
         else
         {
            if(param1)
            {
               this.updateOverride(param1,param1.selected);
            }
            this.checkAllSelected();
         }
         dispatchEvent(new VehicleSelectorEvent(VehicleSelectorEvent.SELECTION_CHANGED,this.getSelectedDescriptors(),this.getSelectedVehicles(),false,false,param2));
      }
      
      public function set listHeight(param1:Number) : void
      {
         this._listHeight = param1;
      }
      
      [Inspectable(defaultValue="false")]
      public function get multiSelection() : Boolean
      {
         return this._multiSelection;
      }
      
      public function set multiSelection(param1:Boolean) : void
      {
         this._multiSelection = param1;
         invalidate(INVALID_SELECTION_MODE);
      }
      
      [Inspectable(defaultValue="allVehicles",enumeration="userVehicles, allVehicles",verbose="1")]
      public function get filtersMode() : String
      {
         return this._filtersMode;
      }
      
      public function set filtersMode(param1:String) : void
      {
         this._filtersMode = param1;
         invalidate(INVALID_FILTERS_MODE);
      }
      
      public function get isUserVehiclesMode() : Boolean
      {
         return this._filtersMode == VehicleSelectorFilter.MODE_USER_VEHICLES;
      }
      
      private function onListSortAppliedHandler(param1:SortableScrollingListEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:VehicleSelectorItemVO = null;
         var _loc2_:int = 0;
         if(!this._multiSelection)
         {
            _loc3_ = false;
            _loc4_ = 0;
            _loc5_ = this.list.dataProvider.length;
            _loc6_ = null;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               _loc6_ = this.list.dataProvider[_loc4_];
               if(_loc6_.selected)
               {
                  _loc3_ = true;
                  _loc2_ = _loc4_;
                  break;
               }
               _loc4_++;
            }
            if(!_loc3_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc5_)
               {
                  _loc6_ = this.list.dataProvider[_loc4_];
                  if(_loc6_.enabled)
                  {
                     _loc2_ = _loc4_;
                     break;
                  }
                  _loc4_++;
               }
            }
         }
         this.list.selectedIndex = _loc2_;
      }
      
      private function onListSelectVehicleHandler(param1:VehicleSelectorItemEvent) : void
      {
         var _loc2_:VehicleSelectorItemVO = Boolean(param1) ? param1.data : null;
         this.dispatchUpdate(_loc2_,param1.forceSelect);
      }
      
      private function onAllCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc3_:VehicleSelectorItemVO = null;
         if(this._ignoreAllCheckBoxChange)
         {
            this._ignoreAllCheckBoxChange = false;
            return;
         }
         var _loc2_:Boolean = this.allCheckBox.selected;
         for each(_loc3_ in this.list.dataProvider)
         {
            _loc3_.selected = _loc2_ && _loc3_.enabled;
            this.updateOverride(_loc3_,_loc3_.selected);
         }
         this.list.dataProvider.invalidate();
         this.dispatchUpdate();
      }
      
      private function onHeaderSortDirectionChangedHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:SortingButton = param1.target as SortingButton;
         App.utils.asserter.assertNotNull(_loc2_,"sortingButton " + Errors.CANT_NULL);
         if(_loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
         {
            this.list.sortByField(_loc2_.id,_loc2_.sortDirection == SortingInfo.ASCENDING_SORT);
         }
      }
   }
}

import net.wg.gui.rally.vo.VehicleAlertVO;

class SelectionInfo
{
    
   
   public var vehicle:VehicleAlertVO;
   
   public var selected:Boolean;
   
   function SelectionInfo(param1:VehicleAlertVO, param2:Boolean)
   {
      super();
      this.vehicle = param1;
      this.selected = param2;
   }
}
