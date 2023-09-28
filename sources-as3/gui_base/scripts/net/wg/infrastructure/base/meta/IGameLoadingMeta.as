package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGameLoadingMeta extends IEventDispatcher
   {
       
      
      function as_setLocale(param1:String) : void;
      
      function as_setVersion(param1:String) : void;
      
      function as_setInfo(param1:String) : void;
      
      function as_setProgress(param1:Number) : void;
      
      function as_updateStage(param1:Number, param2:Number, param3:Number) : void;
   }
}
