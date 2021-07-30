package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMapsTrainingBattleLoadingMeta extends IEventDispatcher
   {
       
      
      function gotoBattleS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setDataPage(param1:Array) : void;
      
      function as_updateProgress(param1:Number) : void;
   }
}
