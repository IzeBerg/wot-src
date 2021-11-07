package net.wg.infrastructure.managers
{
   public interface IEnvironmentManager
   {
       
      
      function quit() : void;
      
      function logoff() : void;
      
      function useEventSystem() : void;
      
      function useExternallInterface() : void;
      
      function addCallback(param1:String, param2:Function) : void;
      
      function call(... rest) : *;
      
      function envoke(param1:String) : *;
      
      function setLastResult(param1:Object) : void;
      
      function checkEnvokeReady(param1:Function, param2:Function = null) : void;
   }
}
