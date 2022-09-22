package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventPlayersPanelMeta extends IEventDispatcher
   {
       
      
      function as_setIsBoss(param1:Boolean) : void;
      
      function as_setBossBotInfo(param1:Object) : void;
      
      function as_updateBossBombTimer(param1:int, param2:Number, param3:Number, param4:Number) : void;
      
      function as_updateBossBotHp(param1:int, param2:int, param3:int) : void;
      
      function as_setBossBotSpotted(param1:int, param2:int) : void;
      
      function as_clearBossBotCamp(param1:int) : void;
   }
}
