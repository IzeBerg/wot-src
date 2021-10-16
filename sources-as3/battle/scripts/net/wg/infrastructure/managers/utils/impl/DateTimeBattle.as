package net.wg.infrastructure.managers.utils.impl
{
   import net.wg.infrastructure.managers.impl.DateTimeCommon;
   
   public class DateTimeBattle extends DateTimeCommon
   {
       
      
      public function DateTimeBattle()
      {
         super();
      }
      
      override protected function getShortMonthName(param1:int) : String
      {
         return MENU.datetime_months_short(param1.toString());
      }
      
      override protected function getFullMonthName(param1:int) : String
      {
         return MENU.datetime_months_full(param1.toString());
      }
      
      override protected function getShortWeekDayName(param1:int) : String
      {
         return MENU.datetime_weekdays_short(param1.toString());
      }
      
      override protected function getFullWeekdayName(param1:int) : String
      {
         return MENU.datetime_weekdays_full(param1.toString());
      }
   }
}
