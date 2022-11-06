package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IDebugPanelMeta extends IEventDispatcher
   {
       
      
      function as_updatePingInfo(param1:String) : void;
      
      function as_updateFPSInfo(param1:String) : void;
      
      function as_updateLagInfo(param1:Boolean) : void;
      
      function as_updatePingFPSInfo(param1:String, param2:String) : void;
      
      function as_updatePingFPSLagInfo(param1:String, param2:String, param3:Boolean) : void;
   }
}
