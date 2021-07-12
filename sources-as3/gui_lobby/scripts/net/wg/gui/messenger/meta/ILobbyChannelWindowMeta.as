package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ILobbyChannelWindowMeta extends IEventDispatcher
   {
       
      
      function onWarningCloseS() : void;
      
      function as_getMembersDP() : Object;
      
      function as_hideMembersList() : void;
      
      function as_showWarning(param1:String) : void;
   }
}
