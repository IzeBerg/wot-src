package net.wg.gui.components.controls.achievements
{
   import net.wg.data.VO.AchievementProgressVO;
   
   public class AchievementCommon extends AchievementProgress
   {
       
      
      public function AchievementCommon()
      {
         super();
      }
      
      override protected function applyData() : void
      {
         var _loc1_:AchievementProgressVO = null;
         if(achievement != null)
         {
            _loc1_ = achievement as AchievementProgressVO;
            if(_loc1_)
            {
               progressInfo = _loc1_.progressInfo;
            }
            loader.alpha = achievement.iconAlpha;
         }
         super.applyData();
      }
      
      override protected function tryToLoadRareAchievement() : void
      {
         super.tryToLoadRareAchievement();
         if(!achievement.rareIconId)
         {
            loader.startLoadAlt();
         }
      }
   }
}
