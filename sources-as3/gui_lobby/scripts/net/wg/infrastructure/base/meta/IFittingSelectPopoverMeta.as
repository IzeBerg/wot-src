package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IFittingSelectPopoverMeta extends IEventDispatcher
   {
       
      
      function setVehicleModuleS(param1:Number, param2:Number, param3:Boolean) : void;
      
      function upgradeVehicleModuleS(param1:int) : void;
      
      function showModuleInfoS(param1:String) : void;
      
      function setAutoRearmS(param1:Boolean) : void;
      
      function buyVehicleModuleS(param1:Number) : void;
      
      function setCurrentTabS(param1:int) : void;
      
      function listOverlayClosedS() : void;
      
      function onManageBattleAbilitiesClickedS() : void;
      
      function as_update(param1:Object) : void;
   }
}
