package net.wg.gui.lobby.epicBattles.components.afterBattle
{
   import net.wg.gui.lobby.epicBattles.events.AfterBattleFameBarEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IScheduler;
   
   public class EpicBattlesAfterBattleFameProgressBar extends UIComponentEx
   {
      
      private static const ACTIVE_LEVEL_STATE:String = "active";
      
      private static const LEVEL_UP_STATE:String = "levelup";
      
      private static const AFTER_LEVEL_UP_TASK_DELAY:int = 1500;
      
      private static const FULL_BAR_PERCENT:Number = 100;
       
      
      public var currentLevel:EpicMetaLevelProgressBarIcons = null;
      
      public var nextLevel:EpicMetaLevelProgressBarIcons = null;
      
      public var progressBar:EpicBattlesMetaLevelProgressBar;
      
      private var _currentLevel:int = 0;
      
      private var _nextLevel:int = 0;
      
      private var _maxLevel:int = 0;
      
      private var _scheduler:IScheduler;
      
      public function EpicBattlesAfterBattleFameProgressBar()
      {
         this._scheduler = App.utils.scheduler;
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         this.progressBar.removeEventListener(AfterBattleFameBarEvent.LEVEL_UP,this.onProgressBarLevelUpHandler);
         this._scheduler.cancelTask(this.afterLevelUpTask);
         this._scheduler.cancelTask(this.afterMaxLevelUpTask);
         this.currentLevel.stop();
         this.nextLevel.stop();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._scheduler = null;
         this.currentLevel.dispose();
         this.currentLevel = null;
         this.nextLevel.dispose();
         this.nextLevel = null;
         this.progressBar.dispose();
         this.progressBar = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.currentLevel.gotoAndPlay(ACTIVE_LEVEL_STATE);
         this.nextLevel.gotoAndPlay(ACTIVE_LEVEL_STATE);
         this.progressBar.addEventListener(AfterBattleFameBarEvent.LEVEL_UP,this.onProgressBarLevelUpHandler);
      }
      
      public function setFameBoostPoints(param1:String) : void
      {
         this.progressBar.setFameBoostPointCounter(param1);
      }
      
      public function setFamePoints(param1:String) : void
      {
         this.progressBar.setFamePointCounter(param1);
      }
      
      public function setMaxLevel(param1:int) : void
      {
         this._maxLevel = param1;
      }
      
      public function setProgress(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:int = param1 != this._maxLevel ? int(param1 >> 0) : int(this._maxLevel - 1);
         this.setCurrentLevel(_loc4_);
         var _loc5_:int = param1 + 1 <= this._maxLevel ? int(param1 + 1 >> 0) : int(this._maxLevel);
         this.setNextLevel(_loc5_);
         if(param1 != this._maxLevel)
         {
            this.progressBar.setBarProgress(param1,param3,param2);
         }
         else
         {
            this.progressBar.setStaticBarProgress(FULL_BAR_PERCENT);
         }
      }
      
      public function startProgressAnimation() : void
      {
         this.progressBar.startProgressAnimation();
      }
      
      private function animateNextLevel() : void
      {
         this.currentLevel.gotoAndPlay(ACTIVE_LEVEL_STATE);
         this.nextLevel.gotoAndPlay(LEVEL_UP_STATE);
         if(this._currentLevel + 1 != this._maxLevel)
         {
            this._scheduler.scheduleTask(this.afterLevelUpTask,AFTER_LEVEL_UP_TASK_DELAY);
         }
         else
         {
            this._scheduler.scheduleTask(this.afterMaxLevelUpTask,AFTER_LEVEL_UP_TASK_DELAY);
         }
      }
      
      private function setCurrentLevel(param1:int) : void
      {
         if(param1 == this._currentLevel)
         {
            return;
         }
         this._currentLevel = param1;
         this.currentLevel.setLevel(param1);
      }
      
      private function setNextLevel(param1:int) : void
      {
         if(param1 == this._nextLevel)
         {
            return;
         }
         this._nextLevel = param1;
         this.nextLevel.setLevel(param1);
      }
      
      private function afterLevelUpTask() : void
      {
         this.currentLevel.gotoAndPlay(ACTIVE_LEVEL_STATE);
         this.setCurrentLevel(this._currentLevel + 1);
         this.setNextLevel(this._nextLevel + 1);
         this.nextLevel.gotoAndPlay(ACTIVE_LEVEL_STATE);
         this.progressBar.levelUpCompleteTask();
      }
      
      private function afterMaxLevelUpTask() : void
      {
         dispatchEvent(new AfterBattleFameBarEvent(AfterBattleFameBarEvent.BAR_FILLED));
      }
      
      private function onProgressBarLevelUpHandler(param1:AfterBattleFameBarEvent) : void
      {
         this.animateNextLevel();
      }
   }
}
