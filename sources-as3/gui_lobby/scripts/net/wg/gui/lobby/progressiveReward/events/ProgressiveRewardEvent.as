package net.wg.gui.lobby.progressiveReward.events
{
   import flash.events.Event;
   
   public class ProgressiveRewardEvent extends Event
   {
      
      public static const OPEN_BTN_CLICK:String = "openBtnClick";
      
      public static const LINK_BTN_CLICK:String = "pre_linkBtnClick";
       
      
      private var _flag:Boolean;
      
      public function ProgressiveRewardEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._flag = param2;
      }
      
      override public function clone() : Event
      {
         return new ProgressiveRewardEvent(type,this._flag,bubbles,cancelable);
      }
      
      public function getFlag() : Boolean
      {
         return this._flag;
      }
   }
}
