package net.wg.infrastructure.uilogger.veh_post_progression
{
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   
   public class LogVehParams extends UILogger
   {
       
      
      public function LogVehParams()
      {
         super(Constants.FEATURE,Constants.GROUP_TTC_PANEL);
      }
      
      public function hideTooltip(param1:String) : void
      {
         var _loc2_:Object = {"parent_screen":param1};
         stopAction(Constants.ACTION_CLOSE,LogLevels.INFO,_loc2_,0.5);
      }
      
      public function showTooltip() : void
      {
         startAction(Constants.TOOLTIP_WATCHED);
      }
   }
}
