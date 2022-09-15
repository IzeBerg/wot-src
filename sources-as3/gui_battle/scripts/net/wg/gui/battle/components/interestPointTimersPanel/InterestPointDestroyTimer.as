package net.wg.gui.battle.components.interestPointTimersPanel
{
   public class InterestPointDestroyTimer extends InterestPointDestroyTimerBase
   {
       
      
      public function InterestPointDestroyTimer()
      {
         super();
      }
      
      override protected function setTimerTFText(param1:String) : void
      {
         if(lastStrTime != param1)
         {
            setTTFText(param1);
         }
      }
   }
}
