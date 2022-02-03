package net.wg.gui.battle.views.questProgress.animated
{
   import fl.motion.easing.Cubic;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   import scaleform.clik.motion.Tween;
   
   public class AnimationItem extends MovieClip implements IQueueAnimProgressState
   {
      
      private static const START_ANIM_FRAME_LABEL:String = "startAnim";
      
      private static const START_PLAY_SND_FRAME_LABEL:String = "startPlaySnd";
      
      private static const PRE_COMPLETED_ANIM_FRAME_LABEL:String = "preCompletedAnim";
      
      private static const FADE_IN_DURATION:Number = 500;
       
      
      public var valueContainer:AnimValueContainer = null;
      
      public var iconContainer:AnimIconContainer = null;
      
      public var animRing:AnimationRing = null;
      
      private var _completedScriptFrame:int = 0;
      
      private var _preCompletedScriptFrame:int = 0;
      
      private var _startPlaySndScriptFrame:int = 0;
      
      private var _completedCallback:Function = null;
      
      private var _preCompletedCallback:Function = null;
      
      private var _animStartCallback:Function = null;
      
      private var _onAnimStartSndCallBack:Function = null;
      
      private var _tween:Tween = null;
      
      private var _disposed:Boolean = false;
      
      public function AnimationItem()
      {
         super();
         stop();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function run(param1:Function, param2:Function, param3:Function, param4:Function) : void
      {
         var _loc8_:FrameLabel = null;
         this._completedCallback = param1;
         this._preCompletedCallback = param2;
         this._animStartCallback = param3;
         this._onAnimStartSndCallBack = param4;
         var _loc5_:String = this.getAnimStatusType();
         if(_loc5_ == QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_COMPLETED)
         {
            this._onAnimStartSndCallBack(_loc5_);
         }
         this._completedScriptFrame = this.totalFrames - 1;
         addFrameScript(this._completedScriptFrame,this.onAnimationComplete);
         var _loc6_:Array = this.currentLabels;
         var _loc7_:int = _loc6_.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc7_)
         {
            _loc8_ = _loc6_[_loc9_];
            if(_loc8_.name == PRE_COMPLETED_ANIM_FRAME_LABEL)
            {
               this._preCompletedScriptFrame = _loc8_.frame;
               addFrameScript(this._preCompletedScriptFrame,this.onAnimationPreComplete);
            }
            else if(_loc8_.name == START_PLAY_SND_FRAME_LABEL)
            {
               this._startPlaySndScriptFrame = _loc8_.frame;
               addFrameScript(this._startPlaySndScriptFrame,this.onStartPlaySnd);
            }
            _loc9_++;
         }
         this.animRing.run(this.onAnimStart);
      }
      
      public function setIcon(param1:String) : void
      {
         this.iconContainer.source = RES_ICONS.maps_icons_quests_battlecondition_90_icon_battle_condition_all_90x90_png(param1);
      }
      
      public function setProgressPrc(param1:int) : void
      {
      }
      
      public function setStartPosition(param1:Point) : void
      {
         this.animRing.x = param1.x;
         this.animRing.y = param1.y;
      }
      
      public function setValue(param1:String) : void
      {
         this.valueContainer.setValue(param1,this.getValueColor());
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         stop();
         this.clearTween();
         this.animRing.dispose();
         this.animRing = null;
         this.valueContainer.dispose();
         this.valueContainer = null;
         this.iconContainer.dispose();
         this.iconContainer = null;
         this._preCompletedCallback = null;
         this._completedCallback = null;
         this._animStartCallback = null;
         this._onAnimStartSndCallBack = null;
         addFrameScript(this._completedScriptFrame,null);
         addFrameScript(this._preCompletedScriptFrame,null);
         addFrameScript(this._startPlaySndScriptFrame,null);
      }
      
      protected function getValueColor() : uint
      {
         return QUEST_PROGRESS_BASE.QP_TEXT_COLOR_STATE_IN_PROGRESS_VALUE;
      }
      
      protected function getAnimStatusType() : String
      {
         return QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_PROGRESS;
      }
      
      private function onAnimStart() : void
      {
         this._animStartCallback();
         this._tween = new Tween(FADE_IN_DURATION,this.animRing,{
            "x":0,
            "y":0
         },{
            "paused":false,
            "ease":Cubic.easeInOut,
            "delay":0,
            "onComplete":null
         });
         this._tween.fastTransform = false;
         gotoAndPlay(START_ANIM_FRAME_LABEL);
      }
      
      private function onAnimationPreComplete() : void
      {
         this._preCompletedCallback();
      }
      
      private function onStartPlaySnd() : void
      {
         var _loc1_:String = this.getAnimStatusType();
         if(_loc1_ == QUEST_PROGRESS_BATTLE.QP_ANIM_STATUS_PROGRESS)
         {
            this._onAnimStartSndCallBack(_loc1_);
         }
      }
      
      private function onAnimationComplete() : void
      {
         stop();
         this._completedCallback();
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
