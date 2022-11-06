package net.wg.gui.lobby.gamma
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.infrastructure.base.meta.IGammaWizardViewMeta;
   import net.wg.infrastructure.base.meta.impl.GammaWizardViewMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.SliderEvent;
   
   public class GammaWizardView extends GammaWizardViewMeta implements IGammaWizardViewMeta
   {
      
      private static const SHINE_STATE_SMALL:String = "small";
      
      private static const SHINE_STATE_BIG:String = "big";
      
      private static const SMALL_TEXTURE_SIZE:int = 384;
      
      private static const BIG_TEXTURE_SIZE:int = 512;
      
      private static const TEXTURE_OFFSET:int = 35;
      
      private static const BLOCK_OFFSET_Y:int = 20;
      
      private static const REFERENCE_WIDTH:int = 1600;
      
      private static const REFERENCE_HEIGHT:int = 900;
      
      private static const BLOCK_OFFSET_X:int = 1;
      
      private static const DESCRIPTION_OFFSET:int = 20;
       
      
      public var title:TextField = null;
      
      public var interactionBlock:InteractionBlock = null;
      
      public var shine:MovieClip = null;
      
      public var sparksLeft:Sprite = null;
      
      public var sparksRight:Sprite = null;
      
      public var description:TextField = null;
      
      private var _initVO:GammaInitVO = null;
      
      private var _applyButton:ISoundButtonEx = null;
      
      private var _cancelButton:ISoundButtonEx = null;
      
      private var _defaultButton:ISoundButtonEx = null;
      
      private var _slider:Slider = null;
      
      private var _header:TextField = null;
      
      private var _textureY:int = -1;
      
      public function GammaWizardView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._applyButton = this.interactionBlock.applyButton;
         this._cancelButton = this.interactionBlock.cancelButton;
         this._defaultButton = this.interactionBlock.defaultButton;
         this._slider = this.interactionBlock.slider;
         this._header = this.interactionBlock.header;
         this.description.autoSize = TextFieldAutoSize.LEFT;
         closeBtn.label = SETTINGS.GAMMAWIZARD_CLOSEBTN;
         this._applyButton.addEventListener(ButtonEvent.CLICK,this.onApplyButtonClickHandler);
         this._cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this._defaultButton.addEventListener(ButtonEvent.CLICK,this.onDefaultButtonClickHandler);
         this._slider.addEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
         this._slider.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this._slider.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this._header.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this._header.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         var _loc1_:int = this.getTextureSize();
         var _loc2_:int = width - _loc1_ >> 1;
         this._textureY = this.title.y + this.title.height + TEXTURE_OFFSET;
         this.updateTexturePosition(_loc2_,_loc1_);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         super.draw();
         if(this._initVO != null && isInvalid(InvalidationType.DATA))
         {
            this.title.htmlText = this._initVO.title;
            this.description.htmlText = this._initVO.description;
            this.interactionBlock.initData(this._initVO);
            this.validateEnable();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc1_ = width >> 1;
            _loc2_ = height < REFERENCE_HEIGHT;
            _loc3_ = this.getTextureSize();
            _loc4_ = width - _loc3_ >> 1;
            this.updateTexturePosition(_loc4_,_loc3_);
            this.title.x = width - this.title.width >> 1;
            this.description.x = width - this.description.width >> 1;
            this.description.y = this._textureY + _loc3_ + DESCRIPTION_OFFSET;
            this.interactionBlock.x = (width - this.interactionBlock.width >> 1) + BLOCK_OFFSET_X;
            this.interactionBlock.y = this.description.y + this.description.height + BLOCK_OFFSET_Y;
            this.shine.gotoAndStop(!!_loc2_ ? SHINE_STATE_SMALL : SHINE_STATE_BIG);
            this.shine.x = _loc1_;
            this.shine.y = this._textureY + _loc3_;
            _loc5_ = Math.min(width / REFERENCE_WIDTH,height / REFERENCE_HEIGHT);
            this.sparksLeft.y = height;
            this.sparksLeft.scaleX = this.sparksLeft.scaleY = _loc5_;
            this.sparksRight.x = width;
            this.sparksRight.y = height;
            this.sparksRight.scaleX = this.sparksRight.scaleY = _loc5_;
         }
      }
      
      override protected function initData(param1:GammaInitVO) : void
      {
         this._initVO = param1;
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.description = null;
         this._applyButton.removeEventListener(ButtonEvent.CLICK,this.onApplyButtonClickHandler);
         this._applyButton = null;
         this._cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this._cancelButton = null;
         this._slider.removeEventListener(SliderEvent.VALUE_CHANGE,this.onSliderValueChangeHandler);
         this._defaultButton.removeEventListener(ButtonEvent.CLICK,this.onDefaultButtonClickHandler);
         this._defaultButton = null;
         this._slider.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this._slider.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this._slider = null;
         this._header.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this._header.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this._header = null;
         this.interactionBlock.dispose();
         this.interactionBlock = null;
         this._initVO = null;
         this.shine = null;
         this.sparksLeft = null;
         this.sparksRight = null;
         super.onDispose();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseS();
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onCloseS();
      }
      
      private function validateEnable() : void
      {
         this._defaultButton.enabled = this._slider.value != this._initVO.defaultValue;
      }
      
      private function updateTexturePosition(param1:int, param2:int) : void
      {
         var _loc3_:Number = App.appScale;
         updateTextureS(param1 * _loc3_,this._textureY * _loc3_,param2 * _loc3_);
      }
      
      private function getTextureSize() : int
      {
         return height < REFERENCE_HEIGHT ? int(SMALL_TEXTURE_SIZE) : int(BIG_TEXTURE_SIZE);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._initVO.gammaTooltip);
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onDefaultButtonClickHandler(param1:ButtonEvent) : void
      {
         this._slider.value = this._initVO.defaultValue;
         this.validateEnable();
      }
      
      private function onApplyButtonClickHandler(param1:ButtonEvent) : void
      {
         onApplyS();
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onCloseS();
      }
      
      private function onSliderValueChangeHandler(param1:SliderEvent) : void
      {
         onChangeGammaS(param1.value);
         if(!this._defaultButton.enabled)
         {
            this.validateEnable();
         }
      }
   }
}
