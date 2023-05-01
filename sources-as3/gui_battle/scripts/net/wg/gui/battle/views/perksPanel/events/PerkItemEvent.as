package net.wg.gui.battle.views.perksPanel.events
{
   import flash.events.Event;
   
   public class PerkItemEvent extends Event
   {
      
      public static const HIDE_ANIM_COMPLETE:String = "hideAnimComplete";
      
      public static const SHOW_ANIM_COMPLETE:String = "showAnimComplete";
       
      
      public function PerkItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
