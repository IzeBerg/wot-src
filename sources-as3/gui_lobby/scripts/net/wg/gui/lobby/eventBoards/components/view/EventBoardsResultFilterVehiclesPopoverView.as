package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.lobby.eventBoards.components.EventBoardsVehicleSelector;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVehiclesVO;
   import net.wg.infrastructure.base.meta.IEventBoardsResultFilterVehiclesPopoverViewMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsResultFilterVehiclesPopoverViewMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class EventBoardsResultFilterVehiclesPopoverView extends EventBoardsResultFilterVehiclesPopoverViewMeta implements IEventBoardsResultFilterVehiclesPopoverViewMeta
   {
       
      
      public var selector:EventBoardsVehicleSelector;
      
      public var ratingButton:ISoundButtonEx;
      
      public var cancelButton:ISoundButtonEx;
      
      public var resetFilterButton:ISoundButtonEx;
      
      public var infoTF:TextField;
      
      public var warningTF:TextField;
      
      private var _initData:EventBoardTableFilterVehiclesVO;
      
      private var _selectedItem:int = -1;
      
      public function EventBoardsResultFilterVehiclesPopoverView()
      {
         super();
      }
      
      override protected function setInitData(param1:EventBoardTableFilterVehiclesVO) : void
      {
         this._initData = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            this.selector.setHeaderDP(this._initData.tableHeaders);
            this.selector.setFiltersData(this._initData.filters);
            this.selector.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
            this.infoTF.htmlText = this._initData.header;
            this.ratingButton.label = this._initData.okButtonLabel;
         }
      }
      
      override protected function onDispose() : void
      {
         this.selector.removeEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onSelectorRendererClickHandler);
         this.selector.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         this.selector.dispose();
         this.selector = null;
         this.ratingButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.ratingButton.dispose();
         this.ratingButton = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.resetFilterButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.resetFilterButton.dispose();
         this.resetFilterButton = null;
         this.infoTF = null;
         this.warningTF = null;
         this._initData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.selector.addEventListener(VehicleSelectRendererEvent.RENDERER_CLICK,this.onSelectorRendererClickHandler);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.cancelButton.label = EVENT_BOARDS.POPOVER_BUTTONS_CANCEL;
         this.ratingButton.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.ratingButton.mouseEnabledOnDisabled = true;
         this.resetFilterButton.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.warningTF.text = EVENT_BOARDS.POPOVER_NOVEHICLES;
         this.resetFilterButton.label = EVENT_BOARDS.POPOVER_RESETFILTER;
         this.warningTF.visible = this.resetFilterButton.visible = false;
      }
      
      public function as_getTableDP() : Object
      {
         return this.selector.getListDP();
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         if(param1.target == this.ratingButton)
         {
            if(this._selectedItem == Values.DEFAULT_INT)
            {
               this._selectedItem = this.selector.getSelectedItem();
            }
            setVehicleSelectedS(this._selectedItem);
            onWindowCloseS();
         }
         else if(param1.target == this.resetFilterButton)
         {
            resetFiltersS();
         }
         else
         {
            onWindowCloseS();
         }
      }
      
      private function onFiltersViewChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         applyFiltersS(param1.nation,param1.vehicleType,param1.level,param1.isMain,param1.compatibleOnly);
         var _loc2_:Boolean = this.selector.getListDP().length == 0 ? Boolean(true) : Boolean(false);
         this.resetFilterButton.visible = this.warningTF.visible = _loc2_;
         this.ratingButton.enabled = this.selector.getSelectedItem() == -1 ? Boolean(false) : Boolean(true);
      }
      
      private function onSelectorRendererClickHandler(param1:VehicleSelectRendererEvent) : void
      {
         this._selectedItem = param1.dbID;
         this.ratingButton.enabled = true;
      }
      
      public function as_updateTableSortField(param1:String, param2:String) : void
      {
         this.selector.updateTableSortField(param1,param2);
      }
   }
}
