package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleRoyaleVehicleInfoMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onShowIntroS() : void;
      
      function as_setData(param1:Object) : void;
      
      function as_setTabsData(param1:Array) : void;
   }
}
