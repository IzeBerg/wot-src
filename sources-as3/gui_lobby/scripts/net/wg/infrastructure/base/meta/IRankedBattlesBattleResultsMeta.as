package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRankedBattlesBattleResultsMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onWidgetUpdateS() : void;
      
      function animationCheckBoxSelectedS(param1:Boolean) : void;
      
      function as_setData(param1:Object) : void;
   }
}
