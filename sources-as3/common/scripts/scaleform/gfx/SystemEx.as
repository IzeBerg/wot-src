package scaleform.gfx
{
   import flash.system.ApplicationDomain;
   
   public final class SystemEx
   {
      
      public static const REPORT_SHORT_FILE_NAMES:uint = 1;
      
      public static const REPORT_NO_CIRCULAR_REFERENCES:uint = 2;
      
      public static const REPORT_SUPPRESS_OVERALL_STATS:uint = 4;
      
      public static const REPORT_ONLY_ANON_OBJ_ADDRESSES:uint = 8;
       
      
      public function SystemEx()
      {
         super();
      }
      
      public static function set actionVerbose(param1:Boolean) : void
      {
      }
      
      public static function get actionVerbose() : Boolean
      {
         return false;
      }
      
      public static function setBackgroundAlpha(param1:Number) : void
      {
      }
      
      public static function getStackTrace() : String
      {
         return "";
      }
      
      public static function getCodeFileName() : String
      {
         return "";
      }
      
      public static function getCodeFileNames() : Array
      {
         return new Array();
      }
      
      public static function describeType(param1:*) : String
      {
         return "";
      }
      
      public static function printObjectsReport(param1:Boolean = true, param2:uint = 11, param3:String = null) : void
      {
      }
      
      public static function getApplicationDomainClasses(param1:ApplicationDomain = null) : Vector.<String>
      {
         return new Vector.<String>();
      }
   }
}
