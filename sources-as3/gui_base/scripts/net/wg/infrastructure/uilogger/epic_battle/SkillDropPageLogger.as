package net.wg.infrastructure.uilogger.epic_battle
{
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.MetricsUILogger;
   
   public class SkillDropPageLogger extends MetricsUILogger
   {
      
      private static const DROP_COST_CURRENCY:Array = ["free","credits","gold","blanks"];
      
      private static const TOOLTIP_TIME_LIMIT:int = 2;
       
      
      private var _state:String = "";
      
      public function SkillDropPageLogger()
      {
         super(EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_FEATURE);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._state = null;
      }
      
      public function startPageLog() : void
      {
         info(EPIC_BATTLE_LOGGER_CONSTANTS.OPEN_ACTION,{
            "item":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,
            "parent_screen":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_PERSONAL_CASE
         });
         startAction(EPIC_BATTLE_LOGGER_CONSTANTS.CLOSE_ACTION);
      }
      
      public function stopPageLog() : void
      {
         stopAction(EPIC_BATTLE_LOGGER_CONSTANTS.CLOSE_ACTION,LogLevels.INFO,{
            "item":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,
            "parent_screen":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_PERSONAL_CASE
         });
      }
      
      public function startTooltipLog(param1:String) : void
      {
         this._state = param1;
         startAction(EPIC_BATTLE_LOGGER_CONSTANTS.TOOLTIP_OPENED_ACTION);
      }
      
      public function stopTooltipLog() : void
      {
         stopAction(EPIC_BATTLE_LOGGER_CONSTANTS.TOOLTIP_OPENED_ACTION,LogLevels.INFO,{
            "item":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_BLANKS,
            "parent_screen":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,
            "item_state":this._state
         },TOOLTIP_TIME_LIMIT);
      }
      
      public function dropSkillClickLog(param1:int) : void
      {
         info(EPIC_BATTLE_LOGGER_CONSTANTS.CLICK_ACTION,{
            "item":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_DROP_BUTTON,
            "parent_screen":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,
            "additional_info":DROP_COST_CURRENCY[param1]
         });
      }
      
      public function currencySelectLog(param1:int) : void
      {
         info(EPIC_BATTLE_LOGGER_CONSTANTS.CLICK_ACTION,{
            "item":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_CURRENCY_BUTTON,
            "parent_screen":EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,
            "additional_info":DROP_COST_CURRENCY[param1]
         });
      }
   }
}
