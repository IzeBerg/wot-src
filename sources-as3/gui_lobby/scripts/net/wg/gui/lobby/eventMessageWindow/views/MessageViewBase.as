package net.wg.gui.lobby.eventMessageWindow.views
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.gui.bootcamp.controls.LoaderContainer;
   import net.wg.gui.bootcamp.interfaces.IAnimatedMovieClip;
   import net.wg.gui.lobby.eventMessageWindow.data.MessageContentResult;
   import net.wg.gui.lobby.eventMessageWindow.data.MessageContentVO;
   import net.wg.gui.lobby.eventMessageWindow.events.EventMessageWindowEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.exceptions.AbstractException;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MessageViewBase extends UIComponentEx
   {
      
      protected static const IN_STATE:String = "in";
      
      protected static const OUT_STATE:String = "out";
      
      protected static const ACCEPT_STATE:String = "accept";
      
      private static const SCREEN_SIZE_FIX:int = 1;
      
      private static const MONEY_PADDING_RIGHT:int = 6;
      
      private static const MONEY_PADDING_TOP:int = 8;
       
      
      public var animContainerTitle:IAnimatedMovieClip = null;
      
      public var animContainerDescription:IAnimatedMovieClip = null;
      
      public var money:TextField;
      
      public var iconContainer:LoaderContainer = null;
      
      public var black:MovieClip = null;
      
      protected var _messageData:MessageContentVO = null;
      
      private var _frameHelper:FrameHelper = null;
      
      private var _isPlayingOutro:Boolean = false;
      
      private var _result:int;
      
      private var _messageStateLabel:String = "";
      
      private var _moneyValue:String = "";
      
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
         if(this.money != null)
         {
            this.alignMoney();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._frameHelper = new FrameHelper(this);
         this._frameHelper.addScriptToFrame(totalFrames - 1,this.onAnimationFinishHandler);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(IN_STATE),this.onReachedInLabelHandler);
         this._frameHelper.addScriptToFrame(this._frameHelper.getFrameByLabel(OUT_STATE),this.onReachedOutLabelHandler);
         this.animContainerTitle.mouseChildren = this.animContainerTitle.mouseEnabled = false;
         this.animContainerDescription.mouseChildren = this.animContainerDescription.mouseEnabled = false;
         if(this.money != null)
         {
            this.money.autoSize = TextFieldAutoSize.LEFT;
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            gotoAndPlay(this._messageStateLabel);
         }
         if(this._messageData != null && isInvalid(InvalidationType.DATA))
         {
            this.updateContent();
         }
      }
      
      override protected function onDispose() : void
      {
         this.animContainerTitle.dispose();
         this.animContainerTitle = null;
         this.animContainerDescription.dispose();
         this.animContainerDescription = null;
         this._frameHelper.dispose();
         this._frameHelper = null;
         addFrameScript(totalFrames - 1,null);
         if(this.iconContainer)
         {
            this.iconContainer.dispose();
            this.iconContainer = null;
         }
         this.money = null;
         this.black = null;
         this._messageData = null;
         super.onDispose();
      }
      
      public function getFocusTarget() : InteractiveObject
      {
         throw new AbstractException("MessageViewBase.getFocusTarget" + Errors.ABSTRACT_INVOKE);
      }
      
      public function handleCancel() : void
      {
         if(_baseDisposed || this._isPlayingOutro)
         {
            return;
         }
         this._result = MessageContentResult.CANCEL;
         this._messageStateLabel = OUT_STATE;
         this.playOutroAnimationStarted();
         invalidateState();
      }
      
      public function setData(param1:MessageContentVO) : void
      {
         this._messageData = param1;
         invalidateData();
         if(StringUtils.isEmpty(this._messageStateLabel))
         {
            this._messageStateLabel = IN_STATE;
            invalidateState();
         }
      }
      
      public function tryToClose() : void
      {
         if(this._messageStateLabel != OUT_STATE)
         {
            this.handleCancel();
         }
      }
      
      protected function playOutroAnimationStarted() : void
      {
         this._isPlayingOutro = true;
         dispatchEvent(new EventMessageWindowEvent(EventMessageWindowEvent.ON_OUTRO_ANIMATION_STARTED));
      }
      
      protected function alignMoney() : void
      {
         this.money.y = MONEY_PADDING_TOP - (_height >> 1);
         this.money.x = (_width >> 1) - this.money.width - MONEY_PADDING_RIGHT | 0;
      }
      
      protected function handleConfirm() : void
      {
         if(_baseDisposed || this._isPlayingOutro)
         {
            return;
         }
         this._result = MessageContentResult.OK;
         this._messageStateLabel = ACCEPT_STATE;
         this.playOutroAnimationStarted();
         invalidateState();
      }
      
      protected function updateContent() : void
      {
         this.animContainerTitle.text = this._messageData.label;
         this.animContainerDescription.text = this._messageData.message;
         if(this.iconContainer && StringUtils.isNotEmpty(this._messageData.iconPath))
         {
            this.iconContainer.source = this._messageData.iconPath;
         }
         if(this.money != null && this._moneyValue != this._messageData.money)
         {
            this._moneyValue = this._messageData.money;
            this.money.htmlText = this._moneyValue;
            this.alignMoney();
         }
      }
      
      protected function onAnimationFinishHandler() : void
      {
         dispatchEvent(new EventMessageWindowEvent(EventMessageWindowEvent.RESULT,this._result));
      }
      
      protected function onReachedOutLabelHandler() : void
      {
         this.animContainerTitle.gotoAndPlay(OUT_STATE);
         this.animContainerDescription.gotoAndPlay(OUT_STATE);
      }
      
      protected function onReachedInLabelHandler() : void
      {
         this.animContainerTitle.gotoAndPlay(IN_STATE);
         this.animContainerDescription.gotoAndPlay(IN_STATE);
      }
   }
}
