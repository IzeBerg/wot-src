package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TradeIco;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.components.controls.price.Price;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.tradeIn.TradeOffWidget;
   import net.wg.gui.lobby.vehiclePreview.data.VPTradeInBuyingPanelVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewTradeInBuyingPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewPersonalTradeInBuyingPanelMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPPersonalTradeInBuyingPanel extends VehiclePreviewPersonalTradeInBuyingPanelMeta implements IVehiclePreviewTradeInBuyingPanelMeta, IVPBottomPanel, IStageSizeDependComponent
   {
      
      private static const BIG_Y_OFFSET:int = 98;
      
      private static const SMALL_Y_OFFSET:int = 74;
      
      private static const ICONS_INDENT:int = 2;
      
      private static const STATUS_OFFSET:int = 14;
      
      private static const CONTROLS_INDENT:int = 10;
      
      private static const GAP:int = 48;
       
      
      public var currentPrice:CompoundPrice;
      
      public var actionButton:UniversalBtn;
      
      public var tradeOffWidget:TradeOffWidget;
      
      public var alertIcon:Image;
      
      public var tradeIcon:TradeIco;
      
      public var alertLabelTf:TextField = null;
      
      public var tradeLabelTf:TextField = null;
      
      public var title:TextField = null;
      
      public var titleSmall:TextField = null;
      
      public var selectedPrice:IconText;
      
      public var tradeInfoBg:Sprite;
      
      private var _offsetY:int = 0;
      
      private var _data:VPTradeInBuyingPanelVO = null;
      
      private var _isSmall:Boolean = false;
      
      public function VPPersonalTradeInBuyingPanel()
      {
         super();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.tradeOffWidget,VEHPREVIEW_CONSTANTS.TRADE_OFF_WIDGET_ALIAS);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.currentPrice.bigFonts = true;
         this.currentPrice.actionState = CompoundPrice.ACTION_STATE_SHOW_VALUE;
         this.currentPrice.itemsDirection = CompoundPrice.DIRECTION_LEFT;
         this.currentPrice.oldPriceAlign = CompoundPrice.OLD_PRICE_ALIGN_LEFT;
         this.currentPrice.oldPriceVisible = true;
         this.actionButton.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.mouseEnabledOnDisabled = true;
         this.tradeLabelTf.mouseWheelEnabled = this.tradeLabelTf.mouseEnabled = false;
         this.tradeLabelTf.wordWrap = this.tradeLabelTf.multiline = false;
         this.tradeLabelTf.autoSize = TextFieldAutoSize.CENTER;
         this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
         this.title.wordWrap = this.title.multiline = false;
         this.title.autoSize = TextFieldAutoSize.CENTER;
         this.titleSmall.mouseWheelEnabled = this.titleSmall.mouseEnabled = false;
         this.titleSmall.wordWrap = this.titleSmall.multiline = false;
         this.titleSmall.autoSize = TextFieldAutoSize.CENTER;
         this.titleSmall.visible = false;
         this.alertLabelTf.mouseWheelEnabled = this.alertLabelTf.mouseEnabled = false;
         this.alertLabelTf.wordWrap = this.alertLabelTf.multiline = false;
         this.alertLabelTf.autoSize = TextFieldAutoSize.CENTER;
         this.alertIcon.addEventListener(Event.CHANGE,this.onImgDataCompleteHandler);
         this.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ALERTBIGICON;
         this.alertIcon.mouseEnabled = this.alertIcon.mouseChildren = false;
         this.alertIcon.visible = false;
         this.selectedPrice.visible = false;
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:PriceVO = null;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._data.selectedPrice != null;
            _loc2_ = _loc1_ && this._data.tradeOffAvailable;
            _loc3_ = !this._data.isFreeExchange;
            _loc4_ = _loc2_ && _loc3_;
            this.currentPrice.setData(this._data.currentPrice);
            this.currentPrice.validateNow();
            this.actionButton.enabled = this._data.tradeOffAvailable;
            this.actionButton.label = !!_loc1_ ? VEHICLE_PREVIEW.BUYINGPANEL_BUYBTN_LABEL_EXCHANGE : VEHICLE_PREVIEW.BUYINGPANEL_BUYBTN_LABEL_BUY;
            App.utils.universalBtnStyles.setStyle(this.actionButton,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
            this.tradeIcon.visible = _loc4_;
            this.title.text = this._data.title;
            this.titleSmall.text = this._data.title;
            this.tradeLabelTf.htmlText = this.alertLabelTf.htmlText = this._data.statusText;
            this.tradeLabelTf.visible = this._data.statusOk;
            this.alertLabelTf.visible = !this.tradeLabelTf.visible;
            this.alertIcon.visible = this.alertLabelTf.visible;
            if(_loc1_)
            {
               if(this._data.tradeOffAvailable && _loc3_)
               {
                  _loc5_ = this._data.selectedPrice.price.getPriceVO();
                  this.selectedPrice.text = App.utils.locale.integer(_loc5_.value);
                  this.selectedPrice.icon = _loc5_.name;
                  this.selectedPrice.invalidatePosition();
                  this.selectedPrice.validateNow();
                  this.currentPrice.actionMode = Price.ACTION_MODE_DISABLED;
               }
            }
            else
            {
               this.currentPrice.actionMode = Price.ACTION_MODE_ENABLED;
            }
            this.selectedPrice.visible = _loc4_;
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.title.visible = !this._isSmall;
            this.titleSmall.visible = this._isSmall;
            this.tradeInfoBg.y = this._offsetY;
            this.actionButton.x = this.tradeInfoBg.x + (this.tradeInfoBg.width - this.actionButton.width >> 1) >> 0;
            this.actionButton.y = this.tradeInfoBg.y - this.actionButton.height - CONTROLS_INDENT >> 0;
            this.currentPrice.x = this.tradeInfoBg.x + (this.tradeInfoBg.width + this.currentPrice.contentWidth - this.tradeOffWidget.width - CONTROLS_INDENT >> 1) >> 0;
            this.currentPrice.y = this.actionButton.y - GAP;
            this.tradeOffWidget.x = this.currentPrice.x + CONTROLS_INDENT >> 0;
            this.tradeOffWidget.y = this.actionButton.y - GAP;
            this.title.x = this.tradeInfoBg.x + (this.tradeInfoBg.width - this.title.width >> 1) >> 0;
            this.title.y = this.tradeOffWidget.y - GAP >> 0;
            this.titleSmall.x = this.tradeInfoBg.x + (this.tradeInfoBg.width - this.titleSmall.width >> 1) >> 0;
            this.titleSmall.y = this.title.y + CONTROLS_INDENT;
            this.tradeLabelTf.x = this.tradeInfoBg.x + (this.tradeInfoBg.width - this.tradeLabelTf.width >> 1) >> 0;
            this.tradeLabelTf.y = this.tradeInfoBg.y + STATUS_OFFSET >> 0;
            this.alertLabelTf.x = this.tradeInfoBg.x + (this.tradeInfoBg.width - this.alertLabelTf.width >> 1) >> 0;
            this.alertLabelTf.y = this.tradeInfoBg.y + STATUS_OFFSET >> 0;
            this.tradeIcon.x = this.tradeLabelTf.x - (this.tradeIcon.width >> 1) + ICONS_INDENT >> 0;
            this.tradeIcon.y = this.tradeLabelTf.y + (this.tradeIcon.height >> 2) >> 0;
            this.alertIcon.x = this.alertLabelTf.x - this.alertIcon.width - ICONS_INDENT >> 0;
            this.alertIcon.y = this.alertLabelTf.y >> 0;
            this.selectedPrice.x = this.tradeLabelTf.x + this.tradeLabelTf.width + ICONS_INDENT >> 0;
            this.selectedPrice.y = this.tradeLabelTf.y + ICONS_INDENT >> 0;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.actionButton.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.alertIcon.removeEventListener(Event.CHANGE,this.onImgDataCompleteHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.currentPrice.dispose();
         this.currentPrice = null;
         this.actionButton.dispose();
         this.actionButton = null;
         this.tradeOffWidget = null;
         this.tradeIcon = null;
         this.alertIcon.dispose();
         this.alertIcon = null;
         this.tradeLabelTf = null;
         this.alertLabelTf = null;
         this.title = null;
         this.selectedPrice.dispose();
         this.selectedPrice = null;
         this.tradeInfoBg = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VPTradeInBuyingPanelVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.actionButton;
      }
      
      public function getTotalHeight() : Number
      {
         return height;
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._isSmall = param2 == StageSizeBoundaries.HEIGHT_768;
         this._offsetY = !!this._isSmall ? int(SMALL_Y_OFFSET) : int(BIG_Y_OFFSET);
         invalidateSize();
      }
      
      private function onActionButtonClickHandler(param1:ButtonEvent) : void
      {
         onBuyClickS();
      }
      
      private function onImgDataCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
