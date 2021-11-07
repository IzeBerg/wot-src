package net.wg.infrastructure.uilogger.manual
{
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   
   public class ManualPageLogger extends UILogger
   {
       
      
      private var _page:String = "";
      
      public function ManualPageLogger()
      {
         super(MANUAL_LOGGER_CONSTANTS.LOGGER_FEATURE,MANUAL_LOGGER_CONSTANTS.PAGE_LOGGER_GROUP);
      }
      
      public function startPageLog(param1:String) : void
      {
         this._page = param1;
         startAction(MANUAL_LOGGER_CONSTANTS.PAGE_OPENED_ACTION);
      }
      
      public function stopPageLog() : void
      {
         stopAction(MANUAL_LOGGER_CONSTANTS.PAGE_OPENED_ACTION,LogLevels.INFO,{"page":this._page});
      }
   }
}
