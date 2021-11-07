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
      
      public static const PRESHOWANIM_MES:int = 3;
      
      public static const ANIM_MES:int = 4;
      
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
      
      private static const INVALID_X_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      private static const INVALID_Y_POSITION:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
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
      
      private var _alphaCurrentStep:int = 0;
      
      private var _currentStateId:int = -1;
      
      private var _isHidingState:Boolean = false;
      
      private var _lastMessageAlpha:Number = -1;
      
      private var _recoveredLatestMessagesAlpha:Number = -1;
      
      private var _recoveredMessagesLifeTime:int = -1;
      
      private var _scheduler:IScheduler;
      
      private var _atlasManager:IAtlasManager;
      
      private var _textFormat:TextFormat;
      
      private var _isHidingShowState:Boolean = false;
      
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
            else if(this._currentStateId == HIDDEN_MES)
            {
               this.clear();
               this.updateMessageElements(this._recoveredLatestMessagesAlpha,false);
            }
            else if(this._currentStateId == PRESHOWANIM_MES)
            {
               this.clear();
               this.updateMessageElements(0,true);
               this._alphaCurrentStep = 0;
               this._scheduler.scheduleRepeatableTask(this.showAnimation,ANIM_SHOW_INTERVAL,ANIM_SHOW_STEPS);
               if(this._isHidingShowState)
               {
                  if(this._lifeTime > 0)
                  {
                     this._scheduler.scheduleTask(this.onEndLifeHandler,this._lifeTime);
                  }
                  this._isHidingState = true;
               }
            }
         }
         if(isInvalid(INVALID_X_POSITION))
         {
            this.messageField.x = this._x + TEXT_OFFSET_X;
            this.background.x = this._x;
         }
         if(isInvalid(INVALID_Y_POSITION))
         {
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
         if(isInvalid(INVALID_MESSAGES_SIZE))
         {
            this.updateMessageSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.clear();
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
      
      public function clear() : void
      {
         this._scheduler.cancelTask(this.showAnimation);
         this.hidingState = false;
         this._isEnterFrameEnable = false;
      }
      
      public function close() : void
      {
         this.clear();
         this._deleteFromPoolFunc(this);
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
            invalidate(INVALID_MESSAGE_VISIBILITY);
         }
      }
      
      public function show(param1:Boolean) : void
      {
         this._isHidingShowState = param1;
         this.setState(PRESHOWANIM_MES,true);
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
         this.background.height = this.messageField.height + TEXT_BOTTOM_PADDING | 0;
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
            this.background.height = this.messageField.height + TEXT_BOTTOM_PADDING | 0;
         }
      }
      
      private function updateMessageElements(param1:Number, param2:Boolean) : void
      {
         this.background.alpha = this.messageField.alpha = param1;
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
      
      private function showAnimation() : void
      {
         ++this._alphaCurrentStep;
         this.background.alpha += ANIM_SHOW_STEP;
         this.messageField.alpha += ANIM_SHOW_STEP;
         if(this._alphaCurrentStep == ANIM_SHOW_STEPS)
         {
            this.setState(VISIBLE_MES);
            this._scheduler.cancelTask(this.showAnimation);
         }
      }
      
      private function onEndLifeHandler() : void
      {
         if(this._fadeTime > 0)
         {
            this._endFadeTime = getTimer() + this._fadeTime;
            this.setState(ANIM_MES);
            this._isEnterFrameEnable = true;
            this._scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
         else
         {
            this.clear();
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
            this.clear();
            this.setState(HIDDEN_MES);
         }
         else
         {
            this._scheduler.scheduleOnNextFrame(this.onEnterFrameHandler);
         }
      }
      
      public function set x(param1:Number) : void
      {
         if(this._x != param1)
         {
            this._x = param1;
            invalidate(INVALID_X_POSITION);
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
            invalidate(INVALID_Y_POSITION);
         }
      }
      
      public function set fadeTime(param1:int) : void
      {
         this._fadeTime = param1;
         this._inverseFadeTime = 1 / this._fadeTime;
      }
      
      public function set hidingState(param1:Boolean) : void
      {
         if(this._isHidingState != param1)
         {
            this._isHidingState = param1;
            if(this._isHidingState)
            {
               if(this._recoveredMessagesLifeTime > 0)
               {
                  this._scheduler.scheduleTask(this.onEndLifeHandler,this._recoveredMessagesLifeTime);
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
