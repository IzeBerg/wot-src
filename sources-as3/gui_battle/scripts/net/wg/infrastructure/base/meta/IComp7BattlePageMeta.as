package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IComp7BattlePageMeta extends IEventDispatcher
   {
       
      
      function showHelpS() : void;
      
      function moveSpaceS(param1:Number, param2:Number, param3:Number) : void;
      
      function notifyCursorOver3dSceneS(param1:Boolean) : void;
      
      function notifyCursorDraggingS(param1:Boolean) : void;
      
      function as_updateVehicleStatus(param1:Object) : void;
      
      function as_onVehicleSelectionConfirmed() : void;
      
      function as_onBattleStarted() : void;
      
      function as_onPrebattleInputStateLocked(param1:Boolean) : void;
   }
}
