package net.wg.gui.battle.views.situationIndicators.events
{
   import flash.events.Event;
   
   public class SituationIndicatorsPanelEvent extends Event
   {
      
      public static const HIDE_ITEM_ANIM_COMPLETE:String = "hideItemAnimComplete";
      
      public static const SHOW_ITEM_ANIM_COMPLETE:String = "showItemAnimComplete";
       
      
      public function SituationIndicatorsPanelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
