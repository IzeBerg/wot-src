package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleVehicleConfiguratorMeta extends IEventDispatcher
   {
       
      
      function onModuleMouseOverS(param1:uint) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_updateModuleInfoPanel(param1:Object) : void;
      
      function as_updateChoiceInfoPanel(param1:Object) : void;
   }
}
