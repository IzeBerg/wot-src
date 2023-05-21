package net.wg.gui.battle.battleRoyale.views.components.timersPanel
{
   import net.wg.infrastructure.base.meta.IBattleRoyaleTimersPanelMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleTimersPanelMeta;
   
   public class BattleRoyaleTimersPanel extends BattleRoyaleTimersPanelMeta implements IBattleRoyaleTimersPanelMeta
   {
       
      
      public var timerRespawn:RespawnTimer = null;
      
      public var timerAirDrop:AirDropTimer = null;
      
      private var _isInitialized:Boolean = false;
      
      public function BattleRoyaleTimersPanel()
      {
         super();
         alpha = 0;
      }
      
      override protected function onDispose() : void
      {
         this.timerRespawn.dispose();
         this.timerRespawn = null;
         this.timerAirDrop.dispose();
         this.timerAirDrop = null;
         super.onDispose();
      }
      
      public function as_setAirDropTime(param1:int) : void
      {
         this.timerAirDrop.setTime(param1);
         this.applyTime(param1);
      }
      
      public function as_setIsReplay(param1:Boolean) : void
      {
         this.timerRespawn.isReplay = param1;
         this.timerAirDrop.isReplay = param1;
      }
      
      public function as_setRespawnTime(param1:int) : void
      {
         this.timerRespawn.setTime(param1);
         this.applyTime(param1);
      }
      
      private function applyTime(param1:int) : void
      {
         if(param1 > 0 && !this._isInitialized)
         {
            alpha = 1;
            this._isInitialized = true;
         }
      }
   }
}
