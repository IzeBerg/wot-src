package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventStatsMeta extends IEventDispatcher
   {
       
      
      function as_updatePlayerStats(param1:Array) : void;
      
      function as_updateData(param1:String, param2:String, param3:int, param4:String) : void;
      
      function as_updateBuffs(param1:Object) : void;
   }
}
