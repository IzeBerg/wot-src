package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class EpicBattlesPrestigeViewVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";
      
      private static const EPIC_PRESTIGE_META_LEVEL_ICON_VO:String = "metaLevelIconPrestige";
       
      
      public var prestigeLevelText:String = "";
      
      public var prestigeTitleText:String = "";
      
      public var removeAbilitiesContainerTitleText:String = "";
      
      public var resetLevelContainerTitleText:String = "";
      
      public var rewardTitleText:String = "";
      
      public var backgroundImageSrc:String = "";
      
      public var metaLevelIconPrestige:MetaLevelVO = null;
      
      public var epicMetaLevelIconData:MetaLevelVO = null;
      
      public var awards:Vector.<AwardItemRendererExVO> = null;
      
      public function EpicBattlesPrestigeViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == AWARDS)
         {
            this.awards = new Vector.<AwardItemRendererExVO>(0);
            for each(_loc3_ in param2)
            {
               this.awards.push(new AwardItemRendererExVO(_loc3_));
            }
            return false;
         }
         if(param1 == EPIC_META_LEVEL_ICON_VO)
         {
            this.epicMetaLevelIconData = new MetaLevelVO(param2);
            return false;
         }
         if(param1 == EPIC_PRESTIGE_META_LEVEL_ICON_VO)
         {
            this.metaLevelIconPrestige = new MetaLevelVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardItemRendererExVO = null;
         for each(_loc1_ in this.awards)
         {
            _loc1_.dispose();
         }
         if(this.awards)
         {
            this.awards.length = 0;
         }
         this.awards = null;
         if(this.epicMetaLevelIconData != null)
         {
            this.epicMetaLevelIconData.dispose();
            this.epicMetaLevelIconData = null;
         }
         if(this.metaLevelIconPrestige != null)
         {
            this.metaLevelIconPrestige.dispose();
            this.metaLevelIconPrestige = null;
         }
         super.onDispose();
      }
   }
}
