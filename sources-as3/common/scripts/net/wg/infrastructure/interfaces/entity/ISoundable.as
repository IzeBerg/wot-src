package net.wg.infrastructure.interfaces.entity
{
   import flash.events.IEventDispatcher;
   
   public interface ISoundable extends IEventDispatcher
   {
       
      
      function canPlaySound(param1:String) : Boolean;
      
      function getSoundType() : String;
      
      function getSoundId() : String;
   }
}
