package net.wg.gui.battle.tutorial.views.tutorial
{
   import net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim.BattleTutorialDoneAnim;
   import net.wg.gui.battle.tutorial.views.tutorial.components.progressBar.BattleTutorialProgressBar;
   import net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.BattleTutorialTasksPanel;
   import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.TutorialTweener;
   import net.wg.infrastructure.base.meta.IBattleTutorialMeta;
   import net.wg.infrastructure.base.meta.impl.BattleTutorialMeta;
   
   public class BattleTutorial extends BattleTutorialMeta implements IBattleTutorialMeta
   {
      
      private static const TASK_PANEL_Y:int = 100;
       
      
      public var tasksPanel:BattleTutorialTasksPanel;
      
      public var tutorialProgressBar:BattleTutorialProgressBar;
      
      public var doneAnim:BattleTutorialDoneAnim;
      
      private var _currentTaskID:String = "";
      
      private var _currentHintID:String = "";
      
      private var _chapterDescription:String = "";
      
      private var _isGreetingShow:Boolean = false;
      
      public function BattleTutorial()
      {
         super();
         this.doneAnim.tasksPanel = this.tasksPanel;
         this.doneAnim.iconAnimEndPositionX = this.tasksPanel.iconSpr.x;
         this.doneAnim.iconAnimEndPositionY = TASK_PANEL_Y + this.tasksPanel.getIconY();
         this.tasksPanel.doneAnim = this.doneAnim;
      }
      
      override protected function onDispose() : void
      {
         TutorialTweener.clearCache();
         this.doneAnim.dispose();
         this.tasksPanel.dispose();
         this.tutorialProgressBar.dispose();
         this.doneAnim = null;
         this.tasksPanel = null;
         this.tutorialProgressBar = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.doneAnim.updateStage(param1,param2);
         this.tutorialProgressBar.x = param1 - this.tutorialProgressBar.width >> 1;
         this.tasksPanel.y = TASK_PANEL_Y;
      }
      
      public function as_populateProgressBar(param1:int, param2:int) : void
      {
         this.tutorialProgressBar.populateProgressBar(param1,param2);
      }
      
      public function as_setTrainingProgressBar(param1:int) : void
      {
         this.tutorialProgressBar.setPhasesStatusMask(param1);
      }
      
      public function as_setChapterProgressBar(param1:int, param2:int) : void
      {
         this.tutorialProgressBar.setTasks(param1,param2);
      }
      
      public function as_showGreeting(param1:String, param2:String, param3:String) : void
      {
         this._isGreetingShow = true;
         this.tasksPanel.setChapter(param2);
         this.tasksPanel.setTask(param3,false,param1);
      }
      
      public function as_hideGreeting(param1:String) : void
      {
         this._isGreetingShow = false;
         this.tasksPanel.setChapter(this._chapterDescription);
      }
      
      public function as_setChapterInfo(param1:String) : void
      {
         this._chapterDescription = param1;
         if(!this._isGreetingShow)
         {
            this.tasksPanel.setChapter(param1);
         }
      }
      
      public function as_showNextTask(param1:String, param2:String, param3:Object) : void
      {
         if(this._currentTaskID != param1)
         {
            this._currentTaskID = param1;
            this.tasksPanel.setTask(param2,param3,param1);
         }
      }
      
      public function as_showHint(param1:String, param2:String, param3:String, param4:String) : void
      {
         if(this._currentHintID != param1)
         {
            this._currentHintID = param1;
            this.tasksPanel.setHint(param2,param3,param4,param1);
         }
      }
   }
}
