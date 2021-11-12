package net.wg.gui.battle.views.battleMessenger
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import net.wg.data.constants.Fonts;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.battle.components.BattleUIComponentsHolder;
   import net.wg.infrastructure.managers.IAtlasManager;
   import net.wg.utils.IScheduler;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleMessage extends BattleUIComponentsHolder
   {
      
      public static const DEFAULT_TEXT_WIDTH:int = 360;
      
      public static const SMALL_TEXT_WIDTH:int = 185;
      
      public static const DEFAULT_TEXT_LINE_SPACING:int = 2;
      
      public static const DEFAULT_TEXT_SIZE:int = 14;
      
      public static const YELLOW_TEXT_COLOR:int = 16774325;
      
      public static const GREEN_TEXT_COLOR:int = 7653168;
      
      public static const RED_TEXT_COLOR:int = 14753553;
      
      public static const RECOVERED_MES:int = 0;
      
      public static const HIDEHALF_MES:int = 1;
      
      public static const HIDDEN_MES:int = 2;
      
      public static const FADE_IN_MES:int = 3;
      
      public static const FADE_OUT_MES:int = 4;
      
      public static const VISIBLE_MES:int = 5;
      
      public static const VISIBLE_WHEEL_MES:int = 6;
      
      public static const TEXT_RIGHT_PADDING:int = 40;
      
      public static const TEXT_BOTTOM_PADDING:int = 5;
      
      public static const ANIM_SHOW_INTERVAL:int = 5;
      
      public static const ANIM_SHOW_STEPS:int = 100;
      
      public static const ANIM_SHOW_STEP:Number = 0.01;
      
      public static const TEXT_HEIGHT_OFFSET:int = 4;
      
      public static const TEXT_OFFSET_X:int = 5;
      
      public static const TEXT_OFFSET_Y:int = 2;
      
      public static const RECT_X:int = 6;
      
      public static const RECT_Y:int = 9;
      
      public static const RECT_WIDTH:int = 310;
      
      public static const RECT_HEIGHT:int = 7;
      
      public static const PLAYER_GREEN_MESSAGE_LEFT_RENDERER:String = "PlayerGreenMessageLeftRenderer";
      
      public static const PLAYER_RED_MESSAGE_LEFT_RENDERER:String = "PlayerRedMessageLeftRenderer";
      
      private static const INVALID_MESSAGE_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALID_MESSAGES_SIZE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const USER_INTERACTION_TIMER_BY_MILLISECONDS:int = 100;
      
      private static const DEFAULT_MESSAGE_Y_PADDING:int = 2;
      
      private static const ADDITIONAL_TF_PADDING:int = 28;
       
      
      public var messageField:TextField;
      
      public var background:Sprite;
      
      public var messageID:String = "";
      
      public var isOpenedToxicPanel:Boolean = false;
      
      private var _endFadeTime:int = -1;
      
      private var _lifeTime:int = -1;
      
      private var _inverseFadeTime:Number = -1;
      
      private var _deleteFromPoolFunc:Function = null;
      
      private var _currentStateId:int = -1;
      
      private var _isWaitingAutoHide:Boolean = false;
      
      private var _lastMessageAlpha:Number = -1;
      
      private var _recoveredLatestMessagesAlpha:Number = -1;
      
      private var _recoveredMessagesLifeTime:int = -1;
      
      private var _scheduler:IScheduler;
      
      private var _atlasManager:IAtlasManager;
      
      private var _textFormat:TextFormat;
      
      private var _isEnterFrameEnable:Boolean = false;
      
      private var _timerID:uint = 0;
      
      private var _userInteractionCallback:Function = null;
      
      private var _x:Number = -1;
      
      private var _y:Number = -1;
      
      private var _fadeTime:int = -1;
      
      private var _messageText:String = "";
      
      private var _isBlockedMessage:Boolean = false;
      
      private var _availableWidth:int = 360;
      
      public function BattleMessage(param1:int, param2:int, param3:Number, param4:Number, param5:int, param6:Function, param7:Function = null)
      {
         this.messageField = new TextField();
         this.background = new Sprite();
         this._scheduler = App.utils.scheduler;
         this._atlasManager = App.atlasMgr;
         this._textFormat = new TextFormat();
         super();
         this._userInteractionCallback = param7;
         this._deleteFromPoolFunc = param6;
         this._lifeTime = param1;
         this._lastMessageAlpha = param3;
         this._recoveredLatestMessagesAlpha = param4;
         this._recoveredMessagesLifeTime = param5;
         this.fadeTime = param2;
         this._textFormat.font = Fonts.FIELD_FONT;
         this._textFormat.size = DEFAULT_TEXT_SIZE;
         this._textFormat.leading = DEFAULT_TEXT_LINE_SPACING;
         this.messageField.multiline = true;
         this.messageField.mouseEnabled = false;
         App.utils.commons.setShadowFilterWithParams(this.messageField,1,90,0,1,2,2,1.2,BitmapFilterQuality.MEDIUM);
         this.messageField.wordWrap = true;
         TextFieldEx.setNoTranslate(this.messageField,true);
         this.backgroundAddListeners();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_MESSAGE_VISIBILITY))
         {
            this.applyState();
         }
         if(isInvalid(INVALID_MESSAGES_SIZE))
         {
            this.updateMessageSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearAnim();
         this.backgroundRemoveListeners();
         this._deleteFromPoolFunc = null;
         this.messageField = null;
         this.background = null;
         this._scheduler = null;
         this._atlasManager = null;
         this._textFormat = null;
         this._userInteractionCallback = null;
         super.onDispose();
      }
      
      public function clearAnim() : void
      {
         this._scheduler.cancelTask(this.fadeInAnimation);
         this.isWaitingAutoHide = false;
         this._scheduler.cancelTask(this.onEnterFrameHandler);
         this._isEnterFrameEnable = false;
      }
      
      public function close() : void
      {
         this.clearAnim();
         this._deleteFromPoolFunc(this);
      }
      
      public function getState() : int
      {
         return this._currentStateId;
      }
      
      public function restoreMessage() : void
      {
         this._isBlockedMessage = false;
         this.messageField.multiline = this.messageField.wordWrap = true;
         this.updateData(this._messageText);
         this.messageField.y = this.background.y + DEFAULT_MESSAGE_Y_PADDING;
      }
      
      public function setAvailableWidth(param1:int) : void
      {
         if(param1 > DEFAULT_TEXT_WIDTH)
         {
            this._availableWidth = DEFAULT_TEXT_WIDTH;
         }
         else
         {
            this._availableWidth = param1 < SMALL_TEXT_WIDTH ? int(SMALL_TEXT_WIDTH) : int(param1);
         }
         invalidate(INVALID_MESSAGES_SIZE);
      }
      
      public function setBlockMessage(param1:String) : void
      {
         this._isBlockedMessage = true;
         this.messageField.multiline = this.messageField.wordWrap = false;
         this.updateData(param1,true,false);
         this.setYPositionByCenter();
      }
      
      public function setMessageData(param1:String) : void
      {
         this._isBlockedMessage = false;
         this.messageField.multiline = this.messageField.wordWrap = true;
         this._messageText = param1;
         this.updateData(this._messageText);
      }
      
      public function setRenderer(param1:String) : void
      {
         this._atlasManager.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1,this.background.graphics,Values.EMPTY_STR,false,true);
         this.background.scale9Grid = new Rectangle(RECT_X,RECT_Y,RECT_WIDTH,RECT_HEIGHT);
         this.updateTextFieldProperties(param1);
      }
      
      public function setState(param1:int, param2:Boolean = false) : void
      {
         if(this._currentStateId != param1 || param2)
         {
            this._currentStateId = param1;
            if(param2)
            {
               this.applyState();
            }
            else
            {
               invalidate(INVALID_MESSAGE_VISIBILITY);
            }
         }
      }
      
      public function show(param1:Boolean) : void
      {
         this.setState(FADE_IN_MES,true);
         if(param1 && this._lifeTime > 0)
         {
            this.setWaitingAutoHideTime(this._lifeTime);
         }
      }
      
      private function applyState() : void
      {
         if(this._currentStateId == VISIBLE_MES)
         {
            this.updateMessageElements(Values.DEFAULT_ALPHA,true);
            this.backgroundAddListeners(true);
         }
         else if(this._currentStateId == VISIBLE_WHEEL_MES)
         {
            this.updateMessageElements(Values.DEFAULT_ALPHA,true);
            this.backgroundAddListeners();
         }
         else if(this._currentStateId == RECOVERED_MES)
         {
            this.backgroundRemoveListeners();
            this.updateMessageElements(this._recoveredLatestMessagesAlpha,true);
         }
         else if(this._currentStateId == HIDEHALF_MES)
         {
            this.updateMessageElements(this._lastMessageAlpha,true);
            this.backgroundAddListeners();
         }
         else if(this._currentStateId == FADE_OUT_MES)
         {
            this.clearAnim();
            this.onEndLifeHandler();
         }
         else if(this._currentStateId == HIDDEN_MES)
         {
            this.hideMes();
         }
         else if(this._currentStateId == FADE_IN_MES)
         {
            this.clearAnim();
            this.updateMessageElements(0,true);
            this._scheduler.scheduleRepeatableTask(this.fadeInAnimation,ANIM_SHOW_INTERVAL,ANIM_SHOW_STEPS);
         }
      }
      
      private function hideMes() : void
      {
         this.clearAnim();
         this.updateMessageElements(this._recoveredLatestMessagesAlpha,false);
      }
      
      private function updateMessageSize() : void
      {
         this.messageField.width = this._availableWidth;
         this.messageField.height = this.messageField.textHeight + TEXT_HEIGHT_OFFSET | 0;
         App.utils.commons.updateTextFieldSize(this.messageField,true,false);
         this.background.width = this.messageField.textWidth + TEXT_RIGHT_PADDING | 0;
         if(this.isOpenedToxicPanel)
         {
            this.background.width += ADDITIONAL_TF_PADDING;
         }
         this.background.height = this.getBackgroundHeight();
      }
      
      private function setYPositionByCenter() : void
      {
         this.messageField.y = this.background.y + (this.background.height - this.messageField.height >> 1);
      }
      
      private function updateData(param1:String, param2:Boolean = true, param3:Boolean = true) : void
      {
         this.messageField.width = this._availableWidth;
         this.messageField.htmlText = param1;
         this.messageField.height = this.messageField.textHeight + TEXT_HEIGHT_OFFSET | 0;
         App.utils.commons.updateTextFieldSize(this.messageField,true,false);
         if(param2)
         {
            this.background.width = this.messageField.textWidth + TEXT_RIGHT_PADDING | 0;
            if(this.isOpenedToxicPanel)
            {
               this.background.width += ADDITIONAL_TF_PADDING;
            }
         }
         if(param3)
         {
            this.background.height = this.getBackgroundHeight();
         }
      }
      
      private function getBackgroundHeight() : Number
      {
         return this.messageField.height + TEXT_BOTTOM_PADDING | 0;
      }
      
      private function updateMessageElements(param1:Number, param2:Boolean) : void
      {
         this.alpha = param1;
         this.background.visible = this.messageField.visible = param2;
      }
      
      private function backgroundAddListeners(param1:Boolean = false) : void
      {
         if(param1 && this.background.hitTestPoint(App.stage.mouseX,App.stage.mouseY,false))
         {
            this._timerID = setTimeout(this.updateUserInteraction,USER_INTERACTION_TIMER_BY_MILLISECONDS);
         }
         this.background.addEventListener(MouseEvent.ROLL_OVER,this.onBackgroundRollOverHandler);
         this.background.addEventListener(MouseEvent.ROLL_OUT,this.onBackgroundRollOutHandler);
      }
      
      private function backgroundRemoveListeners() : void
      {
         clearInterval(this._timerID);
         this.background.removeEventListener(MouseEvent.ROLL_OVER,this.onBackgroundRollOverHandler);
         this.background.removeEventListener(MouseEvent.ROLL_OUT,this.onBackgroundRollOutHandler);
      }
      
      private function updateUserInteraction() : void
      {
         if(this._userInteractionCallback != null && StringUtils.isNotEmpty(this.messageID))
         {
            this.isOpenedToxicPanel = true;
            if(this._userInteractionCallback(true,this.mouseOut,this.messageID,this.y,this.width,this.height))
            {
               this.messageField.x = this._x + TEXT_OFFSET_X + ADDITIONAL_TF_PADDING;
               this.background.width = this.messageField.textWidth + TEXT_RIGHT_PADDING + ADDITIONAL_TF_PADDING | 0;
            }
            this.backgroundRemoveListeners();
         }
         clearTimeout(this._timerID);
      }
      
      private function mouseOut() : void
      {
         this.isOpenedToxicPanel = false;
         this.messageField.x = this._x + TEXT_OFFSET_X;
         this.background.width = this.messageField.textWidth + TEXT_RIGHT_PADDING | 0;
         if(this._currentStateId != RECOVERED_MES)
         {
            this.backgroundAddListeners();
         }
      }
      
      private function updateTextFieldProperties(param1:String) : void
      {
         if(param1 == PLAYER_GREEN_MESSAGE_LEFT_RENDERER)
         {
            this._textFormat.color = GREEN_TEXT_COLOR;
         }
         else if(param1 == PLAYER_RED_MESSAGE_LEFT_RENDERER)
         {
            this._textFormat.color = RED_TEXT_COLOR;
         }
         else
         {
            this._textFormat.color = YELLOW_TEXT_COLOR;
         }
         this.messageField.defaultTextFormat = this._textFormat;
      }
      
      private function fadeInAnimation() : void
      {
         this.background.alpha += ANIM_SHOW_STEP;
         this.messageField.alpha = this.background.alpha;
         if(this.background.alpha >= 1)
         {
            this.setState(VISIBLE_MES);
            this._scheduler.cancelTask(this.fadeInAnimation);
         }
      }
      
      private function onEndLifeHandler() : void
      {
         var _loc1_:Number = NaN;
         this._currentStateId = FADE_OUT_MES;
         this._isWaitingAutoHide = false;
         if(this._fadeTime > 0)
         {
            _loc1_ = this.alpha < this._lastMessageAlpha ? Number(this.alpha * this._fadeTime) : Number(this._fadeTime);
            this._endFadeTime = getTimer() + _loc1_;
            this._isEnterFrameEnable = true;
            this._scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
         else
         {
            this.clearAnim();
            this.setState(HIDDEN_MES);
         }
      }
      
      private function onEnterFrameHandler() : void
      {
         if(!this._isEnterFrameEnable)
         {
            return;
         }
         var _loc1_:int = getTimer();
         var _loc2_:Number = (this._endFadeTime - _loc1_) * this._inverseFadeTime;
         if(_loc2_ < this.messageField.alpha)
         {
            this.messageField.alpha = _loc2_;
            this.background.alpha = _loc2_;
         }
         if(_loc2_ <= 0)
         {
            this.clearAnim();
            this.setState(HIDDEN_MES);
         }
         else
         {
            this._scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
      }
      
      private function setWaitingAutoHideTime(param1:int) : void
      {
         if(this._isWaitingAutoHide)
         {
            this._scheduler.cancelTask(this.onEndLifeHandler);
         }
         this._isWaitingAutoHide = true;
         this._scheduler.scheduleTask(this.onEndLifeHandler,param1);
      }
      
      public function get alpha() : Number
      {
         return this.background.alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this.background.alpha = this.messageField.alpha = param1;
      }
      
      public function set x(param1:Number) : void
      {
         if(this._x != param1)
         {
            this._x = param1;
            this.messageField.x = this._x + TEXT_OFFSET_X;
            this.background.x = this._x;
         }
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function set y(param1:Number) : void
      {
         if(param1 != this._y)
         {
            this._y = param1;
            this.background.y = this._y;
            if(this._isBlockedMessage)
            {
               this.setYPositionByCenter();
            }
            else
            {
               this.messageField.y = this._y + TEXT_OFFSET_Y;
            }
         }
      }
      
      public function set fadeTime(param1:int) : void
      {
         this._fadeTime = param1;
         this._inverseFadeTime = 1 / this._fadeTime;
      }
      
      public function set isWaitingAutoHide(param1:Boolean) : void
      {
         if(this._isWaitingAutoHide != param1)
         {
            this._isWaitingAutoHide = param1;
            if(this._isWaitingAutoHide)
            {
               if(this._recoveredMessagesLifeTime > 0)
               {
                  this.setWaitingAutoHideTime(this._recoveredMessagesLifeTime);
               }
            }
            else
            {
               this._scheduler.cancelTask(this.onEndLifeHandler);
            }
         }
      }
      
      public function get width() : Number
      {
         return this.background.width;
      }
      
      public function get height() : Number
      {
         return this.background.height;
      }
      
      private function onBackgroundRollOutHandler(param1:MouseEvent) : void
      {
         if(this._userInteractionCallback != null)
         {
            this._userInteractionCallback(false,this.mouseOut);
         }
         clearTimeout(this._timerID);
      }
      
      private function onBackgroundRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this.messageID))
         {
            this._timerID = setTimeout(this.updateUserInteraction,USER_INTERACTION_TIMER_BY_MILLISECONDS);
         }
      }
   }
}
