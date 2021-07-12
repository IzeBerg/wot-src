package net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.SortableVoDAAPIDataProvider;
   import net.wg.gui.components.advanced.SearchInput;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.infrastructure.base.meta.IStorageVehicleSelectPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.StorageVehicleSelectPopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleSelectPopover extends StorageVehicleSelectPopoverMeta implements IStorageVehicleSelectPopoverMeta
   {
      
      private static const DUMMY_V_OFFSET:int = 170;
       
      
      public var filtersView:VehicleSelectorFilter;
      
      public var searchInput:SearchInput;
      
      public var table:SortableTable = null;
      
      public var infoTF:TextField;
      
      public var dummyInfoTF:TextField;
      
      private var _initData:StorageVehicleSelectPopoverVO;
      
      private var _vehicleName:String;
      
      private var _searchInputTooltip:String;
      
      public function VehicleSelectPopover()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.table.listDP = new SortableVoDAAPIDataProvider(VehicleSelectPopoverItemVO);
      }
      
      override protected function setInitData(param1:StorageVehicleSelectPopoverVO) : void
      {
         this._initData = param1;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onSelectorRendererClickHandler);
         removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         this.searchInput.removeEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.removeEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         this.searchInput.dispose();
         this.searchInput = null;
         this.table.dispose();
         this.table = null;
         this.filtersView.dispose();
         this.filtersView = null;
         this.infoTF = null;
         this.dummyInfoTF = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.dummyInfoTF.text = STORAGE.VEHICLESELECTPOPOVER_NOVEHICLES;
         this.dummyInfoTF.mouseWheelEnabled = this.dummyInfoTF.mouseEnabled = false;
         this.dummyInfoTF.wordWrap = true;
         this.dummyInfoTF.multiline = true;
         this.dummyInfoTF.autoSize = TextFieldAutoSize.CENTER;
         this.searchInput.addEventListener(Event.CHANGE,this.onSearchInputChangeHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OVER,this.onSearchInputRollOverHandler);
         this.searchInput.addEventListener(MouseEvent.ROLL_OUT,this.onSearchInputRollOutHandler);
         addEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onSelectorRendererClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.dummyInfoTF.y = DUMMY_V_OFFSET + (height - DUMMY_V_OFFSET - this.dummyInfoTF.height >> 1);
         }
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
            this.table.headerDP = this._initData.tableHeaders;
            this.filtersView.setData(this._initData.filters);
            this.infoTF.htmlText = this._initData.header;
         }
      }
      
      public function as_getTableDP() : Object
      {
         return this.table.listDP;
      }
      
      public function as_showDummy(param1:Boolean) : void
      {
         this.dummyInfoTF.visible = param1;
         this.table.listVisible = !param1;
      }
      
      public function as_updateSearch(param1:String, param2:String, param3:String, param4:int) : void
      {
         this.searchInput.defaultText = param1;
         this.searchInput.text = param2;
         this.searchInput.maxChars = param4;
         this._searchInputTooltip = param3;
      }
      
      public function as_updateTableSortField(param1:String, param2:String) : void
      {
         this.table.setSelectedField(param1,param2);
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      private function onFiltersViewChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         applyFiltersS(param1.nation,param1.vehicleType,param1.level,param1.isMain);
      }
      
      private function onSelectorRendererClickHandler(param1:VehicleSelectRendererEvent) : void
      {
         setVehicleSelectedS(param1.dbID,param1.autoClose);
      }
      
      private function onSearchInputRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._searchInputTooltip);
      }
      
      private function onSearchInputRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onSearchInputChangeHandler(param1:Event) : void
      {
         var _loc2_:String = this.searchInput.text;
         if(this._vehicleName != _loc2_)
         {
            this._vehicleName = _loc2_;
            changeSearchNameVehicleS(this._vehicleName);
         }
      }
   }
}
