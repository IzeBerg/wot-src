package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class EpicBattlesRewardRibbonVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";
       
      
      public var rewardTitleHtmlText:String = "";
      
      public var epicMetaLevelIconData:MetaLevelVO = null;
      
      public var imageSource:String = "";
      
      public var buttonText:String = "";
      
      public var awards:Vector.<AwardItemRendererExVO> = null;
      
      public function EpicBattlesRewardRibbonVO(param1:Object)
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
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardItemRendererExVO = null;
         if(this.awards)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.splice(0,this.awards.length);
         }
         this.awards = null;
         if(this.epicMetaLevelIconData != null)
         {
            this.epicMetaLevelIconData.dispose();
            this.epicMetaLevelIconData = null;
         }
         super.onDispose();
      }
   }
}
