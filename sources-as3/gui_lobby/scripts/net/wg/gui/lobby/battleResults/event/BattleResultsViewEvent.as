package net.wg.gui.lobby.battleResults.event
{
   import flash.events.Event;
   
   public class BattleResultsViewEvent extends Event
   {
      
      public static const APPLIED_PREMIUM_BONUS:String = "appliedPremiumBonus";
      
      public static const SHOW_DETAILS_PREMIUM:String = "showDetailsPremium";
      
      public static const SHOW_PROGRESSIVE_REWARD_VIEW:String = "ShowProgressiveRewardView";
      
      public static const BATTLE_QUEUE_ENTERED:String = "BattleLoadingStarted";
      
      public static const BATTLE_QUEUE_EXITED:String = "BattleLoadingFinished";
       
      
      public function BattleResultsViewEvent(param1:String)
      {
         super(param1,true,true);
      }
   }
}
