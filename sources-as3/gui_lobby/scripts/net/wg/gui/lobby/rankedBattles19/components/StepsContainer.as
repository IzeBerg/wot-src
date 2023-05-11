package net.wg.gui.lobby.rankedBattles19.components
{
   import fl.motion.easing.Cubic;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IStepArrow;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IStepsContainer;
   import net.wg.gui.lobby.rankedBattles19.data.StepsContainerVO;
   import net.wg.gui.lobby.rankedBattles19.events.StepEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class StepsContainer extends UIComponentEx implements IStepsContainer
   {
      
      public static const TWEEN_TIME:int = 400;
      
      public static const DELAY_TIME:int = 50;
      
      private static const SMALL_STEPS_GAP:int = 10;
      
      private static const MEDIUM_STEPS_GAP:int = 15;
      
      private static const HUGE_STEPS_GAP:int = 33;
      
      private static const HIDED_STEPS_OFFSET:int = -20;
      
      private static const SMALL_COUNT_TF_Y:int = 1;
      
      private static const MEDIUM_COUNT_TF_Y:int = 12;
      
      private static const HUGE_COUNT_TF_Y:int = 23;
      
      private static const STEPS_GAPS:Object = {};
      
      private static const COUNT_TF_YS:Object = {};
      
      private static const STEPS_WIDTH:Object = {};
      
      private static const EMPTY_BORDER_WIDTH:Object = {};
      
      private static const STEP_WIDTH_SMALL:Number = 14;
      
      private static const STEP_WIDTH_MEDIUM:Number = 16;
      
      private static const STEP_WIDTH_HUGE:Number = 48;
      
      private static const EMPTY_BORDER_WIDTH_SMALL:Number = 27;
      
      private static const EMPTY_BORDER_WIDTH_MEDIUM:Number = 36;
      
      private static const EMPTY_BORDER_WIDTH_HUGE:Number = 70;
       
      
      public var hit:Sprite = null;
      
      protected var model:StepsContainerVO = null;
      
      private var _stepIdxForAnim:int = 0;
      
      private var _steps:Vector.<IStepArrow> = null;
      
      private var _tweens:Vector.<Tween>;
      
      private var _containerSize:String = "";
      
      private var _useButtonMode:Boolean = false;
      
      private var _stepsLength:int = -1;
      
      public function StepsContainer()
      {
         this._tweens = new Vector.<Tween>(0);
         super();
         STEPS_GAPS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = SMALL_STEPS_GAP;
         STEPS_GAPS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = MEDIUM_STEPS_GAP;
         STEPS_GAPS[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = HUGE_STEPS_GAP;
         COUNT_TF_YS[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = SMALL_COUNT_TF_Y;
         COUNT_TF_YS[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = MEDIUM_COUNT_TF_Y;
         COUNT_TF_YS[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = HUGE_COUNT_TF_Y;
         STEPS_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = STEP_WIDTH_SMALL;
         STEPS_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = STEP_WIDTH_MEDIUM;
         STEPS_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = STEP_WIDTH_HUGE;
         EMPTY_BORDER_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_SMALL] = EMPTY_BORDER_WIDTH_SMALL;
         EMPTY_BORDER_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_MEDIUM] = EMPTY_BORDER_WIDTH_MEDIUM;
         EMPTY_BORDER_WIDTH[RANKEDBATTLES_ALIASES.WIDGET_HUGE] = EMPTY_BORDER_WIDTH_HUGE;
      }
      
      override protected function onBeforeDispose() : void
      {
         this.tryDisposeSteps();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.hit = null;
         this._tweens = null;
         this.model = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.model != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.createSteps();
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.calcSize();
            }
         }
      }
      
      public function getStepsState() : String
      {
         var _loc2_:String = null;
         var _loc1_:String = Values.EMPTY_STR;
         if(this.model)
         {
            for each(_loc2_ in this.model.steps)
            {
               if(RANKEDBATTLES_ALIASES.STEP_NOT_ANIMATED_STATES.indexOf(_loc2_) == Values.DEFAULT_INT)
               {
                  _loc1_ = _loc2_;
                  break;
               }
            }
         }
         return _loc1_;
      }
      
      public function runStepsHideAnimation(param1:Function = null) : void
      {
         var _loc2_:IStepArrow = null;
         var _loc3_:int = 0;
         this.tryStopTweens();
         visible = true;
         if(this._stepsLength >= 0)
         {
            _loc2_ = null;
            _loc3_ = this._stepsLength - 1;
            while(_loc3_ >= 0)
            {
               _loc2_ = this._steps[_loc3_];
               this._tweens.push(new Tween(TWEEN_TIME,_loc2_,{
                  "x":_loc2_.x - HIDED_STEPS_OFFSET,
                  "alpha":0
               },{
                  "delay":DELAY_TIME * (this._stepsLength - _loc3_),
                  "ease":Cubic.easeOut,
                  "onComplete":(_loc3_ == 0 ? param1 : null)
               }));
               _loc3_--;
            }
         }
         else if(param1 != null)
         {
            param1();
         }
      }
      
      public function runStepsShineAnimation() : void
      {
         this._stepIdxForAnim = 0;
         this.runStepsAnim();
      }
      
      public function runStepsShowAnimation(param1:Function = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.tryStopTweens();
         this.setStepsToZeroPosition();
         visible = true;
         if(this._stepsLength > 0)
         {
            _loc2_ = STEPS_GAPS[this._containerSize];
            _loc3_ = this._stepsLength - 1;
            while(_loc3_ >= 0)
            {
               this._steps[_loc3_].alpha = 0;
               this._tweens.push(new Tween(TWEEN_TIME,this._steps[_loc3_],{
                  "x":_loc2_ * _loc3_,
                  "alpha":1
               },{
                  "delay":DELAY_TIME * (this._stepsLength - _loc3_),
                  "ease":Cubic.easeOut,
                  "onComplete":(_loc3_ == 0 ? param1 : null)
               }));
               _loc3_--;
            }
         }
         else
         {
            param1();
         }
      }
      
      public function setData(param1:StepsContainerVO) : void
      {
         this.model = param1;
         invalidateData();
      }
      
      public function tryDisposeSteps() : void
      {
         var _loc1_:IStepArrow = null;
         this.tryStopTweens();
         if(this._steps != null)
         {
            for each(_loc1_ in this._steps)
            {
               _loc1_.removeEventListener(StepEvent.STEP_READY,this.onStepStepReadyHandler);
               _loc1_.stop();
               _loc1_.dispose();
               removeChild(DisplayObject(_loc1_));
            }
            this._steps.splice(0,this._steps.length);
            this._steps = null;
         }
      }
      
      public function useButtonMode(param1:Boolean) : void
      {
         var _loc2_:IStepArrow = null;
         this._useButtonMode = param1;
         for each(_loc2_ in this._steps)
         {
            _loc2_.useButtonMode(param1);
         }
      }
      
      protected function runStepsAnim() : void
      {
         var _loc1_:IStepArrow = null;
         for each(_loc1_ in this._steps)
         {
            _loc1_.runAnimation();
            if(_baseDisposed)
            {
               return;
            }
         }
      }
      
      protected function allStepsReady() : void
      {
         dispatchEvent(new StepEvent(StepEvent.ALL_STEPS_READY));
      }
      
      protected function stepReadyHandler() : void
      {
         if(this._stepIdxForAnim == this._steps.length)
         {
            this.allStepsReady();
         }
      }
      
      private function tryStopTweens() : void
      {
         var _loc1_:Tween = null;
         if(this._tweens != null)
         {
            for each(_loc1_ in this._tweens)
            {
               _loc1_.paused = true;
               _loc1_.onComplete = null;
               _loc1_.dispose();
            }
            this._tweens.splice(0,this._tweens.length);
         }
      }
      
      private function calcSize() : void
      {
         var _loc1_:IStepArrow = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = STEPS_GAPS[this._containerSize];
         var _loc5_:int = 0;
         while(_loc5_ < this._stepsLength)
         {
            _loc1_ = this._steps[_loc5_];
            _loc1_.componentSize = this._containerSize;
            _loc1_.x = _loc2_;
            _loc1_.y = _loc3_;
            _loc2_ += _loc4_;
            _loc5_++;
         }
         if(this._stepsLength > 0)
         {
            this.hit.width = _loc1_.x + _loc1_.width;
            this.hit.height = _loc1_.height;
         }
      }
      
      private function createSteps() : void
      {
         this.tryDisposeSteps();
         this._steps = new Vector.<IStepArrow>(0);
         this._stepsLength = this.model.steps != null ? int(this.model.steps.length) : int(0);
         var _loc1_:IStepArrow = null;
         var _loc2_:Class = App.instance.utils.classFactory.getClass(Linkages.RANKED_BATTLES_STEP_ARROW_UI);
         var _loc3_:int = 0;
         while(_loc3_ < this._stepsLength)
         {
            _loc1_ = new _loc2_();
            _loc1_.componentSize = this._containerSize;
            _loc1_.addEventListener(StepEvent.STEP_READY,this.onStepStepReadyHandler);
            addChild(DisplayObject(_loc1_));
            _loc1_.state = this.model.steps[_loc3_];
            this._steps.push(_loc1_);
            _loc3_++;
         }
         this.useButtonMode(this._useButtonMode);
      }
      
      private function setStepsToZeroPosition() : void
      {
         var _loc1_:int = STEPS_GAPS[this._containerSize];
         var _loc2_:int = 0;
         while(_loc2_ < this._stepsLength)
         {
            this._steps[_loc2_].x = HIDED_STEPS_OFFSET + _loc1_ * _loc2_;
            _loc2_++;
         }
      }
      
      override public function get width() : Number
      {
         return this.hit.width;
      }
      
      override public function get height() : Number
      {
         return this.hit.height;
      }
      
      public function get componentSize() : String
      {
         return this._containerSize;
      }
      
      public function set componentSize(param1:String) : void
      {
         if(this._containerSize == param1)
         {
            return;
         }
         this._containerSize = param1;
         invalidateSize();
      }
      
      public function get steps() : Vector.<IStepArrow>
      {
         return this._steps;
      }
      
      public function get stepIdxForAnim() : int
      {
         return this._stepIdxForAnim;
      }
      
      private function onStepStepReadyHandler(param1:StepEvent) : void
      {
         ++this._stepIdxForAnim;
         this.stepReadyHandler();
      }
   }
}
