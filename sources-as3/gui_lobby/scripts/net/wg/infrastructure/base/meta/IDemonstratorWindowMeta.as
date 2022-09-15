package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IDemonstratorWindowMeta extends IEventDispatcher
   {
       
      
      function onGameplaySelectedS(param1:int) : void;
      
      function onLvlSelectedS(param1:int) : void;
      
      function onSpawnSelectedS(param1:int) : void;
      
      function onMapSelectedS(param1:int) : void;
      
      function onBattleStartS() : void;
      
      function as_getDP() : Object;
      
      function as_setGameplayTabs(param1:Array, param2:int) : void;
      
      function as_setSpawns(param1:Array, param2:int) : void;
      
      function as_setLevels(param1:Array, param2:int) : void;
      
      function as_enablePlatoonWarning(param1:Boolean) : void;
      
      function as_enableExtendedSettings(param1:Boolean) : void;
      
      function as_enableBattleButton(param1:Boolean) : void;
   }
}
