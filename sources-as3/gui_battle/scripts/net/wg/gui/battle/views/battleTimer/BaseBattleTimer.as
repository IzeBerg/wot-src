package net.wg.gui.battle.views.battleTimer
{
   import net.wg.infrastructure.base.meta.IBattleTimerMeta;
   import net.wg.infrastructure.base.meta.impl.BattleTimerMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseBattleTimer extends BattleTimerMeta implements IBattleTimerMeta
   {
       
      
      public function BaseBattleTimer()
      {
         super();
      }
      
      public function as_setColor(param1:Boolean) : void
      {
         throw new AbstractException();
      }
      
      public function as_setTotalTime(param1:String, param2:String) : void
      {
         throw new AbstractException();
      }
      
      public function as_showBattleTimer(param1:Boolean) : void
      {
         if(visible != param1)
         {
            visible = param1;
         }
      }
      
      public function updateStage(param1:Boolean = false) : void
      {
      }
   }
}
