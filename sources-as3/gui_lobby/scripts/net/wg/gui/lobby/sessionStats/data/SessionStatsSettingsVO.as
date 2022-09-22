package net.wg.gui.lobby.sessionStats.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SessionStatsSettingsVO extends DAAPIDataClass
   {
      
      private static const HEADER_FIELD:String = "header";
      
      private static const COMMON_FIELD:String = "common";
      
      private static const ECONOMICS_FIELD:String = "economics";
      
      private static const BATTLE_FIELD:String = "battle";
       
      
      public var header:SessionStatsSettingsHeaderVO = null;
      
      public var common:SessionStatsSettingsBaseVO = null;
      
      public var economics:SessionStatsSettingsEconomicsVO = null;
      
      public var battle:SessionStatsSettingsBattleVO = null;
      
      public function SessionStatsSettingsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == HEADER_FIELD)
         {
            this.header = new SessionStatsSettingsHeaderVO(param2);
            return false;
         }
         if(param1 == COMMON_FIELD)
         {
            this.common = new SessionStatsSettingsBaseVO(param2);
            return false;
         }
         if(param1 == ECONOMICS_FIELD)
         {
            this.economics = new SessionStatsSettingsEconomicsVO(param2);
            return false;
         }
         if(param1 == BATTLE_FIELD)
         {
            this.battle = new SessionStatsSettingsBattleVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         this.common.dispose();
         this.common = null;
         this.economics.dispose();
         this.economics = null;
         this.battle.dispose();
         this.battle = null;
         super.onDispose();
      }
   }
}
