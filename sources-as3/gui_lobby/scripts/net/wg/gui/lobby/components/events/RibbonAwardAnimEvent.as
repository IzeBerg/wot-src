package net.wg.gui.lobby.components.events
{
   import flash.events.Event;
   
   public class RibbonAwardAnimEvent extends Event
   {
      
      public static const AWARD_FADE_IN_COMPLETE:String = "awardFadeInComplete";
      
      public static const AWARD_BLINK_COMPLETE:String = "awardBlinkComplete";
      
      public static const AWARD_FADE_OUT_COMPLETE:String = "awardFadeOutComplete";
      
      public static const RIBBON_FADE_IN_COMPLETE:String = "ribbonFadeInComplete";
      
      public static const RIBBON_FADE_OUT_COMPLETE:String = "ribbonFadeOutComplete";
      
      public static const CONSUMABLE_FADE_IN:String = "consumableFadeIn";
      
      public static const MONEY_FADE_IN:String = "moneyFadeIn";
       
      
      public function RibbonAwardAnimEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new RibbonAwardAnimEvent(type,bubbles,cancelable);
      }
   }
}
