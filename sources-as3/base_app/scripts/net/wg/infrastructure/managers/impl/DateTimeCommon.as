package net.wg.infrastructure.managers.impl
{
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Time;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IDateTime;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class DateTimeCommon implements IDateTime
   {
      
      private static var stringProvider:TextField = new TextField();
      
      private static const DAYS_KEY:String = "{days}";
       
      
      public function DateTimeCommon()
      {
         super();
      }
      
      private static function addLeadingZero(param1:Number) : String
      {
         var _loc2_:String = String(param1);
         if(param1 < 10 && param1 > -1)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      private static function get asserter() : IAssertable
      {
         return App.utils.asserter;
      }
      
      public function as3DayNumToPyDayNum(param1:int) : int
      {
         return param1 == 0 ? int(7) : int(param1);
      }
      
      public function as3MonthNumToPyMonthNum(param1:int) : int
      {
         return param1 + 1;
      }
      
      public function cloneDate(param1:Date) : Date
      {
         return new Date(param1.time);
      }
      
      public function convertToTwelveHourFormat(param1:int) : int
      {
         var _loc2_:String = "Invalid value of hour";
         asserter.assert(0 <= param1 && param1 <= Time.HOURS_IN_DAY,_loc2_);
         var _loc3_:int = Time.HOURS_IN_DAY >> 1;
         var _loc4_:int = param1 > _loc3_ ? int(param1 - _loc3_) : int(param1);
         if(param1 == 0)
         {
            _loc4_ = _loc3_;
         }
         return _loc4_;
      }
      
      public function formatSecondsToDDHHMMSS(param1:int, param2:String = "  ", param3:String = ":") : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         var _loc4_:int = param1 / Time.SECONDS_IN_DAY | 0;
         if(_loc4_ > 0)
         {
            param1 -= _loc4_ * Time.SECONDS_IN_DAY;
            _loc5_ = param1 / Time.SECONDS_IN_HOUR | 0;
            _loc6_ = (param1 - _loc5_ * Time.SECONDS_IN_HOUR) / Time.MINUTES_IN_HOUR | 0;
            _loc7_ = param1 - _loc5_ * Time.SECONDS_IN_HOUR - _loc6_ * Time.SECONDS_IN_MINUTE;
            _loc8_ = this.getLocalizedStr(COMMON.DURATION_DAYS);
            return StringUtils.replaceOnce(_loc8_,DAYS_KEY,addLeadingZero(_loc4_)) + param2 + addLeadingZero(_loc5_) + param3 + addLeadingZero(_loc6_) + param3 + addLeadingZero(_loc7_);
         }
         return this.formatSecondsToHHMMSS(param1);
      }
      
      public function formatSecondsToHHMMSS(param1:int, param2:String = ":") : String
      {
         var _loc3_:int = param1 / Time.SECONDS_IN_HOUR | 0;
         var _loc4_:int = (param1 - _loc3_ * Time.SECONDS_IN_HOUR) / Time.MINUTES_IN_HOUR | 0;
         var _loc5_:int = param1 - _loc3_ * Time.SECONDS_IN_HOUR - _loc4_ * Time.SECONDS_IN_MINUTE;
         return addLeadingZero(_loc3_) + param2 + addLeadingZero(_loc4_) + param2 + addLeadingZero(_loc5_);
      }
      
      public function formatSecondsToString(param1:int) : String
      {
         var _loc2_:int = Math.floor(param1 / Time.SECONDS_IN_MINUTE);
         param1 = Math.floor(param1 % Time.SECONDS_IN_MINUTE);
         return (_loc2_ < 10 ? "0" + _loc2_ : _loc2_) + ":" + (param1 < 10 ? "0" + param1 : param1);
      }
      
      public function fromPyTimestamp(param1:Number) : Date
      {
         return new Date(param1 * Time.MILLISECOND_IN_SECOND);
      }
      
      public function getAS3FirstDayOfWeek() : int
      {
         var _loc1_:int = App.utils.getFirstDayOfWeekS();
         return this.pyDayNumToAS3DayNum(_loc1_);
      }
      
      public function getAmPmPrefix(param1:int) : String
      {
         return !!this.hourIsAm(param1) ? Time.AM : Time.PM;
      }
      
      public function getDayName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String
      {
         if(!param2)
         {
            param1 = this.as3DayNumToPyDayNum(param1);
         }
         var _loc6_:String = !!param3 ? this.getFullWeekdayName(param1) : this.getShortWeekDayName(param1);
         var _loc7_:String = App.utils.locale.makeString(_loc6_);
         if(param4)
         {
            _loc7_ = App.utils.changeStringCasingS(_loc7_,true,null);
         }
         else if(param5)
         {
            _loc7_ = App.utils.changeStringCasingS(_loc7_,false,null);
         }
         return _loc7_;
      }
      
      public function getMonthDaysCount(param1:Date) : uint
      {
         var _loc2_:Date = this.cloneDate(param1);
         var _loc3_:uint = _loc2_.date = Time.MIN_MONTH_DAYS_COUNT;
         while(true)
         {
            _loc2_ = this.shiftDate(_loc2_,Time.DAY);
            if(!this.isSameMonth(_loc2_,param1))
            {
               break;
            }
            _loc3_ += 1;
         }
         return _loc3_;
      }
      
      public function getMonthName(param1:int, param2:Boolean = true, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false) : String
      {
         if(!param2)
         {
            param1 = this.as3MonthNumToPyMonthNum(param1);
         }
         var _loc6_:String = !!param3 ? this.getFullMonthName(param1) : this.getShortMonthName(param1);
         var _loc7_:String = App.utils.locale.makeString(_loc6_);
         if(param4)
         {
            _loc7_ = App.utils.changeStringCasingS(_loc7_,true,null);
         }
         else if(param5)
         {
            _loc7_ = App.utils.changeStringCasingS(_loc7_,false,null);
         }
         return _loc7_;
      }
      
      public function hourIsAm(param1:int) : Boolean
      {
         return param1 < Time.HOURS_IN_DAY >> 1;
      }
      
      public function isCurrentMonth(param1:Date) : Boolean
      {
         return this.isSameMonth(param1,this.now());
      }
      
      public function isFuture(param1:Date) : Boolean
      {
         return this.timeDiff(this.now(),param1) < 0;
      }
      
      public function isPast(param1:Date) : Boolean
      {
         return this.timeDiff(this.now(),param1) > 0;
      }
      
      public function isSameDay(param1:Date, param2:Date) : Boolean
      {
         return param1.fullYear == param2.fullYear && param1.month == param2.month && param1.date == param2.date;
      }
      
      public function isSameMonth(param1:Date, param2:Date) : Boolean
      {
         return param1.fullYear == param2.fullYear && param1.month == param2.month;
      }
      
      public function isToday(param1:Date) : Boolean
      {
         return this.isSameDay(param1,this.now());
      }
      
      public function now() : Date
      {
         return new Date();
      }
      
      public function pyDayNumToAS3DayNum(param1:int) : int
      {
         return param1 == 7 ? int(0) : int(param1);
      }
      
      public function pyMonthNumToAS3MonthNum(param1:int) : int
      {
         return param1 - 1;
      }
      
      public function shiftDate(param1:Date, param2:int) : Date
      {
         return new Date(param1.time + param2);
      }
      
      public function timeDiff(param1:Date, param2:Date) : Number
      {
         return param1.time - param2.time;
      }
      
      public function toPyTimestamp(param1:Date) : Number
      {
         return param1.time / Time.SECOND ^ 0;
      }
      
      protected function getShortMonthName(param1:int) : String
      {
         throw new AbstractException("DateTime.getShortMonthName" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function getFullMonthName(param1:int) : String
      {
         throw new AbstractException("DateTime.getFullMonthName" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function getShortWeekDayName(param1:int) : String
      {
         throw new AbstractException("DateTime.getShortWeekDayName" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function getFullWeekdayName(param1:int) : String
      {
         throw new AbstractException("DateTime.getFullWeekdayName" + Errors.ABSTRACT_INVOKE);
      }
      
      private function getLocalizedStr(param1:String) : String
      {
         stringProvider.text = param1;
         return stringProvider.text;
      }
   }
}
