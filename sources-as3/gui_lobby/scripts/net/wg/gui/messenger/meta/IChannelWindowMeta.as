package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IChannelWindowMeta extends IEventDispatcher
   {
       
      
      function showFAQWindowS() : void;
      
      function getClientIDS() : Number;
      
      function as_setTitle(param1:String) : void;
      
      function as_setCloseEnabled(param1:Boolean) : void;
   }
}
