package net.wg.infrastructure.uilogging.personal_reserves
{
   import net.wg.infrastructure.uilogging.base.FlowLogger;
   
   public class InBattleActivationScreenLogger extends FlowLogger
   {
       
      
      public function InBattleActivationScreenLogger()
      {
         super(PERSONAL_RESERVES_LOGGING_CONSTANTS.LOGGING_FEATURE);
      }
      
      public function logOpenActivationThroughShortcut() : void
      {
         log(PERSONAL_RESERVES_LOGGING_CONSTANTS.OPEN_ACTION,PERSONAL_RESERVES_LOGGING_CONSTANTS.SOURCE_BATTLE,PERSONAL_RESERVES_LOGGING_CONSTANTS.DESTINATION_ACTIVATION_TAB,PERSONAL_RESERVES_LOGGING_CONSTANTS.METHOD_SHORTCUT);
      }
      
      public function logActivationTabSelected() : void
      {
         log(PERSONAL_RESERVES_LOGGING_CONSTANTS.OPEN_ACTION,PERSONAL_RESERVES_LOGGING_CONSTANTS.SOURCE_FULLSTATS,PERSONAL_RESERVES_LOGGING_CONSTANTS.DESTINATION_ACTIVATION_TAB,PERSONAL_RESERVES_LOGGING_CONSTANTS.METHOD_TABS);
      }
   }
}
