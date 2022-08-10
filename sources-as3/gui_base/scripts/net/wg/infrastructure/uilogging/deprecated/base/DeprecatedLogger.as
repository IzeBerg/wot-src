package net.wg.infrastructure.uilogging.deprecated.base
{
   import net.wg.infrastructure.uilogging.base.BaseLogger;
   
   public class DeprecatedLogger extends BaseLogger
   {
       
      
      public function DeprecatedLogger(param1:String, param2:String)
      {
         super(param1,param2);
      }
      
      public function log(param1:String, param2:int = 20, param3:Object = null) : void
      {
         _log(param1,param2,param3);
      }
      
      public function logOnce(param1:String, param2:int = 20, param3:Object = null) : void
      {
         _logOnce(param1,param2,param3);
      }
      
      protected function stopAction(param1:String, param2:int = 20, param3:Object = null, param4:Number = 0) : void
      {
         _stopAction(param1,param2,param3,param4);
      }
   }
}
