package net.wg.mock
{
   import flash.events.Event;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   
   public class MockVoiceChatManager implements IVoiceChatManager
   {
       
      
      public function MockVoiceChatManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function as_onPlayerSpeak(param1:Number, param2:Boolean, param3:Boolean) : void
      {
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function isPlayerSpeakingS(param1:Number) : Boolean
      {
         return false;
      }
      
      public function isVOIPEnabledS() : Boolean
      {
         return false;
      }
      
      public function isVOIPAvailableS() : Boolean
      {
         return false;
      }
      
      public function isVivoxS() : Boolean
      {
         return false;
      }
      
      public function isYYS() : Boolean
      {
         return false;
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return false;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
      
      public function getYY() : Boolean
      {
         return false;
      }
   }
}
