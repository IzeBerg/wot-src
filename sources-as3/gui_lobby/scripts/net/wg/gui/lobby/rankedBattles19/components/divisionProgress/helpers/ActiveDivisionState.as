package net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers
{
   import fl.motion.easing.Sine;
   import flash.events.Event;
   import net.wg.gui.lobby.rankedBattles19.components.StepsContainer;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressBlock;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressRankRenderer;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionProgressBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesDivisionProgressVO;
   import scaleform.clik.motion.Tween;
   
   public class ActiveDivisionState extends AbstractDivisionState
   {
      
      private static const SCROLL_ANIMATION_ONESTEP_DURATION:int = 500;
      
      private static const SCROLL_DURATION_DECREMENT_MULT:Number = 0.66;
      
      private static const STEPSCONT_FADE_DURATION:int = 150;
      
      private static const STEPSCONT_FADE_DELAY:int = 100;
       
      
      private var _progressTween:Tween = null;
      
      private var _stepsFadeUpTween:Tween = null;
      
      private var _stepsFadeDownTween:Tween = null;
      
      private var _isScrolling:Boolean = false;
      
      public function ActiveDivisionState(param1:DivisionProgressBlock)
      {
         super(param1);
      }
      
      private static function calcScrollDuration(param1:int, param2:Number) : int
      {
         var _loc3_:Number = param2;
         param1--;
         if(param1 > 0)
         {
            _loc3_ += calcScrollDuration(param1,param2 * SCROLL_DURATION_DECREMENT_MULT);
         }
         return _loc3_;
      }
      
      override public function start() : void
      {
         super.start();
         progressBlock.stepsContainer.visible = true;
         progressBlock.arrowLeft.visible = true;
         progressBlock.arrowRight.visible = true;
         var _loc1_:RankedBattlesDivisionProgressVO = progressBlock.data;
         var _loc2_:DivisionProgressBlockVO = null;
         var _loc3_:int = 0;
         var _loc4_:int = _loc1_.blocks.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = _loc1_.blocks[_loc5_];
            if(_loc2_.isAcquired)
            {
               _loc3_++;
            }
            _loc5_++;
         }
         if(_loc3_ >= _loc4_)
         {
            _loc3_ = _loc4_ - 1;
         }
         progressBlock.selectedIndex = _loc3_;
         progressBlock.addEventListener(Event.SELECT,this.onBlockEventSelectHandler);
         this.immediateUpdate();
      }
      
      override public function stop() : void
      {
         this._isScrolling = false;
         super.stop();
         progressBlock.removeEventListener(Event.SELECT,this.onBlockEventSelectHandler);
      }
      
      override public function updateSize() : void
      {
         if(!this._isScrolling)
         {
            super.updateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this._progressTween = null;
         this._stepsFadeUpTween = null;
         this._stepsFadeDownTween = null;
         super.onDispose();
      }
      
      override protected function update() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<DivisionProgressRankRenderer> = null;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc16_:DivisionProgressRankRenderer = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc1_:BlockViewParams = progressBlock.blockParams;
         _loc2_ = progressBlock.visibleRenderersCount;
         _loc3_ = progressBlock.renderers;
         var _loc4_:int = _loc3_.length;
         _loc5_ = this.position;
         _loc6_ = _loc5_;
         var _loc7_:Number = _loc5_ % 1;
         _loc8_ = _loc6_ - (_loc2_ >> 1);
         var _loc9_:int = _loc8_ + _loc2_;
         var _loc10_:Number = this.getStepsWidthProgress(_loc5_);
         var _loc11_:int = _loc1_.firstStep + (_loc10_ >> 1);
         var _loc12_:int = _loc1_.secondStep;
         var _loc13_:int = _loc1_.regularStep;
         var _loc14_:int = 0;
         if(_loc6_ == 0)
         {
            _loc14_ = -_loc11_ * (1 - _loc7_);
         }
         else if(_loc6_ >= _loc4_ - 1)
         {
            _loc14_ = _loc11_ * (_loc5_ - _loc4_ + 1);
         }
         var _loc15_:int = 0;
         while(_loc15_ < _loc4_)
         {
            _loc16_ = _loc3_[_loc15_];
            if(_loc15_ >= _loc8_ && _loc15_ <= _loc9_)
            {
               _loc16_.visible = true;
               _loc17_ = 0;
               if(_loc15_ < _loc6_ - 1)
               {
                  _loc16_.x = (_loc15_ - _loc5_ + 2) * _loc13_ - _loc12_ - _loc11_;
               }
               else if(_loc15_ == _loc6_ - 1)
               {
                  _loc16_.x = -_loc11_ + _loc12_ * (_loc15_ - _loc5_ + 1) | 0;
                  _loc17_ = _loc15_ - _loc5_ + 2;
               }
               else if(_loc15_ == _loc6_)
               {
                  _loc16_.x = -_loc11_ + 2 * _loc11_ * (_loc15_ - _loc5_ + 1) | 0;
                  _loc17_ = 1;
               }
               else if(_loc15_ == _loc6_ + 1)
               {
                  _loc16_.x = _loc11_ + _loc12_ * (_loc15_ - _loc5_) | 0;
                  _loc17_ = _loc5_ - _loc15_ + 1;
               }
               else
               {
                  _loc16_.x = (_loc15_ - _loc5_ - 1) * _loc13_ + _loc12_ + _loc11_ | 0;
               }
               _loc16_.x += _loc14_;
               _loc18_ = 1;
               if(_loc15_ == _loc8_)
               {
                  _loc18_ = 1 - _loc7_;
               }
               else if(_loc15_ == _loc9_)
               {
                  _loc18_ = _loc7_;
                  if(_loc7_ == 0)
                  {
                     _loc16_.visible = false;
                  }
               }
               _loc16_.setState(_loc17_,_loc18_,!this._isScrolling);
            }
            else
            {
               _loc16_.visible = false;
            }
            _loc15_++;
         }
      }
      
      override protected function stopAllTweens() : void
      {
         stopTween(this._progressTween);
         stopTween(this._stepsFadeUpTween);
         stopTween(this._stepsFadeDownTween);
         super.stopAllTweens();
      }
      
      private function onTweenComplete(param1:Tween) : void
      {
         this._isScrolling = false;
         setInitialPosition(progressBlock.selectedIndex);
         this.update();
      }
      
      private function onFadeDownTweenComplete(param1:Tween) : void
      {
         progressBlock.updateSteps();
         progressBlock.updateArrows();
      }
      
      private function startUpdate() : void
      {
         this.stopAllTweens();
         var _loc1_:int = progressBlock.selectedIndex;
         var _loc2_:StepsContainer = progressBlock.stepsContainer;
         var _loc3_:int = calcScrollDuration(Math.abs(_loc1_ - this.position),SCROLL_ANIMATION_ONESTEP_DURATION);
         this._progressTween = new Tween(_loc3_,this,{"position":_loc1_},{
            "paused":false,
            "onComplete":this.onTweenComplete,
            "ease":Sine.easeInOut
         });
         this._stepsFadeDownTween = new Tween(STEPSCONT_FADE_DURATION,_loc2_,{"alpha":0},{
            "paused":false,
            "onComplete":this.onFadeDownTweenComplete
         });
         var _loc4_:int = _loc3_ - STEPSCONT_FADE_DURATION + STEPSCONT_FADE_DELAY;
         this._stepsFadeUpTween = new Tween(STEPSCONT_FADE_DURATION,_loc2_,{"alpha":1},{
            "paused":false,
            "delay":_loc4_
         });
         this._isScrolling = true;
      }
      
      private function immediateUpdate() : void
      {
         this._isScrolling = false;
         this.stopAllTweens();
         progressBlock.stepsContainer.alpha = 1;
         progressBlock.updateSteps();
         progressBlock.updateArrows();
         setInitialPosition(progressBlock.selectedIndex);
         this.update();
      }
      
      private function onBlockEventSelectHandler(param1:Event) : void
      {
         this.startUpdate();
      }
      
      private function getStepsWidthProgress(param1:Number) : Number
      {
         var _loc2_:int = param1;
         var _loc3_:int = progressBlock.getCachedStepsWidth(_loc2_);
         var _loc4_:Number = param1 % 1;
         if(_loc4_ == 0)
         {
            return _loc3_;
         }
         var _loc5_:int = progressBlock.getCachedStepsWidth(_loc2_ + 1);
         return _loc3_ + _loc4_ * (_loc5_ - _loc3_);
      }
   }
}
