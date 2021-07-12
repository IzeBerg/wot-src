package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.IView;
   
   public interface ILoaderManagerMeta extends IEventDispatcher
   {
       
      
      function viewLoadedS(param1:String, param2:String, param3:IView) : void;
      
      function viewLoadErrorS(param1:String, param2:String, param3:String) : void;
      
      function viewInitializationErrorS(param1:String, param2:String) : void;
      
      function viewLoadCanceledS(param1:String, param2:String) : void;
      
      function as_loadView(param1:Object) : void;
      
      function as_cancelLoadView(param1:String) : void;
   }
}
