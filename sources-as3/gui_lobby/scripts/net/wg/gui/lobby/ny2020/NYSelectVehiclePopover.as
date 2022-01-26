package net.wg.gui.lobby.ny2020
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.interfaces.IVehicleSelectorFilter;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.cyberSport.controls.VehicleSelectorNavigator;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.lobby.components.VehicleSelectorFilter;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.lobby.components.interfaces.IVehicleSelectorFilterVO;
   import net.wg.gui.lobby.ny2020.vo.NYSelectVehiclePopoverVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.meta.INYSelectVehiclePopoverMeta;
   import net.wg.infrastructure.base.meta.impl.NYSelectVehiclePopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.gfx.TextFieldEx;
   
   public class NYSelectVehiclePopover extends NYSelectVehiclePopoverMeta implements INYSelectVehiclePopoverMeta
   {
      
      private static const TF_TO_FILTERS_GAP:int = 15;
      
      private static const FILTERS_TO_TABLE_GAP:int = 41;
      
      private static const TABLE_TO_BUTTONS_GAP:int = 298;
      
      private static const BUTTONS_TO_BOTTOM_GAP:int = 21;
      
      private static const NO_ITEM_Y_OFFSET:int = 20;
       
      
      public var filtersView:IVehicleSelectorFilter;
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var noItemsTF:TextField = null;
      
      public var table:ISortableTable = null;
      
      public var selectButton:SoundButtonEx = null;
      
      public var cancelButton:SoundButtonEx = null;
      
      public var bg:MovieClip = null;
      
      private var _dataProvider:IDataProvider;
      
      private var _initData:NYSelectVehiclePopoverVO;
      
      private var _selectNavigator:VehicleSelectorNavigator;
      
      public function NYSelectVehiclePopover()
      {
         super();
         this.table.listLinkage = Linkages.SORTABLE_SCROLLING_LIST_WITH_DIS_RENDERERS;
         this._selectNavigator = new VehicleSelectorNavigator();
         var _loc1_:NYVehicleSelectorFilter = NYVehicleSelectorFilter(this.filtersView);
         _loc1_.mode = VehicleSelectorFilter.MODE_USER_VEHICLES;
         this.noItemsTF.visible = false;
         this.noItemsTF.mouseEnabled = false;
         this.noItemsTF.text = "#ny:vehiclesView/selectVehiclePopover/noItems";
         TextFieldEx.setVerticalAlign(this.noItemsTF,TextFieldEx.VALIGN_CENTER);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.table.listSelectNavigator = this._selectNavigator;
         this.table.addEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onTableDoubleClickHandler);
         this.table.addEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onTableIndexChangeHandler);
         this.selectButton.enabled = false;
         this.selectButton.addEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.filtersView.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         setViewSize(width,height);
      }
      
      override protected function onDispose() : void
      {
         this._dataProvider.removeEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
         this._dataProvider = null;
         this._initData.dispose();
         this._initData = null;
         this.table.removeEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onTableDoubleClickHandler);
         this.table.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onTableIndexChangeHandler);
         this.table.dispose();
         this.table = null;
         this._selectNavigator.dispose();
         this._selectNavigator = null;
         this.filtersView.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         this.filtersView.dispose();
         this.filtersView = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.selectButton.removeEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.selectButton.dispose();
         this.selectButton = null;
         this.descriptionTF = null;
         this.titleTF = null;
         this.noItemsTF = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_LEFT;
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.text = this._initData.title;
            if(this._initData.description == "")
            {
               this.removeDescription();
            }
            else
            {
               this.descriptionTF.htmlText = this._initData.description;
               App.utils.commons.updateTextFieldSize(this.descriptionTF,false,true);
               invalidateSize();
            }
         }
         super.draw();
         if(this._initData && isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.descriptionTF.y + this.descriptionTF.height + TF_TO_FILTERS_GAP | 0;
            this.filtersView.y = _loc1_;
            this.table.y = this.filtersView.y + FILTERS_TO_TABLE_GAP;
            this.selectButton.y = this.table.y + TABLE_TO_BUTTONS_GAP;
            this.cancelButton.y = this.table.y + TABLE_TO_BUTTONS_GAP;
            this.noItemsTF.y = this.table.y + (this.table.height - this.noItemsTF.height >> 1) + NO_ITEM_Y_OFFSET | 0;
            this.bg.height = this.selectButton.y + this.selectButton.height + BUTTONS_TO_BOTTOM_GAP;
            setViewSize(width,this.bg.height);
         }
      }
      
      override protected function setInitData(param1:NYSelectVehiclePopoverVO) : void
      {
         this._initData = param1;
         this.table.headerDP = this._initData.tableHeaders;
         this.table.sortByField(this._initData.defaultSortField,this._initData.defaultSortDirection);
         this.setFiltersData(this._initData.filters);
         invalidateData();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(VehicleVO);
         this.table.listDP = this._dataProvider;
         this._dataProvider.addEventListener(Event.CHANGE,this.onDataProviderChangeHandler);
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      public function setFiltersData(param1:IVehicleSelectorFilterVO) : void
      {
         this.filtersView.setData(param1);
         this.filtersView.validateNow();
      }
      
      private function removeDescription() : void
      {
         var _loc1_:Number = this.descriptionTF.height;
         removeChild(this.descriptionTF);
         this.filtersView.y -= _loc1_;
         this.table.y -= _loc1_;
         this.noItemsTF.y -= _loc1_;
         this.selectButton.y -= _loc1_;
         this.cancelButton.y -= _loc1_;
         height -= _loc1_;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      private function onFiltersViewChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         applyFiltersS(param1.nation,param1.vehicleType,param1.level);
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onSelectButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:VehicleVO = VehicleVO(this._dataProvider.requestItemAt(this.table.listSelectedIndex));
         onSelectVehicleS(_loc2_.intCD);
      }
      
      private function onTableDoubleClickHandler(param1:SortableTableListEvent) : void
      {
         var _loc2_:VehicleVO = VehicleVO(param1.itemData);
         if(_loc2_.enabled)
         {
            onSelectVehicleS(_loc2_.intCD);
         }
      }
      
      private function onTableIndexChangeHandler(param1:SortableTableListEvent) : void
      {
         this.selectButton.enabled = Boolean(param1.itemData) ? Boolean(VehicleVO(param1.itemData).enabled) : Boolean(false);
      }
      
      private function onDataProviderChangeHandler(param1:Event) : void
      {
         this.noItemsTF.visible = this._dataProvider.length == 0;
         this.table.resetListSelectedItem();
      }
   }
}
