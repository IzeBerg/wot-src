package net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers
{
   import flash.display.DisplayObject;
   import mx.effects.easing.Sine;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressBlock;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressRankRenderer;
   import scaleform.clik.motion.Tween;
   
   public class FirstEnterDivisionState extends AbstractDivisionState
   {
      
      private static const FIRST_ENTER_POSITION_START:int = -2;
      
      private static const FIRST_ENTER_POSITION_ADVANCE:int = -1;
      
      private static const FIRST_ENTER_STEPCONT_OFFSET:int = -70;
      
      private static const SCROLL_ANIMATION_TIME:int = 1500;
      
      private static const SCROLL_ANIMATION_TIME_2:int = 750;
      
      private static const STEPS_ANIMATION_TIME:int = 200;
      
      private static const ARROW_ANIMATION_TIME:int = 200;
      
      private static const ALPHA_MULT:Number = 2;
      
      private static const ALPHA_POSITION_OFFSET:Number = 2;
      
      private static const SOUND_STATE:String = "first_enter";
       
      
      private var _nextState:AbstractDivisionState = null;
      
      private var _progressTween:Tween = null;
      
      private var _stepsFadeUpTween:Tween = null;
      
      private var _rightArrowTween:Tween = null;
      
      public function FirstEnterDivisionState(param1:DivisionProgressBlock, param2:AbstractDivisionState)
      {
         super(param1);
         this._nextState = param2;
      }
      
      override public function start() : void
      {
         super.start();
         setInitialPosition(FIRST_ENTER_POSITION_START);
         progressBlock.selectedIndex = 0;
         progressBlock.updateSteps();
         progressBlock.arrowLeft.visible = false;
         progressBlock.arrowRight.visible = false;
         progressBlock.stepsContainer.visible = false;
         progressBlock.stepsContainer.x = -progressBlock.stepsContainer.width - progressBlock.blockParams.firstStep + FIRST_ENTER_STEPCONT_OFFSET;
         this._progressTween = new Tween(SCROLL_ANIMATION_TIME,this,{"position":FIRST_ENTER_POSITION_ADVANCE},{
            "paused":false,
            "onComplete":this.onFirstEnterPhase1Complete
         });
         App.soundMgr.playControlsSnd(SOUND_STATE,SoundTypes.RANKED_BATTLES_DIVISION,null);
      }
      
      override protected function onDispose() : void
      {
         this._nextState = null;
         this._progressTween = null;
         this._stepsFadeUpTween = null;
         this._rightArrowTween = null;
         super.onDispose();
      }
      
      override protected function update() : void
      {
         var _loc3_:int = 0;
         var _loc9_:DivisionProgressRankRenderer = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc1_:Vector.<DivisionProgressRankRenderer> = progressBlock.renderers;
         var _loc2_:BlockViewParams = progressBlock.blockParams;
         _loc3_ = progressBlock.renderers.length;
         var _loc4_:Number = this.position;
         var _loc5_:Number = 1 / _loc3_;
         var _loc6_:int = progressBlock.visibleRenderersCount >> 1;
         var _loc7_:int = -(_loc2_.regularStep * (_loc3_ - 1) >> 1);
         if(_loc4_ > -1)
         {
            _loc7_ *= -_loc4_;
         }
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc9_ = _loc1_[_loc8_];
            _loc9_.visible = true;
            _loc10_ = 0;
            if(_loc4_ < -1)
            {
               _loc13_ = (_loc4_ - _loc8_ * _loc5_ + ALPHA_POSITION_OFFSET) / (ALPHA_MULT * _loc5_);
               _loc10_ = Math.max(0,Math.min(_loc13_,1));
            }
            else if(_loc8_ < _loc6_)
            {
               _loc10_ = 1;
            }
            else
            {
               _loc10_ = -_loc4_;
            }
            _loc11_ = 0;
            if(_loc8_ == 0 && _loc4_ > -1)
            {
               _loc11_ = _loc4_ + 1;
            }
            _loc12_ = 0;
            if(_loc4_ > -1 && _loc8_ > 0)
            {
               _loc12_ = (_loc2_.secondStep - _loc2_.regularStep) * (_loc4_ + 1);
            }
            _loc9_.setState(_loc11_,_loc10_,false);
            _loc9_.x = _loc8_ * _loc2_.regularStep + _loc7_ + _loc12_ | 0;
            _loc8_++;
         }
      }
      
      override protected function stopAllTweens() : void
      {
         stopTween(this._progressTween);
         stopTween(this._stepsFadeUpTween);
         stopTween(this._rightArrowTween);
         super.stopAllTweens();
      }
      
      private function onFirstEnterPhase1Complete(param1:Tween) : void
      {
         this._progressTween = new Tween(SCROLL_ANIMATION_TIME_2,this,{"position":progressBlock.selectedIndex},{
            "paused":false,
            "onComplete":this.onFirstEnterPhase2Complete,
            "ease":Sine.easeInOut
         });
      }
      
      private function onFirstEnterPhase2Complete(param1:Tween) : void
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = progressBlock.stepsContainer;
         _loc2_.y = -(_loc2_.height >> 1);
         _loc2_.visible = true;
         _loc2_.alpha = 0;
         var _loc3_:int = -_loc2_.width - progressBlock.blockParams.firstStep;
         this._stepsFadeUpTween = new Tween(STEPS_ANIMATION_TIME,_loc2_,{
            "alpha":1,
            "x":_loc3_
         },{"paused":false});
         progressBlock.arrowRight.visible = true;
         progressBlock.arrowRight.alpha = 0;
         this._rightArrowTween = new Tween(ARROW_ANIMATION_TIME,progressBlock.arrowRight,{"alpha":1},{
            "paused":false,
            "onComplete":this.onFirstEnterPhase3Complete
         });
      }
      
      private function onFirstEnterPhase3Complete(param1:Tween) : void
      {
         progressBlock.setState(this._nextState);
      }
   }
}
