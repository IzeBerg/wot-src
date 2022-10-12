package net.wg.gui.battle.comp7.views.prebattleTimer.events
{
   import flash.events.Event;
   
   public class Comp7PrebattleInfoViewEvent extends Event
   {
      
      public static const READY_BTN_CLICKED:String = "readyBtnClicked";
       
      
      public function Comp7PrebattleInfoViewEvent(param1:String, param2:Boolean = true, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new Comp7PrebattleInfoViewEvent(type,bubbles,cancelable);
      }
   }
}
