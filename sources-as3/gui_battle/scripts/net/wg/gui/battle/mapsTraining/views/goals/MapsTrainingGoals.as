package net.wg.gui.battle.mapsTraining.views.goals
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingGoal;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingTimerAnim;
   import net.wg.infrastructure.base.meta.IMapsTrainingGoalsMeta;
   import net.wg.infrastructure.base.meta.impl.MapsTrainingGoalsMeta;
   import net.wg.utils.StageSizeBoundaries;
   
   public class MapsTrainingGoals extends MapsTrainingGoalsMeta implements IMapsTrainingGoalsMeta
   {
      
      private static const TYPE_HINT:String = "hint";
      
      private static const TYPE_GOAL:String = "goal";
      
      private static const TYPE_TIMER_GREEN:String = "timerGreen";
      
      private static const TYPE_TIMER_RED:String = "timerRed";
      
      private static const SMALL_SCALE:Number = 0.6;
      
      private static const GOALS_Y:int = 32;
      
      private static const GOALS_Y_SMALL:int = 23;
      
      private static const TITLE_Y:int = 49;
      
      private static const TITLE_Y_SMALL:int = 33;
      
      private static const TITLE_FONT:int = 36;
      
      private static const TITLE_FONT_SMALL:int = 22;
      
      private static const TITLE_WIDTH:int = 800;
      
      private static const TITLE_WIDTH_SMALL:int = 500;
      
      private static const TIMER_Y:int = 50;
      
      private static const TIMER_Y_SMALL:int = 4;
      
      private static const GREEN:String = "green";
      
      private static const RED:String = "red";
       
      
      public var titleTF:TextField = null;
      
      public var goals:MapsTrainingGoal = null;
      
      public var timer:MapsTrainingTimerAnim = null;
      
      public var background:Sprite = null;
      
      private var _data:Vector.<MapsTrainingGoalVO>;
      
      public function MapsTrainingGoals()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.goals.createGoals(this._data);
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:Boolean = param2 <= StageSizeBoundaries.HEIGHT_800;
         this.background.scaleX = this.background.scaleY = !!_loc3_ ? Number(SMALL_SCALE) : Number(1);
         this.goals.scale = !!_loc3_ ? Number(SMALL_SCALE) : Number(1);
         this.goals.y = !!_loc3_ ? Number(GOALS_Y_SMALL) : Number(GOALS_Y);
         this.titleTF.width = !!_loc3_ ? Number(TITLE_WIDTH_SMALL) : Number(TITLE_WIDTH);
         this.titleTF.x = -this.titleTF.width >> 1;
         this.titleTF.y = !!_loc3_ ? Number(TITLE_Y_SMALL) : Number(TITLE_Y);
         var _loc4_:TextFormat = this.titleTF.getTextFormat();
         _loc4_.size = !!_loc3_ ? TITLE_FONT_SMALL : TITLE_FONT;
         this.titleTF.defaultTextFormat = _loc4_;
         this.titleTF.setTextFormat(_loc4_);
         this.timer.y = !!_loc3_ ? Number(TIMER_Y_SMALL) : Number(TIMER_Y);
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         this.background = null;
         this.goals.dispose();
         this.goals = null;
         this.timer.dispose();
         this.timer = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function update(param1:Vector.<MapsTrainingGoalVO>) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function as_destroyGoal(param1:String) : void
      {
         this.goals.destroyGoal(param1);
      }
      
      public function as_showHint(param1:String, param2:String, param3:String) : void
      {
         if(param1 == TYPE_HINT || param1 == TYPE_GOAL)
         {
            this.titleTF.text = param2;
         }
         else if(param1 == TYPE_TIMER_GREEN)
         {
            this.titleTF.text = param2;
            this.timer.show(GREEN,param3);
         }
         else if(param1 == TYPE_TIMER_RED)
         {
            this.timer.show(RED,param2);
         }
      }
      
      public function as_hideHint() : void
      {
         this.timer.hide();
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         visible = param1;
      }
   }
}
