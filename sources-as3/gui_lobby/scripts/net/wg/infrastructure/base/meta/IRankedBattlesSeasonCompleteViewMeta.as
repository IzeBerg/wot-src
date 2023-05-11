package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesSeasonCompleteViewMeta extends IEventDispatcher
   {
       
      
      function showRatingS() : void;
      
      function closeViewS() : void;
      
      function onSoundTriggerS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setPlace(param1:String) : void;
      
      function as_setAwardsData(param1:Object) : void;
   }
}
