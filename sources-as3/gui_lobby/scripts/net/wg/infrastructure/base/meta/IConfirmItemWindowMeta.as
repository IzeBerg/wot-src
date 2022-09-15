package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IConfirmItemWindowMeta extends IEventDispatcher
   {
       
      
      function submitS(param1:Number, param2:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setSettings(param1:Object) : void;
   }
}
