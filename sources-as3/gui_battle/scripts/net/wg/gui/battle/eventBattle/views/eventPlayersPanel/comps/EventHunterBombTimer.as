package net.wg.gui.battle.eventBattle.views.eventPlayersPanel.comps
{
   import flash.text.TextField;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EventHunterBombTimer extends BattleUIComponent implements IEventTimerAnimation
   {
       
      
      public var timerTF:TextField = null;
      
      public var indexTF:TextField = null;
      
      private var _curTime:int = -1;
      
      private var _animHelper:EventTimerAnimHelper = null;
      
      public function EventHunterBombTimer()
      {
         super();
         this._animHelper = new EventTimerAnimHelper(this);
      }
      
      override protected function onDispose() : void
      {
         this._animHelper.dispose();
         this._animHelper = null;
         this.timerTF = null;
         this.indexTF = null;
         super.onDispose();
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         var _loc3_:int = param2 / Time.MILLISECOND_IN_SECOND;
         if(this._curTime != _loc3_)
         {
            this.timerTF.text = this._animHelper.getTimeFormatted(param2);
            this._curTime = _loc3_;
         }
      }
      
      public function updateTime(param1:int, param2:Number, param3:Number, param4:Number, param5:Boolean = true) : void
      {
         this.indexTF.text = String(param1);
         this._animHelper.setTime(param2,param3,param4,param5);
      }
   }
}
