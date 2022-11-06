package net.wg.gui.battle.components.preBattleTimer
{
   import flash.events.Event;
   
   public class PreBattleTimerEvent extends Event
   {
      
      public static const ALLOW_TO_SHOW_NEXT_DIGIT:String = "allowToShowNextDigit";
      
      public static const HIDDEN:String = "onDigitHidden";
      
      public static const SHOWN:String = "onDigitShown";
       
      
      public var digitID:int = -1;
      
      public function PreBattleTimerEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         this.digitID = param2;
         super(param1,param3,param4);
      }
      
      override public function clone() : Event
      {
         return new PreBattleTimerEvent(type,this.digitID,bubbles,cancelable);
      }
   }
}
