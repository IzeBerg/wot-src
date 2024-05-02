package net.wg.gui.lobby.battleRoyale.levelUpView.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.data.MetaLevelVO;
   
   public class BattleRoyaleLevelUpViewVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const AWARDS_SMALL:String = "awardsSmall";
      
      private static const EPIC_META_LEVEL_ICON_VO:String = "epicMetaLevelIconData";
       
      
      public var awards:Vector.<AwardItemRendererExVO> = null;
      
      public var awardsSmall:Vector.<AwardItemRendererExVO> = null;
      
      public var metaLevelVO:MetaLevelVO = null;
      
      public var levelUpText:String = "";
      
      public var backgroundImageSrc:String = "";
      
      public var maxLvlReached:Boolean = false;
      
      public function BattleRoyaleLevelUpViewVO(param1:Object = null)
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
         if(param1 == AWARDS_SMALL)
         {
            this.awardsSmall = new Vector.<AwardItemRendererExVO>(0);
            for each(_loc3_ in param2)
            {
               this.awardsSmall.push(new AwardItemRendererExVO(_loc3_));
            }
            return false;
         }
         if(param1 == EPIC_META_LEVEL_ICON_VO)
         {
            this.metaLevelVO = new MetaLevelVO(param2);
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
         for each(_loc1_ in this.awardsSmall)
         {
            _loc1_.dispose();
         }
         if(this.awardsSmall)
         {
            this.awardsSmall.length = 0;
         }
         this.awardsSmall = null;
         if(this.metaLevelVO != null)
         {
            this.metaLevelVO.dispose();
            this.metaLevelVO = null;
         }
         super.onDispose();
      }
   }
}
