package net.wg.gui.prebattle.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IReceivedInviteWindowMeta extends IEventDispatcher
   {
       
      
      function acceptInviteS() : void;
      
      function declineInviteS() : void;
      
      function cancelInviteS() : void;
      
      function as_setTitle(param1:String) : void;
      
      function as_setReceivedInviteInfo(param1:Object) : void;
   }
}
