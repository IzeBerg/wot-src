package net.wg.data.constants
{
   public class Time
   {
      
      public static const MILLISECOND_IN_SECOND:uint = 1000;
      
      public static const SECONDS_IN_MINUTE:uint = 60;
      
      public static const MINUTES_IN_HOUR:uint = 60;
      
      public static const SECONDS_IN_HOUR:uint = SECONDS_IN_MINUTE * MINUTES_IN_HOUR;
      
      public static const HOURS_IN_DAY:uint = 24;
      
      public static const SECONDS_IN_DAY:uint = SECONDS_IN_HOUR * HOURS_IN_DAY;
      
      public static const DAYS_IN_WEEK:uint = 7;
      
      public static const WEEKS_IN_MONTH:uint = 4;
      
      public static const MONTHS_IN_YEAR:uint = 12;
      
      public static const DAYS_IN_YEAR:uint = 365;
      
      public static const DAYS_IN_LEAP_YEAR:uint = 366;
      
      public static const MIN_MONTH_DAYS_COUNT:uint = 28;
      
      public static const MAX_MONTH_DAYS_COUNT:uint = 31;
      
      public static const MILLISECOND:uint = 1;
      
      public static const SECOND:uint = MILLISECOND * MILLISECOND_IN_SECOND;
      
      public static const MINUTE:uint = SECOND * SECONDS_IN_MINUTE;
      
      public static const HOUR:uint = MINUTE * MINUTES_IN_HOUR;
      
      public static const DAY:uint = HOUR * HOURS_IN_DAY;
      
      public static const WEEK:uint = DAY * DAYS_IN_WEEK;
      
      public static const MONTH:uint = WEEK * WEEKS_IN_MONTH;
      
      public static const FIRST_DAY_IN_MONTH:uint = 1;
      
      public static const PM:String = "PM";
      
      public static const AM:String = "AM";
      
      public static const PREFIX:String = "0";
      
      public static const DELIMITER:String = ":";
      
      public static const BETWEEN_TIMES:String = " - ";
      
      public static const COUNT_SYMBOLS_WITH_PREFIX:int = 2;
       
      
      public function Time()
      {
         super();
      }
   }
}
