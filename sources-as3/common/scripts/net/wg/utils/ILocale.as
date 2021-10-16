package net.wg.utils
{
   import net.wg.infrastructure.interfaces.IFormattedInt;
   
   public interface ILocale
   {
       
      
      function gold(param1:Object) : String;
      
      function integer(param1:Object) : String;
      
      function float(param1:Object) : String;
      
      [Deprecated]
      function niceNumber(param1:Object) : String;
      
      function numberWithoutZeros(param1:Object) : String;
      
      function parseFormattedInteger(param1:String) : IFormattedInt;
      
      function shortTime(param1:Object) : String;
      
      function longTime(param1:Object) : String;
      
      function shortDate(param1:Object) : String;
      
      function longDate(param1:Object) : String;
      
      function htmlTextWithIcon(param1:String, param2:String) : String;
      
      function makeString(param1:String, param2:Object = null) : String;
      
      function cutCharsBeforeNumber(param1:String) : String;
   }
}
