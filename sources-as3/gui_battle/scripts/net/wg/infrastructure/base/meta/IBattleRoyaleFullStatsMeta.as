package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyaleFullStatsMeta extends IEventDispatcher
   {
       
      
      function as_setData(param1:Object) : void;
      
      function as_updateScore(param1:int, param2:int, param3:String) : void;
      
      function as_updateNationsVehiclesCounter(param1:Object) : void;
   }
}
