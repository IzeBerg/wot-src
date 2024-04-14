package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IDemoPageMeta extends IEventDispatcher
   {
       
      
      function onButtonClickedS(param1:String) : void;
      
      function as_setContent(param1:Array) : void;
   }
}
