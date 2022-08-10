package net.wg.infrastructure.helpers
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class LoaderEx extends Loader
   {
       
      
      public var params:Object = null;
      
      public function LoaderEx()
      {
         super();
      }
      
      public function loadEx(param1:URLRequest, param2:Object = null, param3:LoaderContext = null) : void
      {
         this.params = param2;
         load(param1,param3);
      }
   }
}
