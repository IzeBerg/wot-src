package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IConnectToSecureChannelWindowMeta extends IEventDispatcher
   {
       
      
      function sendPasswordS(param1:String) : void;
      
      function cancelPasswordS() : void;
      
      function as_infoMessage(param1:String) : void;
   }
}
