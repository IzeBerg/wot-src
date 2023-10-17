package net.wg.gui.lobby.modulesPanel
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.components.common.Counter;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.EmptyItemsScrollingList;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.events.DeviceEvent;
   import net.wg.gui.events.ModuleInfoEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.modulesPanel.components.FittingListSelectionNavigator;
   import net.wg.gui.lobby.modulesPanel.components.ListOverlay;
   import net.wg.gui.lobby.modulesPanel.data.DeviceVO;
   import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverVO;
   import net.wg.gui.lobby.modulesPanel.data.ListOverlayVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.base.meta.IFittingSelectPopoverMeta;
   import net.wg.infrastructure.base.meta.impl.FittingSelectPopoverMeta;
   import net.wg.infrastructure.interfaces.IWrapper;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import net.wg.utils.IUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.utils.Padding;
   
   public class FittingSelectPopover extends FittingSelectPopoverMeta implements IFittingSelectPopoverMeta
   {
      
      private static const BOTTOM_PADDING:int = 15;
      
      private static const LIST_BOTTOM_MARGIN:int = 2;
      
      private static const MAX_COUNT_ROWS:int = 3;
      
      private static const CHECKBOX_PADDING:int = 16;
      
      private static const ITEM_LIST_NO_TABBAR_Y:int = 50;
      
      private static const TOP_SEPARATOR_NO_TABBAR_Y:int = -30;
      
      private static const BATTLE_ABILITIES_BTN_AREA_NAME:String = "battleAbilitiesBtnArea";
      
      private static const COUNTER_PROPS:ICounterProps = new CounterProps(CounterProps.DEFAULT_OFFSET_X,7,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false,Counter.EMPTY_STATE);
      
      public static var NEW_COUNTER_CONTAINER_ID:String = "FittingSelectPopoverCountersContainer";
       
      
      public var textTf:TextField;
      
      public var itemsList:EmptyItemsScrollingList;
      
      public var bottomSeparator:MovieClip;
      
      public var topSeparator:MovieClip;
      
      public var battleAbilitiesButton:ISoundButtonEx = null;
      
      public var tabBar:ContentTabBar = null;
      
      public var rearmCheckbox:CheckBox = null;
      
      private var _itemListTabBarY:int = 90;
      
      private var _topSeparatorTabBarY:int = 11;
      
      private var _listOverlay:ListOverlay = null;
      
      private var _data:FittingSelectPopoverVO;
      
      private var _stage:Stage;
      
      private var _utils:IUtils;
      
      private var _rowCount:int = -1;
      
      private var _battleAbilitiesBtnArea:UIComponentEx = null;
      
      private var _counterManager:ICounterManager;
      
      public function FittingSelectPopover()
      {
         this._stage = App.stage;
         this._utils = App.utils;
         this._counterManager = App.utils.counterManager;
         super();
         this._topSeparatorTabBarY = this.topSeparator.y;
         this._itemListTabBarY = this.itemsList.y;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setEmptyHitArea(this.topSeparator);
         this.setEmptyHitArea(this.bottomSeparator);
         this.itemsList.canCleanDataProvider = false;
         this.itemsList.setSelectionNavigator(new FittingListSelectionNavigator());
         this.itemsList.addEventListener(ModuleInfoEvent.SHOW_INFO,this.onItemsListShowInfoHandler);
         this.itemsList.addEventListener(DeviceEvent.DEVICE_REMOVE,this.onItemsListDeviceRemoveHandler);
         this.itemsList.addEventListener(DeviceEvent.DEVICE_DESTROY,this.onItemsListDeviceDestroyHandler);
         this.itemsList.addEventListener(DeviceEvent.DEVICE_BUY,this.onItemsListDeviceBuyHandler);
         this.itemsList.addEventListener(DeviceEvent.DEVICE_EQUIP,this.onItemsListDeviceEquipHandler);
         this.itemsList.addEventListener(DeviceEvent.DEVICE_UPGRADE,this.onItemsListDeviceUpgradeHandler);
         this.itemsList.addEventListener(ListEvent.ITEM_CLICK,this.onItemsListItemClickHandler);
         this.rearmCheckbox.label = MENU.BOOSTERSELECTPOPOVER_REARMCHECKBOXLABEL;
         this.rearmCheckbox.addEventListener(Event.SELECT,this.onRearmCheckboxSelectHandler);
         this.tabBar.width = width;
         this.tabBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChangeHandler);
         this.battleAbilitiesButton.label = MENU.FITTINGPOPOVER_MANAGEABILITIES;
         this.battleAbilitiesButton.addEventListener(ButtonEvent.CLICK,this.onBattleAbilitiesButtonClickHandler);
         this._stage.addEventListener(Event.RESIZE,this.onStageResizeHandler);
      }
      
      override protected function update(param1:FittingSelectPopoverVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:ListOverlayVO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DisplayObject = null;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            if(this._data.preferredLayout != PopOverConst.ARROW_NONE)
            {
               popoverLayout.preferredLayout = this._data.preferredLayout;
            }
            this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
            if(this._data.tabData)
            {
               this.tabBar.dataProvider = this._data.tabData;
               this.tabBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChangeHandler);
               this.tabBar.selectedIndex = this._data.selectedTab;
               this.tabBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChangeHandler);
               this.tabBar.validateNow();
               this.tabBar.visible = true;
               this.itemsList.y = this._itemListTabBarY;
               this.topSeparator.y = this._topSeparatorTabBarY;
            }
            else
            {
               this.tabBar.visible = false;
               this.itemsList.y = ITEM_LIST_NO_TABBAR_Y;
               this.topSeparator.y = TOP_SEPARATOR_NO_TABBAR_Y;
            }
            _loc1_ = this._data.rendererName;
            this.battleAbilitiesButton.visible = this._data.battleAbilitiesButtonVisible;
            this._utils.asserter.assert(FITTING_TYPES.FITTING_RENDERERS.indexOf(_loc1_) >= 0,Errors.INVALID_TYPE + ". Got " + _loc1_);
            this.itemsList.itemRendererName = _loc1_;
            this.itemsList.dataProvider = this._data.availableDevices;
            this.itemsList.selectedIndex = this._data.selectedIndex;
            this.itemsList.validateNow();
            if(this._data.scrollToIndex != Values.DEFAULT_INT)
            {
               this.itemsList.scrollToIndex(this._data.scrollToIndex);
            }
            _loc2_ = this._data.rearmCheckboxVisible;
            if(_loc2_)
            {
               this.rearmCheckbox.visible = _loc2_;
               this.rearmCheckbox.selected = this._data.rearmCheckboxValue;
            }
            _loc3_ = this._data.listOverlay;
            if(_loc3_)
            {
               if(!this._listOverlay)
               {
                  this._listOverlay = this._utils.classFactory.getComponent(Linkages.EQUIPMENT_OVERLAY,ListOverlay);
                  this._listOverlay.addEventListener(MouseEvent.CLICK,this.onListOverlayEventCloseClickHandler);
                  addChild(this._listOverlay);
               }
               this._listOverlay.visible = true;
               this._listOverlay.update(_loc3_);
            }
            else if(this._listOverlay)
            {
               this._listOverlay.visible = false;
            }
            this.textTf.htmlText = this._data.title;
            if(this._data.tabCounters)
            {
               _loc4_ = this._data.tabCounters.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = this.tabBar.getButtonAt(_loc5_);
                  if(this._data.tabCounters[_loc5_] > 0)
                  {
                     this._counterManager.setCounter(_loc6_,"",NEW_COUNTER_CONTAINER_ID,COUNTER_PROPS);
                  }
                  _loc5_++;
               }
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            width = this.topSeparator.width = this.bottomSeparator.width = this._data.width;
            this.bottomSeparator.x = this.bottomSeparator.width;
            this.battleAbilitiesButton.x = width - this.battleAbilitiesButton.width >> 1;
            if(!isNaN(this.itemsList.rowHeight))
            {
               this.updateSize();
            }
            else
            {
               this._utils.scheduler.scheduleOnNextFrame(this.updateSize);
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.itemsList.removeEventListener(ModuleInfoEvent.SHOW_INFO,this.onItemsListShowInfoHandler);
         this.itemsList.removeEventListener(DeviceEvent.DEVICE_REMOVE,this.onItemsListDeviceRemoveHandler);
         this.itemsList.removeEventListener(DeviceEvent.DEVICE_DESTROY,this.onItemsListDeviceDestroyHandler);
         this.itemsList.removeEventListener(ListEvent.ITEM_CLICK,this.onItemsListItemClickHandler);
         this.itemsList.removeEventListener(DeviceEvent.DEVICE_BUY,this.onItemsListDeviceBuyHandler);
         this.itemsList.removeEventListener(DeviceEvent.DEVICE_EQUIP,this.onItemsListDeviceEquipHandler);
         this.itemsList.removeEventListener(DeviceEvent.DEVICE_UPGRADE,this.onItemsListDeviceUpgradeHandler);
         this.battleAbilitiesButton.removeEventListener(ButtonEvent.CLICK,this.onBattleAbilitiesButtonClickHandler);
         this.rearmCheckbox.removeEventListener(Event.SELECT,this.onRearmCheckboxSelectHandler);
         this._stage.removeEventListener(Event.RESIZE,this.onStageResizeHandler);
         this.tabBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabBarIndexChangeHandler);
         this._utils.scheduler.cancelTask(this.updateSize);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.battleAbilitiesButton.dispose();
         this.battleAbilitiesButton = null;
         if(this._battleAbilitiesBtnArea != null)
         {
            this._battleAbilitiesBtnArea.dispose();
            this._battleAbilitiesBtnArea = null;
         }
         if(this._listOverlay)
         {
            this._listOverlay.removeEventListener(MouseEvent.CLICK,this.onListOverlayEventCloseClickHandler);
            this._listOverlay.dispose();
            this._listOverlay = null;
         }
         this._counterManager.disposeCountersForContainer(NEW_COUNTER_CONTAINER_ID);
         this.tabBar.dispose();
         this.tabBar = null;
         this.rearmCheckbox.dispose();
         this.rearmCheckbox = null;
         this.textTf = null;
         this.itemsList.dispose();
         this.itemsList = null;
         this.bottomSeparator.hitArea = null;
         this.bottomSeparator = null;
         this.topSeparator.hitArea = null;
         this.topSeparator = null;
         this._data.dispose();
         this._data = null;
         this._stage = null;
         this._utils = null;
         this._counterManager = null;
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.itemsList);
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = PopOverConst.ARROW_BOTTOM;
         super.initLayout();
      }
      
      private function updateSize() : void
      {
         var _loc4_:int = 0;
         var _loc1_:Array = Boolean(this._data) ? this._data.availableDevices : null;
         var _loc2_:int = Boolean(_loc1_) ? int(_loc1_.length) : int(0);
         if(_loc2_)
         {
            if(this._rowCount == Values.DEFAULT_INT)
            {
               this._rowCount = _loc2_;
            }
            switch(popoverLayout.preferredLayout)
            {
               case PopOverConst.ARROW_TOP:
                  this.itemsList.rowCount = Math.min(MAX_COUNT_ROWS,_loc2_);
                  break;
               case PopOverConst.ARROW_LEFT:
               case PopOverConst.ARROW_RIGHT:
                  this.itemsList.rowCount = Math.min(App.appHeight / this.itemsList.rowHeight,this._rowCount);
                  break;
               case PopOverConst.ARROW_BOTTOM:
               default:
                  _loc4_ = popoverLayout.positionKeyPoint.y - FITTING_TYPES.HANGAR_POPOVER_TOP_MARGIN - popoverLayout.contentPadding.titleTop - this.itemsList.y - BOTTOM_PADDING - popoverLayout.positionKeyPointPadding.bottom.y;
                  this.itemsList.rowCount = Math.min(_loc4_ / this.itemsList.rowHeight,this._rowCount);
            }
         }
         this.itemsList.width = width;
         this.itemsList.sbPadding = new Padding(0,1);
         var _loc3_:int = this.itemsList.y + this.itemsList.height;
         this.bottomSeparator.y = _loc3_ + (this.bottomSeparator.height >> 1) + LIST_BOTTOM_MARGIN;
         if(this._data.rearmCheckboxVisible || this._data.battleAbilitiesButtonVisible)
         {
            this.rearmCheckbox.y = _loc3_ + CHECKBOX_PADDING;
            this.battleAbilitiesButton.y = this.rearmCheckbox.y;
            if(this.battleAbilitiesButton.visible && this._battleAbilitiesBtnArea == null)
            {
               this._battleAbilitiesBtnArea = this._utils.classFactory.getComponent(Linkages.BATTLE_ABILITIES_BTN_AREA_UI,UIComponentEx);
               this._battleAbilitiesBtnArea.name = BATTLE_ABILITIES_BTN_AREA_NAME;
               this._battleAbilitiesBtnArea.mouseChildren = this._battleAbilitiesBtnArea.mouseEnabled = false;
               addChild(this._battleAbilitiesBtnArea);
            }
            if(this._battleAbilitiesBtnArea)
            {
               this._battleAbilitiesBtnArea.x = this.battleAbilitiesButton.x;
               this._battleAbilitiesBtnArea.y = this.battleAbilitiesButton.y;
            }
            height = this.rearmCheckbox.y + this.rearmCheckbox.height + CHECKBOX_PADDING;
         }
         else
         {
            height = _loc3_ + BOTTOM_PADDING;
         }
         dispatchEvent(new Event(Event.RESIZE));
         if(this._listOverlay && this._listOverlay.visible)
         {
            this._listOverlay.useSmallIcon = this.itemsList.rowCount <= 5;
            this._listOverlay.x = this.itemsList.x;
            this._listOverlay.y = this.itemsList.y;
            this._listOverlay.setSize(this.itemsList.width,this.itemsList.height);
         }
      }
      
      private function setEmptyHitArea(param1:Sprite) : void
      {
         var _loc2_:Sprite = new Sprite();
         addChild(_loc2_);
         param1.hitArea = _loc2_;
      }
      
      override public function set wrapper(param1:IWrapper) : void
      {
         super.wrapper = param1;
         PopOver(param1).isCloseBtnVisible = true;
      }
      
      private function onBattleAbilitiesButtonClickHandler(param1:ButtonEvent) : void
      {
         onManageBattleAbilitiesClickedS();
      }
      
      private function onStageResizeHandler(param1:Event) : void
      {
         this._rowCount = Values.DEFAULT_INT;
         invalidateSize();
      }
      
      private function onItemsListShowInfoHandler(param1:ModuleInfoEvent) : void
      {
         showModuleInfoS(param1.id);
      }
      
      private function onItemsListDeviceRemoveHandler(param1:DeviceEvent) : void
      {
         var _loc2_:Number = param1.deviceId;
         setVehicleModuleS(_loc2_,_loc2_,true);
      }
      
      private function onItemsListDeviceDestroyHandler(param1:DeviceEvent) : void
      {
         setVehicleModuleS(param1.deviceId,-1,true);
      }
      
      private function onItemsListDeviceEquipHandler(param1:DeviceEvent) : void
      {
         setVehicleModuleS(param1.deviceId,-1,false);
      }
      
      private function onItemsListDeviceUpgradeHandler(param1:DeviceEvent) : void
      {
         upgradeVehicleModuleS(param1.deviceId);
      }
      
      private function onItemsListDeviceBuyHandler(param1:DeviceEvent) : void
      {
         buyVehicleModuleS(param1.deviceId);
      }
      
      private function onItemsListItemClickHandler(param1:ListEvent) : void
      {
         var _loc4_:DeviceVO = null;
         var _loc5_:DeviceVO = null;
         var _loc6_:Number = NaN;
         var _loc2_:int = this._data.selectedIndex;
         var _loc3_:int = param1.index;
         if(_loc2_ != _loc3_)
         {
            _loc4_ = null;
            _loc5_ = null;
            if(_loc2_ >= 0)
            {
               _loc4_ = this._data.availableDevices[_loc2_];
            }
            if(_loc3_ >= 0)
            {
               _loc5_ = this._data.availableDevices[_loc3_];
            }
            _loc6_ = _loc4_ != null ? Number(_loc4_.id) : Number(-1);
            setVehicleModuleS(_loc5_.id,_loc6_,false);
         }
         else
         {
            App.popoverMgr.hide();
         }
      }
      
      private function onRearmCheckboxSelectHandler(param1:Event) : void
      {
         setAutoRearmS(this.rearmCheckbox.selected);
      }
      
      private function onTabBarIndexChangeHandler(param1:IndexEvent) : void
      {
         setCurrentTabS(this.tabBar.selectedIndex);
      }
      
      private function onListOverlayEventCloseClickHandler(param1:MouseEvent) : void
      {
         if(this._listOverlay.isClickEnabled())
         {
            this._listOverlay.visible = false;
            listOverlayClosedS();
         }
      }
   }
}
