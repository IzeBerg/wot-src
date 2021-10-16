package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVoiceChatManagerMeta extends IEventDispatcher
   {
       
      
      function isPlayerSpeakingS(param1:Number) : Boolean;
      
      function isVivoxS() : Boolean;
      
      function isYYS() : Boolean;
      
      function isVOIPEnabledS() : Boolean;
      
      function as_onPlayerSpeak(param1:Number, param2:Boolean, param3:Boolean) : void;
   }
}
