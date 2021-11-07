package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesAwardsViewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function onSoundTriggerS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
   }
}
