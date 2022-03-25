package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISpawnMenuMeta extends IEventDispatcher
   {
       
      
      function onBGClickS() : void;
      
      function onAutoSetBtnClickS() : void;
      
      function onResetBtnClickS() : void;
      
      function onBattleBtnClickS() : void;
      
      function onSupplySelectS(param1:String) : void;
      
      function onVehicleSelectS(param1:Number) : void;
      
      function onPointClickS(param1:String) : void;
      
      function as_setData(param1:Object, param2:Object) : void;
      
      function as_setItemsData(param1:Array, param2:Array) : void;
      
      function as_updateEntriesData(param1:Array, param2:Array, param3:Array) : void;
      
      function as_setIsWaitingPlayers(param1:Boolean) : void;
      
      function as_setIsAutoSetBtnEnabled(param1:Boolean) : void;
      
      function as_setIsResetBtnEnabled(param1:Boolean) : void;
      
      function as_setIsBattleBtnEnabled(param1:Boolean) : void;
      
      function as_setIsBootcamp(param1:Boolean) : void;
      
      function as_showMapHint(param1:Boolean, param2:uint, param3:String) : void;
   }
}
