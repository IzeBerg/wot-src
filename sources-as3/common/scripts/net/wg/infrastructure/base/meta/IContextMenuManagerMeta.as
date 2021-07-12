package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IContextMenuManagerMeta extends IEventDispatcher
   {
       
      
      function requestOptionsS(param1:String, param2:Object = null) : void;
      
      function onOptionSelectS(param1:String) : void;
      
      function onHideS() : void;
      
      function as_setOptions(param1:Object) : void;
      
      function as_show(param1:String, param2:Object) : void;
      
      function as_hide() : void;
   }
}
