package net.wg.mock
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.ILoaderManager;
   
   public class MockLoaderManager implements ILoaderManager
   {
       
      
      public function MockLoaderManager()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
      }
      
      public function as_cancelLoadView(param1:String) : void
      {
      }
      
      public function as_loadView(param1:Object) : void
      {
      }
      
      public function getStats() : String
      {
         return "";
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return false;
      }
      
      public function initLibraries(param1:DisplayObjectContainer) : void
      {
      }
      
      public function loadLibraries(param1:Vector.<String>) : void
      {
      }
      
      public function viewInitializationErrorS(param1:String, param2:String) : void
      {
      }
      
      public function viewLoadCanceledS(param1:String, param2:String) : void
      {
      }
      
      public function viewLoadErrorS(param1:String, param2:String, param3:String) : void
      {
      }
      
      public function viewLoadedS(param1:String, param2:String, param3:IView) : void
      {
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
      }
      
      public function stopLoadingByViewNames(param1:Array) : void
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
