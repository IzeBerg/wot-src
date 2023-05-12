package net.wg.gui.battle.views.gameMessagesPanel.events
{
   import flash.events.Event;
   
   public class GameMessagesPanelEvent extends Event
   {
      
      public static const MESSAGES_STARTED_PLAYING:String = "messagesStartedPlaying";
      
      public static const MESSAGES_POST_INTRO_PLAYING:String = "messagesPostIntroPlaying";
      
      public static const MESSAGES_OUTRO_PLAYING:String = "messagesOutroPlaying";
      
      public static const MESSAGES_ENDED_PLAYING:String = "MessagesEndedPlaying";
      
      public static const ALL_MESSAGES_ENDED_PLAYING:String = "allMessagesEndedPlaying";
       
      
      public var messageType:String = "";
      
      public var messageModificator:String = "";
      
      public var messageId:int = -1;
      
      public function GameMessagesPanelEvent(param1:String, param2:String, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.messageType = param2;
      }
      
      override public function clone() : Event
      {
         return new GameMessagesPanelEvent(type,this.messageType,bubbles,cancelable);
      }
   }
}
