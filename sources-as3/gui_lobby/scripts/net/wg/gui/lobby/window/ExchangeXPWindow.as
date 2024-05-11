package net.wg.gui.lobby.window
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.SortingInfo;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.advanced.SortingButton;
   import net.wg.gui.components.assets.ArrowSeparator;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.CompactCheckBox;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.NumericStepper;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.WalletResourcesStatus;
   import net.wg.gui.events.SortingEvent;
   import net.wg.infrastructure.base.meta.IExchangeXpWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ExchangeXpWindowMeta;
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.utils.Padding;
   
   public class ExchangeXPWindow extends ExchangeXpWindowMeta implements IExchangeXpWindowMeta
   {
      
      private static const VEHICLES_DATA_INVALID:String = "listInv";
      
      private static const TOTAL_AVAILABLE_XP_INVALID:String = "totalAvailXP";
      
      private static const TOTAL_RESULT_INVALID:String = "resAll";
      
      private static const SORT_FIELD_VEHICLE_NAME:String = "vehicleName";
      
      private static const ASSERTER_MSG_EMPTY_DATA_ARRAY:String = "The exchange XP window submit method have got empty data array.";
      
      private static const FORM_BG_LEFT:int = 10;
      
      private static const FORM_BG_TOP:int = 33;
      
      private static const FORM_BG_RIGHT:int = 11;
      
      private static const FORM_BG_BOTTOM:int = 20;
      
      private static const SCROLL_LIST_DEF_ROW_COUNT:int = 7;
      
      private static const BUTTON_BAR_DEF_SELECTED_INDEX:int = 1;
      
      private static const NS_XP_EXCHANGE_DEF_STEP:int = 1;
      
      private static const NS_GOLD_EXCHANGE_DEF_STEP:int = 1;
      
      private static const NS_GOLD_EXCHANGE_DEF_MIN:int = 0;
      
      private static const NS_XP_EXCHANGE_DEF_MIN:int = 0;
       
      
      public var buttonBar:SortableHeaderButtonBar;
      
      public var lblTotalAvailableXp:TextField;
      
      public var itTotalAvailableXp:IconText;
      
      public var cbSelectAll:CompactCheckBox;
      
      public var nsXpExchange:NumericStepper;
      
      public var nsGoldExchange:NumericStepper;
      
      public var itIconXp:IconText;
      
      public var itIconGold:IconText;
      
      public var warningScreen:ExchangeXPWarningScreen;
      
      public var itExperienceResult:IconText;
      
      public var itGoldResult:IconText;
      
      public var itGoldBefore:IconText;
      
      public var itExperienceBefore:IconText;
      
      public var scrollList:ExchangeXPList;
      
      public var submitBtn:SoundButtonEx;
      
      public var cancelBtn:SoundButtonEx;
      
      public var headerMC:ExchangeHeader;
      
      public var topSeparator:ArrowSeparator;
      
      public var bottomSeparator:ArrowSeparator;
      
      public var exchangeGoldWarning:AlertIco;
      
      public var onHandHaveNotMoney:WalletResourcesStatus = null;
      
      public var resultHaveNotMoney:WalletResourcesStatus = null;
      
      public var onHandHaveNotFreeXp:WalletResourcesStatus = null;
      
      public var resultHaveNotFreeXp:WalletResourcesStatus = null;
      
      private var _scrollListProvider:DataProvider;
      
      private var _haveEliteVehicles:Boolean;
      
      private var _totalXp:int = 0;
      
      private var _selectedGold:int;
      
      private var _selectedXp:int;
      
      private var _xpForFree:int = -1;
      
      private var _locale:ILocale;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _targetXP:int = -1;
      
      public function ExchangeXPWindow()
      {
         this._locale = Boolean(App.utils) ? App.utils.locale : null;
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         var _loc2_:Padding = null;
         super.setWindow(param1);
         if(window != null)
         {
            window.title = MENU.EXCHANGEXP_TITLE;
            _loc2_ = new Padding();
            _loc2_.top = FORM_BG_TOP;
            _loc2_.bottom = this.cancelBtn.height + FORM_BG_BOTTOM;
            _loc2_.right = FORM_BG_RIGHT;
            _loc2_.left = FORM_BG_LEFT;
            window.formBgPadding = _loc2_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tooltipMgr = App.toolTipMgr;
         this.lblTotalAvailableXp.autoSize = TextFieldAutoSize.RIGHT;
         this.nsXpExchange.minimum = NS_XP_EXCHANGE_DEF_MIN;
         this.nsGoldExchange.minimum = NS_GOLD_EXCHANGE_DEF_MIN;
         this.nsGoldExchange.stepSize = NS_GOLD_EXCHANGE_DEF_STEP;
         this.nsXpExchange.addEventListener(IndexEvent.INDEX_CHANGE,this.onNsXpExchangeIndexChangeHandler,false,0,true);
         this.nsGoldExchange.addEventListener(IndexEvent.INDEX_CHANGE,this.onNsGoldExchangeIndexChangeHandler,false,0,true);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler,false,0,true);
         this.submitBtn.addEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler,false,0,true);
         addEventListener(ExchangeXPFromVehicleIR.SELECTION_CHANGED,this.onSelectionChangedHandler,false,0,true);
         this.scrollList.rowCount = SCROLL_LIST_DEF_ROW_COUNT;
         this.cbSelectAll.addEventListener(Event.SELECT,this.onCbSelectAllSelectHandler,false,0,true);
         this.buttonBar.addEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onButtonBarSortDirectionChangedHandler,false,0,true);
         this.exchangeGoldWarning.addEventListener(MouseEvent.ROLL_OVER,this.onExchangeGoldWarningRollOverHandler);
         this.exchangeGoldWarning.addEventListener(MouseEvent.ROLL_OUT,this.onExchangeGoldWarningRollOutHandler);
         this.buttonBar.selectedIndex = BUTTON_BAR_DEF_SELECTED_INDEX;
         var _loc1_:IColorSchemeManager = App.colorSchemeMgr;
         this.applyXpColor(_loc1_.getRGB(ColorSchemeNames.TEXT_COLOR_XP));
         this.applyGoldColor(_loc1_.getRGB(ColorSchemeNames.TEXT_COLOR_GOLD));
         this.applyFilters();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(VEHICLES_DATA_INVALID))
         {
            this.invalidateVehiclesData();
            invalidate(TOTAL_AVAILABLE_XP_INVALID);
         }
         if(isInvalid(TOTAL_AVAILABLE_XP_INVALID))
         {
            this.invalidateAvailableXp();
            invalidate(TOTAL_RESULT_INVALID);
         }
         if(isInvalid(TOTAL_RESULT_INVALID))
         {
            this.invalidateTotalResult();
         }
      }
      
      override protected function applyPrimaryCurrencyChange() : void
      {
         this.itGoldBefore.text = Boolean(this._locale) ? this._locale.gold(totalPrimaryCurrency) : totalPrimaryCurrency.toString();
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }
      
      override protected function applyRatesChanges() : void
      {
         this.headerMC.isActionMode = actionMode;
         this.headerMC.setRates(rate,actionRate);
         invalidate(TOTAL_RESULT_INVALID);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ExchangeXPFromVehicleIR.SELECTION_CHANGED,this.onSelectionChangedHandler);
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onCancelBtnClickHandler);
         this.submitBtn.removeEventListener(ButtonEvent.CLICK,this.onSubmitBtnClickHandler);
         this.nsXpExchange.removeEventListener(IndexEvent.INDEX_CHANGE,this.onNsXpExchangeIndexChangeHandler);
         this.nsGoldExchange.removeEventListener(IndexEvent.INDEX_CHANGE,this.onNsGoldExchangeIndexChangeHandler);
         this.buttonBar.removeEventListener(SortingEvent.SORT_DIRECTION_CHANGED,this.onButtonBarSortDirectionChangedHandler);
         this.cbSelectAll.removeEventListener(Event.SELECT,this.onCbSelectAllSelectHandler);
         this.exchangeGoldWarning.removeEventListener(MouseEvent.ROLL_OVER,this.onExchangeGoldWarningRollOverHandler);
         this.exchangeGoldWarning.removeEventListener(MouseEvent.ROLL_OUT,this.onExchangeGoldWarningRollOutHandler);
         this.exchangeGoldWarning.dispose();
         this.exchangeGoldWarning = null;
         this._scrollListProvider = null;
         this.lblTotalAvailableXp = null;
         this.itTotalAvailableXp.dispose();
         this.itTotalAvailableXp = null;
         this.cbSelectAll.dispose();
         this.cbSelectAll = null;
         this.itIconXp.dispose();
         this.itIconXp = null;
         this.itIconGold.dispose();
         this.itIconGold = null;
         this.warningScreen.dispose();
         this.warningScreen = null;
         this.itExperienceResult.dispose();
         this.itExperienceResult = null;
         this.itGoldResult.dispose();
         this.itGoldResult = null;
         this.itGoldBefore.dispose();
         this.itGoldBefore = null;
         this.itExperienceBefore.dispose();
         this.itExperienceBefore = null;
         this.scrollList.dispose();
         this.scrollList = null;
         this.headerMC.dispose();
         this.headerMC = null;
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.submitBtn.dispose();
         this.submitBtn = null;
         this.nsXpExchange.dispose();
         this.nsXpExchange = null;
         this.nsGoldExchange.dispose();
         this.nsGoldExchange = null;
         this.buttonBar.dispose();
         this.buttonBar = null;
         this.onHandHaveNotFreeXp.dispose();
         this.onHandHaveNotFreeXp = null;
         this.resultHaveNotFreeXp.dispose();
         this.resultHaveNotFreeXp = null;
         this.onHandHaveNotMoney.dispose();
         this.onHandHaveNotMoney = null;
         this.resultHaveNotMoney.dispose();
         this.resultHaveNotMoney = null;
         this.topSeparator.dispose();
         this.topSeparator = null;
         this.bottomSeparator.dispose();
         this.bottomSeparator = null;
         this._locale = null;
         super.onDispose();
      }
      
      override protected function vehiclesDataChanged(param1:ExchangeXPWindowVO) : void
      {
         this.buttonBar.dataProvider = param1.tableHeader;
         this.scrollList.columnsData = this.buttonBar.dataProvider;
         this.scrollList.sortByField(SORT_FIELD_VEHICLE_NAME,true);
         this._haveEliteVehicles = param1.isHaveElite;
         this._xpForFree = param1.xpForFree;
         this._selectedXp = 0;
         if(this._haveEliteVehicles)
         {
            this._scrollListProvider = param1.vehicleList;
         }
         this.headerMC.isForFreeMode = this._xpForFree > 0;
         this.headerMC.setData(param1.exchangeHeaderData);
         invalidate(VEHICLES_DATA_INVALID);
      }
      
      public function as_setWalletStatus(param1:Object, param2:Boolean) : void
      {
         var _loc5_:Boolean = false;
         var _loc3_:IWalletStatusVO = App.utils.voMgr.walletStatusVO;
         _loc3_.update(param1);
         var _loc4_:Boolean = !this.onHandHaveNotMoney.updateStatus(_loc3_.goldStatus);
         this.resultHaveNotMoney.updateStatus(_loc3_.goldStatus);
         _loc5_ = !this.onHandHaveNotFreeXp.updateStatus(_loc3_.freeXpStatus);
         this.resultHaveNotFreeXp.updateStatus(_loc3_.freeXpStatus);
         this.itGoldBefore.visible = _loc4_;
         this.itGoldResult.visible = _loc4_;
         this.itExperienceBefore.visible = _loc5_;
         this.itExperienceResult.visible = _loc5_;
         this.submitBtn.enabled = param2;
      }
      
      public function as_totalExperienceChanged(param1:int) : void
      {
         this._totalXp = param1;
         this.itExperienceBefore.text = Boolean(this._locale) ? this._locale.gold(this._totalXp) : this._totalXp.toString();
         invalidate(TOTAL_RESULT_INVALID);
      }
      
      public function as_setTargetXP(param1:int) : void
      {
         this._targetXP = param1;
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }
      
      private function applyFilters() : void
      {
         this.itIconXp.filters = ExchangeUtils.getGlow(this.itIconXp.icon);
         this.itIconGold.filters = ExchangeUtils.getGlow(this.itIconGold.icon);
         this.itGoldBefore.filters = ExchangeUtils.getGlow(this.itGoldBefore.icon);
         this.itGoldResult.filters = ExchangeUtils.getGlow(this.itGoldResult.icon);
      }
      
      private function applyXpColor(param1:Number) : void
      {
         this.headerMC.rateTo.textColor = param1;
         this.itExperienceResult.textColor = param1;
         this.itExperienceBefore.textColor = param1;
         this.itTotalAvailableXp.textColor = param1;
         this.nsXpExchange.textColorId = TEXT_MANAGER_STYLES.EXP_TEXT;
      }
      
      private function applyGoldColor(param1:Number) : void
      {
         this.headerMC.rateFrom.textColor = param1;
         this.itGoldResult.textColor = param1;
         this.itGoldBefore.textColor = param1;
      }
      
      private function invalidateTotalResult() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = this._xpForFree > 0;
         if(_loc3_)
         {
            this.nsXpExchange.stepSize = NS_XP_EXCHANGE_DEF_STEP;
            this.nsGoldExchange.value = NS_GOLD_EXCHANGE_DEF_MIN;
            _loc1_ = this._selectedXp;
            _loc2_ = totalPrimaryCurrency;
         }
         else
         {
            this.nsXpExchange.stepSize = actualRate;
            this.nsGoldExchange.value = this._selectedGold;
            _loc1_ = this._selectedGold * actualRate;
            _loc2_ = Math.max(totalPrimaryCurrency - this._selectedGold,0);
         }
         this.nsXpExchange.value = _loc1_;
         this.itGoldResult.text = Boolean(this._locale) ? this._locale.gold(_loc2_) : _loc2_.toString();
         this.itGoldResult.validateNow();
         var _loc4_:Number = this._totalXp + _loc1_;
         this.itExperienceResult.text = Boolean(this._locale) ? this._locale.gold(_loc4_) : _loc4_.toString();
         var _loc5_:int = Boolean(this.scrollList.dataProvider) ? int(this.scrollList.dataProvider.length) : int(0);
         this.submitBtn.enabled = getSubmitButtonEnableStateS(_loc1_);
         this.buttonBar.enabled = _loc5_ > 0;
         var _loc6_:Boolean = totalPrimaryCurrency < this._selectedGold;
         this.exchangeGoldWarning.visible = _loc6_;
         this.exchangeGoldWarning.x = this.itGoldResult.x + this.itGoldResult.iconClip.x * this.itGoldResult.scaleX - this.exchangeGoldWarning.actualWidth;
         this.exchangeGoldWarning.y = this.itGoldResult.y + (this.itGoldResult.actualHeight - this.exchangeGoldWarning.height >> 1);
         this.nsGoldExchange.textColorId = !!_loc6_ ? TEXT_MANAGER_STYLES.ERROR_TEXT : TEXT_MANAGER_STYLES.GOLD_TEXT;
         this.itTotalAvailableXp.validateNow();
         this.lblTotalAvailableXp.x = this.itTotalAvailableXp.x + this.itTotalAvailableXp.width - this.itTotalAvailableXp.iconClip.width - this.itTotalAvailableXp.textField.textWidth - this.lblTotalAvailableXp.width - 13;
      }
      
      private function invalidateVehiclesData() : void
      {
         this.scrollList.dataProvider = this._scrollListProvider;
         if(this._haveEliteVehicles)
         {
            if(this._scrollListProvider == null || this._scrollListProvider.length == 0)
            {
               this.warningScreen.text = DIALOGS.EXCHANGEXPWINDOW_ERROR_NOVEHICLESWITHXP;
               this.warningScreen.visible = true;
            }
            else
            {
               this.warningScreen.visible = false;
            }
         }
         else
         {
            this.warningScreen.text = DIALOGS.EXCHANGEXPWINDOW_ERROR_NOELITEVEHICLEINHANGAR;
            this.warningScreen.visible = true;
         }
      }
      
      private function invalidateAvailableXp() : void
      {
         var _loc4_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:ExchangeXPVehicleVO = null;
         var _loc9_:int = 0;
         var _loc1_:Boolean = this._xpForFree > 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc5_:Boolean = true;
         var _loc6_:Boolean = true;
         if(this._scrollListProvider)
         {
            _loc7_ = this._scrollListProvider.length;
            _loc9_ = 0;
            while(_loc9_ < _loc7_)
            {
               _loc8_ = this._scrollListProvider[_loc9_];
               _loc4_ = _loc8_.xp;
               if(_loc8_.isSelectCandidate)
               {
                  _loc3_ += _loc4_;
               }
               _loc5_ = _loc5_ && _loc8_.isSelectCandidate;
               _loc2_ += _loc4_;
               _loc9_++;
            }
            _loc6_ = Boolean(_loc7_);
         }
         else
         {
            _loc6_ = false;
         }
         if(_loc1_ && _loc3_ > this._xpForFree)
         {
            _loc3_ = this._xpForFree;
         }
         this.cbSelectAll.removeEventListener(Event.SELECT,this.onCbSelectAllSelectHandler);
         this.cbSelectAll.selected = _loc6_ && _loc5_;
         this.cbSelectAll.enabled = _loc6_;
         if(_loc6_)
         {
            this.cbSelectAll.addEventListener(Event.SELECT,this.onCbSelectAllSelectHandler,false,0,true);
         }
         this.itTotalAvailableXp.text = Boolean(this._locale) ? this._locale.gold(_loc2_) : _loc2_.toString();
         this._selectedGold = _loc3_ / actualRate;
         this._selectedXp = Math.min(this._xpForFree,_loc3_);
         this.nsGoldExchange.enabled = !_loc1_;
         this.nsGoldExchange.maximum = this._selectedGold;
         this.nsXpExchange.maximum = !!_loc1_ ? Number(Math.min(this._xpForFree,_loc3_)) : Number(this._selectedGold * actualRate);
         if(this._targetXP > 0 && this._targetXP < this.nsXpExchange.maximum)
         {
            this._selectedGold = this._targetXP / actualRate >> 0;
            this._selectedXp = this._targetXP;
         }
      }
      
      private function onCbSelectAllSelectHandler(param1:Event) : void
      {
         this.scrollList.applySelection(this.cbSelectAll.selected);
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }
      
      private function onButtonBarSortDirectionChangedHandler(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         param1.stopImmediatePropagation();
         var _loc2_:SortingButton = SortingButton(param1.target);
         if(_loc2_ && _loc2_.sortDirection != SortingInfo.WITHOUT_SORT)
         {
            _loc3_ = _loc2_.sortDirection == SortingInfo.ASCENDING_SORT;
            this.scrollList.sortByField(_loc2_.id,_loc3_);
         }
      }
      
      private function onNsGoldExchangeIndexChangeHandler(param1:IndexEvent) : void
      {
         this._selectedGold = this.nsGoldExchange.value;
         invalidate(TOTAL_RESULT_INVALID);
      }
      
      private function onNsXpExchangeIndexChangeHandler(param1:IndexEvent) : void
      {
         this._selectedXp = this.nsXpExchange.value;
         this._selectedGold = this._selectedXp / actualRate;
         invalidate(TOTAL_RESULT_INVALID);
      }
      
      private function onSelectionChangedHandler(param1:Event) : void
      {
         param1.stopImmediatePropagation();
         invalidate(TOTAL_AVAILABLE_XP_INVALID);
      }
      
      private function onSubmitBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc3_:ExchangeXPVehicleVO = null;
         var _loc2_:Array = [];
         var _loc4_:DataProvider = DataProvider(this.scrollList.dataProvider);
         var _loc5_:uint = Boolean(_loc4_) ? uint(_loc4_.length) : uint(0);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = ExchangeXPVehicleVO(_loc4_[_loc6_]);
            if(_loc3_.isSelectCandidate)
            {
               _loc2_.push(_loc3_.id);
            }
            _loc6_++;
         }
         App.utils.asserter.assert(_loc2_.length > 0,ASSERTER_MSG_EMPTY_DATA_ARRAY);
         var _loc7_:Object = {
            "exchangeXp":this.nsXpExchange.value,
            "selectedVehicles":_loc2_
         };
         exchangeS(_loc7_);
      }
      
      private function onCancelBtnClickHandler(param1:ButtonEvent) : void
      {
         handleWindowClose();
      }
      
      private function onExchangeGoldWarningRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(TOOLTIPS.XPEXCHANGEWINDOW_GOLD_GOLDAFTEREXCHANGE);
      }
      
      private function onExchangeGoldWarningRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
