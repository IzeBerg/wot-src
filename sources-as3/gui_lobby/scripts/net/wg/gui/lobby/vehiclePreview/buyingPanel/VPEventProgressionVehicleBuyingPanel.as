package net.wg.gui.lobby.vehiclePreview.buyingPanel
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.IconTextBigButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPEventProgressionBuyingPanelVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemsVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewEventProgressionBuyingPanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewEventProgressionBuyingPanelMeta;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPEventProgressionVehicleBuyingPanel extends VehiclePreviewEventProgressionBuyingPanelMeta implements IVehiclePreviewEventProgressionBuyingPanelMeta, IVPBottomPanel
   {
      
      private static const BTN_GAP:int = 10;
      
      private static const PRICE_GAP:int = 15;
      
      private static const LEFT_OFFSET:int = 6;
      
      private static const BUTTON_TOP_OFFSET:int = 2;
      
      private static const MIN_BTNS_WIDTH:int = 160;
       
      
      public var moneyLabel:TextField = null;
      
      public var priceLabel:TextField = null;
      
      public var titleLabel:TextField = null;
      
      public var buyBtnOrange:IconTextBigButton = null;
      
      public var setItemsView:SetItemsView = null;
      
      private var _data:VPEventProgressionBuyingPanelVO;
      
      public function VPEventProgressionVehicleBuyingPanel()
      {
         super();
      }
      
      private static function get isNormalWidth() : Boolean
      {
         return App.appWidth > StageSizeBoundaries.WIDTH_1280;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.moneyLabel.autoSize = TextFieldAutoSize.LEFT;
         this.priceLabel.autoSize = TextFieldAutoSize.LEFT;
         this.titleLabel.autoSize = TextFieldAutoSize.LEFT;
         this.buyBtnOrange.mouseEnabledOnDisabled = true;
         this.buyBtnOrange.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.setItemsView.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.setItemsView.addEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
         this.moneyLabel.addEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.moneyLabel.addEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
         this.priceLabel.addEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.priceLabel.addEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.moneyLabel.htmlText = this._data.money;
            this.priceLabel.htmlText = this._data.price;
            this.titleLabel.htmlText = !!isNormalWidth ? this._data.title : this._data.shortTitle;
            this.buyBtnOrange.visible = true;
            this.buyBtnOrange.enabled = this._data.buyButtonEnabled;
            this.buyBtnOrange.minWidth = MIN_BTNS_WIDTH;
            this.buyBtnOrange.autoSize = TextFieldAutoSize.CENTER;
            this.buyBtnOrange.label = this._data.buyButtonLabel;
            this.buyBtnOrange.tooltip = this._data.buyButtonTooltip;
            this.buyBtnOrange.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.titleLabel.x = (width >> 1) - (this.titleLabel.width + this.moneyLabel.width >> 1);
            this.moneyLabel.x = this.titleLabel.x + this.titleLabel.width >> 0;
            this.moneyLabel.y = this.titleLabel.y;
            this.setItemsView.x = this.titleLabel.x + LEFT_OFFSET + this.setItemsView.actualWidth + (this.titleLabel.width - this.setItemsView.actualWidth - this.priceLabel.width - this.buyBtnOrange.width - BTN_GAP - PRICE_GAP >> 1);
            this.priceLabel.x = this.setItemsView.x + PRICE_GAP | 0;
            this.buyBtnOrange.x = this.priceLabel.x + this.priceLabel.width + BTN_GAP | 0;
            this.priceLabel.y = this.setItemsView.y + (SetItemsBlock.BLOCK_HEIGHT - this.priceLabel.height >> 1);
            this.buyBtnOrange.y = this.setItemsView.y + (SetItemsBlock.BLOCK_HEIGHT - this.buyBtnOrange.height >> 1) + BUTTON_TOP_OFFSET;
         }
      }
      
      override protected function onDispose() : void
      {
         this.priceLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.priceLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
         this.moneyLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onLabelRollOutHandler);
         this.moneyLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onLabelRollOverHandler);
         this.setItemsView.removeEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
         this.setItemsView.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.buyBtnOrange.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.priceLabel = null;
         this.moneyLabel = null;
         this.titleLabel = null;
         this._data = null;
         this.setItemsView.dispose();
         this.setItemsView = null;
         this.buyBtnOrange.dispose();
         this.buyBtnOrange = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VPEventProgressionBuyingPanelVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      override protected function setSetItemsData(param1:VPSetItemsVO) : void
      {
         this.setItemsView.setData(param1.blocks);
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.buyBtnOrange;
      }
      
      public function getTotalHeight() : Number
      {
         return height;
      }
      
      private function onBuyButtonClickHandler(param1:ButtonEvent) : void
      {
         onBuyClickS();
      }
      
      private function onSetItemsViewShowTooltipHandler(param1:VehiclePreviewEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:VPSetItemVO = VPSetItemVO(param1.data);
         showTooltipS(_loc2_.id,_loc2_.type);
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         invalidateData();
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
