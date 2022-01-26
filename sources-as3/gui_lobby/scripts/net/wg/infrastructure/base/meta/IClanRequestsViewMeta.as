package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanRequestsViewMeta extends IEventDispatcher
   {
       
      
      function acceptRequestS(param1:Number) : void;
      
      function declineRequestS(param1:Number) : void;
      
      function sendInviteS(param1:Number) : void;
   }
}
