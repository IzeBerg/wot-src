package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.vehiclePreview.VehiclePreviewEvent;
   import net.wg.gui.lobby.vehiclePreview.data.VPOfferGiftBuyingPanelVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemVO;
   import net.wg.gui.lobby.vehiclePreview.data.VPSetItemsVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBottomPanelOfferGiftMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBottomPanelOfferGiftMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class VPBottomPanelOfferGift extends VehiclePreviewBottomPanelOfferGiftMeta implements IVehiclePreviewBottomPanelOfferGiftMeta, IVPBottomPanel
   {
      
      private static const BTN_GAP:int = 45;
      
      private static const PRICE_GAP:int = 15;
      
      private static const LEFT_OFFSET:int = -15;
      
      private static const BUTTON_TOP_OFFSET:int = 2;
      
      private static const MIN_BTNS_WIDTH:int = 160;
      
      private static const TITLE_LABEL_WIDTH:int = 650;
       
      
      public var titleLabel:TextField;
      
      public var buyBtn:UniversalBtn = null;
      
      public var setItemsView:SetItemsView = null;
      
      private var _data:VPOfferGiftBuyingPanelVO;
      
      public function VPBottomPanelOfferGift()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleLabel.autoSize = TextFieldAutoSize.CENTER;
         this.titleLabel.multiline = true;
         this.titleLabel.wordWrap = true;
         this.titleLabel.width = TITLE_LABEL_WIDTH;
         TextFieldEx.setVerticalAlign(this.titleLabel,TextFieldEx.VALIGN_BOTTOM);
         this.buyBtn.addEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         App.utils.universalBtnStyles.setStyle(this.buyBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         this.setItemsView.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.setItemsView.addEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.titleLabel.htmlText = this._data.title;
            this.buyBtn.visible = true;
            this.buyBtn.enabled = true;
            this.buyBtn.minWidth = MIN_BTNS_WIDTH;
            this.buyBtn.autoSize = TextFieldAutoSize.CENTER;
            this.buyBtn.label = this._data.buyButtonLabel;
            this.buyBtn.validateNow();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.titleLabel.x = (this.width >> 1) - (this.titleLabel.width >> 1);
            this.setItemsView.x = this.titleLabel.x + LEFT_OFFSET + this.setItemsView.actualWidth + (this.titleLabel.width - this.setItemsView.actualWidth - this.buyBtn.width - BTN_GAP - PRICE_GAP >> 1);
            this.buyBtn.x = this.setItemsView.x + BTN_GAP | 0;
            this.buyBtn.y = this.setItemsView.y + (SetItemsBlock.BLOCK_HEIGHT - this.buyBtn.height >> 1) + BUTTON_TOP_OFFSET;
         }
      }
      
      override protected function onDispose() : void
      {
         this.setItemsView.removeEventListener(VehiclePreviewEvent.SHOW_TOOLTIP,this.onSetItemsViewShowTooltipHandler);
         this.setItemsView.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this.buyBtn.removeEventListener(ButtonEvent.CLICK,this.onBuyButtonClickHandler);
         this.titleLabel = null;
         this._data = null;
         this.setItemsView.dispose();
         this.setItemsView = null;
         this.buyBtn.dispose();
         this.buyBtn = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VPOfferGiftBuyingPanelVO) : void
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
         return this.buyBtn;
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
      
      private function onSetItemsViewShowTooltipHandler(param1:VehiclePreviewEvent) : void
      {
         param1.stopImmediatePropagation();
         var _loc2_:VPSetItemVO = VPSetItemVO(param1.data);
         showTooltipS(_loc2_.id,_loc2_.type);
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
