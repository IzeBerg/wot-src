package net.wg.gui.battle.views.prebattleTimer
{
   import flash.display.FrameLabel;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.PREBATTLE_TIMER;
   import net.wg.gui.battle.components.preBattleTimer.TimerAnim;
   import net.wg.gui.battle.interfaces.IPrebattleTimerBase;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.meta.IPrebattleTimerBaseMeta;
   import net.wg.infrastructure.base.meta.impl.PrebattleTimerBaseMeta;
   
   public class PrebattleTimerBase extends PrebattleTimerBaseMeta implements IPrebattleTimerBase, IPrebattleTimerBaseMeta
   {
      
      protected static const INVALID_COMPONENT_VISIBILITY:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      protected static const INVALID_RESET_HIDE_ANIM:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
      
      protected static const INVALID_WIN_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 3;
      
      private static const INVALID_MESSAGE_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 4;
      
      private static const INVALID_TIME_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 5;
      
      private static const FRAME_LABEL_INIT:String = "init";
      
      private static const FRAME_LABEL_HIDE:String = "hide";
      
      private static const FRAME_LABEL_HIDE_COMPLETED:String = "hideCompleted";
      
      private static const TIMER_LARGE_SCALE:Number = 1;
      
      private static const TIMER_SMALL_SCALE:Number = 0.75;
      
      private static const TIMER_LARGE_Y:int = -14;
      
      private static const TIMER_SMALL_Y:int = 25;
      
      private static const SMALL_STATE:String = "smallState";
      
      private static const LARGE_STATE:String = "largeState";
       
      
      public var message:TextFieldContainer = null;
      
      public var win:TextFieldContainer = null;
      
      public var background:PrebattleTimerBg = null;
      
      public var timer:TimerAnim = null;
      
      private var _componentVisibility:Boolean = false;
      
      private var _hideAnimProgress:Boolean = false;
      
      private var _timerDirty:Boolean = false;
      
      private var _totalTime:Number = -1;
      
      private var _winMessageText:String = "";
      
      private var _messageText:String = "";
      
      private var _frameHelper:FrameHelper = null;
      
      private var _currentState:String = null;
      
      private var _isNeedWinChangePosition:Boolean = true;
      
      private var _isBackgroundHidden:Boolean = false;
      
      private var _isDescriptionHidden:Boolean = false;
      
      private var _isDirtyCompVisible:Boolean = false;
      
      public function PrebattleTimerBase()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
         this.initFramesScript();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.message.noTranslateTextfield = true;
         this.win.noTranslateTextfield = true;
      }
      
      override protected function onDispose() : void
      {
         this._frameHelper.dispose();
         this._frameHelper = null;
         this.timer.dispose();
         this.timer = null;
         this.message.dispose();
         this.message = null;
         this.win.dispose();
         this.win = null;
         this.background.dispose();
         this.background = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:String = null;
         super.draw();
         if(isInvalid(INVALID_COMPONENT_VISIBILITY))
         {
            this.doComponentVisibility(this._componentVisibility);
            if(this._componentVisibility)
            {
               invalidateSize();
            }
         }
         if(this._timerDirty && isInvalid(INVALID_RESET_HIDE_ANIM))
         {
            this._timerDirty = false;
            this.doResetHideAnim();
         }
         if(isInvalid(INVALID_MESSAGE_TF))
         {
            this.message.label = this._messageText;
            invalidateSize();
         }
         if(isInvalid(INVALID_WIN_TF))
         {
            this.win.label = this._winMessageText;
         }
         if(this._totalTime != Values.DEFAULT_INT && isInvalid(INVALID_TIME_TF))
         {
            this.timer.setTime(this._totalTime,false);
         }
         if(this._isNeedWinChangePosition && isInvalid(InvalidationType.SIZE))
         {
            this.win.y = this.message.y + this.message.height | 0;
            _loc1_ = App.appHeight <= PREBATTLE_TIMER.APP_MIN_HEIGHT_BREAKING;
            _loc2_ = !!_loc1_ ? SMALL_STATE : LARGE_STATE;
            if(_loc2_ != this._currentState)
            {
               this._currentState = _loc2_;
               this.doUpdateSize(_loc1_);
            }
         }
      }
      
      public function as_hideAll(param1:Boolean) : void
      {
         this.hideComponent(param1);
      }
      
      public function as_setMessage(param1:String) : void
      {
         if(this._messageText != param1)
         {
            this._messageText = param1;
            invalidate(INVALID_MESSAGE_TF);
         }
      }
      
      public function as_setTimer(param1:int) : void
      {
         this._totalTime = param1;
         invalidate(INVALID_TIME_TF);
         if(this._hideAnimProgress || !this._componentVisibility)
         {
            this._componentVisibility = true;
            this._hideAnimProgress = false;
            this._timerDirty = true;
            invalidate(INVALID_RESET_HIDE_ANIM | INVALID_COMPONENT_VISIBILITY);
         }
      }
      
      public function as_setWinConditionText(param1:String) : void
      {
         if(this._winMessageText != param1)
         {
            this._winMessageText = param1;
            invalidate(INVALID_WIN_TF);
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.background.updateSize(param1,param2);
         invalidateSize();
      }
      
      public function showBackground() : void
      {
         this._isBackgroundHidden = false;
         this.background.visible = this._isDirtyCompVisible;
      }
      
      public function showDescription() : void
      {
         this._isDescriptionHidden = false;
         this.win.visible = this.message.visible = this._isDirtyCompVisible;
      }
      
      public function hideBackground() : void
      {
         this._isBackgroundHidden = true;
         this.background.visible = false;
      }
      
      public function hideDescription() : void
      {
         this._isDescriptionHidden = true;
         this.win.visible = this.message.visible = false;
      }
      
      protected function doUpdateSize(param1:Boolean) : void
      {
         this.timer.scaleX = this.timer.scaleY = !!param1 ? Number(TIMER_SMALL_SCALE) : Number(TIMER_LARGE_SCALE);
         this.timer.y = !!param1 ? Number(TIMER_SMALL_Y) : Number(TIMER_LARGE_Y);
      }
      
      protected function doResetHideAnim() : void
      {
         this.gotoAndStop(FRAME_LABEL_INIT);
      }
      
      protected function doComponentVisibility(param1:Boolean) : void
      {
         this.win.visible = this.message.visible = !this._isDescriptionHidden && param1;
         this.timer.visible = param1;
         this.background.visible = !!this._isBackgroundHidden ? Boolean(false) : Boolean(param1);
         this._isDirtyCompVisible = param1;
         if(!param1)
         {
            dispatchEvent(new PrebattleTimerEvent(PrebattleTimerEvent.START_HIDING,false));
         }
      }
      
      protected function hideComponent(param1:Boolean) : void
      {
         if(param1)
         {
            this._hideAnimProgress = true;
            gotoAndPlay(FRAME_LABEL_HIDE);
         }
         else
         {
            this._hideAnimProgress = false;
            gotoAndStop(FRAME_LABEL_HIDE_COMPLETED);
         }
         dispatchEvent(new PrebattleTimerEvent(PrebattleTimerEvent.START_HIDING,param1));
      }
      
      protected final function hideFinalize() : void
      {
         this._componentVisibility = false;
         invalidate(INVALID_COMPONENT_VISIBILITY);
      }
      
      protected function initFramesScript() : void
      {
         var _loc3_:FrameLabel = null;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            this.addScriptFrame(this._frameHelper,_loc3_.name,_loc3_.frame);
            _loc4_++;
         }
      }
      
      protected function addScriptFrame(param1:FrameHelper, param2:String, param3:int) : void
      {
         if(param2 == FRAME_LABEL_HIDE_COMPLETED)
         {
            param1.addScriptToFrame(param3,this.onHideCompleted);
         }
      }
      
      private function onHideCompleted() : void
      {
         stop();
         this._hideAnimProgress = false;
         this.hideFinalize();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         this.timer.ownerVisibleChange(param1);
         super.visible = param1;
      }
      
      public function get componentVisibility() : Boolean
      {
         return this._componentVisibility;
      }
      
      public function set isNeedWinChangePosition(param1:Boolean) : void
      {
         this._isNeedWinChangePosition = param1;
      }
   }
}
