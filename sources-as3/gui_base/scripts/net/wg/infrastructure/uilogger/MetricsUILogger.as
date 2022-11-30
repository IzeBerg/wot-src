package net.wg.infrastructure.uilogger
{
   public class MetricsUILogger extends UILogger
   {
      
      public static const LOGGER_GROUP_METRICS:String = "metrics";
       
      
      public function MetricsUILogger(param1:String)
      {
         super(param1,LOGGER_GROUP_METRICS);
      }
      
      override protected function checkDefaultParams(param1:Object) : void
      {
         if(!param1.hasOwnProperty("partner_id"))
         {
            param1["partner_id"] = null;
         }
         if(!param1.hasOwnProperty("parent_screen"))
         {
            param1["parent_screen"] = null;
         }
         if(!param1.hasOwnProperty("item_state"))
         {
            param1["item_state"] = null;
         }
         if(!param1.hasOwnProperty("additional_info"))
         {
            param1["additional_info"] = null;
         }
      }
   }
}
