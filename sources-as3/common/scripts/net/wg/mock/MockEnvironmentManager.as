package net.wg.mock
{
   import net.wg.infrastructure.managers.IEnvironmentManager;
   
   public class MockEnvironmentManager implements IEnvironmentManager
   {
       
      
      public function MockEnvironmentManager()
      {
         super();
      }
      
      public function addCallback(param1:String, param2:Function) : void
      {
      }
      
      public function call(... rest) : *
      {
         return null;
      }
      
      public function envoke(param1:String) : *
      {
         return null;
      }
      
      public function logoff() : void
      {
      }
      
      public function quit() : void
      {
      }
      
      public function setLastResult(param1:Object) : void
      {
      }
      
      public function useEventSystem() : void
      {
      }
      
      public function useExternallInterface() : void
      {
      }
      
      public function checkEnvokeReady(param1:Function, param2:Function = null) : void
      {
      }
   }
}
