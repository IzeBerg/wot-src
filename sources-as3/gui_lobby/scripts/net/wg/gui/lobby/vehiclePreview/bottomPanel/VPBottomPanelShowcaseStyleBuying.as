package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.ActionPrice;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.vehiclePreview.data.VPShowcaseStyleBuyingVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBottomPanelShowcaseStyleBuyingMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBottomPanelShowcaseStyleBuyingMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPBottomPanelShowcaseStyleBuying extends VehiclePreviewBottomPanelShowcaseStyleBuyingMeta implements IVehiclePreviewBottomPanelShowcaseStyleBuyingMeta, IVPBottomPanel
   {
      
      private static const INVALIDATE_BUYING_TIME_ELAPSED:String = "invalidateBuyingTimeElapsed";
      
      private static const MAX_WIDTH:uint = 700;
      
      private static const MAX_HEIGHT:uint = 120;
      
      private static const OFFSET_Y:int = 25;
      
      private static const STRIKELINE_OFFSET_X:int = 1;
      
      private static const CURRENT_PRICE_TF_PADDING_LEFT:int = 10;
      
      private static const PRICE_ICON_PADDING_LEFT:int = 5;
      
      private static const ACTION_PRICE_PADDING_LEFT:int = 5;
      
      private static const ACTION_BUTTON_PADDING_LEFT:int = 28;
      
      private static const DIVIDER_PADDING_LEFT:int = 22;
      
      private static const TIME_REMAINING_DESC_PADDING_LEFT:int = 22;
      
      private static const TIME_ICON_PADDING_LEFT:int = 2;
      
      private static const TIME_REMAINING_PADDING_LEFT:int = -7;
      
      private static const SMALL_SCREEN_OFFSET_Y:int = 13;
       
      
      public var infoIcon:InfoIcon = null;
      
      public var infoMsgTf:TextField = null;
      
      public var strikeline:Sprite = null;
      
      public var oldPriceTf:TextField = null;
      
      public var currentPriceTf:TextField = null;
      
      public var priceIcon:MovieClip = null;
      
      public var actionPrice:ActionPrice = null;
      
      public var actionButton:UniversalBtn = null;
      
      public var divider:Sprite = null;
      
      public var timeRemainingDescTf:TextField = null;
      
      public var timeIcon:Sprite = null;
      
      public var timeRemainingTf:TextField = null;
      
      public var doubleCheck:Sprite = null;
      
      public var boughtMsgTf:TextField = null;
      
      public var bg:VehiclePreviewBottomPanelShowcaseStyleBuyingBg = null;
      
      private var _data:VPShowcaseStyleBuyingVO = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _isBuyingTimeElapsed:Boolean = false;
      
      private var _isBuyingTimeStateChangedFlag:Boolean = false;
      
      public function VPBottomPanelShowcaseStyleBuying()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      private static function getCurrentPriceTextColor(param1:String) : uint
      {
         var _loc2_:uint = IconsTypes.MONEY_COLOR;
         switch(param1)
         {
            case IconsTypes.GOLD:
               _loc2_ = IconsTypes.GOLD_COLOR;
               break;
            case IconsTypes.GOLD_BIG:
               _loc2_ = IconsTypes.GOLD_COLOR;
               break;
            case IconsTypes.CREDITS:
               _loc2_ = IconsTypes.CREDITS_COLOR;
               break;
            case IconsTypes.CREDITS_BIG:
               _loc2_ = IconsTypes.CREDITS_COLOR;
               break;
            case IconsTypes.CRYSTAL:
               _loc2_ = IconsTypes.CRYSTAL_COLOR;
               break;
            case IconsTypes.WDR_COIN:
               _loc2_ = IconsTypes.WDR_COIN_COLOR;
         }
         return _loc2_;
      }
      
      override protected function setData(param1:VPShowcaseStyleBuyingVO) : void
      {
         this._data = param1;
         invalidateData();
         invalidateSize();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoIcon.icoType = InfoIcon.TYPE_WARNING;
         this.infoIcon.visible = false;
         this.infoMsgTf.autoSize = TextFieldAutoSize.LEFT;
         this.infoMsgTf.text = VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_NOVEHICLEMSG;
         this.infoMsgTf.visible = false;
         this.oldPriceTf.autoSize = TextFieldAutoSize.LEFT;
         this.currentPriceTf.autoSize = TextFieldAutoSize.LEFT;
         this.priceIcon.stop();
         this.actionPrice.mouseEnabled = this.actionPrice.mouseChildren = false;
         this.actionButton.mouseEnabledOnDisabled = true;
         this.actionButton.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.addEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.actionButton.addEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         this.actionButton.label = VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_ACTIONBTN_LABEL_BUY;
         App.utils.universalBtnStyles.setStyle(this.actionButton,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
         this.timeRemainingDescTf.autoSize = TextFieldAutoSize.LEFT;
         this.timeRemainingDescTf.text = VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_TIMEREMAINING_DESC;
         this.timeRemainingTf.autoSize = TextFieldAutoSize.LEFT;
         this.doubleCheck.visible = false;
         this.boughtMsgTf.autoSize = TextFieldAutoSize.LEFT;
         this.boughtMsgTf.text = VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_BOUGHTMSG;
         this.boughtMsgTf.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:ActionPriceVO = null;
         var _loc2_:Boolean = false;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               if(this._data.isBought)
               {
                  this.infoIcon.visible = this.infoMsgTf.visible = this.strikeline.visible = this.oldPriceTf.visible = this.currentPriceTf.visible = this.priceIcon.visible = this.actionPrice.visible = this.actionButton.visible = this.divider.visible = this.timeRemainingDescTf.visible = this.timeIcon.visible = this.timeRemainingTf.visible = false;
                  this.doubleCheck.visible = this.boughtMsgTf.visible = true;
                  this.bg.useExtraSmallSize();
               }
               else
               {
                  _loc1_ = this._data.actionPrice;
                  _loc2_ = StringUtils.isNotEmpty(this._data.timeRemainingStr);
                  this.infoMsgTf.text = !!this._data.isNoVehicle ? VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_NOVEHICLEMSG : VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_OUTOFTIMEMSG;
                  this.infoIcon.visible = this.infoMsgTf.visible = this._data.isNoVehicle;
                  this.priceIcon.gotoAndStop(this._data.priceType);
                  this.bg.useSmallSize();
                  if(_loc1_)
                  {
                     this.strikeline.visible = this.oldPriceTf.visible = this.actionPrice.visible = true;
                     this.priceIcon.visible = false;
                     this.oldPriceTf.text = App.utils.commons.formatNumberToStringWithSpaces(_loc1_.oldPrice);
                     this.actionPrice.setData(_loc1_);
                     this.bg.useMediumSize();
                  }
                  else
                  {
                     this.strikeline.visible = this.oldPriceTf.visible = this.actionPrice.visible = false;
                     this.priceIcon.visible = StringUtils.isNotEmpty(this._data.priceType);
                  }
                  this.currentPriceTf.textColor = getCurrentPriceTextColor(this._data.priceType);
                  this.currentPriceTf.text = App.utils.commons.formatNumberToStringWithSpaces(this._data.price);
                  this.actionButton.enabled = this._data.actionBtnEnabled;
                  this.actionButton.label = this._data.actionBtnLabel;
                  this.divider.visible = this.timeRemainingDescTf.visible = this.timeIcon.visible = this.timeRemainingTf.visible = _loc2_;
                  if(this.infoMsgTf.visible)
                  {
                     this.bg.useSmallLongSize();
                     if(_loc1_ || _loc2_)
                     {
                        this.timeRemainingTf.text = this._data.timeRemainingStr;
                        this.bg.useExtraLargeSize();
                     }
                  }
                  else if(_loc2_)
                  {
                     this.timeRemainingTf.text = this._data.timeRemainingStr;
                     this.bg.useMediumSize();
                     if(_loc1_)
                     {
                        this.bg.useLargeSize();
                     }
                  }
               }
            }
            if(this._isBuyingTimeStateChangedFlag && isInvalid(INVALIDATE_BUYING_TIME_ELAPSED))
            {
               this.infoMsgTf.text = VEHICLE_PREVIEW.SHOWCASESTYLEBUYING_OUTOFTIMEMSG;
               this.infoIcon.visible = this.infoMsgTf.visible = this._isBuyingTimeElapsed;
               this.actionButton.enabled = !this._isBuyingTimeElapsed;
               this.bg.useLargeSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(this._data.isBought)
               {
                  this.boughtMsgTf.x = this.bg.width - this.boughtMsgTf.textWidth + this.doubleCheck.width >> 1;
                  this.doubleCheck.x = this.boughtMsgTf.x - this.doubleCheck.width;
               }
               else
               {
                  this.infoMsgTf.x = this.bg.width - this.infoMsgTf.textWidth + this.infoIcon.width >> 1;
                  this.infoIcon.x = this.infoMsgTf.x - this.infoIcon.width;
                  _loc3_ = this.currentPriceTf.textWidth;
                  if(this._data.actionPrice)
                  {
                     _loc3_ += this.oldPriceTf.textWidth + CURRENT_PRICE_TF_PADDING_LEFT;
                     _loc3_ += ACTION_PRICE_PADDING_LEFT + this.actionPrice.width;
                  }
                  else
                  {
                     _loc3_ += PRICE_ICON_PADDING_LEFT + this.priceIcon.width;
                  }
                  _loc3_ += ACTION_BUTTON_PADDING_LEFT + this.actionButton.width;
                  if(StringUtils.isNotEmpty(this._data.timeRemainingStr))
                  {
                     _loc3_ += DIVIDER_PADDING_LEFT + this.divider.width;
                     _loc3_ += TIME_REMAINING_DESC_PADDING_LEFT + this.timeRemainingDescTf.width;
                     _loc3_ += TIME_ICON_PADDING_LEFT + this.timeIcon.width;
                     _loc3_ += TIME_REMAINING_PADDING_LEFT + this.timeRemainingTf.textWidth;
                  }
                  _loc4_ = this.bg.width - _loc3_ >> 1;
                  this.strikeline.x = _loc4_ + STRIKELINE_OFFSET_X;
                  this.oldPriceTf.x = _loc4_;
                  this.currentPriceTf.x = this.oldPriceTf.textWidth + CURRENT_PRICE_TF_PADDING_LEFT + _loc4_ | 0;
                  if(this._data.actionPrice)
                  {
                     this.actionPrice.x = this.currentPriceTf.x + this.currentPriceTf.textWidth + ACTION_PRICE_PADDING_LEFT | 0;
                     this.actionButton.x = this.actionPrice.x + this.actionPrice.width + ACTION_BUTTON_PADDING_LEFT | 0;
                  }
                  else
                  {
                     this.priceIcon.x = this.currentPriceTf.x + this.currentPriceTf.textWidth + PRICE_ICON_PADDING_LEFT | 0;
                     this.actionButton.x = this.currentPriceTf.x + this.currentPriceTf.width + ACTION_BUTTON_PADDING_LEFT;
                  }
                  this.divider.x = this.actionButton.x + this.actionButton.width + DIVIDER_PADDING_LEFT;
                  this.timeRemainingDescTf.x = this.divider.x + this.divider.width + TIME_REMAINING_DESC_PADDING_LEFT;
                  this.timeIcon.x = this.timeRemainingDescTf.x + this.timeRemainingDescTf.textWidth + TIME_ICON_PADDING_LEFT | 0;
                  this.timeRemainingTf.x = this.timeIcon.x + this.timeIcon.width + TIME_REMAINING_PADDING_LEFT;
                  this.strikeline.width = this.oldPriceTf.textWidth + STRIKELINE_OFFSET_X | 0;
               }
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.actionButton.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.infoIcon.dispose();
         this.infoIcon = null;
         this.infoMsgTf = null;
         this.strikeline = null;
         this.oldPriceTf = null;
         this.currentPriceTf = null;
         this.priceIcon = null;
         this.actionPrice.dispose();
         this.actionPrice = null;
         this.actionButton.dispose();
         this.actionButton = null;
         this.divider = null;
         this.timeRemainingDescTf = null;
         this.timeIcon = null;
         this.timeRemainingTf = null;
         this.doubleCheck = null;
         this.boughtMsgTf = null;
         this.bg = null;
         this._data = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function as_setBuyingTimeElapsed(param1:Boolean) : void
      {
         this._isBuyingTimeElapsed = param1;
         this._isBuyingTimeStateChangedFlag = true;
         this._data.timeRemainingStr = "";
         this.setData(this._data);
         invalidate(INVALIDATE_BUYING_TIME_ELAPSED);
      }
      
      public function as_updateTimeRemaining(param1:String) : void
      {
         this.timeRemainingTf.text = param1;
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.actionButton;
      }
      
      public function getOffsetY() : int
      {
         return OFFSET_Y;
      }
      
      public function getSmallScreenOffsetY() : int
      {
         return SMALL_SCREEN_OFFSET_Y;
      }
      
      public function getTotalHeight() : Number
      {
         return super.height;
      }
      
      override public function get width() : Number
      {
         return MAX_WIDTH;
      }
      
      override public function get height() : Number
      {
         return MAX_HEIGHT;
      }
      
      private function onActionButtonClickHandler(param1:ButtonEvent) : void
      {
         onBuyClickS();
      }
      
      private function onActionButtonRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data && StringUtils.isNotEmpty(this._data.actionBtnTooltip))
         {
            this._tooltipMgr.show(this._data.actionBtnTooltip);
         }
      }
      
      private function onActionButtonRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
