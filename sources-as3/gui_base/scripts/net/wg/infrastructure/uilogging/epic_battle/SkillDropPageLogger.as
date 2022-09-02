package net.wg.infrastructure.uilogging.epic_battle
{
   import net.wg.infrastructure.uilogging.LogLevels;
   import net.wg.infrastructure.uilogging.base.MetricsLogger;
   
   public class SkillDropPageLogger extends MetricsLogger
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
         log(EPIC_BATTLE_LOGGER_CONSTANTS.OPEN_ACTION,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_PERSONAL_CASE);
         startAction(EPIC_BATTLE_LOGGER_CONSTANTS.CLOSE_ACTION);
      }
      
      public function stopPageLog() : void
      {
         stopAction(EPIC_BATTLE_LOGGER_CONSTANTS.CLOSE_ACTION,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_PERSONAL_CASE);
      }
      
      public function startTooltipLog(param1:String) : void
      {
         this._state = param1;
         startAction(EPIC_BATTLE_LOGGER_CONSTANTS.TOOLTIP_OPENED_ACTION);
      }
      
      public function stopTooltipLog() : void
      {
         stopAction(EPIC_BATTLE_LOGGER_CONSTANTS.TOOLTIP_OPENED_ACTION,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_BLANKS,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,this._state,null,LogLevels.INFO,TOOLTIP_TIME_LIMIT);
      }
      
      public function dropSkillClickLog(param1:int) : void
      {
         log(EPIC_BATTLE_LOGGER_CONSTANTS.CLICK_ACTION,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_DROP_BUTTON,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,null,DROP_COST_CURRENCY[param1]);
      }
      
      public function currencySelectLog(param1:int) : void
      {
         log(EPIC_BATTLE_LOGGER_CONSTANTS.CLICK_ACTION,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_CURRENCY_BUTTON,EPIC_BATTLE_LOGGER_CONSTANTS.LOGGER_ITEM_SKILL_DROP,DROP_COST_CURRENCY[param1]);
      }
   }
}
