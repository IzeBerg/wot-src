package net.wg.infrastructure.uilogger.veh_post_progression
{
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   
   public class LogDemountAllBtn extends UILogger
   {
      
      private static const EXPANDABLE_TTC:String = "expandable_ttc";
       
      
      public function LogDemountAllBtn()
      {
         super(Constants.FEATURE,Constants.GROUP_DEMOUNT_ALL_MODIFICATIONS_BUTTON);
      }
      
      public function clickOnDemountAll(param1:Boolean) : void
      {
         var _loc2_:Object = {"parent_screen":Constants.GROUP_MODIFICATIONS_TREE};
         if(param1)
         {
            _loc2_.additional_info = EXPANDABLE_TTC;
         }
         log(Constants.ACTION_CLICK,LogLevels.INFO,_loc2_);
      }
   }
}
