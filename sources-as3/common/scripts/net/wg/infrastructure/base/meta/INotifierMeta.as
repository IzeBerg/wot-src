package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface INotifierMeta extends IEventDispatcher
   {
       
      
      function showDialogS(param1:String, param2:String, param3:String, param4:Array, param5:Object) : void;
      
      function showI18nDialogS(param1:String, param2:String, param3:Object) : void;
   }
}
