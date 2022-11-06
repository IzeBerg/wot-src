package net.wg.infrastructure.uilogging.base
{
   public class FlowLogger extends BaseLogger
   {
       
      
      public function FlowLogger(param1:String)
      {
         super(param1,"flow");
      }
      
      public function log(param1:String, param2:String, param3:String, param4:String, param5:int = 20) : void
      {
         _log(param1,param5,{
            "source_item":param2,
            "destination_item":param3,
            "transition_method":param4
         });
      }
      
      public function logOnce(param1:String, param2:String, param3:String, param4:String, param5:int = 20) : void
      {
         _logOnce(param1,param5,{
            "source_item":param2,
            "destination_item":param3,
            "transition_method":param4
         });
      }
      
      public function stopAction(param1:String, param2:String, param3:String, param4:String, param5:int = 20, param6:Number = 0) : void
      {
         _stopAction(param1,param5,{
            "source_item":param2,
            "destination_item":param3,
            "transition_method":param4
         },param6);
      }
   }
}
