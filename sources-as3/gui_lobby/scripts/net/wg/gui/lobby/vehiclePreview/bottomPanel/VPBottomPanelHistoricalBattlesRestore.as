package net.wg.gui.lobby.vehiclePreview.bottomPanel
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.PriceVO;
   import net.wg.gui.components.controls.price.CompoundPrice;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.vehiclePreview.data.VPHBRestorePanelVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewHBRestorePanelMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewHBRestorePanelMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VPBottomPanelHistoricalBattlesRestore extends VehiclePreviewHBRestorePanelMeta implements IVehiclePreviewHBRestorePanelMeta, IStageSizeDependComponent, IVPBottomPanel
   {
      
      private static const BUY_BUTTON_DEFAULT_OFFSET:int = 32;
      
      private static const BG_BIG_OFFSET:int = 60;
      
      private static const BG_SMALL_OFFSET:int = 42;
       
      
      public var background:Sprite = null;
      
      public var uniqueLabelTf:TextField;
      
      public var actionButton:UniversalBtn = null;
      
      public var compoundPrice:CompoundPrice = null;
      
      private var _data:VPHBRestorePanelVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _bgOffset:int;
      
      public function VPBottomPanelHistoricalBattlesRestore()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
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
         this.compoundPrice.addEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.compoundPrice.addEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         this.actionButton.addEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.addEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.actionButton.addEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         this.actionButton.mouseEnabledOnDisabled = true;
         this.uniqueLabelTf.mouseWheelEnabled = this.uniqueLabelTf.mouseEnabled = false;
         this.uniqueLabelTf.autoSize = TextFieldAutoSize.LEFT;
         this.background.mouseChildren = this.background.mouseEnabled = false;
         mouseEnabled = false;
         App.stageSizeMgr.register(this);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.actionButton.removeEventListener(ButtonEvent.CLICK,this.onActionButtonClickHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.actionButton.removeEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         this.compoundPrice.removeEventListener(MouseEvent.ROLL_OVER,this.onActionButtonRollOverHandler);
         this.compoundPrice.removeEventListener(MouseEvent.ROLL_OUT,this.onActionButtonRollOutHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.actionButton.dispose();
         this.actionButton = null;
         this.compoundPrice.dispose();
         this.compoundPrice = null;
         this.uniqueLabelTf = null;
         this.background = null;
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
         if(this._data && isInvalid(InvalidationType.SIZE))
         {
            this.updatePanelSize();
         }
      }
      
      override protected function setBuyData(param1:VPHBRestorePanelVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function getBtn() : SoundButtonEx
      {
         return this.actionButton;
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
      
      private function updatePanelData() : void
      {
         var _loc1_:String = null;
         if(this._data)
         {
            if(this._data.uniqueVehicleTitle)
            {
               this.uniqueLabelTf.visible = true;
               this.uniqueLabelTf.htmlText = this._data.uniqueVehicleTitle;
            }
            else
            {
               this.uniqueLabelTf.visible = false;
            }
            _loc1_ = Boolean(this._data.price) ? this._data.price.price.getPriceVO().name : null;
            this.compoundPrice.setData(this._data.price);
            this.compoundPrice.updateEnoughStatuses(new <PriceVO>[new PriceVO([_loc1_,int(this._data.isMoneyEnough)])]);
            this.compoundPrice.visible = true;
            this.compoundPrice.validateNow();
            this.actionButton.label = this._data.buyButtonLabel;
            this.actionButton.enabled = this._data.buyButtonEnabled;
            App.utils.universalBtnStyles.setStyle(this.actionButton,UniversalBtnStylesConst.STYLE_HEAVY_LIME);
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
         if(this.uniqueLabelTf.visible)
         {
            this.uniqueLabelTf.x = width - this.uniqueLabelTf.width >> 1;
         }
         this.actionButton.x = width - this.actionButton.width >> 1;
         this.compoundPrice.x = this.actionButton.x - BUY_BUTTON_DEFAULT_OFFSET - this.compoundPrice.actualWidth | 0;
         this.background.x = width - this.background.width >> 1;
         this.background.y = this.actionButton.y + this.actionButton.height - this.background.height + this._bgOffset | 0;
      }
      
      override public function get height() : Number
      {
         return this.actionButton.y + this.actionButton.height;
      }
      
      private function onActionButtonClickHandler(param1:ButtonEvent) : void
      {
         onBuyClickS();
      }
      
      private function onActionButtonRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data || this._data.shortage <= 0)
         {
            return;
         }
         var _loc2_:String = Boolean(this._data.price) ? this._data.price.price.getPriceVO().name : null;
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.NOT_ENOUGH_MONEY,null,this._data.shortage,_loc2_);
      }
      
      private function onActionButtonRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
