package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicInGameRankMeta extends IEventDispatcher
   {
       
      
      function levelUpAnimationCompleteS() : void;
      
      function as_triggerLevelUp(param1:Number) : void;
      
      function as_updateProgress(param1:Number, param2:Number) : void;
      
      function as_setRank(param1:Object) : void;
   }
}
