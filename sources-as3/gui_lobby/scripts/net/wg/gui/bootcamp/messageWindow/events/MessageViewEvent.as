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
      
      public static const REWARD_ANIMATION_STOP:String = "rewardAnimationStop";
      
      public static const UNLOCK_ANIMATION_START:String = "unlockAnimationStart";
       
      
      private var _id:String = "";
      
      public function MessageViewEvent(param1:String, param2:String = "", param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._id = param2;
      }
      
      override public function clone() : Event
      {
         return new MessageViewEvent(type,this.id,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ManualViewEvent","id","type","bubbles","cancelable");
      }
      
      public function get id() : String
      {
         return this._id;
      }
   }
}
