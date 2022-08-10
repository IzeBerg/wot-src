package net.wg.gui.lobby.vehicleTradeWnds.buy.views
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Colors;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.gui.components.advanced.DashLine;
   import net.wg.gui.components.assets.ArrowSeparator;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.TankmanTrainingButton;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.ev.VehicleBuyEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyRentItemVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuySubmitVo;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class ContentBuyView extends ContentBuyViewBase
   {
      
      private static const DD_MARGIN_X:int = 5;
      
      private static const SCHOOL_GROUP_NAME:String = "scoolGroup";
      
      private static const TRAINING_TYPE_ACADEMY:String = "academy";
      
      private static const TRAINING_TYPE_SCOOL:String = "scool";
      
      private static const TRAINING_TYPE_FREE:String = "free";
      
      private static const TRAINING_TYPES:Array = [TRAINING_TYPE_FREE,TRAINING_TYPE_SCOOL,TRAINING_TYPE_ACADEMY];
      
      private static const RESULT_ICON_TEXT_TOP_GAP:Number = 3;
      
      private static const RESULT_DASHLINE_TOP_GAP:Number = 16;
       
      
      public var tankPriceLabel:TextField = null;
      
      public var tankPrice:IconText = null;
      
      public var tankActionPrice:ActionPrice = null;
      
      public var rentIcon:MovieClip = null;
      
      public var rentDD:DropdownMenu;
      
      public var priceDashLine:DashLine = null;
      
      public var slotCheckbox:CheckBox = null;
      
      public var slotPrice:IconText = null;
      
      public var slotActionPrice:ActionPrice = null;
      
      public var slotDashLine:DashLine = null;
      
      public var freeRentSlot:TextField = null;
      
      public var ammoCheckbox:CheckBox = null;
      
      public var ammoPrice:IconText = null;
      
      public var ammoActionPrice:ActionPrice = null;
      
      public var ammoDashLine:DashLine = null;
      
      public var tankmenLabel:TextField = null;
      
      public var tankmenTotalLabel:TextField = null;
      
      public var academyBtn:TankmanTrainingButton = null;
      
      public var scoolBtn:TankmanTrainingButton = null;
      
      public var freeBtn:TankmanTrainingButton = null;
      
      public var separator:ArrowSeparator = null;
      
      public var crewCheckbox:CheckBox = null;
      
      public var crewInVehicle:TextField = null;
      
      public var resultPriceLabel:TextField = null;
      
      public var resultCreditsPrice:IconText = null;
      
      public var resultGoldPrice:IconText = null;
      
      public var resultDashLine:DashLine = null;
      
      private var _btnGroup:ButtonGroup = null;
      
      private var _lastSelectedButton:Button;
      
      private var _selectedRentId:int = -1;
      
      public function ContentBuyView()
      {
         super();
      }
      
      override public function getSubmitData() : VehicleBuySubmitVo
      {
         return new VehicleBuySubmitVo(this.slotCheckbox.selected,this.ammoCheckbox.selected,this.crewType,this._selectedRentId,Values.DEFAULT_INT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.rentIcon.visible = false;
         this.rentDD.visible = false;
         this.slotCheckbox.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.ammoCheckbox.addEventListener(Event.SELECT,this.onCheckBoxSelectHandler);
         this.crewCheckbox.addEventListener(Event.SELECT,this.onCrewCheckBoxSelectHandler);
         this.slotCheckbox.label = DIALOGS.BUYVEHICLEWINDOW_SLOTCHECKBOX;
         this.ammoCheckbox.label = DIALOGS.BUYVEHICLEWINDOW_AMMOCHECKBOX;
         this.tankmenLabel.text = DIALOGS.BUYVEHICLEWINDOW_TANKMENLABEL;
         var _loc1_:String = SCHOOL_GROUP_NAME;
         this._btnGroup = new ButtonGroup(_loc1_,this);
         this._btnGroup.addButton(this.academyBtn);
         this._btnGroup.addButton(this.scoolBtn);
         this._btnGroup.addButton(this.freeBtn);
         this.academyBtn.groupName = _loc1_;
         this.scoolBtn.groupName = _loc1_;
         this.freeBtn.groupName = _loc1_;
         this._btnGroup.addEventListener(Event.CHANGE,this.onBtnGroupChangeHandler,false,0,true);
         this.academyBtn.toggle = true;
         this.academyBtn.allowDeselect = false;
         this.scoolBtn.toggle = true;
         this.scoolBtn.allowDeselect = false;
         this.freeBtn.toggle = true;
         this.freeBtn.allowDeselect = false;
         this.freeBtn.selected = true;
         this.academyBtn.soundType = SoundTypes.RNDR_NORMAL;
         this.scoolBtn.soundType = SoundTypes.RNDR_NORMAL;
         this.freeBtn.soundType = SoundTypes.RNDR_NORMAL;
         this.crewInVehicle.text = DIALOGS.BUYVEHICLEWINDOW_CREWINVEHICLE;
         this.resultPriceLabel.text = DIALOGS.BUYVEHICLEWINDOW_TOTALLABEL;
         this.freeRentSlot.autoSize = TextFieldAutoSize.LEFT;
         this.freeRentSlot.text = DIALOGS.BUYVEHICLEWINDOW_FREERENTSLOT;
      }
      
      override protected function onDispose() : void
      {
         this.tankPriceLabel = null;
         this.rentIcon = null;
         this.tankPrice.dispose();
         this.tankPrice = null;
         this.tankActionPrice.dispose();
         this.tankActionPrice = null;
         this.rentDD.removeEventListener(ListEvent.INDEX_CHANGE,this.onHeaderMcRentDDIndexChangeHandler);
         this.rentDD.dispose();
         this.rentDD = null;
         this.priceDashLine.dispose();
         this.priceDashLine = null;
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
         this.tankmenLabel = null;
         this.tankmenTotalLabel = null;
         this.crewCheckbox.removeEventListener(Event.SELECT,this.onCrewCheckBoxSelectHandler);
         this.freeRentSlot = null;
         this._btnGroup.removeEventListener(Event.CHANGE,this.onBtnGroupChangeHandler);
         this._btnGroup.dispose();
         this._btnGroup = null;
         this.academyBtn.dispose();
         this.academyBtn = null;
         this.scoolBtn.dispose();
         this.scoolBtn = null;
         this.freeBtn.dispose();
         this.freeBtn = null;
         this._lastSelectedButton = null;
         this.crewCheckbox.dispose();
         this.crewCheckbox = null;
         this.crewInVehicle = null;
         this.resultPriceLabel = null;
         this.resultCreditsPrice.dispose();
         this.resultCreditsPrice = null;
         this.resultGoldPrice.dispose();
         this.resultGoldPrice = null;
         this.resultDashLine.dispose();
         this.resultDashLine = null;
         this.separator.dispose();
         this.separator = null;
         super.onDispose();
      }
      
      override public function setTrainingButtonsEnableState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         super.setTrainingButtonsEnableState(param1,param2,param3);
         this.academyBtn.enabled = param1;
         this.scoolBtn.enabled = param2;
         this.freeBtn.enabled = param3;
      }
      
      override protected function drawContent(param1:VehicleBuyContentVo) : void
      {
         super.drawContent(param1);
         if(param1.slotCheckboxTooltip)
         {
            this.slotCheckbox.toolTip = param1.slotCheckboxTooltip;
            this.slotCheckbox.infoIcoType = InfoIcon.TYPE_ATTENTION;
         }
         this.tankPriceLabel.text = param1.priceLabel;
         this.tankmenTotalLabel.text = param1.tankmenTotalLabel;
         this.crewCheckbox.label = param1.crewCheckbox;
         this.initStudyButtons();
         this.slotPrice.text = App.utils.locale.integer(param1.slotPrice);
         this.slotActionPrice.setData(param1.slotActionPriceDataVo);
         this.slotPrice.visible = !this.slotActionPrice.visible;
         this.updateSlotDashLine();
         this.rentDD.visible = param1.isRentable;
         if(param1.isRentable)
         {
            this.rentDD.dataProvider = new DataProvider(param1.rentDataProviderDD);
            this.rentDD.x = this.tankPriceLabel.x + this.tankPriceLabel.textWidth + DD_MARGIN_X ^ 0;
            this.rentIcon.x = this.rentDD.x + this.rentDD.width;
            if(!this.rentDD.hasEventListener(ListEvent.INDEX_CHANGE))
            {
               this.rentDD.addEventListener(ListEvent.INDEX_CHANGE,this.onHeaderMcRentDDIndexChangeHandler);
               this.rentDD.selectedIndex = param1.rentDataSelectedIndex;
            }
            if(param1.isStudyDisabled)
            {
               this.crewCheckbox.selected = false;
            }
         }
         else
         {
            this.freeRentSlot.visible = false;
         }
         this.scoolBtn.showPriceLabel = !param1.isStudyDisabled;
         this.academyBtn.showPriceLabel = !param1.isStudyDisabled;
         this.freeBtn.showPriceLabel = !param1.isStudyDisabled;
         this.crewCheckbox.visible = !param1.isStudyDisabled;
         this.crewInVehicle.visible = param1.isStudyDisabled;
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
         var _loc2_:Object = this.rentDD.dataProvider[this.rentDD.selectedIndex];
         if(param1.isRentable && _loc2_)
         {
            this.checkRentDDSelectedItem(_loc2_.data);
         }
         this.updateVehiclePrice();
      }
      
      override protected function drawWarningMsg(param1:String) : void
      {
         param1 = contentData && contentData.warningMsg != null ? contentData.warningMsg : Values.EMPTY_STR;
         super.drawWarningMsg(param1);
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Number = warningMsg.y + warningMsg.height;
         this.resultPriceLabel.y = _loc1_;
         this.resultGoldPrice.y = this.resultCreditsPrice.y = _loc1_ + RESULT_ICON_TEXT_TOP_GAP;
         this.resultDashLine.y = _loc1_ + RESULT_DASHLINE_TOP_GAP;
         bounds.height = this.resultPriceLabel.y + this.resultPriceLabel.height ^ 0;
         super.updateSize();
      }
      
      override protected function updateTotalResult() : void
      {
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
         if(!this.crewCheckbox.selected)
         {
            if(this.isGoldPriceSelected)
            {
               _loc1_ += this.selectedPrice;
            }
            else
            {
               _loc2_ += this.selectedPrice;
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
         super.updateTotalResult();
      }
      
      private function initStudyButtons() : void
      {
         this.freeBtn.updatePrice(contentData.studyFreeVo.price,Values.EMPTY_STR,contentData.studyFreeVo.actionPrice);
         this.scoolBtn.updatePrice(contentData.studySchoolVo.price,IconsTypes.CREDITS,contentData.studySchoolVo.actionPrice);
         this.academyBtn.updatePrice(contentData.studyAcademyVo.price,IconsTypes.GOLD,contentData.studyAcademyVo.actionPrice);
         this.freeBtn.data = contentData.studyFreeVo.price;
         this.scoolBtn.data = contentData.studySchoolVo.price;
         this.academyBtn.data = contentData.studyAcademyVo.price;
         this.scoolBtn.nation = this.academyBtn.nation = this.freeBtn.nation = contentData.nation;
      }
      
      private function checkRentDDSelectedItem(param1:VehicleBuyRentItemVo) : void
      {
         var _loc2_:ActionPriceVO = null;
         this._selectedRentId = param1.itemId;
         this.rentIcon.visible = this._selectedRentId != VehicleBuyRentItemVo.DEF_ITEM_ID;
         if(param1.itemId == VehicleBuyRentItemVo.DEF_ITEM_ID)
         {
            this.slotCheckbox.visible = true;
            _loc2_ = contentData.slotActionPriceDataVo;
            this.slotActionPrice.setData(_loc2_);
            this.slotPrice.visible = !this.slotActionPrice.visible;
            this.freeRentSlot.visible = false;
            this.updateSlotDashLine();
            this.slotDashLine.visible = true;
         }
         else
         {
            this.slotCheckbox.selected = false;
            this.slotCheckbox.visible = false;
            this.slotActionPrice.visible = false;
            this.slotPrice.visible = false;
            this.slotDashLine.visible = false;
            this.freeRentSlot.visible = true;
         }
         contentData.vehiclePricesActionData = param1.actionPriceDataVo;
         contentData.vehiclePrice = param1.price;
      }
      
      private function updatePriceDashLine() : void
      {
         this.tankPrice.validateNow();
         var _loc1_:Number = 0;
         if(this.rentIcon.visible)
         {
            _loc1_ = this.rentIcon.x + this.rentIcon.width;
         }
         else if(this.rentDD.visible)
         {
            _loc1_ = this.rentDD.x + this.rentDD.width;
         }
         else
         {
            _loc1_ = this.tankPriceLabel.x + this.tankPriceLabel.textWidth;
         }
         var _loc2_:Number = this.tankPrice.x + this.tankPrice.scaleX * this.tankPrice.textField.x;
         if(this.tankActionPrice.visible)
         {
            _loc2_ += DASH_LINE_ACTION_PRICE_SHIFT;
         }
         this.priceDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
         this.priceDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
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
      
      private function updateResultDashLine() : void
      {
         this.resultGoldPrice.validateNow();
         var _loc1_:Number = this.resultPriceLabel.x + this.resultPriceLabel.textWidth;
         var _loc2_:Number = this.resultGoldPrice.x + this.resultGoldPrice.scaleX * this.resultGoldPrice.textField.x;
         this.resultDashLine.width = _loc2_ - _loc1_ - DASH_LINE_LEFT_MARGIN ^ 0;
         this.resultDashLine.x = DASH_LINE_LEFT_MARGIN + _loc1_ ^ 0;
      }
      
      private function updateVehiclePrice() : void
      {
         var _loc1_:ActionPriceVO = contentData.vehiclePricesActionData;
         this.tankActionPrice.setData(_loc1_);
         this.tankPrice.visible = !this.tankActionPrice.visible;
         this.tankPrice.icon = !!contentData.vehiclePrice.isGold ? CURRENCIES_CONSTANTS.GOLD : CURRENCIES_CONSTANTS.CREDITS;
         this.tankPrice.textColor = !!contentData.vehiclePrice.isGold ? Number(CURRENCIES_CONSTANTS.GOLD_COLOR) : Number(CURRENCIES_CONSTANTS.CREDITS_COLOR);
         this.tankPrice.text = locale.integer(contentData.vehiclePrice.price);
         this.updatePriceDashLine();
         invalidate(INV_TOTAL_RESULT);
      }
      
      public function get lastItemSelected() : Boolean
      {
         if(this._lastSelectedButton)
         {
            return this._lastSelectedButton.selected;
         }
         return false;
      }
      
      public function set lastItemSelected(param1:Boolean) : void
      {
         if(this.lastItemSelected == param1)
         {
            return;
         }
         if(this._lastSelectedButton != null)
         {
            this._lastSelectedButton.selected = param1;
         }
         if(!param1)
         {
            this._btnGroup.selectedButton = null;
         }
      }
      
      public function get crewType() : int
      {
         var _loc1_:TankmanTrainingButton = null;
         if(this._btnGroup != null && this._btnGroup.selectedButton)
         {
            _loc1_ = TankmanTrainingButton(this._btnGroup.selectedButton);
            return TRAINING_TYPES.indexOf(_loc1_.type);
         }
         return -1;
      }
      
      public function get isGoldPriceSelected() : Boolean
      {
         if(this._btnGroup && this._btnGroup.selectedButton)
         {
            return TankmanTrainingButton(this._btnGroup.selectedButton).type == TRAINING_TYPE_ACADEMY;
         }
         return false;
      }
      
      public function get selectedPrice() : Number
      {
         if(this._btnGroup != null && this._btnGroup.selectedButton)
         {
            return Number(TankmanTrainingButton(this._btnGroup.selectedButton).data);
         }
         return NaN;
      }
      
      private function onHeaderMcRentDDIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:VehicleBuyRentItemVo = VehicleBuyRentItemVo(param1.itemData.data);
         this.checkRentDDSelectedItem(_loc2_);
         this.updateVehiclePrice();
      }
      
      private function onCheckBoxSelectHandler(param1:Event) : void
      {
         invalidate(INV_TOTAL_RESULT);
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.UPDATE_INTERFACE));
      }
      
      private function onCrewCheckBoxSelectHandler(param1:Event) : void
      {
         this.lastItemSelected = !this.crewCheckbox.selected;
         invalidate(INV_TOTAL_RESULT);
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.UPDATE_INTERFACE));
      }
      
      private function onBtnGroupChangeHandler(param1:Event) : void
      {
         if(this._btnGroup.selectedButton)
         {
            this._lastSelectedButton = this._btnGroup.selectedButton;
         }
         this.crewCheckbox.selected = false;
         invalidate(INV_TOTAL_RESULT);
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.UPDATE_INTERFACE));
      }
   }
}
