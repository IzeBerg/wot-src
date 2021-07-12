package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanPersonalInvitesWindowMeta extends IEventDispatcher
   {
       
      
      function as_setActualInvitesText(param1:String) : void;
      
      function as_showWaitingAnimation(param1:Boolean) : void;
   }
}
