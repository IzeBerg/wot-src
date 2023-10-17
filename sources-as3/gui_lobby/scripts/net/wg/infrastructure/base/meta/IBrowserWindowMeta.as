package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBrowserWindowMeta extends IEventDispatcher
   {
       
      
      function as_configure(param1:String, param2:Boolean, param3:Boolean, param4:Boolean) : void;
      
      function as_setSize(param1:Number, param2:Number) : void;
   }
}
