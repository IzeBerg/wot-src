package net.wg.mock
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ISoundManager;
   
   public class MockSoundManager implements ISoundManager
   {
       
      
      public function MockSoundManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function addSoundsHdlrs(param1:ISoundable) : void
      {
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function playControlsSnd(param1:String, param2:String, param3:String) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function removeSoundHdlrs(param1:ISoundable) : void
      {
      }
      
      public function soundEventHandlerS(param1:String, param2:String, param3:String, param4:String) : void
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
   }
}
