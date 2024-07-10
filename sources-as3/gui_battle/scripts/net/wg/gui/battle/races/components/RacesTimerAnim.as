package net.wg.gui.battle.races.components
{
   import net.wg.gui.battle.components.preBattleTimer.DigitAnim;
   import net.wg.gui.battle.components.preBattleTimer.DigitsChain;
   import net.wg.gui.battle.components.preBattleTimer.PreBattleTimerEvent;
   import net.wg.gui.battle.components.preBattleTimer.TimerAnim;
   
   public class RacesTimerAnim extends TimerAnim
   {
      
      private static const CHAINS_COUNT:int = 2;
       
      
      public function RacesTimerAnim()
      {
         super();
      }
      
      override protected function createDigitChains() : Vector.<DigitsChain>
      {
         var _loc1_:Vector.<DigitsChain> = new Vector.<DigitsChain>(CHAINS_COUNT,true);
         _loc1_[0] = new RacesDigitsChain(new <DigitAnim>[secondUnit0,secondUnit1,secondUnit2,secondUnit3,secondUnit4,secondUnit5,secondUnit6,secondUnit7,secondUnit8,secondUnit9]);
         _loc1_[1] = new RacesDigitsChain(new <DigitAnim>[secondDecade0,secondDecade1,secondDecade2,secondDecade3,secondDecade4,secondDecade5,secondDecade6,secondDecade7,secondDecade8,secondDecade9]);
         RacesDigitsChain(_loc1_[0]).setDigitAnimationCallbacks(this.onDigitShown,this.onDigitHidden);
         RacesDigitsChain(_loc1_[1]).setDigitAnimationCallbacks(this.onDigitShown,this.onDigitHidden);
         return _loc1_;
      }
      
      private function onDigitShown(param1:int) : void
      {
         dispatchEvent(new PreBattleTimerEvent(PreBattleTimerEvent.SHOWN,param1));
      }
      
      private function onDigitHidden(param1:int) : void
      {
         dispatchEvent(new PreBattleTimerEvent(PreBattleTimerEvent.HIDDEN,param1));
      }
   }
}
