package org.idmedia.as3commons.util
{
   import org.idmedia.as3commons.lang.IllegalArgumentException;
   import org.idmedia.as3commons.lang.NullPointerException;
   
   public class StringUtils
   {
      
      private static const EMPTY:String = "";
      
      private static const INDEX_NOT_FOUND:int = -1;
      
      private static const PAD_LIMIT:uint = 8192;
       
      
      public function StringUtils()
      {
         super();
      }
      
      public static function toInitials(param1:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         return param1.match(/[A-Z]/g).join(EMPTY).toLowerCase();
      }
      
      public static function chomp(param1:String) : String
      {
         return chompString(param1,"(\r\n|\r|\n)");
      }
      
      public static function chompString(param1:String, param2:String) : String
      {
         if(isEmpty(param1) || param2 == null)
         {
            return param1;
         }
         return param1.replace(new RegExp(param2 + "$",EMPTY),EMPTY);
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         return param1.replace(/^\s*/,EMPTY).replace(/\s*$/,EMPTY);
      }
      
      public static function deleteSpaces(param1:String) : String
      {
         return deleteFromString(param1,/\t|\r|\n|\b/g);
      }
      
      public static function deleteWhitespace(param1:String) : String
      {
         return deleteFromString(param1,/\s/g);
      }
      
      private static function deleteFromString(param1:String, param2:RegExp) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         return param1.replace(param2,EMPTY);
      }
      
      public static function left(param1:String, param2:int) : String
      {
         if(param1 == null)
         {
            return null;
         }
         if(param2 < 0)
         {
            return EMPTY;
         }
         if(param1.length <= param2)
         {
            return param1;
         }
         return param1.substring(0,param2);
      }
      
      public static function center(param1:String, param2:int, param3:String) : String
      {
         if(param1 == null || param2 <= 0)
         {
            return param1;
         }
         if(isEmpty(param3))
         {
            param3 = " ";
         }
         var _loc4_:int = param1.length;
         var _loc5_:int = param2 - _loc4_;
         if(_loc5_ <= 0)
         {
            return param1;
         }
         param1 = leftPad(param1,_loc4_ + _loc5_ / 2,param3);
         return rightPad(param1,param2,param3);
      }
      
      public static function leftPad(param1:String, param2:int, param3:String) : String
      {
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         if(isEmpty(param3))
         {
            param3 = " ";
         }
         var _loc4_:int = param3.length;
         var _loc5_:int = param1.length;
         var _loc6_:int = param2 - _loc5_;
         if(_loc6_ <= 0)
         {
            return param1;
         }
         if(_loc4_ == 1 && _loc6_ <= PAD_LIMIT)
         {
            return leftPadChar(param1,param2,param3.charAt(0));
         }
         if(_loc6_ == _loc4_)
         {
            return param3.concat(param1);
         }
         if(_loc6_ < _loc4_)
         {
            return param3.substring(0,_loc6_).concat(param1);
         }
         _loc7_ = new Array();
         _loc8_ = param3.split("");
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc7_[_loc9_] = _loc8_[_loc9_ % _loc4_];
            _loc9_++;
         }
         return _loc7_.join("").concat(param1);
      }
      
      public static function leftPadChar(param1:String, param2:int, param3:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:int = param2 - param1.length;
         if(_loc4_ <= 0)
         {
            return param1;
         }
         if(_loc4_ > PAD_LIMIT)
         {
            return leftPad(param1,param2,param3);
         }
         return padding(_loc4_,param3).concat(param1);
      }
      
      public static function rightPad(param1:String, param2:int, param3:String) : String
      {
         var _loc7_:Array = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         if(isEmpty(param3))
         {
            param3 = " ";
         }
         var _loc4_:int = param3.length;
         var _loc5_:int = param1.length;
         var _loc6_:int = param2 - _loc5_;
         if(_loc6_ <= 0)
         {
            return param1;
         }
         if(_loc4_ == 1 && _loc6_ <= PAD_LIMIT)
         {
            return rightPadChar(param1,param2,param3.charAt(0));
         }
         if(_loc6_ == _loc4_)
         {
            return param1.concat(param3);
         }
         if(_loc6_ < _loc4_)
         {
            return param1.concat(param3.substring(0,_loc6_));
         }
         _loc7_ = new Array();
         _loc8_ = param3.split("");
         _loc9_ = 0;
         while(_loc9_ < _loc6_)
         {
            _loc7_[_loc9_] = _loc8_[_loc9_ % _loc4_];
            _loc9_++;
         }
         return param1.concat(_loc7_.join(""));
      }
      
      public static function rightPadChar(param1:String, param2:int, param3:String) : String
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:int = param2 - param1.length;
         if(_loc4_ <= 0)
         {
            return param1;
         }
         if(_loc4_ > PAD_LIMIT)
         {
            return rightPad(param1,param2,param3);
         }
         return param1.concat(padding(_loc4_,param3));
      }
      
      private static function padding(param1:int, param2:String) : String
      {
         var _loc3_:String = EMPTY;
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc3_ += param2;
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         if(param1 == null || isEmpty(param2) || param3 == null)
         {
            return param1;
         }
         return param1.replace(new RegExp(param2,"g"),param3);
      }
      
      public static function replaceTo(param1:String, param2:String, param3:String, param4:int) : String
      {
         if(param1 == null || isEmpty(param2) || param3 == null || param4 == 0)
         {
            return param1;
         }
         var _loc5_:String = "";
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         while((_loc7_ = param1.indexOf(param2,_loc6_)) != -1)
         {
            _loc5_ += param1.substring(_loc6_,_loc7_) + param3;
            _loc6_ = _loc7_ + param2.length;
            if(--param4 == 0)
            {
               break;
            }
         }
         return _loc5_ + param1.substring(_loc6_);
      }
      
      public static function replaceOnce(param1:String, param2:String, param3:String) : String
      {
         if(param1 == null || isEmpty(param2) || param3 == null)
         {
            return param1;
         }
         return param1.replace(new RegExp(param2,EMPTY),param3);
      }
      
      public static function defaultIfEmpty(param1:String, param2:String) : String
      {
         return !!isEmpty(param1) ? param2 : param1;
      }
      
      public static function isEmpty(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return true;
         }
         return param1.length == 0;
      }
      
      public static function isNotEmpty(param1:String) : Boolean
      {
         return !isEmpty(param1);
      }
      
      public static function isBlank(param1:String) : Boolean
      {
         return isEmpty(trimToEmpty(param1));
      }
      
      public static function isNotBlank(param1:String) : Boolean
      {
         return !isBlank(param1);
      }
      
      public static function trimToNull(param1:String) : String
      {
         var _loc2_:String = trim(param1);
         return !!isEmpty(_loc2_) ? null : _loc2_;
      }
      
      public static function trimToEmpty(param1:String) : String
      {
         return param1 == null ? EMPTY : trim(param1);
      }
      
      public static function capitalize(param1:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         return param1.charAt(0).toUpperCase() + param1.substring(1);
      }
      
      public static function uncapitalize(param1:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         return param1.charAt(0).toLowerCase() + param1.substring(1);
      }
      
      public static function titleize(param1:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         var _loc2_:Array = param1.toLowerCase().split(" ");
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc2_[_loc3_] = capitalize(_loc2_[_loc3_]);
            _loc3_++;
         }
         return _loc2_.join(" ");
      }
      
      public static function substringAfter(param1:String, param2:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         if(param2 == null)
         {
            return EMPTY;
         }
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ == INDEX_NOT_FOUND)
         {
            return EMPTY;
         }
         return param1.substring(_loc3_ + param2.length);
      }
      
      public static function substringAfterLast(param1:String, param2:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         if(isEmpty(param2))
         {
            return EMPTY;
         }
         var _loc3_:int = param1.lastIndexOf(param2);
         if(_loc3_ == INDEX_NOT_FOUND || _loc3_ == param1.length - param2.length)
         {
            return EMPTY;
         }
         return param1.substring(_loc3_ + param2.length);
      }
      
      public static function substringBefore(param1:String, param2:String) : String
      {
         if(isEmpty(param1) || param2 == null)
         {
            return param1;
         }
         if(param2.length == 0)
         {
            return EMPTY;
         }
         var _loc3_:int = param1.indexOf(param2);
         if(_loc3_ == INDEX_NOT_FOUND)
         {
            return param1;
         }
         return param1.substring(0,_loc3_);
      }
      
      public static function substringBeforeLast(param1:String, param2:String) : String
      {
         if(isEmpty(param1) || isEmpty(param2))
         {
            return param1;
         }
         var _loc3_:int = param1.lastIndexOf(param2);
         if(_loc3_ == INDEX_NOT_FOUND)
         {
            return param1;
         }
         return param1.substring(0,_loc3_);
      }
      
      public static function substringBetween(param1:String, param2:String, param3:String) : String
      {
         var _loc5_:int = 0;
         if(param1 == null || param2 == null || param3 == null)
         {
            return null;
         }
         var _loc4_:int = param1.indexOf(param2);
         if(_loc4_ != INDEX_NOT_FOUND)
         {
            _loc5_ = param1.indexOf(param3,_loc4_ + param2.length);
            if(_loc5_ != INDEX_NOT_FOUND)
            {
               return param1.substring(_loc4_ + param2.length,_loc5_);
            }
         }
         return null;
      }
      
      public static function strip(param1:String, param2:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         return stripEnd(stripStart(param1,param2),param2);
      }
      
      public static function stripStart(param1:String, param2:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         var _loc3_:RegExp = new RegExp("^[" + (param2 || " ") + "]*",EMPTY);
         return param1.replace(_loc3_,EMPTY);
      }
      
      public static function stripEnd(param1:String, param2:String) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         var _loc3_:RegExp = new RegExp("[" + (param2 || " ") + "]*$",EMPTY);
         return param1.replace(_loc3_,EMPTY);
      }
      
      public static function abbreviate(param1:String, param2:int, param3:int) : String
      {
         if(param1 == null)
         {
            return param1;
         }
         if(param3 < 4)
         {
            throw new IllegalArgumentException("Minimum abbreviation width is 4");
         }
         if(param1.length <= param3)
         {
            return param1;
         }
         if(param2 > param1.length)
         {
            param2 = param1.length;
         }
         if(param1.length - param2 < param3 - 3)
         {
            param2 = param1.length - (param3 - 3);
         }
         if(param2 <= 4)
         {
            return param1.substring(0,param3 - 3) + "...";
         }
         if(param3 < 7)
         {
            throw new IllegalArgumentException("Minimum abbreviation width with offset is 7");
         }
         if(param2 + (param3 - 3) < param1.length)
         {
            return "..." + abbreviate(param1.substring(param2),0,param3 - 3);
         }
         return "..." + param1.substring(param1.length - (param3 - 3));
      }
      
      public static function ordinalIndexOf(param1:String, param2:String, param3:int) : int
      {
         if(param1 == null || param2 == null || param3 <= 0)
         {
            return INDEX_NOT_FOUND;
         }
         if(param2.length == 0)
         {
            return 0;
         }
         var _loc4_:int = 0;
         var _loc5_:int = INDEX_NOT_FOUND;
         while(true)
         {
            _loc5_ = param1.indexOf(param2,_loc5_ + 1);
            if(_loc5_ < 0)
            {
               break;
            }
            _loc4_++;
            if(_loc4_ >= param3)
            {
               return _loc5_;
            }
         }
         return _loc5_;
      }
      
      public static function countMatches(param1:String, param2:String) : int
      {
         if(isEmpty(param1) || isEmpty(param2))
         {
            return 0;
         }
         return param1.match(new RegExp("(" + param2 + ")","g")).length;
      }
      
      public static function contains(param1:String, param2:String) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         return new RegExp("(" + param2 + ")","g").test(param1);
      }
      
      public static function containsNone(param1:String, param2:String) : Boolean
      {
         if(isEmpty(param1) || param2 == null)
         {
            return true;
         }
         return new RegExp("^[^" + param2 + "]*$",EMPTY).test(param1);
      }
      
      public static function containsOnly(param1:String, param2:String) : Boolean
      {
         if(param1 == null || isEmpty(param2))
         {
            return false;
         }
         if(param1.length == 0)
         {
            return true;
         }
         return new RegExp("^[" + param2 + "]*$","g").test(param1);
      }
      
      public static function indexOfAny(param1:String, param2:String) : int
      {
         if(isEmpty(param1) || isEmpty(param2))
         {
            return INDEX_NOT_FOUND;
         }
         return param1.search(new RegExp("[" + param2 + "]",EMPTY));
      }
      
      public static function indexOfAnyBut(param1:String, param2:String) : int
      {
         if(isEmpty(param1) || isEmpty(param2))
         {
            return INDEX_NOT_FOUND;
         }
         return param1.search(new RegExp("[^" + param2 + "]",EMPTY));
      }
      
      public static function difference(param1:String, param2:String) : String
      {
         if(param1 == null)
         {
            return param2;
         }
         if(param2 == null)
         {
            return param1;
         }
         var _loc3_:int = indexOfDifference(param1,param2);
         if(_loc3_ == -1)
         {
            return EMPTY;
         }
         return param2.substring(_loc3_);
      }
      
      public static function indexOfDifference(param1:String, param2:String) : int
      {
         var _loc3_:int = 0;
         if(param1 == param2)
         {
            return INDEX_NOT_FOUND;
         }
         if(isEmpty(param1) || isEmpty(param2))
         {
            return 0;
         }
         _loc3_ = 0;
         while(_loc3_ < param1.length && _loc3_ < param2.length)
         {
            if(param1.charAt(_loc3_) != param2.charAt(_loc3_))
            {
               break;
            }
            _loc3_++;
         }
         if(_loc3_ < param2.length || _loc3_ < param1.length)
         {
            return _loc3_;
         }
         return INDEX_NOT_FOUND;
      }
      
      public static function equals(param1:String, param2:String) : Boolean
      {
         return new RegExp(param1,EMPTY).test(param2);
      }
      
      public static function equalsIgnoreCase(param1:String, param2:String) : Boolean
      {
         return new RegExp(param1,"i").test(param2);
      }
      
      public static function isAlpha(param1:String) : Boolean
      {
         return testString(param1,/^[a-zA-Z]*$/);
      }
      
      public static function isAlphaSpace(param1:String) : Boolean
      {
         return testString(param1,/^[a-zA-Z\s]*$/);
      }
      
      public static function isAlphanumeric(param1:String) : Boolean
      {
         return testString(param1,/^[a-zA-Z0-9]*$/);
      }
      
      public static function isAlphanumericSpace(param1:String) : Boolean
      {
         return testString(param1,/^[a-zA-Z0-9\s]*$/);
      }
      
      public static function isNumeric(param1:String) : Boolean
      {
         return testString(param1,/^[0-9]*$/);
      }
      
      public static function isDigit(param1:String) : Boolean
      {
         return testString(param1,/\d+/);
      }
      
      public static function isNumericSpace(param1:String) : Boolean
      {
         return testString(param1,/^[0-9\s]*$/);
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         return testString(param1,/^[\s]*$/);
      }
      
      private static function testString(param1:String, param2:RegExp) : Boolean
      {
         return param1 != null && param2.test(param1);
      }
      
      public static function overlay(param1:String, param2:String, param3:int, param4:int) : String
      {
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return null;
         }
         if(param2 == null)
         {
            param2 = EMPTY;
         }
         var _loc5_:int = param1.length;
         if(param3 < 0)
         {
            param3 = 0;
         }
         if(param3 > _loc5_)
         {
            param3 = _loc5_;
         }
         if(param4 < 0)
         {
            param4 = 0;
         }
         if(param4 > _loc5_)
         {
            param4 = _loc5_;
         }
         if(param3 > param4)
         {
            _loc6_ = param3;
            param3 = param4;
            param4 = _loc6_;
         }
         return param1.substring(0,param3).concat(param2).concat(param1.substring(param4));
      }
      
      public static function remove(param1:String, param2:String) : String
      {
         return safeRemove(param1,new RegExp(param2,"g"));
      }
      
      public static function removeEnd(param1:String, param2:String) : String
      {
         return safeRemove(param1,new RegExp(param2 + "$",EMPTY));
      }
      
      public static function removeStart(param1:String, param2:String) : String
      {
         return safeRemove(param1,new RegExp("^" + param2,EMPTY));
      }
      
      private static function safeRemove(param1:String, param2:RegExp) : String
      {
         if(isEmpty(param1))
         {
            return param1;
         }
         return param1.replace(param2,EMPTY);
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         return testString(param1,new RegExp(param2 + "$",EMPTY));
      }
      
      public static function startsWith(param1:String, param2:String) : Boolean
      {
         return testString(param1,new RegExp("^" + param2,EMPTY));
      }
      
      public static function compareToIgnoreCase(param1:String, param2:String) : int
      {
         if(param1 == null || param2 == null)
         {
            throw new NullPointerException();
         }
         return compareTo(param1.toLowerCase(),param2.toLowerCase());
      }
      
      public static function compareTo(param1:String, param2:String) : int
      {
         if(param1 == null || param2 == null)
         {
            throw new NullPointerException();
         }
         return param1.localeCompare(param2);
      }
   }
}
