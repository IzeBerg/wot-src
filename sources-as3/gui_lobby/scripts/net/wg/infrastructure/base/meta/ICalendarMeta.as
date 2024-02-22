package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICalendarMeta extends IEventDispatcher
   {
       
      
      function onMonthChangedS(param1:Number) : void;
      
      function onDateSelectedS(param1:Number) : void;
      
      function formatYMHeaderS(param1:Number) : String;
      
      function as_openMonth(param1:Number) : void;
      
      function as_selectDate(param1:Number) : void;
      
      function as_setMinAvailableDate(param1:Number) : void;
      
      function as_setMaxAvailableDate(param1:Number) : void;
      
      function as_setHighlightedDays(param1:Array) : void;
      
      function as_setDayTooltipType(param1:String) : void;
   }
}
