package net.wg.gui.battle.views.prebattleTimer
{
   import flash.events.Event;
   
   public class PrebattleTimerEvent extends Event
   {
      
      public static const ALLOW_TO_SHOW_QP:String = "onAllowToShowQP";
      
      public static const RESET_ANIM_QP:String = "onResetShowAnimQP";
      
      public static const START_HIDING:String = "onStartHiding";
       
      
      public var useAnim:Boolean = false;
      
      public function PrebattleTimerEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.useAnim = param2;
      }
      
      override public function clone() : Event
      {
         return new PrebattleTimerEvent(type,this.useAnim,bubbles,cancelable);
      }
   }
}
