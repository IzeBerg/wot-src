package net.wg.white_tiger.gui.battle.views.shared
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.white_tiger.gui.battle.views.shared.interfaces.ITimerAnimation;
   
   public class HunterResurrectTimer extends BattleUIComponent implements ITimerAnimation
   {
       
      
      public var timerTF:TextField = null;
      
      private var _animHelper:TimerAnimHelper = null;
      
      public function HunterResurrectTimer()
      {
         super();
         this._animHelper = new TimerAnimHelper(this);
      }
      
      override protected function onDispose() : void
      {
         this._animHelper.dispose();
         this._animHelper = null;
         this.timerTF = null;
         super.onDispose();
      }
      
      public function updateProgress(param1:Number, param2:int) : void
      {
         this.timerTF.text = this._animHelper.getTimeFormatted(param2);
      }
      
      public function updateTime(param1:Number, param2:Number, param3:Number) : void
      {
         this._animHelper.setTime(param1,param2,param3);
      }
      
      public function set finishCallback(param1:Function) : void
      {
         this._animHelper.finishCallback = param1;
      }
   }
}
