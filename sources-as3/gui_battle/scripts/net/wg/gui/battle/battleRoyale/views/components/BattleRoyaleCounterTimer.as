package net.wg.gui.battle.battleRoyale.views.components
{
   import net.wg.gui.battle.views.destroyTimers.SecondaryTimer;
   import net.wg.gui.battle.views.destroyTimers.data.StatusNotificationVO;
   
   public class BattleRoyaleCounterTimer extends SecondaryTimer
   {
       
      
      public function BattleRoyaleCounterTimer()
      {
         super();
      }
      
      override public function cropSize() : Boolean
      {
         if(this.timerContainer != null)
         {
            this.timerContainer.isSmall = true;
         }
         return true;
      }
      
      override public function fullSize() : Boolean
      {
         if(this.timerContainer != null)
         {
            this.timerContainer.isSmall = false;
         }
         return true;
      }
      
      override public function updateData(param1:StatusNotificationVO) : void
      {
         super.updateData(param1);
         this.updateCounter(param1.additionalInfo,param1.additionalState);
      }
      
      private function updateCounter(param1:String, param2:int) : void
      {
         if(this.timerContainer != null)
         {
            this.timerContainer.updateCounterData(param1,param2);
         }
      }
      
      private function get timerContainer() : BattleRoyaleCounterTimerContainer
      {
         return container as BattleRoyaleCounterTimerContainer;
      }
   }
}
