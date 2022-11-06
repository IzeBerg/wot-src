package net.wg.mock.utils
{
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import net.wg.utils.ILocale;
   
   public class MockLocale implements ILocale
   {
       
      
      public function MockLocale()
      {
         super();
      }
      
      public function cutCharsBeforeNumber(param1:String) : String
      {
         return "";
      }
      
      public function float(param1:Object) : String
      {
         return "";
      }
      
      public function gold(param1:Object) : String
      {
         return "";
      }
      
      public function htmlTextWithIcon(param1:String, param2:String) : String
      {
         return "";
      }
      
      public function integer(param1:Object) : String
      {
         return "";
      }
      
      public function longDate(param1:Object) : String
      {
         return "";
      }
      
      public function longTime(param1:Object) : String
      {
         return "";
      }
      
      public function makeString(param1:String, param2:Object = null) : String
      {
         return "";
      }
      
      [Deprecated]
      public function niceNumber(param1:Object) : String
      {
         return "";
      }
      
      public function numberWithoutZeros(param1:Object) : String
      {
         return "";
      }
      
      public function parseFormattedInteger(param1:String) : IFormattedInt
      {
         return null;
      }
      
      public function shortDate(param1:Object) : String
      {
         return "";
      }
      
      public function shortTime(param1:Object) : String
      {
         return "";
      }
   }
}
