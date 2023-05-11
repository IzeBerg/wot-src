package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICalloutPanelMeta extends IEventDispatcher
   {
       
      
      function onHideCompletedS() : void;
      
      function onHideStartS() : void;
      
      function as_setData(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void;
      
      function as_setHideData(param1:Boolean, param2:String) : void;
   }
}
