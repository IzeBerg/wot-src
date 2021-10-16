package net.wg.gui.battle.tutorial.views.tutorial.components.doneAnim
{
   import fl.transitions.easing.Regular;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.tutorial.views.tutorial.interfaces.IBattleTutorialDoneAnim;
   import net.wg.gui.battle.tutorial.views.tutorial.interfaces.IBattleTutorialTasksPanel;
   import net.wg.gui.battle.tutorial.views.tutorial.utils.tween.TutorialTweener;
   
   public class BattleTutorialDoneAnim extends BattleUIComponent implements IBattleTutorialDoneAnim
   {
       
      
      public var doneAnimContainer:BattleTutorialDoneAnimContainer = null;
      
      public var iconAnimEndPositionX:int = -1;
      
      public var iconAnimEndPositionY:int = -1;
      
      private var _tasksPanel:IBattleTutorialTasksPanel = null;
      
      private var _animStartPositionX:int = -1;
      
      private var _animStartPositionY:int = -1;
      
      private var _textShift:int = -1;
      
      private const ANIM_TIME:int = 600;
      
      private const ANIM_SCALE:Number = 0.4;
      
      private const ANIM_ALPHA:Number = 0.4;
      
      private const SHOW_LABEL:String = "show";
      
      private const ICON_TWEEN_ANIM_DONE_ID:int = 1;
      
      public function BattleTutorialDoneAnim()
      {
         super();
         addFrameScript(this.totalFrames - 1,this.continueAnimTaskDone);
         visible = false;
         this._textShift = this.doneAnimContainer.textField.x + this.doneAnimContainer.textField.textWidth;
         stop();
      }
      
      public function startAnimTaskDone() : void
      {
         scaleX = scaleY = 1;
         x = this._animStartPositionX;
         y = this._animStartPositionY;
         visible = true;
         gotoAndPlay(this.SHOW_LABEL);
      }
      
      public function continueAnimTaskDone() : void
      {
         stop();
         var _loc1_:Object = {
            "x":this.iconAnimEndPositionX,
            "ease":Regular.easeIn
         };
         TutorialTweener.tweener.tween(this,this.ANIM_TIME,_loc1_,this);
         _loc1_ = {
            "y":this.iconAnimEndPositionY,
            "alpha":this.ANIM_ALPHA,
            "scaleX":this.ANIM_SCALE,
            "scaleY":this.ANIM_SCALE,
            "ease":Regular.easeOut
         };
         TutorialTweener.tweener.tween(this,this.ANIM_TIME,_loc1_,this,this.ICON_TWEEN_ANIM_DONE_ID);
      }
      
      public function onTweenComplete(param1:int) : void
      {
         if(param1 == this.ICON_TWEEN_ANIM_DONE_ID)
         {
            alpha = Values.DEFAULT_ALPHA;
            visible = false;
            this._tasksPanel.finishedAnimTaskDone();
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._animStartPositionX = param1 - this._textShift >> 1;
         this._animStartPositionY = param2 >> 2;
      }
      
      public function set tasksPanel(param1:IBattleTutorialTasksPanel) : void
      {
         this._tasksPanel = param1;
      }
      
      override protected function onDispose() : void
      {
         this._tasksPanel = null;
         this.doneAnimContainer.dispose();
         this.doneAnimContainer = null;
         super.onDispose();
      }
   }
}
