package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAmmunitionPanelInjectMeta extends IEventDispatcher
   {
       
      
      function onHangarSwitchAnimCompleteS(param1:Boolean) : void;
      
      function as_setPanelSize(param1:int, param2:int, param3:int) : void;
      
      function as_setHelpLayout(param1:Object) : void;
      
      function as_clearHelpLayout() : void;
   }
}
