package net.wg.mock
{
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IImageData;
   import net.wg.infrastructure.managers.IImageManager;
   
   public class MockImageManager implements IImageManager
   {
       
      
      public function MockImageManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function as_loadImages(param1:Array) : void
      {
      }
      
      public function as_unloadImages(param1:Array) : void
      {
      }
      
      public function as_setImageCacheSettings(param1:int, param2:int) : void
      {
      }
      
      public final function dispose() : void
      {
      }
      
      public function getImageData(param1:String, param2:int = 1) : IImageData
      {
         return null;
      }
      
      public function hasEventListener(param1:String) : Boolean
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
   }
}
