package net.wg.gui.lobby.vehicleTradeWnds.buy.popover
{
   import flash.text.TextField;
   import net.wg.data.ListDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.interfaces.ISortableTable;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.cyberSport.controls.VehicleSelectorNavigator;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.infrastructure.base.meta.ITradeInPopupMeta;
   import net.wg.infrastructure.base.meta.impl.TradeInPopupMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class TradeInPopover extends TradeInPopupMeta implements ITradeInPopupMeta
   {
       
      
      public var titleTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var table:ISortableTable;
      
      public var selectButton:SoundButtonEx;
      
      public var cancelButton:SoundButtonEx;
      
      private var _dataProvider:IDataProvider;
      
      private var _initData:TradeInVO;
      
      private var _selectNavigator:VehicleSelectorNavigator;
      
      public function TradeInPopover()
      {
         super();
         this.table.listLinkage = Linkages.SORTABLE_SCROLLING_LIST_WITH_DIS_RENDERERS;
         this._selectNavigator = new VehicleSelectorNavigator();
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
         setViewSize(width,height);
      }
      
      override protected function onDispose() : void
      {
         this._dataProvider = null;
         this._initData.dispose();
         this._initData = null;
         this.table.removeEventListener(SortableTableListEvent.RENDERER_DOUBLE_CLICK,this.onTableDoubleClickHandler);
         this.table.removeEventListener(SortableTableListEvent.LIST_INDEX_CHANGE,this.onTableIndexChangeHandler);
         this.table.dispose();
         this.table = null;
         this._selectNavigator.dispose();
         this._selectNavigator = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.selectButton.removeEventListener(ButtonEvent.CLICK,this.onSelectButtonClickHandler);
         this.selectButton.dispose();
         this.selectButton = null;
         this.descriptionTF = null;
         this.titleTF = null;
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
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.text = this._initData.title;
            this.descriptionTF.text = this._initData.description;
         }
         super.draw();
      }
      
      override protected function setInitData(param1:TradeInVO) : void
      {
         this._initData = param1;
         this.table.headerDP = this._initData.tableHeaders;
         this.table.sortByField(this._initData.defaultSortField,this._initData.defaultSortDirection);
         invalidateData();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._dataProvider = new ListDAAPIDataProvider(TradeInRendererVO);
         this.table.listDP = this._dataProvider;
      }
      
      public function as_getDP() : Object
      {
         return this._dataProvider;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onSelectButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:TradeInRendererVO = TradeInRendererVO(this._dataProvider.requestItemAt(this.table.listSelectedIndex));
         onSelectVehicleS(_loc2_.intCD);
      }
      
      private function onTableDoubleClickHandler(param1:SortableTableListEvent) : void
      {
         var _loc2_:TradeInRendererVO = TradeInRendererVO(param1.itemData);
         if(_loc2_.enabled)
         {
            onSelectVehicleS(_loc2_.intCD);
         }
      }
      
      private function onTableIndexChangeHandler(param1:SortableTableListEvent) : void
      {
         this.selectButton.enabled = Boolean(param1.itemData) ? Boolean(TradeInRendererVO(param1.itemData).enabled) : Boolean(false);
      }
   }
}
