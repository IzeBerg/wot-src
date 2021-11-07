package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicScorePanelMeta extends IEventDispatcher
   {
       
      
      function as_updateBases(param1:int, param2:int, param3:int) : void;
      
      function as_updateHeadquarterHealth(param1:int, param2:Number) : void;
      
      function as_headquarterDestroyed(param1:int) : void;
      
      function as_updatePointsForBase(param1:int, param2:Number) : void;
      
      function as_setTarget(param1:int, param2:int) : void;
      
      function as_setPrebattleTimer(param1:int) : void;
   }
}
