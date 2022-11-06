package net.wg.infrastructure.uilogging.base
{
   public class MetricsLogger extends BaseLogger
   {
       
      
      public function MetricsLogger(param1:String)
      {
         super(param1,"metrics");
      }
      
      public function log(param1:String, param2:String, param3:String = null, param4:String = null, param5:String = null, param6:int = 20) : void
      {
         _log(param1,param6,{
            "item":param2,
            "parent_screen":param3,
            "item_state":param4,
            "additional_info":param5
         });
      }
      
      public function logOnce(param1:String, param2:String, param3:String = null, param4:String = null, param5:String = null, param6:int = 20) : void
      {
         _logOnce(param1,param6,{
            "item":param2,
            "parent_screen":param3,
            "item_state":param4,
            "additional_info":param5
         });
      }
      
      public function stopAction(param1:String, param2:String, param3:String = null, param4:String = null, param5:String = null, param6:int = 20, param7:Number = 0) : void
      {
         _stopAction(param1,param6,{
            "item":param2,
            "parent_screen":param3,
            "item_state":param4,
            "additional_info":param5
         },param7);
      }
   }
}
