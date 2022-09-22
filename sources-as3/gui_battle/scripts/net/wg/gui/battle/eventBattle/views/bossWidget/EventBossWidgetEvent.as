package net.wg.gui.battle.eventBattle.views.bossWidget
{
   import flash.events.Event;
   
   public class EventBossWidgetEvent extends Event
   {
      
      public static const SHOW_BOSS_ICON_ANIMATION:String = "showBossIconAnimation";
      
      public static const SHOW_SHIELD_IDLE_ANIMATION:String = "showShieldIdleAnimation";
      
      public static const HIDE_SHIELD_IDLE_ANIMATION:String = "hideShieldIdleAnimation";
       
      
      public function EventBossWidgetEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new EventBossWidgetEvent(type,bubbles,cancelable);
      }
   }
}
