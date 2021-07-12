package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehiclePreview.data.VPEventProgressionBuyingPanelVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewEventProgressionBuyingPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewEventProgressionBuyingPanelMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPEventProgressionStyleBuyingPanel extends VehiclePreviewEventProgressionBuyingPanelMeta implements IVehiclePreviewEventProgressionBuyingPanelMeta, IVPBottomPanel
   {
      
      private static const PRICE_OFFSET:int = 20;
      
      private static const BTN_GAP:int = 10;
      
      private static const BUTTON_TOP_OFFSET:int = 5;
      
      private static const PRICE_TOP_OFFSET:int = 9;
      
      private static const MIN_BTNS_WIDTH:int = 160;
       
      
      public var moneyLabel:TextField = null;
      
      public var priceLabel:TextField = null;
      
      public var titleLabel:TextField = null;
      
      public var buyBtnOrange:IconTextBigButton = null;
      
      private var _data:VPEventProgressionBuyingPanelVO;
      
      public function VPEventProgressionStyleBuyingPanel()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.moneyLabel.autoSize = TextFieldAutoSize.LEFT;
         this.priceLabel.autoSize = TextFieldAutoSize.LEFT;
         this.titleLabel.autoSize = TextFieldAutoSize.LEFT;
         this.buyBtnOrange.mouseEnabledOnDisabled = true;
         this.buyBtnOrange.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.moneyLabel.addEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.moneyLabel.addEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
         this.priceLabel.addEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.priceLabel.addEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.moneyLabel.htmlText = this._data.money;
            this.priceLabel.htmlText = this._data.price;
            this.titleLabel.htmlText = this._data.title;
            this.buyBtnOrange.visible = true;
            this.buyBtnOrange.enabled = this._data.buyButtonEnabled;
            this.buyBtnOrange.minWidth = MIN_BTNS_WIDTH;
            this.buyBtnOrange.autoSize = TextFieldAutoSize.CENTER;
            this.buyBtnOrange.label = this._data.buyButtonLabel;
            this.buyBtnOrange.tooltip = this._data.buyButtonTooltip;
            this.buyBtnOrange.validateNow();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = this.titleLabel.width + this.moneyLabel.width;
            this.titleLabel.x = this.width - _loc1_ >> 1;
            this.moneyLabel.x = this.titleLabel.x + this.titleLabel.width | 0;
            this.moneyLabel.y = this.titleLabel.y;
            _loc2_ = this.priceLabel.width + BTN_GAP + this.buyBtnOrange.width;
            this.priceLabel.x = (this.titleLabel.x + _loc1_ - _loc2_ >> 1) - PRICE_OFFSET;
            this.buyBtnOrange.x = this.priceLabel.x + this.priceLabel.width + BTN_GAP | 0;
            this.priceLabel.y = this.titleLabel.y + this.titleLabel.height + PRICE_TOP_OFFSET | 0;
            this.buyBtnOrange.y = this.priceLabel.y + BUTTON_TOP_OFFSET | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.priceLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.priceLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
         this.moneyLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.moneyLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
         this.buyBtnOrange.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.priceLabel = null;
         this.moneyLabel = null;
         this.titleLabel = null;
         this._data = null;
         this.buyBtnOrange.dispose();
         this.buyBtnOrange = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VPEventProgressionBuyingPanelVO) : void
      {
         this._data = param1;
         validateNow();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.buyBtnOrange;
      }
      
      public function getTotalHeight() : Number
      {
         return height;
      }
      
      override public function get width() : Number
      {
         return this.titleLabel.width;
      }
      
      private function onBuyButtonClickHandler(param1:ButtonEvent) : void
      {
         onBuyClickS();
      }
      
      private function onLabelRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onLabelRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._data.priceTooltip))
         {
            App.toolTipMgr.showComplex(this._data.priceTooltip);
         }
      }
   }
}
