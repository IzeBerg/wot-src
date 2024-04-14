package net.wg.gui.lobby.vehicleTradeWnds.buy.views
{
   import net.wg.gui.components.advanced.ContentTabBar;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.ev.VehicleBuyEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.interfaces.IVehicleBuyView;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuySubmitVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   
   public class ContentBuyTradeInContainer extends UIComponentEx implements IVehicleBuyView
   {
      
      private static const INVALID_TAB_INDEX:String = "invalidSelectedIndex";
       
      
      public var tabs:ContentTabBar = null;
      
      public var tradeInView:IVehicleBuyView = null;
      
      public var buyView:IVehicleBuyView = null;
      
      private var _currentView:IVehicleBuyView = null;
      
      private var _academyButtonEnabled:Boolean;
      
      private var _schoolButtonEnabled:Boolean;
      
      private var _freeButtonEnabled:Boolean;
      
      private var _tabSelectedIndex:Number = -1;
      
      private var _isTabSelected:Boolean;
      
      public function ContentBuyTradeInContainer()
      {
         super();
         this.mouseEnabled = false;
         this.buyView.visible = false;
         this.tradeInView.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tabs.dataProvider = new DataProvider([{"label":DIALOGS.BUYVEHICLEWINDOW_TABS_BUY},{"label":DIALOGS.BUYVEHICLEWINDOW_TABS_TRADE}]);
         this.tabs.addEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.buyView.addEventListener(VehicleBuyEvent.TOTAL_PRICE_UPDATED,this.onBuyViewTotalPriceUpdatedHandler);
         this.tradeInView.addEventListener(VehicleBuyEvent.TOTAL_PRICE_UPDATED,this.onTradeInViewTotalPriceUpdatedHandler);
         this.buyView.addEventListener(VehicleBuyEvent.SIZE_CHANGE,this.onBuyViewSizeChangeHandler);
         this.tradeInView.addEventListener(VehicleBuyEvent.SIZE_CHANGE,this.onTradeInViewSizeChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.buyView.removeEventListener(VehicleBuyEvent.TOTAL_PRICE_UPDATED,this.onBuyViewTotalPriceUpdatedHandler);
         this.buyView.removeEventListener(VehicleBuyEvent.SIZE_CHANGE,this.onBuyViewSizeChangeHandler);
         this.tradeInView.removeEventListener(VehicleBuyEvent.TOTAL_PRICE_UPDATED,this.onTradeInViewTotalPriceUpdatedHandler);
         this.tradeInView.removeEventListener(VehicleBuyEvent.SIZE_CHANGE,this.onTradeInViewSizeChangeHandler);
         this.buyView.dispose();
         this.buyView = null;
         this.tradeInView.dispose();
         this.tradeInView = null;
         this._currentView = null;
         this.tabs.removeEventListener(IndexEvent.INDEX_CHANGE,this.onTabsIndexChangeHandler);
         this.tabs.dispose();
         this.tabs = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(INVALID_TAB_INDEX))
         {
            this._tabSelectedIndex = this._tabSelectedIndex > this.tabs.dataProvider.length ? Number(0) : Number(this._tabSelectedIndex);
            this.tabs.selectedIndex = this._tabSelectedIndex;
            this.updateCurrentTab();
         }
      }
      
      public function getActualHeight() : Number
      {
         if(this._currentView)
         {
            return this._currentView.getActualHeight();
         }
         return 0;
      }
      
      public function getSubmitData() : VehicleBuySubmitVo
      {
         return this._currentView.getSubmitData();
      }
      
      public function memberTradeInIntCD(param1:Number) : void
      {
         this.buyView.memberTradeInIntCD(param1);
         this.tradeInView.memberTradeInIntCD(param1);
      }
      
      public function setTradeInWarningMessagege(param1:String) : void
      {
         this.tradeInView.setTradeInWarningMessagege(param1);
      }
      
      public function setTrainingButtonsEnableState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this._academyButtonEnabled = param1;
         this._schoolButtonEnabled = param2;
         this._freeButtonEnabled = param3;
         if(this._currentView)
         {
            this._currentView.setTrainingButtonsEnableState(param1,param2,param3);
         }
      }
      
      public function update(param1:VehicleBuyContentVo) : void
      {
         this.buyView.update(param1);
         this.tradeInView.update(param1);
         if(!this._isTabSelected)
         {
            this._tabSelectedIndex = param1.selectedTab;
            this._isTabSelected = true;
         }
         invalidate(INVALID_TAB_INDEX);
      }
      
      public function updateTotalCredits(param1:Number) : void
      {
         this.buyView.updateTotalCredits(param1);
         this.tradeInView.updateTotalCredits(param1);
      }
      
      public function updateTotalGold(param1:Number) : void
      {
         this.buyView.updateTotalGold(param1);
         this.tradeInView.updateTotalGold(param1);
      }
      
      public function updateTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void
      {
         this.tradeInView.updateTradeOffVehicle(param1);
      }
      
      private function updateTotalPrice(param1:Boolean) : void
      {
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.TOTAL_PRICE_UPDATED,false,false,param1));
      }
      
      private function onWarningVisibilityChanged() : void
      {
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.SIZE_CHANGE));
      }
      
      private function updateCurrentTab() : void
      {
         if(this._currentView)
         {
            this._currentView.visible = false;
            this._currentView.removeEventListener(VehicleBuyEvent.UPDATE_INTERFACE,dispatchEvent);
         }
         this._currentView = this._tabSelectedIndex == 0 ? this.buyView : this.tradeInView;
         this._currentView.visible = true;
         this._currentView.addEventListener(VehicleBuyEvent.UPDATE_INTERFACE,dispatchEvent);
         this._currentView.setTrainingButtonsEnableState(this._academyButtonEnabled,this._schoolButtonEnabled,this._freeButtonEnabled);
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.TAB_CHANGE,false,false,false,this.tabs.selectedIndex));
         this.updateTotalPrice(false);
      }
      
      private function onTradeInViewTotalPriceUpdatedHandler(param1:VehicleBuyEvent) : void
      {
         if(this._currentView != param1.target)
         {
            return;
         }
         this.updateTotalPrice(param1.isSubmitSetFocus);
      }
      
      private function onBuyViewTotalPriceUpdatedHandler(param1:VehicleBuyEvent) : void
      {
         if(this._currentView != param1.target)
         {
            return;
         }
         this.updateTotalPrice(param1.isSubmitSetFocus);
      }
      
      private function onTradeInViewSizeChangeHandler(param1:VehicleBuyEvent) : void
      {
         if(this._currentView != param1.target)
         {
            return;
         }
         this.onWarningVisibilityChanged();
      }
      
      private function onBuyViewSizeChangeHandler(param1:VehicleBuyEvent) : void
      {
         if(this._currentView != param1.target)
         {
            return;
         }
         this.onWarningVisibilityChanged();
      }
      
      private function onTabsIndexChangeHandler(param1:IndexEvent) : void
      {
         if(initialized)
         {
            this._tabSelectedIndex = this.tabs.selectedIndex;
            invalidate(INVALID_TAB_INDEX);
         }
      }
   }
}
