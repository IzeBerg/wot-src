package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IConfirmDialogMeta extends IEventDispatcher
   {
       
      
      function submitS(param1:Boolean) : void;
      
      function as_setSettings(param1:Object) : void;
   }
}
