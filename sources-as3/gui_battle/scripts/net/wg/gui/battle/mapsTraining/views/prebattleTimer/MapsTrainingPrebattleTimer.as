package net.wg.gui.battle.mapsTraining.views.prebattleTimer
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.PREBATTLE_TIMER;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.gui.battle.mapsTraining.views.goals.hint.MapsTrainingGoal;
   import net.wg.infrastructure.base.meta.IMapsTrainingPrebattleTimerMeta;
   import net.wg.infrastructure.base.meta.impl.MapsTrainingPrebattleTimerMeta;
   
   public class MapsTrainingPrebattleTimer extends MapsTrainingPrebattleTimerMeta implements IMapsTrainingPrebattleTimerMeta
   {
      
      private static const INVALID_SIDE_TF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const SIDE_FONT:int = 24;
      
      private static const SIDE_FONT_SMALL:int = 18;
      
      private static const TITLE_FONT:int = 36;
      
      private static const TITLE_FONT_SMALL:int = 24;
      
      private static const TITLE_SMALL_OFFSET:int = -47;
      
      private static const GOALS_SMALL_OFFSET:int = -37;
      
      private static const GOALS_SMALL_SCALE:Number = 0.6;
       
      
      public var side:MapsTrainingTextFieldContainer = null;
      
      public var title:MapsTrainingTextFieldContainer = null;
      
      public var goals:MapsTrainingGoal = null;
      
      private var _data:Vector.<MapsTrainingGoalVO>;
      
      private var _sideText:String = "";
      
      private var _title:String = "";
      
      public function MapsTrainingPrebattleTimer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      override protected function doUpdateSize(param1:Boolean) : void
      {
         super.doUpdateSize(param1);
         this.side.setSize(param1,!!param1 ? int(SIDE_FONT_SMALL) : int(SIDE_FONT));
         this.title.setSize(param1,!!param1 ? int(TITLE_FONT_SMALL) : int(TITLE_FONT));
         this.title.offset = !!param1 ? int(TITLE_SMALL_OFFSET) : int(0);
         this.goals.offset = !!param1 ? int(GOALS_SMALL_OFFSET) : int(0);
         this.goals.scale = !!param1 ? Number(GOALS_SMALL_SCALE) : Number(1);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.title.label = this._title;
            this.updateSizeAfterText();
            this.goals.createGoals(this._data);
         }
         if(isInvalid(INVALID_SIDE_TF))
         {
            this.side.label = this._sideText;
            this.updateSizeAfterText();
         }
      }
      
      override protected function onDispose() : void
      {
         this.side.dispose();
         this.side = null;
         this.title.dispose();
         this.title = null;
         this.goals.dispose();
         this.goals = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function update(param1:Vector.<MapsTrainingGoalVO>, param2:String) : void
      {
         this._title = param2;
         this._data = param1;
         invalidateData();
      }
      
      public function as_setSide(param1:String) : void
      {
         if(this._sideText != param1)
         {
            this._sideText = param1;
            invalidate(INVALID_SIDE_TF);
         }
      }
      
      private function updateSizeAfterText() : void
      {
         this.doUpdateSize(App.appHeight <= PREBATTLE_TIMER.APP_MIN_HEIGHT_BREAKING);
      }
      
      override public function as_setMessage(param1:String) : void
      {
      }
      
      override public function as_setWinConditionText(param1:String) : void
      {
      }
   }
}
