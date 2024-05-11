package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import flash.display.MovieClip;
   import net.wg.gui.lobby.epicBattles.events.AfterBattleFameBarEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class EpicBattlesMetaLevelProgressBar extends UIComponentEx
   {
      
      private static const MAX_BAR_FRAME:int = 100;
      
      private static const SINGLE_FRAME_BAR_WIDTH:int = 6;
      
      private static const FAME_COUNTER_GAP:int = 7;
      
      private static const FULL_BAR_WIDTH:int = 600;
      
      private static const HIGHLIGHT_BAR_OFFSET:int = 40;
      
      private static const HALF_HIGHLIGHT_BAR_OFFSET:int = HIGHLIGHT_BAR_OFFSET >> 1;
      
      private static const DEFAULT_HIGHLIGHT_BAR_WIDTH:int = 46;
      
      private static const BOOST_ANIM_DELAY:int = 200;
      
      private static const FILL_UP_PROGRESS_HIGHLIGHT_TASK_LENGTH:int = 200;
      
      private static const FILL_UP_PROGRESS_HIGHLIGHT_TASK_DELAY:int = 700;
      
      private static const FILL_UP_PROGRESS_HIGHLIGHT_TASK_NORMAL_LENGTH:int = 2000;
      
      private static const FILL_UP_PROGRESS_HIGHLIGHT_TASK_FAST_LENGTH:int = 1000;
       
      
      public var bg:MovieClip = null;
      
      public var famePointCounter:EpicBattlesFamePointsCounter = null;
      
      public var fameBoostPointCounter:EpicBattlesFamePointsCounter = null;
      
      public var fameBarFg:MovieClip = null;
      
      public var highlightSection:MovieClip = null;
      
      public var highlightBoostSection:MovieClip = null;
      
      private var _scheduler:IScheduler;
      
      private var _oldLevelProgress:Number = 0;
      
      private var _newLevelProgress:Number = 0;
      
      private var _pureLevelProgress:Number = 0;
      
      private var _fillBarTween:Tween = null;
      
      private var _isLevelUp:Boolean = false;
      
      private var _isBoostLevelUp:Boolean = false;
      
      private var _isBoost:Boolean = false;
      
      public function EpicBattlesMetaLevelProgressBar()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         if(this._fillBarTween)
         {
            this._fillBarTween.paused = true;
            this._fillBarTween.dispose();
         }
         this._scheduler.cancelTask(this.fillUpProgressHighlightTask);
         this.famePointCounter.stop();
         this.fameBoostPointCounter.stop();
         this.fameBarFg.stop();
         this.highlightSection.stop();
         this.highlightBoostSection.stop();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         if(this._fillBarTween)
         {
            this._fillBarTween = null;
         }
         this._scheduler = null;
         this.famePointCounter.dispose();
         this.famePointCounter = null;
         this.fameBoostPointCounter.dispose();
         this.fameBoostPointCounter = null;
         this.fameBarFg = null;
         this.highlightSection = null;
         this.highlightBoostSection = null;
         this.bg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.fameBoostPointCounter.visible = this._isBoost;
            if(this._isBoost)
            {
               this.famePointCounter.x = (this.bg.width - this.famePointCounter.width - this.fameBoostPointCounter.width - FAME_COUNTER_GAP >> 1) + DEFAULT_HIGHLIGHT_BAR_WIDTH;
               this.fameBoostPointCounter.x = this.famePointCounter.x + this.famePointCounter.width + FAME_COUNTER_GAP;
            }
            else
            {
               this.famePointCounter.x = (this.bg.width - this.famePointCounter.width >> 1) + DEFAULT_HIGHLIGHT_BAR_WIDTH;
            }
         }
      }
      
      public function levelUpCompleteTask() : void
      {
         this.fameBarFg.visible = false;
         this.highlightSection.x = -HALF_HIGHLIGHT_BAR_OFFSET;
         this.highlightSection.width = DEFAULT_HIGHLIGHT_BAR_WIDTH;
         this.highlightSection.visible = false;
         this.highlightBoostSection.x = -HALF_HIGHLIGHT_BAR_OFFSET;
         this.highlightBoostSection.width = DEFAULT_HIGHLIGHT_BAR_WIDTH;
         this.highlightBoostSection.visible = false;
         if(this._isLevelUp)
         {
            this.fillUpProgressHighlightTask(FILL_UP_PROGRESS_HIGHLIGHT_TASK_LENGTH);
         }
         else if(this._isBoostLevelUp)
         {
            dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.START_ANIM));
            this.fillUpProgressHighlightBoostTask(FILL_UP_PROGRESS_HIGHLIGHT_TASK_LENGTH);
         }
      }
      
      public function setBarProgress(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:int = (param1 - (param1 >> 0)) * MAX_BAR_FRAME + 1;
         this.fameBarFg.visible = true;
         this.fameBarFg.gotoAndStop(_loc4_);
         this.highlightSection.visible = false;
         this.highlightSection.x = (_loc4_ - 1) * SINGLE_FRAME_BAR_WIDTH - HALF_HIGHLIGHT_BAR_OFFSET;
         this.highlightSection.width = DEFAULT_HIGHLIGHT_BAR_WIDTH;
         this._oldLevelProgress = param1;
         this._newLevelProgress = param2;
         this._pureLevelProgress = param3;
         this._isBoost = this._newLevelProgress != this._pureLevelProgress;
         this.highlightBoostSection.visible = false;
      }
      
      public function setFameBoostPointCounter(param1:String) : void
      {
         this.fameBoostPointCounter.setFamePoints(param1);
         invalidateSize();
      }
      
      public function setFamePointCounter(param1:String) : void
      {
         this.famePointCounter.setFamePoints(param1);
         invalidateSize();
      }
      
      public function setStaticBarProgress(param1:Number) : void
      {
         var _loc2_:int = param1 / 100 * MAX_BAR_FRAME + 1;
         this.fameBarFg.visible = true;
         this.fameBarFg.gotoAndStop(_loc2_);
         this.highlightSection.visible = false;
         this.highlightBoostSection.visible = false;
      }
      
      public function startProgressAnimation() : void
      {
         if(this._pureLevelProgress > this._oldLevelProgress)
         {
            this.famePointCounter.animate();
            this.fameBoostPointCounter.animate();
            this._scheduler.scheduleTask(this.fillUpProgressHighlightTask,FILL_UP_PROGRESS_HIGHLIGHT_TASK_DELAY);
         }
         else
         {
            dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.BAR_FILLED));
         }
      }
      
      private function fillBarTween(param1:int, param2:int, param3:int) : void
      {
         this._fillBarTween = new Tween(param1,this.highlightSection,{"width":param3},{
            "delay":param2,
            "onComplete":this.onFillBarTweenAnimComplete
         });
      }
      
      private function fillBoostBarTween(param1:int, param2:int, param3:int) : void
      {
         this._fillBarTween = new Tween(param1,this.highlightBoostSection,{"width":param3},{
            "delay":param2,
            "onComplete":this.onFillBoostBarTweenAnimComplete
         });
      }
      
      private function onFillBarTweenAnimComplete(param1:Tween) : void
      {
         var _loc2_:int = 0;
         if(this._isLevelUp)
         {
            dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.LEVEL_UP));
         }
         else if(this._isBoost)
         {
            this._isLevelUp = false;
            _loc2_ = (this._pureLevelProgress - (this._pureLevelProgress >> 0)) * MAX_BAR_FRAME;
            this.highlightBoostSection.x = _loc2_ * SINGLE_FRAME_BAR_WIDTH - HALF_HIGHLIGHT_BAR_OFFSET;
            this.highlightBoostSection.width = DEFAULT_HIGHLIGHT_BAR_WIDTH;
            this._scheduler.scheduleTask(this.fillUpProgressHighlightBoostTask,BOOST_ANIM_DELAY);
         }
         else
         {
            dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.BAR_FILLED));
         }
         param1.dispose();
         param1 = null;
      }
      
      private function onFillBoostBarTweenAnimComplete(param1:Tween) : void
      {
         if(this._isBoostLevelUp)
         {
            dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.LEVEL_UP));
         }
         else
         {
            dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.BAR_FILLED));
         }
         param1.dispose();
         param1 = null;
      }
      
      private function fillUpProgressHighlightTask(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this._isLevelUp = (this._pureLevelProgress >> 0) - (this._oldLevelProgress >> 0) > 0;
         if(this._isLevelUp)
         {
            _loc4_ = this._oldLevelProgress + 1 >> 0;
            _loc5_ = _loc4_ - this._oldLevelProgress;
            this._oldLevelProgress = _loc4_;
            _loc2_ = _loc5_ * FULL_BAR_WIDTH + HIGHLIGHT_BAR_OFFSET;
         }
         else
         {
            if(this._pureLevelProgress == this._oldLevelProgress)
            {
               dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.BAR_FILLED));
               return;
            }
            _loc2_ = (this._pureLevelProgress - this._oldLevelProgress) * FULL_BAR_WIDTH + HIGHLIGHT_BAR_OFFSET;
         }
         this.highlightSection.visible = true;
         var _loc3_:int = _loc2_ > FULL_BAR_WIDTH >> 1 ? int(FILL_UP_PROGRESS_HIGHLIGHT_TASK_NORMAL_LENGTH) : int(FILL_UP_PROGRESS_HIGHLIGHT_TASK_FAST_LENGTH);
         dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.START_ANIM));
         this.fillBarTween(_loc3_,param1,_loc2_);
      }
      
      private function fillUpProgressHighlightBoostTask(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         this._isBoostLevelUp = (this._newLevelProgress >> 0) - (this._pureLevelProgress >> 0) > 0;
         if(this._isBoostLevelUp)
         {
            _loc4_ = this._pureLevelProgress + 1 >> 0;
            _loc5_ = _loc4_ - this._pureLevelProgress;
            this._pureLevelProgress = _loc4_;
            _loc2_ = _loc5_ * FULL_BAR_WIDTH + HIGHLIGHT_BAR_OFFSET;
         }
         else
         {
            if(this._pureLevelProgress == this._newLevelProgress)
            {
               dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.BAR_FILLED));
               return;
            }
            _loc2_ = (this._newLevelProgress - this._pureLevelProgress) * FULL_BAR_WIDTH + HIGHLIGHT_BAR_OFFSET;
         }
         this.highlightBoostSection.visible = true;
         var _loc3_:int = _loc2_ > FULL_BAR_WIDTH >> 1 ? int(FILL_UP_PROGRESS_HIGHLIGHT_TASK_NORMAL_LENGTH) : int(FILL_UP_PROGRESS_HIGHLIGHT_TASK_FAST_LENGTH);
         this.fillBoostBarTween(_loc3_,param1,_loc2_);
      }
   }
}
