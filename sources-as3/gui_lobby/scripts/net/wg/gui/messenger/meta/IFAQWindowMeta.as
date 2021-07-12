package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFAQWindowMeta extends IEventDispatcher
   {
       
      
      function onLinkClickedS(param1:String) : void;
      
      function as_appendText(param1:String) : void;
   }
}
