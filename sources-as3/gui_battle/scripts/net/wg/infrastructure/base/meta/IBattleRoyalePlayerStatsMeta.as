package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyalePlayerStatsMeta extends IEventDispatcher
   {
       
      
      function as_setInitData(param1:String) : void;
      
      function as_setData(param1:Array) : void;
      
      function as_setStpCoins(param1:int, param2:int) : void;
   }
}
