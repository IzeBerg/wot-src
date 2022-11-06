package net.wg.gui.battle.comp7.views.consumablesPanel
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.generated.COMP7_CONSTS;
   import net.wg.gui.battle.comp7.views.consumablesPanel.events.ConsumablesPanelEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Comp7ProgressContainer extends Sprite implements IDisposable
   {
       
      
      public var progressBarLevel1:Comp7ProgressBar = null;
      
      public var progressBarLevel2:Comp7ProgressBar = null;
      
      public var progressBarLevel3:Comp7ProgressBar = null;
      
      private var _progressBars:Vector.<Comp7ProgressBar> = null;
      
      private var _levelCompleted:int;
      
      private var _nextLevelProgress:Number;
      
      private var _curProgressBarsIdx:int;
      
      private var _progressBarsLength:int;
      
      private var _disposed:Boolean = false;
      
      public function Comp7ProgressContainer()
      {
         var _loc1_:Comp7ProgressBar = null;
         super();
         this._progressBars = new <Comp7ProgressBar>[this.progressBarLevel1,this.progressBarLevel2,this.progressBarLevel3];
         for each(_loc1_ in this._progressBars)
         {
            _loc1_.addEventListener(ConsumablesPanelEvent.PROGRESS_COMPLETED,this.onProgressCompletedHandler);
         }
         this._progressBarsLength = this._progressBars.length;
      }
      
      public final function dispose() : void
      {
         var _loc1_:Comp7ProgressBar = null;
         this._disposed = true;
         for each(_loc1_ in this._progressBars)
         {
            _loc1_.removeEventListener(ConsumablesPanelEvent.PROGRESS_COMPLETED,this.onProgressCompletedHandler);
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._progressBars.length = 0;
         this._progressBars = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setData(param1:int, param2:Number, param3:int) : void
      {
         this.stopAnimations();
         this._levelCompleted = param1;
         this._nextLevelProgress = param2;
         this._curProgressBarsIdx = 0;
         var _loc4_:Boolean = param3 == COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_NEXT_LEVEL;
         var _loc5_:int = !!_loc4_ ? int(-1) : int(0);
         while(this._curProgressBarsIdx < param1 + _loc5_)
         {
            this._progressBars[this._curProgressBarsIdx].setProgress(1);
            ++this._curProgressBarsIdx;
         }
         if(_loc4_)
         {
            this._progressBars[this._curProgressBarsIdx].setProgress(1,true);
         }
         else if(param3 == COMP7_CONSTS.ROLE_SKILL_SLOT_ANIM_PROGRESS)
         {
            if(this._curProgressBarsIdx < this._progressBarsLength)
            {
               this._progressBars[this._curProgressBarsIdx].setProgress(this._nextLevelProgress,true);
            }
         }
         else if(this._curProgressBarsIdx < this._progressBarsLength)
         {
            this._progressBars[this._curProgressBarsIdx].setProgress(this._nextLevelProgress);
         }
         var _loc6_:int = this._curProgressBarsIdx + 1;
         while(_loc6_ < this._progressBarsLength)
         {
            this._progressBars[_loc6_].setProgress(0);
            _loc6_++;
         }
      }
      
      private function stopAnimations() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._progressBarsLength)
         {
            this._progressBars[_loc1_].clearTweens();
            _loc1_++;
         }
      }
      
      private function animateNext() : void
      {
         ++this._curProgressBarsIdx;
         if(this._progressBarsLength <= this._curProgressBarsIdx)
         {
            return;
         }
         if(this._levelCompleted >= this._curProgressBarsIdx)
         {
            if(this._levelCompleted == this._curProgressBarsIdx)
            {
               this._progressBars[this._curProgressBarsIdx].setProgress(this._nextLevelProgress,true);
            }
            else
            {
               this._progressBars[this._curProgressBarsIdx].setProgress(1,true);
            }
         }
         else
         {
            this._progressBars[this._curProgressBarsIdx].setProgress(0);
         }
      }
      
      private function onProgressCompletedHandler(param1:Event = null) : void
      {
         this.animateNext();
      }
   }
}
