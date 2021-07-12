package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPBuyingPanelVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPCouponVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPOfferVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemsVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetVehiclesVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPVehicleCarouselVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBuyingPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBuyingPanelMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPBuyingPanel extends VehiclePreviewBuyingPanelMeta implements IVehiclePreviewBuyingPanelMeta, IStageSizeDependComponent, IVPBottomPanel
   {
      
      private static const CUSTOM_OFFER_OFFSET_X:int = 20;
      
      private static const CUSTOM_OFFER_OFFSET_Y:int = 4;
      
      private static const ACTION_BUTTON_DISCOUNT_OFFSET:int = 10;
      
      private static const DISCOUNT_OVERLAY_OFFSET:int = 30;
      
      private static const BUY_BUTTON_DEFAULT_OFFSET:int = 32;
      
      private static const ACTION_BUTTON_PADDING:int = 20;
      
      private static const ACTION_BUTTON_OFFSET:int = 16;
      
      private static const NOT_RESEARCHED_ALERT_ICON_OFFSET:int = 10;
      
      private static const NOT_RESEARCHED_LABEL_OFFSET:int = 2;
      
      private static const HALF_BUY_BUTTON_DEFAULT_OFFSET:int = BUY_BUTTON_DEFAULT_OFFSET >> 1;
      
      private static const COMPENSATION_Y_OFFSET:int = 7;
      
      private static const LEFT_TIME_INV:String = "leftTimeInv";
      
      private static const TITLE_TOOLTIP_INV:String = "titleTooltipInv";
      
      private static const COUPON_VIEW_OFFSET_X:int = -28;
      
      private static const TIME_LEFT_OFFSET_X:int = 10;
      
      private static const INFO_ICON_OFFSET:int = 30;
      
      private static const TIME_LEFT_OFFSET_Y:int = 3;
      
      private static const TOTAL_H:int = 90;
      
      private static const PRICE_WITHOUT_COMP_POSITION_Y:int = 4;
      
      private static const PRICE_WITH_COMP_POSITION_Y:int = -8;
      
      private static const END_TIME_FILTER:Array = [new DropShadowFilter(0,0,16711680,1,16,16,2,BitmapFilterQuality.HIGH)];
      
      private static const PLUS_V_OFFSET:int = 2;
      
      private static const TF_V_OFFSET:int = 2;
      
      private static const PLUS_ICON_NAME:String = "plusIcon";
      
      private static const DISCOUNT_OVERLAY_BUY:String = "buy";
      
      private static const DISCOUNT_OVERLAY_RESEARCH:String = "research";
      
      private static const ACTION_BUTTON_DISABLED_ICON_ALPHA:Number = 0.5;
       
      
      public var notResearchedLabelTf:TextField;
      
      public var uniqueLabelTf:TextField;
      
      public var setTitleTF:TextField = null;
      
      public var actionButton:UniversalBtn = null;
      
      public var compoundPrice:CompoundPrice = null;
      
      public var compensation:CompensationPanel = null;
      
      public var setItemsView:SetItemsView = null;
      
      public var setVehiclesView:SetVehiclesView;
      
      public var offersView:OffersView;
      
      public var setTimeLeftTF:TextField = null;
      
      public var timeLeftInfoIcon:Image = null;
      
      public var notResearchedAlertIcon:Image = null;
      
      public var discountOverlay:MovieClip = null;
      
      public var customOfferLabelTF:TextField = null;
      
      public var couponView:CouponView = null;
      
      private var _data:VPBuyingPanelVO;
      
      private var _plus:Bitmap;
      
      private var _formattedLeftTime:String = null;
      
      private var _firstRearrange:Boolean = false;
      
      private var _titleTooltip:String = "";
      
      private var _useCompactData:Boolean;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function VPBuyingPanel()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         removeChild(this.setVehiclesView);
         removeChild(this.offersView);
         removeChild(this.couponView);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         updateDataS(this._useCompactData);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.compoundPrice.bigFonts = true;
         this.compoundPrice.actionState = CompoundPrice.ACTION_STATE_SHOW_VALUE;
         this.compoundPrice.itemsDirection = CompoundPrice.DIRECTION_RIGHT;
         this.compoundPrice.oldPriceVisible = false;
         this.compoundPrice.oldPriceAlign = CompoundPrice.OLD_PRICE_ALIGN_LEFT;
         this.compoundPrice.priceActionOffset = new Point(0,3);
         this.compensation.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.actionButton.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.addEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.actionButton.addEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         this.actionButton.mouseEnabledOnDisabled = true;
         this.actionButton.disabledImageAlpha = ACTION_BUTTON_DISABLED_ICON_ALPHA;
         this.notResearchedLabelTf.mouseWheelEnabled = this.notResearchedLabelTf.mouseEnabled = false;
         this.notResearchedLabelTf.autoSize = TextFieldAutoSize.LEFT;
         this.notResearchedLabelTf.wordWrap = true;
         this.notResearchedLabelTf.multiline = true;
         this.uniqueLabelTf.mouseWheelEnabled = this.uniqueLabelTf.mouseEnabled = false;
         this.uniqueLabelTf.autoSize = TextFieldAutoSize.LEFT;
         this.setTitleTF.mouseWheelEnabled = this.setTitleTF.mouseEnabled = false;
         this.setTitleTF.autoSize = TextFieldAutoSize.LEFT;
         this.offersView.addEventListener(VehiclePreviewEvent.SELECT,this.onOffersViewSelectHandler);
         this.couponView.addEventListener(Event.SELECT,this.onCouponViewSelectHandler);
         this.setVehiclesView.addEventListener(VehiclePreviewEvent.SHOW,this.onSetVehiclesViewShowHandler);
         this.setVehiclesView.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.setItemsView.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.setItemsView.addEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
         this.setTimeLeftTF.autoSize = TextFieldAutoSize.LEFT;
         this.setTimeLeftTF.visible = false;
         this.setTimeLeftTF.filters = END_TIME_FILTER;
         this.notResearchedAlertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTBIGICON;
         this.notResearchedAlertIcon.mouseEnabled = this.notResearchedAlertIcon.mouseChildren = false;
         this.timeLeftInfoIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_INFO;
         this.timeLeftInfoIcon.visible = false;
         this.timeLeftInfoIcon.addEventListener(MouseEvent.ROLL_OVER,this.onTimeLeftInfoIconRollOverHandler);
         this.timeLeftInfoIcon.addEventListener(MouseEvent.ROLL_OUT,this.onTimeLeftInfoIconRollOutHandler);
         this.customOfferLabelTF.autoSize = TextFieldAutoSize.LEFT;
         this.customOfferLabelTF.visible = false;
         this.discountOverlay.mouseEnabled = this.discountOverlay.mouseChildren = false;
         this.discountOverlay.visible = false;
         this.compensation.visible = false;
         mouseEnabled = false;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.actionButton.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         this.offersView.removeEventListener(VehiclePreviewEvent.SELECT,this.onOffersViewSelectHandler);
         this.couponView.removeEventListener(Event.SELECT,this.onCouponViewSelectHandler);
         this.timeLeftInfoIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onTimeLeftInfoIconRollOverHandler);
         this.timeLeftInfoIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onTimeLeftInfoIconRollOutHandler);
         this.setVehiclesView.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.setVehiclesView.removeEventListener(VehiclePreviewEvent.SHOW,this.onSetVehiclesViewShowHandler);
         this.setItemsView.removeEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
         this.setItemsView.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.compensation.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(this._plus)
         {
            this._plus.bitmapData.dispose();
            this._plus.bitmapData = null;
            this._plus = null;
         }
         this.setVehiclesView.dispose();
         this.setVehiclesView = null;
         this.offersView.dispose();
         this.offersView = null;
         this.couponView.dispose();
         this.couponView = null;
         this.setItemsView.dispose();
         this.setItemsView = null;
         this.actionButton.dispose();
         this.actionButton = null;
         this.compoundPrice.dispose();
         this.compoundPrice = null;
         this.compensation.dispose();
         this.compensation = null;
         this.notResearchedAlertIcon.dispose();
         this.notResearchedAlertIcon = null;
         this.timeLeftInfoIcon.dispose();
         this.timeLeftInfoIcon = null;
         this.setTimeLeftTF = null;
         this.notResearchedLabelTf = null;
         this.uniqueLabelTf = null;
         this.setTitleTF = null;
         this.discountOverlay = null;
         this.customOfferLabelTF = null;
         this._data = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updatePanelData();
         }
         if(isInvalid(TITLE_TOOLTIP_INV))
         {
            this.timeLeftInfoIcon.visible = StringUtils.isNotEmpty(this._titleTooltip);
         }
         if(isInvalid(LEFT_TIME_INV))
         {
            if(this._formattedLeftTime)
            {
               this.setTimeLeftTF.htmlText = this._formattedLeftTime;
               this.setTimeLeftTF.visible = true;
               this.setTimeLeftTF.mouseEnabled = StringUtils.isNotEmpty(this._titleTooltip);
               this.setTimeLeftTF.y = this.setTitleTF.y + (this.setTitleTF.textHeight - this.setTimeLeftTF.textHeight >> 1) + TIME_LEFT_OFFSET_Y;
            }
            else
            {
               this.setTimeLeftTF.visible = false;
            }
         }
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            this.updatePanelSize();
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function setBuyData(param1:VPBuyingPanelVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setSetItemsData(param1:VPSetItemsVO) : void
      {
         this.setItemsView.setData(param1.blocks);
         invalidateSize();
      }
      
      override protected function setSetVehiclesData(param1:VPSetVehiclesVO) : void
      {
         this.setVehiclesView.setData(param1.vehicles);
         addChild(this.setVehiclesView);
         invalidateSize();
      }
      
      override protected function setOffersData(param1:DataProvider) : void
      {
         this.offersView.setData(param1);
         addChild(this.offersView);
         invalidateSize();
      }
      
      override protected function setCoupon(param1:VPCouponVO) : void
      {
         this.couponView.setData(param1);
         addChild(this.couponView);
         invalidateSize();
      }
      
      public function as_setSetTitleTooltip(param1:String) : void
      {
         this._titleTooltip = param1;
         invalidate(TITLE_TOOLTIP_INV);
      }
      
      public function as_updateLeftTime(param1:String, param2:Boolean) : void
      {
         this._formattedLeftTime = param1;
         invalidate(LEFT_TIME_INV);
         if(!this._firstRearrange)
         {
            invalidateSize();
            this._firstRearrange = true;
         }
         if(!param2 && this.setTimeLeftTF.filters.length != 0)
         {
            this.setTimeLeftTF.filters = [];
         }
         else if(param2 && this.setTimeLeftTF.filters.length == 0)
         {
            this.setTimeLeftTF.filters = END_TIME_FILTER;
         }
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.actionButton;
      }
      
      public function getTotalHeight() : Number
      {
         return TOTAL_H;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = param2 == StageSizeBoundaries.HEIGHT_768;
         if(isDAAPIInited && this._useCompactData != _loc3_)
         {
            this._useCompactData = _loc3_;
            updateDataS(this._useCompactData);
         }
      }
      
      private function updatePanelData() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         if(this._data)
         {
            this.customOfferLabelTF.visible = false;
            this.discountOverlay.visible = false;
            if(this._data.uniqueVehicleTitle)
            {
               this.uniqueLabelTf.visible = true;
               this.uniqueLabelTf.htmlText = this._data.uniqueVehicleTitle;
            }
            else
            {
               this.uniqueLabelTf.visible = false;
            }
            this.notResearchedAlertIcon.visible = this.notResearchedLabelTf.visible = StringUtils.isNotEmpty(this._data.warning);
            if(this._data.setTitle)
            {
               this.setTitleTF.htmlText = this._data.setTitle;
               this.setTitleTF.visible = true;
            }
            else
            {
               this.setTitleTF.visible = false;
            }
            if(StringUtils.isNotEmpty(this._data.customOffer))
            {
               this.compoundPrice.visible = false;
               this.customOfferLabelTF.visible = true;
               this.customOfferLabelTF.htmlText = this._data.customOffer;
               this.discountOverlay.visible = true;
               this.discountOverlay.gotoAndStop(!!this._data.isUnlock ? DISCOUNT_OVERLAY_RESEARCH : DISCOUNT_OVERLAY_BUY);
               this.actionButton.changeSizeOnlyUpwards = true;
               this.actionButton.dynamicSizeByText = true;
               this.actionButton.paddingHorizontal = ACTION_BUTTON_PADDING;
               this.actionButton.visible = true;
            }
            else if(this._data.isBuyingAvailable)
            {
               this.discountOverlay.visible = this._data.showAction;
               this.discountOverlay.gotoAndStop(!!this._data.isUnlock ? DISCOUNT_OVERLAY_RESEARCH : DISCOUNT_OVERLAY_BUY);
               if(_baseDisposed)
               {
                  return;
               }
               this.compensation.visible = this._data.hasCompensation;
               if(this._data.hasCompensation)
               {
                  this.compensation.setData(this._data.compensation);
                  this.compensation.validateNow();
               }
               this.compoundPrice.setData(this._data.itemPrice);
               this.compoundPrice.setCouponDiscount(this._data.couponDiscount);
               _loc2_ = Boolean(this._data.itemPrice) ? this._data.itemPrice.price.getPriceVO().name : null;
               this.compoundPrice.updateEnoughStatuses(new <PriceVO>[new PriceVO([_loc2_,int(this._data.isMoneyEnough)])]);
               this.compoundPrice.visible = true;
               this.compoundPrice.actionTooltip = this.compoundPrice.mouseEnabled = this.compoundPrice.mouseChildren = this._data.showAction;
               if(StringUtils.isNotEmpty(this._data.actionTooltip))
               {
                  this.compoundPrice.customActionTooltip = this._data.actionTooltip;
               }
               this.compoundPrice.validateNow();
            }
            else
            {
               this.compoundPrice.visible = false;
               this.discountOverlay.visible = false;
            }
            this.actionButton.label = this._data.buyButtonLabel;
            this.actionButton.iconSource = this._data.buyButtonIcon;
            this.actionButton.iconAlign = this._data.buyButtonIconAlign;
            this.actionButton.enabled = this._data.buyButtonEnabled;
            _loc1_ = !!this._data.isUnlock ? UniversalBtnStylesConst.STYLE_HEAVY_LIME : UniversalBtnStylesConst.STYLE_HEAVY_ORANGE;
            App.utils.universalBtnStyles.setStyle(this.actionButton,_loc1_);
            if(this._data.isReferralEnabled)
            {
               this.compoundPrice.visible = false;
               this.discountOverlay.visible = false;
               this.actionButton.visible = true;
               this.actionButton.enabled = this._data.buyButtonEnabled;
               this.actionButton.label = this._data.buyButtonLabel;
            }
            this.couponView.setCouponDiscount(this._data.couponDiscount);
            visible = true;
            invalidateSize();
         }
         else
         {
            visible = false;
         }
      }
      
      private function updatePanelSize() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Point = null;
         var _loc5_:Number = NaN;
         var _loc1_:int = 0;
         if(this._data.isBuyingAvailable)
         {
            if(contains(this.setVehiclesView))
            {
               _loc1_ += this.setVehiclesView.x + this.setVehiclesView.width;
               if(this.setItemsView.visible)
               {
                  this._plus = this._plus || this.getNewPlusSign();
                  this._plus.x = _loc1_ + (SetItemsView.BLOCKS_OFFSET - this._plus.width >> 1) >> 0;
                  this._plus.y = this.actionButton.y + (this.actionButton.height - this._plus.height >> 1) - PLUS_V_OFFSET >> 0;
               }
            }
            if(contains(this.offersView))
            {
               _loc1_ += this.offersView.x + this.offersView.width;
            }
            if(contains(this.couponView))
            {
               _loc1_ += this.couponView.x + this.couponView.actualWidth + COUPON_VIEW_OFFSET_X;
            }
            if(this.setItemsView.visible)
            {
               _loc1_ += this.setItemsView.actualWidth;
               _loc1_ += !!contains(this.setVehiclesView) ? SetItemsView.BLOCKS_OFFSET : 0;
               _loc1_ -= this.setItemsView.actualOffset << (!!contains(this.setVehiclesView) ? 1 : 0);
               this.setItemsView.x = _loc1_;
               _loc1_ += this.setItemsView.actualOffset << 1;
            }
            if(this.compensation.visible)
            {
               this.compensation.y = this.compoundPrice.y + this.compoundPrice.contentHeight - COMPENSATION_Y_OFFSET >> 0;
               this.compensation.x = _loc1_;
               _loc1_ += BUY_BUTTON_DEFAULT_OFFSET + this.compensation.actualWidth;
               this.compoundPrice.y = PRICE_WITH_COMP_POSITION_Y;
            }
            else
            {
               this.compoundPrice.y = PRICE_WITHOUT_COMP_POSITION_Y;
            }
            if(this.compoundPrice.visible)
            {
               _loc1_ += !!contains(this.offersView) ? this.compoundPrice.width : 0;
               if(this.compensation.visible)
               {
                  this.compoundPrice.x = _loc1_ - BUY_BUTTON_DEFAULT_OFFSET - this.compoundPrice.actualWidth >> 0;
                  this.actionButton.x = _loc1_;
                  _loc1_ = this.compoundPrice.x;
               }
               else
               {
                  _loc3_ = this.compoundPrice.contentWidth + HALF_BUY_BUTTON_DEFAULT_OFFSET >> 0;
                  this.compoundPrice.x = Number(_loc1_) || Number(-_loc3_);
                  this.actionButton.x = this.compoundPrice.x + _loc3_;
               }
               if(this.discountOverlay.visible)
               {
                  this.discountOverlay.x = this.compoundPrice.x + (this.compoundPrice.contentWidth - this.discountOverlay.width >> 1);
                  this.discountOverlay.y = this.compoundPrice.y + (this.compoundPrice.contentHeight - this.discountOverlay.height >> 1);
               }
            }
            else if(this.customOfferLabelTF.visible)
            {
               if(this.setItemsView.visible)
               {
                  this.customOfferLabelTF.x = _loc1_ + CUSTOM_OFFER_OFFSET_X;
                  this.customOfferLabelTF.y = CUSTOM_OFFER_OFFSET_Y;
               }
               else
               {
                  this.customOfferLabelTF.x = !!this.notResearchedAlertIcon.visible ? Number(-this.customOfferLabelTF.width - ACTION_BUTTON_DISCOUNT_OFFSET) : Number(0);
               }
               if(this.discountOverlay.visible)
               {
                  this.discountOverlay.x = this.customOfferLabelTF.x + this.customOfferLabelTF.width - (this.discountOverlay.width >> 1) - DISCOUNT_OVERLAY_OFFSET | 0;
                  this.discountOverlay.y = this.customOfferLabelTF.y - (this.discountOverlay.height - this.customOfferLabelTF.height >> 1);
               }
               this.actionButton.x = this.customOfferLabelTF.x + (this.customOfferLabelTF.width + ACTION_BUTTON_DISCOUNT_OFFSET) | 0;
               this.actionButton.y = this.customOfferLabelTF.y - (this.actionButton.height - this.customOfferLabelTF.height >> 1);
            }
         }
         else
         {
            this.actionButton.x = 0;
         }
         if(this.notResearchedAlertIcon.visible)
         {
            this.notResearchedLabelTf.text = this._data.warning;
            this.notResearchedAlertIcon.x = this.actionButton.x + this.actionButton.width + NOT_RESEARCHED_ALERT_ICON_OFFSET >> 0;
            this.notResearchedAlertIcon.y = this.actionButton.y + (this.actionButton.height - this.notResearchedAlertIcon.height >> 1) | 0;
            this.notResearchedLabelTf.x = this.notResearchedAlertIcon.x + this.notResearchedAlertIcon.width + NOT_RESEARCHED_LABEL_OFFSET >> 0;
            _loc4_ = localToGlobal(new Point(this.notResearchedLabelTf.x,0));
            this.notResearchedLabelTf.width = App.appWidth - _loc4_.x;
            this.notResearchedLabelTf.y = this.notResearchedAlertIcon.y + (this.notResearchedAlertIcon.height - this.notResearchedLabelTf.textHeight >> 1) - TF_V_OFFSET;
         }
         if(this.uniqueLabelTf.visible)
         {
            this.uniqueLabelTf.x = this.width - this.uniqueLabelTf.width >> 1;
         }
         var _loc2_:int = this.setTitleTF.width;
         _loc2_ += !!this.setTimeLeftTF.visible ? this.setTimeLeftTF.width + TIME_LEFT_OFFSET_X : 0;
         _loc2_ += !!this.timeLeftInfoIcon.visible ? INFO_ICON_OFFSET : 0;
         if(this.setTitleTF.visible)
         {
            this.setTitleTF.x = this.width - _loc2_ >> 1;
         }
         if(this.setTimeLeftTF.visible)
         {
            this.setTimeLeftTF.x = this.setTitleTF.x + this.setTitleTF.width + TIME_LEFT_OFFSET_X ^ 0;
         }
         if(this.timeLeftInfoIcon.visible)
         {
            this.timeLeftInfoIcon.x = this.setTitleTF.x + this.setTitleTF.width ^ 0;
         }
         if(this._data.isReferralEnabled)
         {
            this.actionButton.x = Number(_loc1_) || Number(-this.actionButton.width >> 0);
            if(this.setTitleTF.visible)
            {
               _loc5_ = this.setItemsView.x + this.actionButton.x + this.actionButton.width;
               this.setTitleTF.x = (_loc5_ >> 1) - (this.setTitleTF.textWidth >> 1);
            }
         }
      }
      
      private function getNewPlusSign() : Bitmap
      {
         var _loc1_:Bitmap = new Bitmap(BitmapData(App.utils.classFactory.getObject(Linkages.GREEN_PLUS_ICON)));
         _loc1_.name = PLUS_ICON_NAME;
         addChild(_loc1_);
         return _loc1_;
      }
      
      override public function get width() : Number
      {
         return this.actionButton.x + this.actionButton.width + ACTION_BUTTON_OFFSET + (!!contains(this.setItemsView) ? this.setItemsView.actualOffset : 0);
      }
      
      override public function get height() : Number
      {
         return this.actionButton.height;
      }
      
      private function onCouponViewSelectHandler(param1:Event) : void
      {
         onCouponSelectedS(this.couponView.getSelect());
      }
      
      private function onTimeLeftInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._titleTooltip);
      }
      
      private function onTimeLeftInfoIconRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onSetItemsViewShowTooltipHandler(param1:VehiclePreviewEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:VPSetItemVO = VPSetItemVO(param1.data);
         showTooltipS(_loc2_.id,_loc2_.type);
      }
      
      private function onActionButtonClickHandler(param1:ButtonEvent) : void
      {
         onBuyOrResearchClickS();
      }
      
      private function onSetVehiclesViewShowHandler(param1:VehiclePreviewEvent) : void
      {
         onCarouselVehicleSelectedS(VPVehicleCarouselVO(param1.data).intCD);
      }
      
      private function onOffersViewSelectHandler(param1:VehiclePreviewEvent) : void
      {
         onOfferSelectedS(VPOfferVO(param1.data).id);
      }
      
      private function onActionButtonRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data == null || StringUtils.isEmpty(this._data.buyButtonTooltip))
         {
            return;
         }
         if(this._data.isShowSpecialTooltip)
         {
            this._toolTipMgr.showSpecial(this._data.buyButtonTooltip,null);
         }
         else
         {
            this._toolTipMgr.showComplex(this._data.buyButtonTooltip);
         }
      }
      
      private function onActionButtonRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
