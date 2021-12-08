package net.wg.mock
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import net.wg.utils.IGameInputManager;
   
   public class MockGameInputManager implements IGameInputManager
   {
       
      
      public function MockGameInputManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function as_addKeyHandler(param1:Number, param2:String, param3:Boolean, param4:String, param5:Number) : void
      {
      }
      
      public function as_clearKeyHandler(param1:Number, param2:String) : void
      {
      }
      
      public function clearKeyHandler(param1:Number, param2:String, param3:Function) : void
      {
      }
      
      public function clearKeyHandlers() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function handleGlobalKeyEventS(param1:Number, param2:String) : void
      {
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function initStage(param1:IEventDispatcher) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function setIgnoredKeyCode(param1:Number) : void
      {
      }
      
      public function setKeyHandler(param1:Number, param2:String, param3:Function, param4:Boolean, param5:String = null, param6:Number = 0) : void
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
      
      public function as_setIgnoredKeyCode(param1:Number) : void
      {
      }
   }
}
