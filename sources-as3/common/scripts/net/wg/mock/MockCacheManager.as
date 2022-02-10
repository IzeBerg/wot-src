package net.wg.mock
{
   import flash.display.Loader;
   import flash.events.Event;
   import net.wg.infrastructure.managers.ICacheManager;
   
   public class MockCacheManager implements ICacheManager
   {
       
      
      public function MockCacheManager()
      {
         super();
      }
      
      public function add(param1:String, param2:Loader, param3:Class = null) : Boolean
      {
         return false;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function getClassDef(param1:String, param2:Boolean = false) : Class
      {
         return null;
      }
      
      public function getSettingsS() : Object
      {
         return null;
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function isCached(param1:String) : Boolean
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
      
      public function get enabled() : Boolean
      {
         return false;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return false;
      }
   }
}
