package net.wg.gui.bootcamp.messageWindow.events
{
   import flash.events.Event;
   
   public final class MessageViewEvent extends Event
   {
      
      public static const MESSAGE_REMOVED:String = "messageRemoved";
      
      public static const MESSAGE_DISAPPEAR:String = "messageDisappear";
      
      public static const MESSAGE_EXECUTED:String = "messageExecuted";
      
      public static const MESSAGE_OPEN_NATIONS:String = "openNations";
      
      public static const REWARD_ICON_LOADED:String = "rewardIconLoaded";
      
      public static const REWARD_ANIMATION_COMPLETE:String = "rewardAnimationComplete";
      
      public static const REWARD_ANIMATION_START:String = "rewardAnimationStart";
       
      
      public function MessageViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new MessageViewEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ManualViewEvent","type","bubbles","cancelable");
      }
   }
}
