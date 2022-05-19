package
{
   public class DebugUtils
   {
      
      private static const CPP_DO_LOG_METHOD_NAME:String = "WG.doLog";
      
      private static const SEVERITY_TRACE:Number = 65536;
      
      private static const SEVERITY_DEBUG:Number = 131072;
      
      private static const SEVERITY_WARNING:Number = 196608;
      
      private static const SEVERITY_ERROR:Number = 262144;
       
      
      public function DebugUtils()
      {
         super();
      }
      
      public static function LOG_TRACE(... rest) : void
      {
      }
      
      public static function LOG_DEBUG(... rest) : void
      {
      }
      
      public static function LOG_ERROR(... rest) : void
      {
         rest.unshift(SEVERITY_ERROR);
         __doLog.apply(null,rest);
      }
      
      public static function LOG_WARNING(... rest) : void
      {
         rest.unshift(SEVERITY_WARNING);
         __doLog.apply(null,rest);
      }
      
      private static function __doLog() : void
      {
         App.environment.call(CPP_DO_LOG_METHOD_NAME,arguments[0],String(arguments.slice(1)));
      }
   }
}
