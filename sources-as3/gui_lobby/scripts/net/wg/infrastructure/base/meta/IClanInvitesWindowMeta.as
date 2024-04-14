package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanInvitesWindowMeta extends IEventDispatcher
   {
       
      
      function onInvitesButtonClickS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setClanInfo(param1:Object) : void;
      
      function as_setHeaderState(param1:Object) : void;
      
      function as_setClanEmblem(param1:String) : void;
      
      function as_setControlsEnabled(param1:Boolean) : void;
   }
}
