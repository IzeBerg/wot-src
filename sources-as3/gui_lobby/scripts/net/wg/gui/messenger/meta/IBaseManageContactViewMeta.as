package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBaseManageContactViewMeta extends IEventDispatcher
   {
       
      
      function checkTextS(param1:String) : void;
      
      function as_setLabel(param1:String) : void;
      
      function as_setInputText(param1:String) : void;
   }
}
