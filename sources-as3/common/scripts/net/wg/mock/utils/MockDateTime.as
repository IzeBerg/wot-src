package net.wg.mock.utils
{
   import net.wg.utils.IDateTime;
   
   public class MockDateTime implements IDateTime
   {
       
      
      public function MockDateTime()
      {
         super();
      }
      
      public function as3DayNumToPyDayNum(param1:int) : int
      {
         return 0;
      }
      
      public function as3MonthNumToPyMonthNum(param1:int) : int
      {
         return 0;
      }
      
      public function cloneDate(param1:Date) : Date
      {
         return null;
      }
      
      public function convertToTwelveHourFormat(param1:int) : int
      {
         return 0;
      }
      
      public function fromPyTimestamp(param1:Number) : Date
      {
         return null;
      }
      
      public function getAS3FirstDayOfWeek() : int
      {
         return 0;
      }
      
      public function getAmPmPrefix(param1:int) : String
      {
         return "";
      }
      
      public function formatSecondsToString(param1:int) : String
      {
         return "";
      }
      
      public function getDayName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String
      {
         return "";
      }
      
      public function getMonthDaysCount(param1:Date) : uint
      {
         return 0;
      }
      
      public function getMonthName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String
      {
         return "";
      }
      
      public function hourIsAm(param1:int) : Boolean
      {
         return false;
      }
      
      public function isCurrentMonth(param1:Date) : Boolean
      {
         return false;
      }
      
      public function isFuture(param1:Date) : Boolean
      {
         return false;
      }
      
      public function isPast(param1:Date) : Boolean
      {
         return false;
      }
      
      public function isSameDay(param1:Date, param2:Date) : Boolean
      {
         return false;
      }
      
      public function isSameMonth(param1:Date, param2:Date) : Boolean
      {
         return false;
      }
      
      public function isToday(param1:Date) : Boolean
      {
         return false;
      }
      
      public function now() : Date
      {
         return null;
      }
      
      public function pyDayNumToAS3DayNum(param1:int) : int
      {
         return 0;
      }
      
      public function pyMonthNumToAS3MonthNum(param1:int) : int
      {
         return 0;
      }
      
      public function shiftDate(param1:Date, param2:int) : Date
      {
         return null;
      }
      
      public function timeDiff(param1:Date, param2:Date) : Number
      {
         return 0;
      }
      
      public function toPyTimestamp(param1:Date) : Number
      {
         return 0;
      }
   }
}
