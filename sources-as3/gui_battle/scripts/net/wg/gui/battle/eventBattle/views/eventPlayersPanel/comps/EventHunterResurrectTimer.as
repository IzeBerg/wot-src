package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventHunterResurrectTimer extends BattleUIComponent implements IEventTimerAnimation
   {
       
      
      public var timerTF:TextField = null;
      
      private var _animHelper:EventTimerAnimHelper = null;
      
      public function EventHunterResurrectTimer()
      {
         super();
         this._animHelper = new EventTimerAnimHelper(this);
      }
      
      override protected function onDispose() : void
      {
         this._animHelper.dispose();
         this._animHelper = null;
         this.timerTF = null;
         super.onDispose();
      }
      
      public function set finishCallback(param1:Function) : void
      {
         this._animHelper.finishCallback = param1;
      }
      
      public function updateTime(param1:Number, param2:Number, param3:Number) : void
      {
         this._animHelper.setTime(param1,param2,param3);
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         this.timerTF.text = this._animHelper.getTimeFormatted(param2);
      }
   }
}
