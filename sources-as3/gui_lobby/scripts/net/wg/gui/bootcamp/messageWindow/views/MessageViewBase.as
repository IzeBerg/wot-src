package net.wg.gui.bootcamp.messageWindow.views
{
   import flash.display.FrameLabel;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.bootcamp.controls.LoaderContainer;
   import net.wg.gui.bootcamp.interfaces.IAnimatedButtonRenderer;
   import net.wg.gui.bootcamp.interfaces.IAnimatedMovieClip;
   import net.wg.gui.bootcamp.messageWindow.data.MessageContentVO;
   import net.wg.gui.bootcamp.messageWindow.events.MessageViewEvent;
   import net.wg.gui.bootcamp.messageWindow.interfaces.IMessageView;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class MessageViewBase extends UIComponentEx implements IMessageView
   {
      
      protected static const IN_STATE:String = "in";
      
      protected static const OUT_STATE:String = "out";
      
      protected static const ACCEPT_STATE:String = "accept";
      
      private static const MESSAGE_SHOW:String = "show";
      
      private static const MESSAGE_FINISH:String = "finish";
      
      private static const BACKGROUND_WIDTH:int = 1920;
      
      private static const BACKGROUND_HEIGHT:int = 1080;
      
      private static const BTN_CONTINUE_PADDING:int = 106;
      
      private static const SCREEN_SIZE_FIX:int = 1;
       
      
      public var animContainerTitle:IAnimatedMovieClip = null;
      
      public var animContainerDescription:IAnimatedMovieClip = null;
      
      public var iconContainer:LoaderContainer = null;
      
      public var imgBg:LoaderContainer = null;
      
      public var black:MovieClip = null;
      
      public var animContainerBtnContinue:IAnimatedButtonRenderer = null;
      
      private var _messageData:MessageContentVO = null;
      
      private var _outTween:Tween = null;
      
      private var _messageShowLabelFrame:int = -1;
      
      private var _messageFinishLabelFrame:int = -1;
      
      private var _messageStateLabel:String = "";
      
      public function MessageViewBase()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this.black.width = param1 + SCREEN_SIZE_FIX;
         this.black.height = param2 + SCREEN_SIZE_FIX;
         this.black.x = -param1 >> 1;
         this.black.y = -param2 >> 1;
      }
      
      override protected function configUI() : void
      {
         var _loc2_:FrameLabel = null;
         super.configUI();
         var _loc1_:Array = currentLabels;
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.name == MESSAGE_SHOW)
            {
               this._messageShowLabelFrame = _loc2_.frame - 1;
               addFrameScript(this._messageShowLabelFrame,this.onPressAnyKeyHandler);
            }
            else if(_loc2_.name == MESSAGE_FINISH)
            {
               this._messageFinishLabelFrame = _loc2_.frame - 1;
               addFrameScript(this._messageFinishLabelFrame,this.onAnimationFinishHandler);
            }
         }
         this.animContainerTitle.mouseChildren = this.animContainerTitle.mouseEnabled = false;
         this.animContainerDescription.mouseChildren = this.animContainerDescription.mouseEnabled = false;
         if(this.imgBg != null)
         {
            this.imgBg.centered = true;
            this.imgBg.addEventListener(UILoaderEvent.COMPLETE,this.onImgBgCompleteHandler);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            _loc1_ = this.getMessageStateLabel();
            gotoAndPlay(_loc1_);
            this.animContainerTitle.gotoAndPlay(_loc1_);
            this.animContainerDescription.gotoAndPlay(_loc1_);
            this.animContainerDescription.maxLinesNumber = 2;
            this.animContainerBtnContinue.gotoAndPlay(_loc1_);
         }
         if(this._messageData != null && isInvalid(InvalidationType.DATA))
         {
            this.updateContent();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this.imgBg != null)
            {
               _loc2_ = 0;
               _loc3_ = 0;
               _loc4_ = BACKGROUND_WIDTH / BACKGROUND_HEIGHT;
               _loc5_ = width / height;
               if(_loc5_ >= _loc4_)
               {
                  _loc2_ = width;
                  _loc3_ = Math.round(_loc2_ / _loc4_);
               }
               else if(_loc5_ < _loc4_)
               {
                  _loc3_ = height;
                  _loc2_ = Math.round(_loc3_ * _loc4_);
               }
               this.imgBg.setSize(_loc2_,_loc3_);
            }
            this.animContainerBtnContinue.y = (height >> 1) - BTN_CONTINUE_PADDING;
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeTween();
         this.animContainerTitle.dispose();
         this.animContainerTitle = null;
         this.animContainerDescription.dispose();
         this.animContainerDescription = null;
         if(this._messageShowLabelFrame != -1)
         {
            addFrameScript(this._messageShowLabelFrame,null);
         }
         if(this._messageFinishLabelFrame != -1)
         {
            addFrameScript(this._messageFinishLabelFrame,null);
         }
         if(this.iconContainer)
         {
            this.iconContainer.dispose();
            this.iconContainer = null;
         }
         if(this.imgBg != null)
         {
            this.imgBg.removeEventListener(UILoaderEvent.COMPLETE,this.onImgBgCompleteHandler);
            this.imgBg.dispose();
            this.imgBg = null;
         }
         this.black = null;
         this._messageData = null;
         this.animContainerBtnContinue.button.removeEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
         this.animContainerBtnContinue.dispose();
         this.animContainerBtnContinue = null;
         super.onDispose();
      }
      
      public function getFocusTarget() : InteractiveObject
      {
         return this.animContainerBtnContinue.button;
      }
      
      public function setMessageData(param1:MessageContentVO) : void
      {
         this._messageData = param1;
         this._messageStateLabel = IN_STATE;
         invalidateData();
         invalidateState();
      }
      
      public function tryToClose() : void
      {
         if(this._messageStateLabel != OUT_STATE)
         {
            this.setOutState();
         }
      }
      
      protected function getMessageStateLabel() : String
      {
         return this._messageStateLabel;
      }
      
      protected function setOutState() : void
      {
         if(!_baseDisposed)
         {
            dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_DISAPPEAR));
            this._messageStateLabel = OUT_STATE;
            invalidateState();
         }
      }
      
      protected function setExecuteState(param1:Boolean) : void
      {
         if(!_baseDisposed)
         {
            if(param1)
            {
               dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_EXECUTED));
            }
            this._messageStateLabel = ACCEPT_STATE;
            invalidateState();
         }
      }
      
      protected function setDescription() : void
      {
         this.animContainerDescription.text = this._messageData.message;
         this.animContainerDescription.maxLinesNumber = 2;
      }
      
      protected function updateContent() : void
      {
         this.animContainerTitle.text = this._messageData.label;
         this.setDescription();
         this.animContainerBtnContinue.text = BOOTCAMP.BTN_CONTINUE;
         if(this.iconContainer && StringUtils.isNotEmpty(this._messageData.iconPath))
         {
            this.iconContainer.source = this._messageData.iconPath;
         }
         if(this.imgBg && StringUtils.isNotEmpty(this._messageData.background))
         {
            this.imgBg.source = this._messageData.background;
         }
      }
      
      private function disposeTween() : void
      {
         if(this._outTween)
         {
            this._outTween.onComplete = null;
            this._outTween.onChange = null;
            this._outTween.paused = true;
            this._outTween.dispose();
            this._outTween = null;
         }
      }
      
      protected function onPressAnyKeyHandler() : void
      {
         stop();
         this.animContainerBtnContinue.button.addEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
      }
      
      protected function onAnimationFinish() : void
      {
         dispatchEvent(new MessageViewEvent(MessageViewEvent.MESSAGE_REMOVED));
      }
      
      private function onAnimationFinishHandler() : void
      {
         this.onAnimationFinish();
      }
      
      protected function get messageData() : MessageContentVO
      {
         return this._messageData;
      }
      
      private function onBtnContinueClickHandler(param1:Event) : void
      {
         this.animContainerBtnContinue.button.removeEventListener(ButtonEvent.CLICK,this.onBtnContinueClickHandler);
         this.setOutState();
      }
      
      private function onImgBgCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
