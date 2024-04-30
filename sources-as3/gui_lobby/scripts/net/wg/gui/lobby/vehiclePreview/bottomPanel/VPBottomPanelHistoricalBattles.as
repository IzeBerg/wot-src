package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.components.controls.price.Discount;
   import net.wg.gui.components.controls.price.Price;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.vehiclePreview.data.VPHBBuyingPanelVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewHBPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewHBPanelMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class VPBottomPanelHistoricalBattles extends VehiclePreviewHBPanelMeta implements IVehiclePreviewHBPanelMeta, IVPBottomPanel, IStageSizeDependComponent
   {
      
      private static const BTN_GAP:int = 28;
      
      private static const MIN_BTNS_WIDTH:int = 160;
      
      private static const TITLE_SMALL_WIDTH:int = 490;
      
      private static const TITLE_MEDIUM_WIDTH:int = 550;
      
      private static const TITLE_BIG_WIDTH:int = 650;
      
      private static const FULL_DISCOUNT:int = 100;
      
      private static const ACTIONCMP_MARGIN_X:int = 15;
      
      private static const DISCOUNT_OVERLAY_BUY:String = "buy";
      
      private static const TITLE_SMALL_SIZE:int = 15;
      
      private static const TITLE_MEDIUM_SIZE:int = 18;
      
      private static const TITLE_BIG_SIZE:int = 24;
      
      private static const TITLE_SMALL_OFFSET:int = 60;
      
      private static const TITLE_BIG_OFFSET:int = 73;
      
      private static const BG_BIG_OFFSET:int = 60;
      
      private static const BG_SMALL_OFFSET:int = 42;
       
      
      public var titleLabel:TextField = null;
      
      public var separatorLabel:TextField = null;
      
      public var buyBtn:UniversalBtn = null;
      
      public var secondaryBtn:UniversalBtn = null;
      
      public var price:CompoundPrice = null;
      
      public var arrowIcon:Sprite = null;
      
      public var actionCmp:Discount = null;
      
      public var discountOverlay:MovieClip = null;
      
      public var background:Sprite = null;
      
      private var _data:VPHBBuyingPanelVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _titleSize:int;
      
      private var _titleOffset:int;
      
      private var _titleWidth:int;
      
      private var _bgOffset:int;
      
      public function VPBottomPanelHistoricalBattles()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleLabel.autoSize = TextFieldAutoSize.CENTER;
         this.titleLabel.multiline = true;
         this.titleLabel.wordWrap = true;
         TextFieldEx.setVerticalAlign(this.titleLabel,TextFieldEx.VALIGN_BOTTOM);
         this.separatorLabel.autoSize = TextFieldAutoSize.LEFT;
         this.separatorLabel.text = TOOLTIPS.VEHICLE_TEXTDELIMITER_OR;
         this.price.bigFonts = true;
         this.price.actionState = CompoundPrice.ACTION_STATE_SHOW_VALUE;
         this.price.actionMode = Price.ACTION_MODE_ALWAYS_SHOW;
         this.price.itemsDirection = CompoundPrice.DIRECTION_RIGHT;
         this.price.oldPriceAlign = CompoundPrice.OLD_PRICE_ALIGN_LEFT;
         this.price.oldPriceVisible = true;
         this.price.actionTooltip = true;
         this.actionCmp.visible = false;
         this.discountOverlay.mouseEnabled = this.discountOverlay.mouseChildren = false;
         this.discountOverlay.gotoAndStop(DISCOUNT_OVERLAY_BUY);
         this.background.mouseChildren = this.background.mouseEnabled = false;
         this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.secondaryBtn.addEventListener(ButtonEvent.CLICK,this.onSecondaryButtonClickHandler);
         this.buyBtn.addEventListener(MouseEvent.ROLL_OVER,this.onBuyBtnRollOverHandler);
         this.buyBtn.addEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
         App.utils.universalBtnStyles.setStyle(this.buyBtn,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
         App.utils.universalBtnStyles.setStyle(this.secondaryBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:TextFormat = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleLabel.htmlText = this._data.title;
            _loc2_ = Boolean(this._data.price) ? this._data.price.price.getPriceVO().name : null;
            if(!this._data.isFree)
            {
               this.actionCmp.visible = false;
               this.price.visible = true;
               this.price.setData(this._data.price);
               this.price.updateEnoughStatuses(new <PriceVO>[new PriceVO([_loc2_,int(this._data.shortage <= 0)])]);
               this.price.validateNow();
            }
            else
            {
               this.price.visible = false;
               this.actionCmp.visible = true;
               this.actionCmp.state = Discount.WITH_VALUE_STATE;
               this.actionCmp.data = new PriceVO([_loc2_,FULL_DISCOUNT]);
            }
            this.buyBtn.visible = Boolean(this._data.acceptBtnLabel);
            this.buyBtn.enabled = true;
            this.buyBtn.minWidth = MIN_BTNS_WIDTH;
            this.buyBtn.autoSize = TextFieldAutoSize.CENTER;
            this.buyBtn.label = this._data.acceptBtnLabel;
            this.buyBtn.validateNow();
            this.secondaryBtn.visible = !this._data.isFree;
            this.secondaryBtn.enabled = true;
            this.secondaryBtn.minWidth = MIN_BTNS_WIDTH;
            this.secondaryBtn.autoSize = TextFieldAutoSize.CENTER;
            this.secondaryBtn.label = this._data.secondaryBtnLabel;
            this.secondaryBtn.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc3_ = this.titleLabel.getTextFormat();
            _loc3_.size = this._titleSize;
            this.titleLabel.setTextFormat(_loc3_);
            this.titleLabel.x = this.width - this.titleLabel.width >> 1;
            this.titleLabel.y = this.buyBtn.y - this.titleLabel.height - this._titleOffset | 0;
            this.titleLabel.width = this._titleWidth;
            this.price.x = this.width - this.price.actualWidth >> 1;
            this.actionCmp.x = (this.width - this.actionCmp.contentWidth >> 1) - ACTIONCMP_MARGIN_X;
            if(this.price.visible)
            {
               this.discountOverlay.x = this.price.x + (this.price.contentWidth - this.discountOverlay.width >> 1);
               this.discountOverlay.y = this.price.y + (this.price.contentHeight - this.discountOverlay.height >> 1);
            }
            else
            {
               this.discountOverlay.x = this.actionCmp.x + (this.actionCmp.width - this.discountOverlay.width >> 1);
               this.discountOverlay.y = this.actionCmp.y + (this.actionCmp.height - this.discountOverlay.height >> 1);
            }
            this.arrowIcon.visible = this.separatorLabel.visible = this.secondaryBtn.visible && this.buyBtn.visible;
            if(!this.secondaryBtn.visible)
            {
               this.buyBtn.x = this.width - this.buyBtn.width >> 1;
            }
            else if(!this.buyBtn.visible)
            {
               this.secondaryBtn.x = this.width - this.secondaryBtn.width >> 1;
            }
            else
            {
               _loc1_ = this.secondaryBtn.width + this.separatorLabel.width + this.buyBtn.width + BTN_GAP * 2 | 0;
               this.secondaryBtn.x = this.width - _loc1_ >> 1;
               this.separatorLabel.x = this.secondaryBtn.x + this.secondaryBtn.width + BTN_GAP | 0;
               this.arrowIcon.x = this.separatorLabel.x + (this.separatorLabel.width >> 1) - (this.arrowIcon.width >> 1);
               this.buyBtn.x = this.separatorLabel.x + this.separatorLabel.width + BTN_GAP | 0;
            }
            this.background.x = this.width - this.background.width >> 1;
            this.background.y = this.buyBtn.y + this.buyBtn.height - this.background.height + this._bgOffset | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.secondaryBtn.removeEventListener(ButtonEvent.CLICK,this.onSecondaryButtonClickHandler);
         this.buyBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onBuyBtnRollOverHandler);
         this.buyBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onBuyBtnRollOutHandler);
         this.buyBtn.dispose();
         this.buyBtn = null;
         this.secondaryBtn.dispose();
         this.secondaryBtn = null;
         this.price.dispose();
         this.price = null;
         this.actionCmp.dispose();
         this.actionCmp = null;
         this.discountOverlay = null;
         this.background = null;
         this.titleLabel = null;
         this.separatorLabel = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VPHBBuyingPanelVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return !!this.buyBtn.visible ? this.buyBtn : this.secondaryBtn;
      }
      
      public function getOffsetY() : int
      {
         return 0;
      }
      
      public function getSmallScreenOffsetY() : int
      {
         return 0;
      }
      
      public function getTotalHeight() : Number
      {
         return this.height;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(isDAAPIInited)
         {
            this._titleOffset = param2 >= StageSizeBoundaries.HEIGHT_900 ? int(TITLE_BIG_OFFSET) : int(TITLE_SMALL_OFFSET);
            if(param1 < StageSizeBoundaries.WIDTH_1366)
            {
               this._titleSize = TITLE_SMALL_SIZE;
               this._titleWidth = TITLE_SMALL_WIDTH;
            }
            else if(param1 == StageSizeBoundaries.WIDTH_1366)
            {
               this._titleSize = TITLE_MEDIUM_SIZE;
               this._titleWidth = TITLE_MEDIUM_WIDTH;
            }
            else
            {
               this._titleSize = TITLE_BIG_SIZE;
               this._titleWidth = TITLE_BIG_WIDTH;
            }
            if(param2 <= StageSizeBoundaries.HEIGHT_900)
            {
               this._bgOffset = BG_SMALL_OFFSET;
            }
            else
            {
               this._bgOffset = BG_BIG_OFFSET;
            }
            invalidateSize();
         }
      }
      
      override public function get width() : Number
      {
         return this.titleLabel.width;
      }
      
      override public function get height() : Number
      {
         return this.buyBtn.y + this.buyBtn.height | 0;
      }
      
      private function onBuyButtonClickHandler(param1:ButtonEvent) : void
      {
         onAcceptClickedS();
      }
      
      private function onSecondaryButtonClickHandler(param1:ButtonEvent) : void
      {
         onSecondaryClickedS();
      }
      
      private function onBuyBtnRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data || this._data.shortage <= 0)
         {
            return;
         }
         var _loc2_:String = Boolean(this._data.price) ? this._data.price.price.getPriceVO().name : null;
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.NOT_ENOUGH_MONEY,null,this._data.shortage,_loc2_);
      }
      
      private function onBuyBtnRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
