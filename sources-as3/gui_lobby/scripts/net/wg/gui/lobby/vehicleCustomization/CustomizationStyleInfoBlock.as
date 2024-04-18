package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.events.ScrollPaneEvent;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.BuyBtnVO;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.StyleInfoVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationStyleInfoEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class CustomizationStyleInfoBlock extends UIComponentEx
   {
      
      private static const SCROLL_BAR_STEP_FACTOR:int = 20;
      
      private static const BOTTOM_LIPS_OFFSET:int = -80;
      
      private static const TOP_LIPS_OFFSET:int = -111;
      
      private static const SCROLL_BAR_VALUE:String = "ScrollBar";
      
      private static const WIDTH_MEDIUM:int = 1600;
      
      private static const HEIGHT_MEDIUM:int = 900;
      
      private static const VERTICAL_SHIFT:Number = -0.05;
      
      private static const BLOCK_OFFSET_Y:int = 50;
      
      private static const BLOCK_MARGIN_Y:int = 40;
      
      private static const BUTTON_OFFSET_Y:int = 40;
      
      private static const SCROLL_AREA_OFFSET_Y:int = 10;
       
      
      public var styleNameTf:TextField = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var btnBuy:UniversalBtn = null;
      
      public var bottomLips:Sprite = null;
      
      public var topLips:Sprite = null;
      
      private var _scrollContainer:CustomizationStyleScrollContainer = null;
      
      private var _buyBtnDisabledTooltip:String = "";
      
      private var _availableHeight:int = 0;
      
      private var _blockMargin:int = 0;
      
      private var _styleName:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function CustomizationStyleInfoBlock()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._scrollContainer = CustomizationStyleScrollContainer(this.scrollPane.target);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btnBuy.mouseEnabledOnDisabled = true;
         this.btnBuy.soundType = SoundTypes.CUSTOMIZATION_DEFAULT;
         this.btnBuy.addEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
         this.btnBuy.addEventListener(MouseEvent.MOUSE_OUT,this.onBuyBtnMouseOutHandler);
         this.btnBuy.addEventListener(MouseEvent.MOUSE_OVER,this.onBuyBtnMouseOverHandler);
         App.utils.universalBtnStyles.setStyle(this.btnBuy,UniversalBtnStylesConst.STYLE_HEAVY_ORANGE);
         this.scrollPane.isSmoothScroll = false;
         this.scrollPane.scrollBar = SCROLL_BAR_VALUE;
         this.scrollPane.scrollStepFactor = SCROLL_BAR_STEP_FACTOR;
         this.scrollPane.scrollPosition = 0;
         this.scrollPane.addEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollPanePositionChangedHandler);
         this.topLips.mouseEnabled = this.bottomLips.mouseEnabled = false;
         this.styleNameTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      private function onBuyBtnClickHandler(param1:ButtonEvent) : void
      {
         App.stage.dispatchEvent(new CustomizationStyleInfoEvent(CustomizationStyleInfoEvent.APPLY_STYLE));
         dispatchEvent(new CustomizationEvent(CustomizationEvent.SHOW_BUY_WINDOW,false));
      }
      
      private function onBuyBtnMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onBuyBtnMouseOverHandler(param1:MouseEvent) : void
      {
         if(!this.btnBuy.enabled)
         {
            this._toolTipMgr.show(this._buyBtnDisabledTooltip);
         }
      }
      
      public function updateSize(param1:int, param2:int) : void
      {
         this._blockMargin = param2;
         this._availableHeight = param1;
         invalidateSize();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = App.appHeight < HEIGHT_MEDIUM;
            _loc2_ = App.appWidth < WIDTH_MEDIUM;
            _loc3_ = _loc1_ || _loc2_ ? TEXT_MANAGER_STYLES.GRAND_TITLE_YELLOW : TEXT_MANAGER_STYLES.HERO_TITLE_YELLOW;
            this.styleNameTf.htmlText = App.textMgr.getTextStyleById(_loc3_,this._styleName);
            this.styleNameTf.width = this._scrollContainer.width = this.width;
            this._scrollContainer.updateSize(_loc1_,_loc2_);
            this.scrollPane.y = this.styleNameTf.height + SCROLL_AREA_OFFSET_Y | 0;
            _loc4_ = 0;
            _loc5_ = this._availableHeight - this.scrollPane.y - BLOCK_OFFSET_Y;
            if(this.btnBuy.visible)
            {
               _loc5_ -= this.btnBuy.height + BUTTON_OFFSET_Y + BLOCK_MARGIN_Y;
               this.btnBuy.x = this.width - this.btnBuy.width >> 1 | 0;
               this.btnBuy.y = this.scrollPane.y + Math.min(_loc5_,this._scrollContainer.contentHeight) + BUTTON_OFFSET_Y;
               _loc4_ = this.btnBuy.y + this.btnBuy.height | 0;
            }
            else
            {
               _loc4_ = this.scrollPane.y + Math.min(_loc5_,this._scrollContainer.contentHeight);
            }
            this.scrollPane.setSize(this.width,_loc5_);
            this.scrollPane.invalidateSize();
            this.scrollPane.scrollBarShiftHorizontal = this._blockMargin;
            this._scrollContainer.scaleX = this._scrollContainer.scaleY = 1;
            this.topLips.width = this.bottomLips.width = this._scrollContainer.width;
            this.topLips.y = this.scrollPane.y + TOP_LIPS_OFFSET;
            this.bottomLips.y = this.scrollPane.y + this.scrollPane.height + BOTTOM_LIPS_OFFSET | 0;
            this.x = App.appWidth - (this.width + this.scrollPane.scrollBarShiftHorizontal);
            this.y = Math.max(BLOCK_OFFSET_Y,(this._availableHeight - _loc4_ >> 1) + App.appHeight * VERTICAL_SHIFT | 0);
            invalidate(InvalidationType.SCROLL_BAR);
         }
         if(isInvalid(InvalidationType.SCROLL_BAR))
         {
            this.topLips.visible = this.scrollPane.scrollPosition != 0;
            this.bottomLips.visible = this.scrollPane.scrollPosition != this.scrollPane.maxScroll && this.scrollPane.getContentHeight() > this.scrollPane.availableHeight;
         }
      }
      
      override protected function onDispose() : void
      {
         this.btnBuy.removeEventListener(ButtonEvent.CLICK,this.onBuyBtnClickHandler);
         this.btnBuy.removeEventListener(MouseEvent.MOUSE_OUT,this.onBuyBtnMouseOutHandler);
         this.btnBuy.removeEventListener(MouseEvent.MOUSE_OVER,this.onBuyBtnMouseOverHandler);
         this.btnBuy.dispose();
         this.btnBuy = null;
         this.scrollPane.removeEventListener(ScrollPaneEvent.POSITION_CHANGED,this.onScrollPanePositionChangedHandler);
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.bottomLips = null;
         this.topLips = null;
         this.styleNameTf = null;
         this._scrollContainer.dispose();
         this._scrollContainer = null;
         this._buyBtnDisabledTooltip = null;
         this._styleName = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function onScrollPanePositionChangedHandler(param1:ScrollPaneEvent) : void
      {
         invalidate(InvalidationType.SCROLL_BAR);
      }
      
      public function setData(param1:StyleInfoVO) : void
      {
         this._styleName = param1.styleName;
         this._scrollContainer.setData(param1);
         invalidateSize();
      }
      
      public function buttonUpdate(param1:BuyBtnVO) : void
      {
         this.btnBuy.visible = param1.visible;
         if(this.btnBuy.visible)
         {
            this.btnBuy.label = param1.label;
            this.btnBuy.enabled = param1.enabled;
            this._buyBtnDisabledTooltip = param1.disabledTooltip;
         }
         invalidateSize();
      }
   }
}
