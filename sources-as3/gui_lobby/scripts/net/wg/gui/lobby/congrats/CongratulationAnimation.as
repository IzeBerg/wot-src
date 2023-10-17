package net.wg.gui.lobby.congrats
{
   import fl.motion.easing.Back;
   import fl.transitions.easing.Regular;
   import fl.transitions.easing.Strong;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class CongratulationAnimation extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const IMAGE_V_OFFSET:int = 20;
      
      private static const DESCRIPTION_V_OFFSET:int = 54;
      
      private static const TITLE_V_OFFSET:int = 4;
      
      private static const BUTTONS_V_OFFSET:int = 56;
      
      private static const BUTTONS_GAP:int = 30;
      
      private static const BUTTONS_MIN_WIDTH:int = 160;
      
      private static const HIGHLIGHT_OFFSET:int = 80;
      
      private static const SCALE_BIG:Number = 1;
      
      private static const SCALE_SMALL:Number = 0.75;
      
      private static const ANIMATION_DURATION:int = 500;
      
      private static const BUTTONS_TWEEN_DELAY:int = 1200;
      
      private static const TEXTS_TWEEN_DELAY:int = 100;
      
      private static const TEXTS_TWEEN_TOP_PADDING:int = 15;
      
      private static const ANIMATION_FLAG:String = "animationFlag";
      
      private static const CONFIRM_EVENT_TYPE:String = "confirm";
      
      private static const BACK_EVENT_TYPE:String = "back";
       
      
      public var titleTF:TextField;
      
      public var descriptionTF:TextField;
      
      public var image:UILoaderAlt;
      
      public var confirmButton:UniversalBtn;
      
      public var backButton:UniversalBtn;
      
      public var highlight:MovieClip;
      
      private var _showAnimation:Boolean;
      
      private var _tweens:Vector.<Tween>;
      
      private var _scale:Number = 1;
      
      public function CongratulationAnimation()
      {
         super();
         this._tweens = new Vector.<Tween>(0);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.highlight.visible = false;
         this.highlight.stop();
         App.stageSizeMgr.register(this);
         this.image.addEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.disposeTweens();
         this.confirmButton.removeEventListener(ButtonEvent.CLICK,this.onConfirmButtonClickHandler);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
         this._tweens = null;
         this.titleTF = null;
         this.descriptionTF = null;
         this.image.removeEventListener(UILoaderEvent.COMPLETE,this.onImageCompleteHandler);
         this.image.dispose();
         this.image = null;
         this.confirmButton.dispose();
         this.confirmButton = null;
         this.backButton.dispose();
         this.backButton = null;
         this.highlight = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         visible = false;
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         this.titleTF.mouseWheelEnabled = this.titleTF.mouseEnabled = false;
         this.descriptionTF.autoSize = TextFieldAutoSize.LEFT;
         this.descriptionTF.mouseWheelEnabled = this.descriptionTF.mouseEnabled = false;
         this.image.maintainAspectRatio = false;
         this.image.mouseEnabled = this.image.mouseChildren = false;
         this.highlight.mouseEnabled = this.highlight.mouseChildren = false;
         App.utils.universalBtnStyles.setStyle(this.confirmButton,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         App.utils.universalBtnStyles.setStyle(this.backButton,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.confirmButton.minWidth = BUTTONS_MIN_WIDTH;
         this.confirmButton.autoSize = TextFieldAutoSize.LEFT;
         this.confirmButton.addEventListener(ButtonEvent.CLICK,this.onConfirmButtonClickHandler);
         this.backButton.minWidth = BUTTONS_MIN_WIDTH;
         this.backButton.autoSize = TextFieldAutoSize.LEFT;
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.titleTF.x = width - this.titleTF.width >> 1;
            this.descriptionTF.x = width - this.descriptionTF.width >> 1;
            if(this.backButton.visible)
            {
               this.confirmButton.x = width - this.confirmButton.width - this.backButton.width - BUTTONS_GAP >> 1;
               this.backButton.x = this.confirmButton.x + this.confirmButton.width + BUTTONS_GAP | 0;
            }
            else
            {
               this.confirmButton.x = width - this.confirmButton.width >> 1;
            }
            this.image.scaleX = this.image.scaleY = this._scale;
            this.image.x = width - this.image.width >> 1;
            this.image.y = (height - this.image.height >> 1) + IMAGE_V_OFFSET;
            this.descriptionTF.y = this.image.y - DESCRIPTION_V_OFFSET - this.descriptionTF.height | 0;
            this.titleTF.y = this.descriptionTF.y - TITLE_V_OFFSET - this.titleTF.height | 0;
            this.confirmButton.y = this.backButton.y = this.image.y + this.image.height + BUTTONS_V_OFFSET | 0;
            dispatchEvent(new Event(Event.RESIZE));
         }
         if(this._showAnimation && isInvalid(ANIMATION_FLAG))
         {
            this._showAnimation = false;
            visible = true;
            this.disposeTweens();
            this._tweens.push(new Tween(ANIMATION_DURATION,this.titleTF,{
               "y":this.titleTF.y,
               "alpha":1
            },{
               "ease":Regular.easeOut,
               "fastTransform":false
            }));
            this.titleTF.y -= TEXTS_TWEEN_TOP_PADDING;
            this.titleTF.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION,this.descriptionTF,{
               "y":this.descriptionTF.y,
               "alpha":1
            },{
               "ease":Regular.easeOut,
               "fastTransform":false,
               "delay":TEXTS_TWEEN_DELAY
            }));
            this.descriptionTF.y -= TEXTS_TWEEN_TOP_PADDING << 1;
            this.descriptionTF.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION * 1.2,this.image,{
               "x":this.image.x,
               "y":this.image.y,
               "alpha":1,
               "scaleX":this._scale,
               "scaleY":this._scale
            },{
               "ease":Back.easeOut,
               "fastTransform":false,
               "delay":200
            }));
            this.image.scaleX = 0.5 * this._scale;
            this.image.scaleY = 0.5 * this._scale;
            this.image.x = (width - this.image.width >> 1) + 30 * this._scale;
            this.image.y = height - this.image.height >> 1;
            this.image.alpha = 0;
            this.highlight.scaleX = this.highlight.scaleY = this._scale;
            this.highlight.x = width - this.highlight.width >> 1;
            this.highlight.y = (height - this.highlight.height >> 1) + HIGHLIGHT_OFFSET / this._scale + 30;
            this.highlight.alpha = 1;
            this.highlight.visible = false;
            this._tweens.push(new Tween(ANIMATION_DURATION * 3,this.highlight,{
               "scaleX":4 * this._scale,
               "scaleY":3 * this._scale,
               "alpha":0,
               "x":width - this.highlight.width * 4 >> 1,
               "y":(height - this.highlight.height * 3 >> 1) + HIGHLIGHT_OFFSET * this._scale
            },{
               "ease":Strong.easeOut,
               "fastTransform":false,
               "delay":ANIMATION_DURATION * 0.75,
               "onChange":this.onStartVehicleHighlightAnimation
            }));
            this._tweens.push(new Tween(ANIMATION_DURATION,this.confirmButton,{"alpha":1},{
               "ease":Strong.easeOut,
               "fastTransform":false,
               "delay":BUTTONS_TWEEN_DELAY
            }));
            this.confirmButton.alpha = 0;
            this._tweens.push(new Tween(ANIMATION_DURATION,this.backButton,{"alpha":1},{
               "ease":Strong.easeOut,
               "fastTransform":false,
               "delay":BUTTONS_TWEEN_DELAY
            }));
            this.backButton.alpha = 0;
         }
      }
      
      public function setData(param1:Object) : void
      {
         this.titleTF.text = param1.title;
         this.descriptionTF.text = param1.description;
         this.image.autoSize = false;
         this.image.source = param1.image;
         this.image.sourceAlt = param1.imageAlt;
         this.confirmButton.label = param1.confirmLbl;
         this.confirmButton.visible = StringUtils.isNotEmpty(this.confirmButton.label);
         this.backButton.label = param1.backLbl;
         this.backButton.visible = StringUtils.isNotEmpty(this.backButton.label);
         invalidateSize();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._scale = param2 >= StageSizeBoundaries.HEIGHT_900 ? Number(SCALE_BIG) : Number(SCALE_SMALL);
         invalidateSize();
      }
      
      private function onStartVehicleHighlightAnimation(param1:Tween) : void
      {
         if(!_baseDisposed)
         {
            param1.onChange = null;
            this.highlight.visible = true;
         }
      }
      
      private function disposeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this._tweens.length = 0;
      }
      
      private function onImageCompleteHandler(param1:UILoaderEvent) : void
      {
         invalidateSize();
         invalidate(ANIMATION_FLAG);
         this._showAnimation = true;
      }
      
      private function onConfirmButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(CONFIRM_EVENT_TYPE));
      }
      
      private function onBackButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new Event(BACK_EVENT_TYPE));
      }
   }
}
