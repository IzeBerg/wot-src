package net.wg.infrastructure.events
{
   import flash.events.Event;
   
   public class VoiceChatEvent extends Event
   {
      
      public static const START_SPEAKING:String = "startSpeaking";
      
      public static const STOP_SPEAKING:String = "stopSpeaking";
       
      
      private var _accountDBID:Number;
      
      private var _himself:Boolean;
      
      public function VoiceChatEvent(param1:String, param2:Number, param3:Boolean)
      {
         super(param1);
         this._accountDBID = param2;
         this._himself = param3;
      }
      
      public function getAccountDBID() : Number
      {
         return this._accountDBID;
      }
      
      public function isHimself() : Boolean
      {
         return this._himself;
      }
   }
}
