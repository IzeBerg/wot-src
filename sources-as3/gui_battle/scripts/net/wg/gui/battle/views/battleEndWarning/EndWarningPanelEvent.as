package net.wg.gui.battle.views.battleEndWarning
{
   import flash.events.Event;
   
   public class EndWarningPanelEvent extends Event
   {
      
      public static const VISIBILITY_CHANGED:String = "endWarningVisibilityChanged";
       
      
      public function EndWarningPanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EndWarningPanelEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("EndWarningPanelEvent","type","bubbles","cancelable","sizeIndex");
      }
   }
}
