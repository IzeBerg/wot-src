package scaleform.gfx
{
   import flash.system.ApplicationDomain;
   
   public final class SystemEx
   {
      
      public static const REPORT_SHORT_FILE_NAMES:uint = 1;
      
      public static const REPORT_NO_CIRCULAR_REFERENCES:uint = 2;
      
      public static const REPORT_SUPPRESS_OVERALL_STATS:uint = 4;
      
      public static const REPORT_ADDRESSES_FOR_ANON_OBJ_ONLY:uint = 8;
      
      public static const REPORT_SUPPRESS_MOVIEDEFS_STATS:uint = 16;
      
      public static const REPORT_NO_ELLIPSIS:uint = 32;
      
      public static const REPORT_GENERATE_GRAPH_VIZ_FULL:uint = 64;
      
      public static const REPORT_GENERATE_GRAPH_VIZ_ABC:uint = 128;
      
      public static const REPORT_GENERATE_GRAPH_VIZ_MOVIE:uint = 256;
      
      public static const REPORT_OTHER_OBJECTS:uint = 512;
      
      public static const REPORT_PRINT_ABC_FILES:uint = 1024;
      
      public static const REPORT_PRINT_MOVIEDEFS:uint = 2048;
      
      public static const REPORT_GRAPH_VIZ_MOVIEDEFS_ONLY:uint = 4096;
      
      public static const REPORT_GRAPH_VIZ_SWF_ONLY:uint = 8192;
      
      public static const REPORT_GENERATE_GRAPH_VIZ_PICTURE:uint = 16384;
       
      
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
      
      public static function printObjectsReport(param1:Boolean = true, param2:uint = 16655, param3:String = null) : void
      {
      }
      
      public static function getApplicationDomainClasses(param1:ApplicationDomain = null) : Vector.<String>
      {
         return new Vector.<String>();
      }
   }
}
