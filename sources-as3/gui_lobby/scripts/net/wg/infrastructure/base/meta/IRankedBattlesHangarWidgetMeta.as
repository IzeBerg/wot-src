package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesHangarWidgetMeta extends IEventDispatcher
   {
       
      
      function onWidgetClickS() : void;
      
      function onAnimationFinishedS() : void;
      
      function onSoundTriggerS(param1:String) : void;
      
      function as_setData(param1:Array) : void;
      
      function as_setBonusBattlesLabel(param1:String) : void;
   }
}
