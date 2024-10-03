package net.wg.white_tiger.gui.battle.views.wtBossWidget.events
{
   import flash.events.Event;
   
   public class BossWidgetEvent extends Event
   {
      
      public static const SHOW_BOSS_ICON_ANIMATION:String = "showBossIconAnimation";
      
      public static const SHOW_SHIELD_IDLE_ANIMATION:String = "showShieldIdleAnimation";
      
      public static const HIDE_SHIELD_IDLE_ANIMATION:String = "hideShieldIdleAnimation";
       
      
      public function BossWidgetEvent(param1:String, param2:Boolean = false, param3:Boolean = true)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new BossWidgetEvent(type,bubbles,cancelable);
      }
   }
}
