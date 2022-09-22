package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesRewardsRanksMeta extends IEventDispatcher
   {
       
      
      function onRequestDataS(param1:Number, param2:String, param3:Number) : void;
      
      function as_setDivisionsData(param1:Array, param2:Boolean) : void;
      
      function as_setRewards(param1:Array, param2:Boolean) : void;
   }
}
