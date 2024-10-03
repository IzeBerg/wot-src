package net.wg.white_tiger.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWTPlayersPanelMeta extends IEventDispatcher
   {
       
      
      function as_setIsBoss(param1:Boolean) : void;
      
      function as_setBossBotInfo(param1:Object) : void;
      
      function as_updateBossBotHp(param1:int, param2:int, param3:int) : void;
      
      function as_setBossBotSpotted(param1:int, param2:int) : void;
      
      function as_clearBossBotCamp(param1:int) : void;
      
      function as_setAllBossBotCampsOffline() : void;
      
      function as_updateCampInfoStatus(param1:int) : void;
      
      function as_updateGeneratorCaptureTimer(param1:int, param2:Number, param3:Number, param4:Number, param5:Number) : void;
      
      function as_setIsDestroyed(param1:int, param2:Boolean) : void;
      
      function as_resetGeneratorCaptureTimer(param1:int) : void;
      
      function as_updateGeneratorDownTime(param1:int, param2:Number, param3:Number, param4:String) : void;
   }
}
