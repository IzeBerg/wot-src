package net.wg.gui.lobby.window
{
   import net.wg.data.VO.DialogSettingsVO;
   import net.wg.data.constants.Currencies;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.VO.CompoundPriceVO;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.infrastructure.base.meta.IConfirmItemWindowMeta;
   import net.wg.infrastructure.base.meta.impl.ConfirmItemWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.ListEvent;
   
   public class ConfirmItemWindow extends ConfirmItemWindowMeta implements IConfirmItemWindowMeta
   {
      
      private static const NORMAL_COLOR:int = 6447189;
      
      private static const ACTION_COLOR:int = 16777215;
      
      private static const RESULT_INVALID:String = "resultInv";
      
      private static const SELECTED_CURRENCY_INVALID:String = "currencyInv";
      
      private static const SETTINGS_INVALID:String = "settingsInv";
      
      private static const ZERO_STRING:String = "0";
      
      private static const TF_MAX_HEIGHT:int = 82;
       
      
      protected var data:ConfirmItemWindowVO;
      
      private var _settingsVO:DialogSettingsVO;
      
      private var _currency:String;
      
      private var _selectedCount:Number = 0;
      
      private var _locale:ILocale;
      
      private var _memLeftX:int = 0;
      
      public function ConfirmItemWindow()
      {
         this._locale = App.utils.locale;
         super();
         showWindowBgForm = false;
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(param1)
         {
            invalidate(SETTINGS_INVALID);
         }
      }
      
      override protected function setLabels() : void
      {
         content.countLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_COUNTLABEL);
         content.leftLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_PRICELABEL);
         content.rightLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
         content.resultLabel.text = this._locale.makeString(DIALOGS.CONFIRMMODULEDIALOG_TOTALLABEL);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(SETTINGS_INVALID) && window != null && this._settingsVO != null)
         {
            window.title = this._settingsVO.title;
            content.submitBtn.label = this._settingsVO.submitBtnLabel;
            content.cancelBtn.label = this._settingsVO.cancelBtnLabel;
         }
         if(this.data == null)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.applyData();
            invalidate(SELECTED_CURRENCY_INVALID);
            invalidateSize();
         }
         if(isInvalid(SELECTED_CURRENCY_INVALID))
         {
            this.applyCurrency();
            invalidate(RESULT_INVALID);
         }
         if(isInvalid(RESULT_INVALID))
         {
            this.applyResult();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            content.description.y = content.moduleName.y + content.moduleName.textHeight ^ 0;
            content.description.height = TF_MAX_HEIGHT - content.description.y;
         }
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         this._settingsVO = null;
         if(content != null)
         {
            content.dropdownMenu.removeEventListener(ListEvent.INDEX_CHANGE,this.onDropDownMenuIndexChangeHandler);
         }
         this._locale = null;
         super.onDispose();
      }
      
      override protected function setSettings(param1:DialogSettingsVO) : void
      {
         this._settingsVO = param1;
         invalidate(SETTINGS_INVALID);
      }
      
      protected function applyData() : void
      {
         var _loc7_:int = 0;
         var _loc8_:DataProvider = null;
         var _loc9_:int = 0;
         var _loc10_:Vector.<PriceVO> = null;
         var _loc11_:int = 0;
         var _loc12_:PriceVO = null;
         var _loc13_:String = null;
         var _loc1_:DropdownMenu = content.dropdownMenu;
         content.moduleName.htmlText = this.data.name;
         content.description.htmlText = this.data.description;
         var _loc2_:String = this.data.currency;
         var _loc3_:CompoundPriceVO = this.data.price;
         var _loc4_:int = _loc3_.getPriceValueByName(_loc2_);
         var _loc5_:int = NORMAL_COLOR;
         var _loc6_:Boolean = false;
         if(this.data.hasSeveralPrices)
         {
            _loc7_ = _loc1_.selectedIndex != -1 ? int(_loc1_.selectedIndex) : int(1);
            if(_loc1_.dataProvider != null)
            {
               _loc1_.dataProvider.cleanUp();
            }
            _loc8_ = new DataProvider();
            _loc9_ = 0;
            _loc10_ = _loc3_.items;
            _loc11_ = _loc10_.length;
            while(_loc9_ < _loc11_)
            {
               _loc12_ = _loc10_[_loc9_];
               _loc13_ = _loc12_.name;
               _loc8_.push(this._locale.htmlTextWithIcon(this._locale.integer(_loc12_.value),_loc13_));
               if(!_loc6_ && _loc13_ == CURRENCIES_CONSTANTS.GOLD)
               {
                  _loc6_ = true;
               }
               _loc9_++;
            }
            _loc1_.dataProvider = _loc8_;
            _loc1_.addEventListener(ListEvent.INDEX_CHANGE,this.onDropDownMenuIndexChangeHandler,false,0,true);
            _loc1_.selectedIndex = _loc7_;
            _loc5_ = ACTION_COLOR;
         }
         else if(_loc2_ == CURRENCIES_CONSTANTS.GOLD)
         {
            content.leftIT.text = this._locale.gold(_loc4_);
         }
         else
         {
            content.leftIT.text = this._locale.integer(_loc4_);
         }
         content.leftLabel.textColor = _loc5_;
         content.rightLabel.textColor = _loc5_;
         _loc1_.visible = this.data.hasSeveralPrices;
         content.leftIT.visible = !this.data.hasSeveralPrices;
         if(this.data.defaultValue != Values.DEFAULT_INT)
         {
            this._selectedCount = this.data.defaultValue;
         }
         else
         {
            this._selectedCount = content.nsCount.value;
         }
         content.leftResultIT.visible = _loc2_ == CURRENCIES_CONSTANTS.GOLD || _loc6_;
         this._memLeftX = content.leftResultIT.x;
         content.leftResultIT.x = content.rightResultIT.x;
         content.rightResultIT.visible = !content.leftResultIT.visible;
      }
      
      protected function clearData() : void
      {
         if(this.data != null)
         {
            this.data.dispose();
            this.data = null;
         }
      }
      
      private function applyCurrency() : void
      {
         var _loc1_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:PriceVO = null;
         var _loc2_:String = this.data.currency;
         var _loc3_:int = Currencies.INDEX_FROM_NAME[_loc2_];
         var _loc4_:uint = this.data.stepSize;
         if(this.data.hasSeveralPrices)
         {
            _loc6_ = content.dropdownMenu.selectedIndex;
            _loc7_ = this.data.price.items[_loc6_];
            _loc3_ = Currencies.INDEX_FROM_NAME[_loc7_.name];
         }
         _loc1_ = this.data.maxAvailableCount[_loc3_] * _loc4_;
         var _loc5_:Number = Math.min(1,_loc1_) * _loc4_;
         content.nsCount.stepSize = _loc4_;
         content.nsCount.minimum = _loc5_;
         content.nsCount.maximum = _loc1_;
         content.nsCount.value = Math.min(this._selectedCount,_loc1_);
         content.submitBtn.enabled = _loc5_ > 0;
      }
      
      private function applyResult() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc8_:int = 0;
         var _loc9_:CompoundPriceVO = null;
         var _loc12_:int = 0;
         var _loc13_:PriceVO = null;
         var _loc14_:PriceVO = null;
         var _loc6_:String = this.data.currency;
         var _loc7_:int = Currencies.INDEX_FROM_NAME[_loc6_];
         _loc9_ = this.data.price;
         var _loc10_:Vector.<PriceVO> = _loc9_.items;
         if(this.data.hasSeveralPrices)
         {
            _loc12_ = content.dropdownMenu.selectedIndex;
            _loc13_ = _loc10_[_loc12_];
            this._currency = _loc13_.name;
            _loc7_ = Currencies.INDEX_FROM_NAME[this._currency];
            if(_loc7_ != CURRENCIES_CONSTANTS.GOLD_INDEX)
            {
               _loc3_ = ZERO_STRING;
               _loc8_ = _loc9_.getPriceValueByName(this._currency);
               _loc2_ = content.nsCount.value / this.data.stepSize * _loc8_;
               _loc4_ = this._locale.integer(_loc2_);
               _loc5_ = _loc4_;
            }
            else
            {
               this._currency = CURRENCIES_CONSTANTS.GOLD;
               _loc4_ = ZERO_STRING;
               _loc8_ = _loc9_.getPriceValueByName(this._currency);
               _loc1_ = content.nsCount.value / this.data.stepSize * _loc8_;
               _loc3_ = this._locale.gold(_loc1_);
               _loc5_ = _loc3_;
            }
         }
         else
         {
            this._currency = this.data.currency;
            _loc8_ = _loc9_.getPriceValueByName(this._currency);
            if(this._currency == CURRENCIES_CONSTANTS.GOLD)
            {
               _loc1_ = content.nsCount.value / this.data.stepSize * _loc8_;
               _loc3_ = this._locale.gold(_loc1_);
               _loc5_ = _loc3_;
               _loc4_ = ZERO_STRING;
            }
            else
            {
               _loc2_ = content.nsCount.value / this.data.stepSize * _loc8_;
               _loc4_ = this._locale.integer(_loc2_);
               _loc5_ = _loc4_;
               _loc3_ = ZERO_STRING;
            }
         }
         var _loc11_:String = this._currency;
         if(_loc10_.length > 1)
         {
            for each(_loc14_ in _loc10_)
            {
               if(_loc14_.name != CURRENCIES_CONSTANTS.GOLD)
               {
                  _loc11_ = _loc14_.name;
               }
            }
         }
         else if(this._currency == CURRENCIES_CONSTANTS.GOLD)
         {
            _loc11_ = CURRENCIES_CONSTANTS.CREDITS;
         }
         content.leftResultIT.text = _loc3_;
         content.rightResultIT.text = _loc4_;
         content.rightResultIT.icon = _loc11_;
         content.leftIT.icon = this._currency;
         content.leftIT.textColor = Currencies.TEXT_COLORS[this._currency];
         content.rightIT.icon = this._currency;
         content.rightIT.textColor = Currencies.TEXT_COLORS[this._currency];
         content.rightIT.text = _loc5_;
         content.actionPrice.textColorType = ActionPrice.TEXT_COLOR_TYPE_ICON;
         content.actionPrice.setData(this.data.actionPriceData);
         content.rightIT.visible = !content.actionPrice.visible;
         if(_loc1_ > 0 && _loc2_ > 0)
         {
            content.leftResultIT.x = this._memLeftX;
            content.leftResultIT.visible = true;
            content.rightResultIT.visible = true;
         }
         else
         {
            content.leftResultIT.x = content.rightResultIT.x;
            content.leftResultIT.visible = _loc1_ > 0;
            content.rightResultIT.visible = !content.leftResultIT.visible;
         }
      }
      
      override protected function selectedCountChangeHandler(param1:IndexEvent) : void
      {
         this._selectedCount = content.nsCount.value;
         invalidate(RESULT_INVALID);
      }
      
      override protected function submitBtnClickHandler(param1:ButtonEvent) : void
      {
         submitS(this._selectedCount,this._currency);
      }
      
      private function onDropDownMenuIndexChangeHandler(param1:ListEvent) : void
      {
         invalidate(SELECTED_CURRENCY_INVALID);
      }
   }
}
