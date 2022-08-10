package net.wg.gui.lobby.vehicleTradeWnds.buy.views
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.Aliases;
   import net.wg.data.Colors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.assets.ArrowSeparator;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.ButtonIconTransparent;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenuPrice;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.ev.VehicleBuyEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyStudyVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuySubmitVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
   import net.wg.gui.lobby.vehicleTradeWnds.cpmts.ConfirmationInput;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class ContentBuyTradInView extends ContentBuyViewBase implements IPopOverCaller
   {
      
      private static const DISABLE_TEXT_ALPHA:Number = 0.5;
      
      private static const ENABLE_TEXT_ALPHA:Number = 1;
      
      private static const VEHICLE_INFO_WARNING_DEF_Y_POS:Number = 63;
      
      private static const VEHICLE_INFO_WARNING_TOP_PADDING:Number = 21;
      
      private static const VEHICLE_INFO_WARNING_ACTION_TOP_PADDING:Number = 4;
      
      private static const VEHICLE_INFO_WARNING_RIGHT_PADDING:Number = 25;
      
      private static const VEHICLE_INFO_TOP_PADDING:Number = 38;
      
      private static const INVALID_DISCOUNT_PRICE:String = "invalidDiscountPrice";
       
      
      public var tankPriceLabel:TextField = null;
      
      public var tankPrice:IconText = null;
      
      public var tankActionPrice:ActionPrice = null;
      
      public var vehiclePriceHit:Sprite = null;
      
      public var priceDashLine:DashLine = null;
      
      public var warningIco:AlertIco = null;
      
      public var vehicleBtn:CSVehicleButton = null;
      
      public var removeBtn:ButtonIconTransparent = null;
      
      public var tradeOffInfoTF:TextField = null;
      
      public var slotCheckbox:CheckBox = null;
      
      public var slotPrice:IconText = null;
      
      public var slotActionPrice:ActionPrice = null;
      
      public var slotDashLine:DashLine = null;
      
      public var ammoCheckbox:CheckBox = null;
      
      public var ammoPrice:IconText = null;
      
      public var ammoActionPrice:ActionPrice = null;
      
      public var ammoDashLine:DashLine = null;
      
      public var crewCheckbox:CheckBox = null;
      
      public var crewInVehicle:TextField = null;
      
      public var crewStudyLabel:TextField = null;
      
      public var crewDropdown:DropdownMenuPrice = null;
      
      public var crewDashLine:DashLine = null;
      
      public var resultPriceLabel:TextField = null;
      
      public var resultCreditsPrice:IconText = null;
      
      public var resultGoldPrice:IconText = null;
      
      public var resultDashLine:DashLine = null;
      
      public var confirmationInput:ConfirmationInput = null;
      
      public var separatorUp:ArrowSeparator = null;
      
      public var separatorDown:ArrowSeparator = null;
      
      private var _totalGold:String = "";
      
      private var _tradeInWarningMessagege:String = "";
      
      public function ContentBuyTradInView()
      {
         super();
      }
      
      override public function getSubmitData() : VehicleBuySubmitVo
      {
         var _loc2_:VehicleBuyStudyVo = null;
         var _loc1_:int = -1;
         if(!this.crewCheckbox.selected)
         {
            _loc2_ = VehicleBuyStudyVo(this.crewDropdown.dataProvider.requestItemAt(this.crewDropdown.selectedIndex));
            _loc1_ = _loc2_.crewType;
         }
         return new VehicleBuySubmitVo(this.slotCheckbox.selected,this.ammoCheckbox.selected,_loc1_,-1,tradeOffIntCD);
      }
      
      override public function setTradeInWarningMessagege(param1:String) : void
      {
         this._tradeInWarningMessagege = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tankActionPrice.interactive = false;
         this.warningIco.icoType = AlertIco.ALERT_ICO_BIG;
         this.warningIco.visible = false;
         this.warningIco.enabled = false;
         this.warningIco.buttonMode = false;
         this.removeBtn.iconSource = RES_ICONS.MAPS_ICONS_CLANS_INVITESWINDOW_CROSS;
         this.removeBtn.visible = false;
         this.vehicleBtn.visible = false;
         this.slotCheckbox.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.ammoCheckbox.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.crewCheckbox.addEventListener(Event.SELECT,this.onCrewCheckBoxSelectHandler);
         this.crewDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onCrewDropDownIndexChangeHandler);
         this.slotCheckbox.label = DIALOGS.BUYVEHICLEWINDOW_SLOTCHECKBOX;
         this.ammoCheckbox.label = DIALOGS.BUYVEHICLEWINDOW_AMMOCHECKBOX;
         this.resultPriceLabel.text = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_TOTALLABEL;
         this.confirmationInput.headerText = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_CONFIRMATION_TITLE;
         this.confirmationInput.questionText = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_CONFIRMATION_QUESTION;
         this.confirmationInput.errorText = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_CONFIRMATION_ERRORMESSAGE;
         this.confirmationInput.addEventListener(ConfirmationInput.USER_INPUT_HANDLER,this.onConfirmationInputUserInputHandler);
         this.vehiclePriceHit.addEventListener(MouseEvent.MOUSE_OVER,this.onVehiclePriceMouseOverHandler);
         this.vehiclePriceHit.addEventListener(MouseEvent.MOUSE_OUT,this.onVehiclePriceMouseOutHandler);
         this.vehiclePriceHit.addEventListener(MouseEvent.CLICK,this.onVehiclePriceClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.tankPriceLabel = null;
         this.tankPrice.dispose();
         this.tankPrice = null;
         this.tankActionPrice.dispose();
         this.tankActionPrice = null;
         this.vehiclePriceHit.removeEventListener(MouseEvent.MOUSE_OVER,this.onVehiclePriceMouseOverHandler);
         this.vehiclePriceHit.removeEventListener(MouseEvent.MOUSE_OUT,this.onVehiclePriceMouseOutHandler);
         this.vehiclePriceHit.removeEventListener(MouseEvent.CLICK,this.onVehiclePriceClickHandler);
         this.vehiclePriceHit = null;
         this.priceDashLine.dispose();
         this.priceDashLine = null;
         this.updateListenersWarningIco(false);
         this.warningIco.dispose();
         this.warningIco = null;
         this.vehicleBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.onVehicleBtnMouseDownHandler);
         this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleBtnRollOverHandler);
         this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleBtnRollOutHandler);
         this.vehicleBtn.dispose();
         this.vehicleBtn = null;
         this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
         this.removeBtn.dispose();
         this.removeBtn = null;
         this.tradeOffInfoTF = null;
         this.slotCheckbox.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.slotCheckbox.dispose();
         this.slotCheckbox = null;
         this.slotPrice.dispose();
         this.slotPrice = null;
         this.slotActionPrice.dispose();
         this.slotActionPrice = null;
         this.slotDashLine.dispose();
         this.slotDashLine = null;
         this.ammoCheckbox.removeEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.ammoCheckbox.dispose();
         this.ammoCheckbox = null;
         this.ammoPrice.dispose();
         this.ammoPrice = null;
         this.ammoActionPrice.dispose();
         this.ammoActionPrice = null;
         this.ammoDashLine.dispose();
         this.ammoDashLine = null;
         this.crewInVehicle = null;
         this.crewCheckbox.removeEventListener(Event.SELECT,this.onCrewCheckBoxSelectHandler);
         this.crewCheckbox.dispose();
         this.crewCheckbox = null;
         this.crewStudyLabel = null;
         this.crewDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onCrewDropDownIndexChangeHandler);
         this.crewDropdown.dispose();
         this.crewDropdown = null;
         this.crewDashLine.dispose();
         this.crewDashLine = null;
         this.resultPriceLabel = null;
         this.resultCreditsPrice.dispose();
         this.resultCreditsPrice = null;
         this.resultGoldPrice.dispose();
         this.resultGoldPrice = null;
         this.resultDashLine.dispose();
         this.resultDashLine = null;
         this.separatorUp.dispose();
         this.separatorUp = null;
         this.separatorDown.dispose();
         this.separatorDown = null;
         this.confirmationInput.removeEventListener(ConfirmationInput.USER_INPUT_HANDLER,this.onConfirmationInputUserInputHandler);
         this.confirmationInput.dispose();
         this.confirmationInput = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_DISCOUNT_PRICE))
         {
            this.updateTankPrice();
         }
      }
      
      override protected function drawContent(param1:VehicleBuyContentVo) : void
      {
         super.drawContent(param1);
         this.tankPriceLabel.text = param1.tradeInPriceLabel;
         this.crewCheckbox.label = param1.tradeInCrewCheckbox;
         this.slotPrice.text = App.utils.locale.integer(param1.slotPrice);
         this.slotActionPrice.setData(param1.slotActionPriceDataVo);
         this.slotPrice.visible = !this.slotActionPrice.visible;
         this.updateSlotDashLine();
         this.ammoPrice.text = locale.integer(param1.ammoPrice);
         if(param1.isNoAmmo)
         {
            this.ammoActionPrice.setData(param1.ammoActionPriceDataVo);
            this.ammoPrice.visible = !this.ammoActionPrice.visible;
         }
         else
         {
            this.ammoPrice.visible = this.ammoActionPrice.visible = param1.isNoAmmo;
         }
         this.ammoCheckbox.visible = param1.isNoAmmo;
         this.updateAmmoDashLine();
         this.crewStudyLabel.htmlText = param1.tradeInStudyLabel;
         this.crewDropdown.dataProvider = new DataProvider(App.utils.data.vectorToArray(param1.studyDataVo));
         this.crewDropdown.selectedIndex = param1.studyDataVo.length - 1;
         this.updateCrewDashLine();
         this.updateVehiclePrice();
         invalidate(INV_TRADEOFF_VEHICLE);
      }
      
      override protected function drawWarningMsg(param1:String) : void
      {
         param1 = this._tradeInWarningMessagege != null ? this._tradeInWarningMessagege : Values.EMPTY_STR;
         super.drawWarningMsg(param1);
      }
      
      override protected function updateSize() : void
      {
         bounds.height = warningMsg.y + warningMsg.height ^ 0;
         super.updateSize();
      }
      
      override protected function updateTotalResult() : void
      {
         var _loc3_:VehicleBuyStudyVo = null;
         var _loc1_:Number = !!this.slotCheckbox.selected ? Number(contentData.slotPrice) : Number(0);
         var _loc2_:Number = !!this.ammoCheckbox.selected ? Number(contentData.ammoPrice) : Number(0);
         if(contentData.vehiclePrice.isGold)
         {
            _loc1_ += contentData.vehiclePrice.price;
         }
         else
         {
            _loc2_ += contentData.vehiclePrice.price;
         }
         if(vehicleBuyTradeOffVo && vehicleBuyTradeOffVo.price > Values.DEFAULT_INT)
         {
            _loc1_ -= vehicleBuyTradeOffVo.price;
         }
         if(!this.crewCheckbox.selected)
         {
            _loc3_ = VehicleBuyStudyVo(this.crewDropdown.dataProvider.requestItemAt(this.crewDropdown.selectedIndex));
            if(_loc3_.id == VehicleBuyStudyVo.STUDY_ACADEMY_ID)
            {
               _loc1_ += _loc3_.price;
            }
            else
            {
               _loc2_ += _loc3_.price;
            }
         }
         this.resultGoldPrice.text = locale.gold(_loc1_);
         _loc2_ = !!isNaN(_loc2_) ? Number(0) : Number(_loc2_);
         this.resultCreditsPrice.text = locale.integer(_loc2_);
         isEnoughMoney = true;
         if(_loc1_ > userTotalGold)
         {
            this.resultGoldPrice.textColor = Colors.ERROR_COLOR;
            isEnoughMoney = false;
         }
         else
         {
            this.resultGoldPrice.textColor = Colors.GOLD_COLOR;
         }
         if(_loc2_ > userTotalCredits)
         {
            this.resultCreditsPrice.textColor = Colors.ERROR_COLOR;
            isEnoughMoney = false;
         }
         else
         {
            this.resultCreditsPrice.textColor = Colors.SILVER_COLOR;
         }
         this.updateResultDashLine();
         this.updateConfirmQuestion(_loc1_);
         super.updateTotalResult();
      }
      
      override protected function isSetSubmitFocused() : Boolean
      {
         return true;
      }
      
      override protected function drawTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void
      {
         tradeOffIntCD = Values.DEFAULT_INT;
         var _loc2_:Boolean = false;
         if(param1)
         {
            if(param1.vehicleVo != null)
            {
               this.vehicleBtn.setVehicle(param1.vehicleVo);
               tradeOffIntCD = param1.vehicleVo.intCD;
               _loc2_ = param1.vehicleVo.actionPrice != null;
            }
            if(param1.status)
            {
               this.tradeOffInfoTF.htmlText = param1.status;
            }
            else
            {
               this.setTradeOffDefText();
            }
         }
         else
         {
            this.vehicleBtn.reset();
            this.vehicleBtn.selectState(true,DIALOGS.BUYVEHICLEWINDOW_TRADEIN_VEHICLE_CHOOSE);
            this.setTradeOffDefText();
         }
         this.updateControlsEnabling(contentData.hasTradeOffVehicles,tradeOffIntCD != Values.DEFAULT_INT,_loc2_);
         invalidate(INVALID_DISCOUNT_PRICE);
         super.drawTradeOffVehicle(param1);
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.vehicleBtn;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.vehicleBtn;
      }
      
      private function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function updateTankPrice() : void
      {
         var _loc1_:Number = 0;
         if(vehicleBuyTradeOffVo != null && vehicleBuyTradeOffVo.price)
         {
            _loc1_ = -vehicleBuyTradeOffVo.price;
         }
         this.tankPrice.text = locale.integer(contentData.tradeInVehiclePrice.price + _loc1_);
         if(contentData.tradeInVehiclePricesActionData != null)
         {
            this.tankActionPrice.addExtraDiscount(_loc1_);
         }
      }
      
      private function updateControlsEnabling(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Boolean = param1 && param2;
         var _loc5_:Number = !!_loc4_ ? Number(ENABLE_TEXT_ALPHA) : Number(DISABLE_TEXT_ALPHA);
         this.warningIco.visible = !param1 || param1 && param3;
         this.vehicleBtn.enabled = param1;
         this.vehicleBtn.visible = param1;
         this.removeBtn.visible = _loc4_;
         if(param1)
         {
            this.tradeOffInfoTF.y = this.vehicleBtn.y + VEHICLE_INFO_TOP_PADDING;
            this.removeBtn.addEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
            this.vehicleBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onVehicleBtnMouseDownHandler);
            this.vehicleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleBtnRollOverHandler);
            this.vehicleBtn.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleBtnRollOutHandler);
            if(param3)
            {
               this.warningIco.y = this.tradeOffInfoTF.y + VEHICLE_INFO_WARNING_ACTION_TOP_PADDING;
               this.warningIco.x = (bounds.width - this.tradeOffInfoTF.textWidth >> 1) - VEHICLE_INFO_WARNING_RIGHT_PADDING;
               this.updateListenersWarningIco(true);
            }
            else
            {
               this.updateListenersWarningIco(false);
            }
         }
         else
         {
            this.updateListenersWarningIco(false);
            this.warningIco.x = bounds.width - this.warningIco.width >> 1;
            this.warningIco.y = VEHICLE_INFO_WARNING_DEF_Y_POS;
            this.tradeOffInfoTF.y = this.warningIco.y + VEHICLE_INFO_WARNING_TOP_PADDING;
            this.removeBtn.removeEventListener(ButtonEvent.CLICK,this.onRemoveBtnClickHandler);
            this.vehicleBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.onVehicleBtnMouseDownHandler);
            this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleBtnRollOverHandler);
            this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleBtnRollOutHandler);
         }
         this.slotCheckbox.enabled = _loc4_;
         this.slotPrice.enabled = _loc4_;
         this.slotActionPrice.enabled = _loc4_;
         this.slotDashLine.enabled = _loc4_;
         this.ammoCheckbox.enabled = _loc4_;
         this.ammoPrice.enabled = _loc4_;
         this.ammoActionPrice.enabled = _loc4_;
         this.ammoDashLine.enabled = _loc4_;
         this.crewCheckbox.enabled = _loc4_;
         this.crewInVehicle.alpha = _loc5_;
         this.crewStudyLabel.alpha = _loc5_;
         this.crewDropdown.enabled = _loc4_;
         this.crewDashLine.enabled = _loc4_;
         this.resultPriceLabel.alpha = _loc5_;
         this.resultCreditsPrice.enabled = _loc4_;
         this.resultGoldPrice.enabled = _loc4_;
         this.resultDashLine.enabled = _loc4_;
         this.confirmationInput.enabled = _loc4_;
      }
      
      private function updateListenersWarningIco(param1:Boolean) : void
      {
         if(param1)
         {
            this.warningIco.addEventListener(MouseEvent.MOUSE_OVER,this.onWarningIcoMouseOverHandler);
            this.warningIco.addEventListener(MouseEvent.MOUSE_OUT,this.onWarningIcoMouseOutHandler);
            this.warningIco.addEventListener(MouseEvent.CLICK,this.onWarningIcoClickHandler);
         }
         else
         {
            this.warningIco.removeEventListener(MouseEvent.MOUSE_OVER,this.onWarningIcoMouseOverHandler);
            this.warningIco.removeEventListener(MouseEvent.MOUSE_OUT,this.onWarningIcoMouseOutHandler);
            this.warningIco.removeEventListener(MouseEvent.CLICK,this.onWarningIcoClickHandler);
         }
         this.warningIco.enabled = param1;
      }
      
      private function onWarningIcoMouseOverHandler(param1:MouseEvent) : void
      {
         this.showTradeOffActionTooltip();
      }
      
      private function onWarningIcoMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onWarningIcoClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      public function showTradeOffActionTooltip() : void
      {
         if(vehicleBuyTradeOffVo && vehicleBuyTradeOffVo.vehicleVo.actionPrice)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_PRICE,null,vehicleBuyTradeOffVo.vehicleVo.actionPrice.type,vehicleBuyTradeOffVo.vehicleVo.actionPrice.key,vehicleBuyTradeOffVo.vehicleVo.actionPrice.newPrices,vehicleBuyTradeOffVo.vehicleVo.actionPrice.oldPrices,vehicleBuyTradeOffVo.vehicleVo.actionPrice.isBuying,vehicleBuyTradeOffVo.vehicleVo.actionPrice.forCredits,vehicleBuyTradeOffVo.vehicleVo.actionPrice.rentPackage);
         }
      }
      
      private function updateVehiclePrice() : void
      {
         this.tankPrice.icon = !!contentData.tradeInVehiclePrice.isGold ? CURRENCIES_CONSTANTS.GOLD : CURRENCIES_CONSTANTS.CREDITS;
         this.tankPrice.textColor = !!contentData.tradeInVehiclePrice.isGold ? Number(CURRENCIES_CONSTANTS.GOLD_COLOR) : Number(CURRENCIES_CONSTANTS.CREDITS_COLOR);
         this.tankActionPrice.setData(contentData.tradeInVehiclePricesActionData);
         this.tankPrice.visible = !this.tankActionPrice.visible;
         this.updateTankPrice();
         this.updatePriceDashLine();
         invalidate(INV_TOTAL_RESULT);
      }
      
      private function updatePriceDashLine() : void
      {
         this.tankPrice.validateNow();
         var _loc1_:Number = this.tankPriceLabel.x + this.tankPriceLabel.textWidth;
         var _loc2_:Number = this.tankPrice.x + this.tankPrice.scaleX * this.tankPrice.textField.x;
         if(this.tankActionPrice.visible)
         {
            _loc2_ += DASH_LINE_ACTION_PRICE_SHIFT;
         }
         this.priceDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
         this.priceDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
         this.vehiclePriceHit.x = this.priceDashLine.x + this.priceDashLine.width;
         this.vehiclePriceHit.width = this.tankPrice.textField.textWidth + this.tankPrice.scaleX * this.tankPrice.iconClip.width;
      }
      
      private function updateSlotDashLine() : void
      {
         this.slotCheckbox.validateNow();
         this.slotPrice.validateNow();
         var _loc1_:Number = this.slotCheckbox.x + this.slotCheckbox.hit.width;
         var _loc2_:Number = this.slotPrice.x + this.slotPrice.scaleX * this.slotPrice.textField.x;
         if(this.slotActionPrice.visible)
         {
            _loc2_ += DASH_LINE_ACTION_PRICE_SHIFT;
         }
         this.slotDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
         this.slotDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
      }
      
      private function updateAmmoDashLine() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         this.ammoDashLine.visible = this.ammoCheckbox.visible;
         if(this.ammoDashLine.visible)
         {
            this.ammoCheckbox.validateNow();
            this.ammoPrice.validateNow();
            _loc1_ = this.ammoCheckbox.x + this.ammoCheckbox.hit.width;
            _loc2_ = this.ammoPrice.x + this.ammoPrice.scaleX * this.ammoPrice.textField.x;
            if(this.ammoActionPrice.visible)
            {
               _loc2_ += DASH_LINE_ACTION_PRICE_SHIFT;
            }
            this.ammoDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
            this.ammoDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
         }
      }
      
      private function updateCrewDashLine() : void
      {
         var _loc1_:Number = this.crewStudyLabel.x + this.crewStudyLabel.textWidth;
         var _loc2_:Number = this.crewDropdown.x;
         this.crewDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
         this.crewDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
      }
      
      private function updateResultDashLine() : void
      {
         this.resultGoldPrice.validateNow();
         var _loc1_:Number = this.resultPriceLabel.x + this.resultPriceLabel.textWidth;
         var _loc2_:Number = this.resultGoldPrice.x + this.resultGoldPrice.scaleX * this.resultGoldPrice.textField.x;
         this.resultDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
         this.resultDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
      }
      
      private function updateConfirmQuestion(param1:Number) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = param1.toString(10);
         if(this._totalGold != _loc2_)
         {
            this.confirmationInput.cleanField();
            this._totalGold = _loc2_;
            _loc3_ = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.GOLD_TEXT,this.resultGoldPrice.text);
            this.confirmationInput.controlText = this._totalGold;
            this.confirmationInput.formattedControlText = this.resultGoldPrice.text;
            this.confirmationInput.questionText = App.utils.locale.makeString(DIALOGS.BUYVEHICLEWINDOW_TRADEIN_CONFIRMATION_QUESTION) + "(" + _loc3_ + ")";
         }
      }
      
      private function clearVehicleBtn() : void
      {
         tradeOffIntCD = Values.DEFAULT_INT;
         vehicleBuyTradeOffVo = null;
         invalidate(INV_TRADEOFF_VEHICLE);
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.TRADE_IN_CLEAR_VEHICLE,true));
      }
      
      private function setTradeOffDefText() : void
      {
         if(contentData && contentData.hasTradeOffVehicles)
         {
            this.tradeOffInfoTF.text = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_WARNING_CHOOSE;
         }
         else
         {
            this.tradeOffInfoTF.text = DIALOGS.BUYVEHICLEWINDOW_TRADEIN_INFO_NOVEHICLES;
         }
      }
      
      override public function get isSubmitEnabled() : Boolean
      {
         return isEnoughMoney && this.confirmationInput.isValidControlInput && contentData && contentData.hasTradeOffVehicles && tradeInIntCD != Values.DEFAULT_INT;
      }
      
      private function onVehiclePriceMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.TRADE_IN_PRICE,null,tradeInIntCD,tradeOffIntCD);
      }
      
      private function onVehiclePriceMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onVehiclePriceClickHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         invalidate(INV_TOTAL_RESULT);
      }
      
      private function onCrewCheckBoxSelectHandler(param1:Event) : void
      {
         invalidate(INV_TOTAL_RESULT);
      }
      
      private function onCrewDropDownIndexChangeHandler(param1:ListEvent) : void
      {
         this.crewCheckbox.removeEventListener(Event.SELECT,this.onCrewCheckBoxSelectHandler);
         this.crewCheckbox.selected = false;
         this.crewCheckbox.addEventListener(Event.SELECT,this.onCrewCheckBoxSelectHandler);
         invalidate(INV_TOTAL_RESULT);
      }
      
      private function onConfirmationInputUserInputHandler(param1:Event) : void
      {
         dispatchUpdate();
      }
      
      private function onRemoveBtnClickHandler(param1:ButtonEvent) : void
      {
         if(tradeOffIntCD >= Values.DEFAULT_INT)
         {
            this.clearVehicleBtn();
         }
      }
      
      private function onVehicleBtnMouseDownHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
         var _loc2_:Object = {
            "tradeIn":tradeInIntCD,
            "tradeOff":tradeOffIntCD
         };
         App.popoverMgr.show(this,Aliases.TRADEIN_POPOVER,_loc2_);
      }
      
      private function onVehicleBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(tradeOffIntCD != Values.DEFAULT_INT)
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SELECTED_VEHICLE_TRADEOFF,null,tradeOffIntCD);
         }
      }
      
      private function onVehicleBtnRollOutHandler(param1:MouseEvent) : void
      {
         this.hideTooltip();
      }
   }
}
