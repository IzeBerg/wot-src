package net.wg.gui.lobby.profile.pages.summary
{
   import net.wg.data.constants.Errors;
   
   public class ProfileSummaryPage extends ProfileSummary
   {
       
      
      public var nearestAwards:AwardsListComponent;
      
      public function ProfileSummaryPage()
      {
         super();
      }
      
      override public function as_setInitData(param1:Object) : void
      {
         summaryInitVO = new SummaryPageInitVO(param1);
         this.applyInitData();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.nearestAwards.titleToolTip = PROFILE.PROFILE_SUMMARY_NEXTAWARDS_TOOLTIP;
         layoutManager.registerComponents(this.nearestAwards);
      }
      
      override protected function applyInitData() : void
      {
         super.applyInitData();
         var _loc1_:SummaryPageInitVO = summaryInitVO as SummaryPageInitVO;
         App.utils.asserter.assertNotNull(_loc1_,"summaryPageInitVO " + Errors.CANT_NULL);
         this.nearestAwards.label = _loc1_.nextAwardsLabel;
         this.nearestAwards.errorText = _loc1_.nextAwardsErrorText;
      }
      
      override protected function applyData(param1:Object) : void
      {
         super.applyData(param1);
         this.nearestAwards.dataProvider = profileSummaryVO.nearestAchievements;
      }
      
      override protected function onDispose() : void
      {
         this.nearestAwards = null;
         super.onDispose();
      }
   }
}
