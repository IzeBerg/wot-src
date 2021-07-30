package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMapsTrainingPrebattleTimerMeta extends IEventDispatcher
   {
       
      
      function as_update(param1:Array, param2:String) : void;
      
      function as_setSide(param1:String) : void;
   }
}
