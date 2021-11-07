package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISuperPlatoonPanelMeta extends IEventDispatcher
   {
       
      
      function as_setPlatoonTitle(param1:String) : void;
      
      function as_setMaxDisplayedInviteMessages(param1:int) : void;
   }
}
