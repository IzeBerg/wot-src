package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventBossTeleportViewMeta extends IEventDispatcher
   {
       
      
      function onTeleportPointClickS(param1:String) : void;
      
      function onCancelS() : void;
   }
}
