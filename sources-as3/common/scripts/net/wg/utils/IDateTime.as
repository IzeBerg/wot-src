package net.wg.utils
{
   public interface IDateTime
   {
       
      
      function cloneDate(param1:Date) : Date;
      
      function shiftDate(param1:Date, param2:int) : Date;
      
      function timeDiff(param1:Date, param2:Date) : Number;
      
      function now() : Date;
      
      function isPast(param1:Date) : Boolean;
      
      function isFuture(param1:Date) : Boolean;
      
      function isSameDay(param1:Date, param2:Date) : Boolean;
      
      function isSameMonth(param1:Date, param2:Date) : Boolean;
      
      function isCurrentMonth(param1:Date) : Boolean;
      
      function isToday(param1:Date) : Boolean;
      
      function getMonthDaysCount(param1:Date) : uint;
      
      function getMonthName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String;
      
      function getDayName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String;
      
      function toPyTimestamp(param1:Date) : Number;
      
      function fromPyTimestamp(param1:Number) : Date;
      
      function getAS3FirstDayOfWeek() : int;
      
      function pyDayNumToAS3DayNum(param1:int) : int;
      
      function as3DayNumToPyDayNum(param1:int) : int;
      
      function pyMonthNumToAS3MonthNum(param1:int) : int;
      
      function as3MonthNumToPyMonthNum(param1:int) : int;
      
      function convertToTwelveHourFormat(param1:int) : int;
      
      function hourIsAm(param1:int) : Boolean;
      
      function getAmPmPrefix(param1:int) : String;
      
      function formatSecondsToString(param1:int) : String;
   }
}
