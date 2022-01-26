package net.wg.gui.lobby.vehicleTradeWnds.sell
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.SellDialogElementVO;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.AlertIco;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.events.VehicleSellDialogEvent;
   import net.wg.gui.interfaces.ISaleItemBlockRenderer;
   import net.wg.gui.lobby.vehicleTradeWnds.sell.utils.VehicleSellDialogUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class SaleItemBlockRenderer extends ListItemRenderer implements ISaleItemBlockRenderer
   {
      
      private static const RIGHT_MARGIN:Number = 7;
      
      private static const ACTION_PRICE_LEFT_PADDING:Number = -5;
      
      private static const DASH:String = "-";
       
      
      public var tfShort:TextFieldShort = null;
      
      public var alertIcon:AlertIco = null;
      
      public var ddm:DropdownMenu = null;
      
      public var labelTf:TextField = null;
      
      public var money:IconText = null;
      
      public var actionPrice:ActionPrice = null;
      
      public var clickArea:SoundButton = null;
      
      public var itemUnderline:MovieClip = null;
      
      private var _rendererData:SellDialogElementVO;
      
      public function SaleItemBlockRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = param1;
         this._rendererData = SellDialogElementVO(param1);
         if(this._rendererData.sellActionPriceVo)
         {
            this._rendererData.sellActionPriceVo.useSign = true;
            this._rendererData.sellActionPriceVo.forCredits = true;
            this._rendererData.sellActionPriceVo.newPrice = this._rendererData.moneyValue;
         }
         if(this._rendererData.removeActionPriceVo)
         {
            this._rendererData.removeActionPriceVo.useSign = true;
            this._rendererData.removeActionPriceVo.externalSign = DASH;
            this._rendererData.removeActionPriceVo.forCredits = false;
         }
         invalidateData();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         this.money.x = param1 - this.money.width - RIGHT_MARGIN;
         this.actionPrice.x = param1 + ACTION_PRICE_LEFT_PADDING;
         this.itemUnderline.width = param1;
      }
      
      override protected function onDispose() : void
      {
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler,false);
         this.alertIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler,false);
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.clickArea.removeEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false);
         this.clickArea.removeEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false);
         this.clickArea.removeEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false);
         this.clickArea.removeEventListener(MouseEvent.CLICK,handleMouseRelease,false);
         this.clickArea.removeEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease);
         this.clickArea.dispose();
         this.clickArea = null;
         this.labelTf = null;
         if(this.ddm)
         {
            this.ddm.removeEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler);
            this.ddm.dispose();
            this.ddm = null;
         }
         this.tfShort.dispose();
         this.tfShort = null;
         this.money.dispose();
         this.money = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.itemUnderline = null;
         this._rendererData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.buttonMode = false;
         this.money.textFieldYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
         this.actionPrice.textYOffset = VehicleSellDialog.ICONS_TEXT_OFFSET;
         this.labelTf.text = DIALOGS.VEHICLESELLDIALOG_UNLOAD;
         this.alertIcon.addEventListener(MouseEvent.ROLL_OVER,this.onAlertIconRollOverHandler,false,0,true);
         this.alertIcon.addEventListener(MouseEvent.ROLL_OUT,this.onAlertIconRollOutHandler,false,0,true);
         this.alertIcon.buttonMode = false;
         this.tfShort.buttonMode = false;
         this.tfShort.useHtml = true;
         if(this.clickArea)
         {
            this.clickArea.addEventListener(MouseEvent.ROLL_OVER,handleMouseRollOver,false,0,true);
            this.clickArea.addEventListener(MouseEvent.ROLL_OUT,handleMouseRollOut,false,0,true);
            this.clickArea.addEventListener(MouseEvent.MOUSE_DOWN,handleMousePress,false,0,true);
            this.clickArea.addEventListener(MouseEvent.CLICK,handleMouseRelease,false,0,true);
            this.clickArea.addEventListener(MouseEvent.DOUBLE_CLICK,handleMouseRelease,false,0,true);
            this.clickArea.buttonMode = false;
            this.clickArea.soundEnabled = false;
         }
         if(_focusIndicator != null && !_focused && _focusIndicator.totalFrames == 1)
         {
            focusIndicator.visible = false;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && data)
         {
            _loc1_ = this._rendererData.onlyToInventory;
            this.labelTf.visible = _loc1_;
            this.ddm.visible = !_loc1_;
            if(_loc1_)
            {
               this.actionPrice.setData(null);
               this.alertIcon.visible = false;
               this.drawMoney(CURRENCIES_CONSTANTS.CREDITS,0);
            }
            else
            {
               this.ddm.dataProvider = this.createDropDownDataProvider();
               this.ddm.selectedIndex = this.getSelectedIndex();
               this.ddm.validateNow();
               this.ddm.addEventListener(ListEvent.INDEX_CHANGE,this.onIndexChangeHandler);
               this.updateStateByDropDown();
            }
         }
         if(this._rendererData.type == FITTING_TYPES.SHELL)
         {
            if(this._rendererData.kind != Values.EMPTY_STR)
            {
               _loc2_ = App.utils.locale.makeString(ITEM_TYPES.shell_kindsabbreviation(this._rendererData.kind));
               this.tfShort.label = _loc2_ + " " + this._rendererData.id;
               this.tfShort.altToolTip = App.utils.locale.makeString(ITEM_TYPES.shell_kinds(this._rendererData.kind)) + " " + data.id;
            }
         }
         else
         {
            this.tfShort.label = this._rendererData.id;
         }
         constraints.update(this._width,this._height);
      }
      
      private function createDropDownDataProvider() : DataProvider
      {
         var _loc2_:Object = null;
         var _loc3_:Vector.<String> = null;
         var _loc4_:ActionPriceVO = null;
         var _loc5_:String = null;
         var _loc1_:DataProvider = new DataProvider();
         if(this._rendererData.isComplexOptionalDevice)
         {
            _loc1_.push(new DDItem(VehicleSellDialogUtils.getLabel(DIALOGS.SELLCONFIRMATION_SUBMIT),this._rendererData.moneyValue,this._rendererData.sellActionPriceVo,false));
            _loc2_ = this._rendererData.removePrice;
            _loc3_ = VehicleSellDialogUtils.extractSortedCurrencies(_loc2_);
            _loc4_ = this._rendererData.removeActionPriceVo;
            for each(_loc5_ in _loc3_)
            {
               _loc1_.push(new DDItem(VehicleSellDialogUtils.getLabel(DIALOGS.VEHICLESELLDIALOG_UNLOAD,_loc5_),-_loc2_[_loc5_],_loc4_,true,_loc5_));
            }
         }
         else
         {
            _loc1_.push(new DDItem(DIALOGS.SELLCONFIRMATION_SUBMIT,this._rendererData.moneyValue,this._rendererData.sellActionPriceVo,false));
            _loc1_.push(new DDItem(DIALOGS.VEHICLESELLDIALOG_UNLOAD));
         }
         return _loc1_;
      }
      
      private function getSelectedIndex() : uint
      {
         var _loc1_:Array = null;
         var _loc2_:DDItem = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!this._rendererData.toInventory)
         {
            return 0;
         }
         if(this._rendererData.isComplexOptionalDevice)
         {
            _loc1_ = this.ddm.dataProvider as Array;
            if(_loc1_)
            {
               _loc3_ = _loc1_.length;
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_ = _loc1_[_loc4_] as DDItem;
                  if(_loc2_ && _loc2_.currency == this._rendererData.removeCurrency)
                  {
                     return _loc4_;
                  }
                  _loc4_++;
               }
            }
         }
         return 1;
      }
      
      public function hideLine() : void
      {
         this.itemUnderline.visible = false;
      }
      
      private function getDropDownSelectedItem() : DDItem
      {
         if(this.ddm.selectedIndex < 0 || this.ddm.selectedIndex >= this.ddm.dataProvider.length)
         {
            return null;
         }
         return this.ddm.dataProvider[this.ddm.selectedIndex] as DDItem;
      }
      
      private function updateStateByDropDown() : void
      {
         var _loc1_:DDItem = this.getDropDownSelectedItem();
         if(_loc1_ == null)
         {
            return;
         }
         this.drawMoney(_loc1_.currency,_loc1_.value);
         this.actionPrice.setData(_loc1_.actionPrice);
         this.alertIcon.visible = _loc1_.toInventory && !this._rendererData.isRemovable;
         this.money.visible = !this.actionPrice.visible;
      }
      
      private function drawMoney(param1:String, param2:int) : void
      {
         this.money.text = VehicleSellDialogUtils.getCost(param2,param1);
         this.money.textColor = VehicleSellDialogUtils.getColorByCurrency(param1);
         this.money.icon = param1;
      }
      
      private function onAlertIconRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 330;
         var _loc3_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,_loc2_);
         if(CURRENCIES_CONSTANTS.GOLD in this._rendererData.removePrice)
         {
            App.toolTipMgr.showComplex(TOOLTIPS.VEHICLESELLDIALOG_RENDERER_ALERTICONGOLD,_loc3_);
         }
         else
         {
            App.toolTipMgr.showComplex(TOOLTIPS.VEHICLESELLDIALOG_RENDERER_ALERTICONCRYSTAL,_loc3_);
         }
      }
      
      private function onAlertIconRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onIndexChangeHandler(param1:ListEvent) : void
      {
         this.updateStateByDropDown();
         var _loc2_:DDItem = this.getDropDownSelectedItem();
         if(_loc2_)
         {
            dispatchEvent(new VehicleSellDialogEvent(VehicleSellDialogEvent.SELECTION_CHANGED,0,this._rendererData.itemIDList,_loc2_.toInventory,_loc2_.currency));
         }
      }
   }
}

import net.wg.data.constants.Currencies;
import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
import net.wg.gui.components.controls.VO.ActionPriceVO;

class DDItem
{
    
   
   public var label:String;
   
   public var value:int;
   
   public var toInventory:Boolean;
   
   public var currency:String;
   
   public var actionPrice:ActionPriceVO;
   
   function DDItem(param1:String, param2:int = 0, param3:ActionPriceVO = null, param4:Boolean = true, param5:String = null)
   {
      super();
      this.label = param1;
      this.value = param2;
      this.currency = param5 || CURRENCIES_CONSTANTS.CREDITS;
      this.actionPrice = this.currency in Currencies.TEXT_COLORS ? param3 : null;
      this.toInventory = param4;
   }
}
