package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface INYMainViewMeta extends IEventDispatcher
   {
       
      
      function onEscPressS() : void;
      
      function onSwitchViewS() : void;
      
      function as_switchView(param1:uint) : void;
   }
}
