package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class EpicBattlesInfoViewVO extends DAAPIDataClass
   {
      
      private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";
      
      private static const EPIC_COMBAT_RESERVES_VO:String = "epicCombatReservesData";
      
      private static const EPIC_META_PROGRESS_VO:String = "epicMetaProgressData";
      
      private static const EPIC_PRESTIGE_PROGRESS_VO:String = "epicPrestigeProgressData";
      
      private static const EPIC_REWARD_RIBBON_VO:String = "epicRewardRibbonData";
       
      
      public var backgroundImageSrc:String = "";
      
      public var smallPageTitleHtmlText:String = "";
      
      public var bigPageTitleHtmlText:String = "";
      
      public var pageDescriptionHtmlText:String = "";
      
      public var aboutButtonLabel:String = "";
      
      public var canClaimFinalReward:Boolean = false;
      
      public var epicMetaLevelIconData:MetaLevelVO = null;
      
      public var rewardRibbonDataVO:EpicBattlesRewardRibbonVO = null;
      
      public var combatReservesVO:EpicBattlesInfoCombatReservesVO = null;
      
      public var metaProgressVO:EpicBattlesInfoMetaProgressVO = null;
      
      public var prestigeProgressVO:EpicBattlesPrestigeProgressVO = null;
      
      public function EpicBattlesInfoViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == EPIC_META_LEVEL_ICON_VO)
         {
            this.epicMetaLevelIconData = new MetaLevelVO(param2);
            return false;
         }
         if(param1 == EPIC_COMBAT_RESERVES_VO)
         {
            this.combatReservesVO = new EpicBattlesInfoCombatReservesVO(param2);
            return false;
         }
         if(param1 == EPIC_META_PROGRESS_VO)
         {
            this.metaProgressVO = new EpicBattlesInfoMetaProgressVO(param2);
            return false;
         }
         if(param1 == EPIC_PRESTIGE_PROGRESS_VO)
         {
            this.prestigeProgressVO = new EpicBattlesPrestigeProgressVO(param2);
            return false;
         }
         if(param1 == EPIC_REWARD_RIBBON_VO)
         {
            this.rewardRibbonDataVO = new EpicBattlesRewardRibbonVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.epicMetaLevelIconData != null)
         {
            this.epicMetaLevelIconData.dispose();
            this.epicMetaLevelIconData = null;
         }
         if(this.combatReservesVO != null)
         {
            this.combatReservesVO.dispose();
            this.combatReservesVO = null;
         }
         if(this.metaProgressVO != null)
         {
            this.metaProgressVO.dispose();
            this.metaProgressVO = null;
         }
         if(this.prestigeProgressVO != null)
         {
            this.prestigeProgressVO.dispose();
            this.prestigeProgressVO = null;
         }
         if(this.rewardRibbonDataVO != null)
         {
            this.rewardRibbonDataVO.dispose();
            this.rewardRibbonDataVO = null;
         }
         super.onDispose();
      }
   }
}
