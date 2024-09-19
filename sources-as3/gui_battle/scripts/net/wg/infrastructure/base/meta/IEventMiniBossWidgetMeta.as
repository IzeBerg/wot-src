package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEventMiniBossWidgetMeta extends IEventDispatcher
   {
       
      
      function as_setMiniBossWidgetData(param1:String, param2:Number, param3:Number, param4:Boolean) : void;
      
      function as_updateMiniBossHp(param1:Number) : void;
      
      function as_resetMiniBossWidget() : void;
   }
}
