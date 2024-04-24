package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISwitchModePanelMeta extends IEventDispatcher
   {
       
      
      function switchModeS() : void;
      
      function onSelectCheckBoxAutoSquadS(param1:Boolean) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setVisible(param1:Boolean) : void;
   }
}
