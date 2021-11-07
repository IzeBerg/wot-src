package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITutorialDialogMeta extends IEventDispatcher
   {
       
      
      function submitS() : void;
      
      function cancelS() : void;
      
      function as_setContent(param1:Object) : void;
      
      function as_updateContent(param1:Object) : void;
   }
}
