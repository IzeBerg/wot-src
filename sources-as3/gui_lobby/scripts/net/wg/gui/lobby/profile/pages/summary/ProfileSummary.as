package net.wg.gui.lobby.profile.pages.summary
{
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.LineDescrIconText;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.components.LditBattles;
   import net.wg.gui.lobby.profile.components.LditMarksOfMastery;
   import net.wg.gui.lobby.profile.components.LditValued;
   import net.wg.gui.lobby.profile.components.PersonalScoreComponent;
   import net.wg.gui.lobby.profile.components.ProfileFooter;
   import net.wg.gui.lobby.profile.data.ProfileUserVO;
   import net.wg.gui.lobby.profile.data.SectionLayoutManager;
   import net.wg.infrastructure.base.meta.IProfileSummaryMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileSummaryMeta;
   
   public class ProfileSummary extends ProfileSummaryMeta implements IProfileSummaryMeta
   {
      
      private static const INIT_DATA_INVALID:String = "idInv";
      
      private static const SUMMARY_LEFT_OFFSET:int = 18;
      
      private static const MIN_HEIGHT:int = 525;
      
      private static const MAX_HEIGHT:int = 740;
      
      private static const LINE_TEXT_FIELD_CENTER_AREA_WIDTH:int = 140;
      
      private static const PERCENT:String = "%";
       
      
      public var tfWins:LineDescrIconText = null;
      
      public var tfAvgExperience:LineDescrIconText = null;
      
      public var tfHits:LineDescrIconText = null;
      
      public var tfAvgDamage:LineDescrIconText = null;
      
      public var tfMaxDestroyed:LditValued = null;
      
      public var tfMaxExperience:LditValued = null;
      
      public var tfTotalBattles:LditBattles = null;
      
      public var tfMarksOfMastery:LditMarksOfMastery = null;
      
      public var tfPersonalScore:PersonalScoreComponent = null;
      
      public var footer:ProfileFooter = null;
      
      public var significantAwards:AwardsListComponent = null;
      
      protected var profileSummaryVO:ProfileSummaryVO;
      
      protected var summaryInitVO:SummaryInitVO;
      
      private var _lineTextFieldsLayout:LineTextFieldsLayout = null;
      
      public function ProfileSummary()
      {
         super();
         _deferredDispose = true;
      }
      
      override public function as_setInitData(param1:Object) : void
      {
         this.summaryInitVO = new SummaryInitVO(param1);
         this.applyInitData();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.significantAwards.titleToolTip = PROFILE.PROFILE_SUMMARY_SIGNIFICANTAWARDS_TOOLTIP;
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         this.tfPersonalScore.hitArea = _loc1_;
         layoutManager = new SectionLayoutManager(MIN_HEIGHT,MAX_HEIGHT);
         layoutManager.registerComponents(this.footer,this.tfWins,this.tfHits,this.tfAvgExperience,this.tfAvgDamage,this.tfMaxDestroyed,this.tfMaxExperience,this.tfTotalBattles,this.tfMarksOfMastery,this.tfPersonalScore,this.significantAwards);
         this._lineTextFieldsLayout = new LineTextFieldsLayout(ProfileConstants.WINDOW_WIDTH,LINE_TEXT_FIELD_CENTER_AREA_WIDTH);
         this._lineTextFieldsLayout.addLeftPair(this.tfTotalBattles,this.tfHits);
         this._lineTextFieldsLayout.addRightPair(this.tfAvgExperience,this.tfMaxDestroyed);
         this._lineTextFieldsLayout.addLeftPair(this.tfWins,this.tfAvgDamage);
         this._lineTextFieldsLayout.addRightPair(this.tfMaxExperience,this.tfMarksOfMastery);
         this._lineTextFieldsLayout.layout();
      }
      
      override protected function applyResizing() : void
      {
         if(layoutManager != null)
         {
            layoutManager.setDimension(currentDimension.x,currentDimension.y);
         }
         this.footer.width = currentDimension.x;
         this.x = Math.round(currentDimension.x / 2 - centerOffset + SUMMARY_LEFT_OFFSET);
      }
      
      override protected function applyData(param1:Object) : void
      {
         this.profileSummaryVO = new ProfileSummaryVO(param1);
         if(this.profileSummaryVO.battlesCount != 0)
         {
            this.tfWins.text = this.profileSummaryVO.getWinsEfficiencyStr() + PERCENT;
            this.tfWins.enabled = true;
         }
         else
         {
            this.tfWins.enabled = false;
         }
         if(this.profileSummaryVO.hitsEfficiency != -1)
         {
            this.tfHits.enabled = true;
            this.tfHits.text = this.profileSummaryVO.getHitsEfficiencyStr() + PERCENT;
         }
         else
         {
            this.tfHits.enabled = false;
         }
         if(this.profileSummaryVO.avgXP != -1)
         {
            this.tfAvgExperience.enabled = true;
            this.tfAvgExperience.text = this.profileSummaryVO.getAvgExperienceStr();
         }
         else
         {
            this.tfAvgExperience.enabled = false;
         }
         if(this.profileSummaryVO.avgDamage != -1)
         {
            this.tfAvgDamage.enabled = true;
            this.tfAvgDamage.text = this.profileSummaryVO.getAvgDamageStr();
         }
         else
         {
            this.tfAvgDamage.enabled = false;
         }
         this.tfMaxDestroyed.text = this.profileSummaryVO.getMaxDestroyedStr();
         var _loc2_:String = this.profileSummaryVO.maxDestroyed > 0 ? this.profileSummaryVO.maxDestroyedByVehicle : null;
         this.tfMaxDestroyed.value = _loc2_;
         this.tfMaxExperience.text = this.profileSummaryVO.getMaxExperienceStr();
         _loc2_ = this.profileSummaryVO.maxXP > 0 ? this.profileSummaryVO.maxXPByVehicle : null;
         this.tfMaxExperience.value = _loc2_;
         this.tfTotalBattles.text = this.profileSummaryVO.getBattlesCountStr();
         this.tfTotalBattles.setValues(this.profileSummaryVO.getWinsCountStr(),this.profileSummaryVO.getLossesCountStr(),this.profileSummaryVO.getDrawsCountStr());
         this.tfMarksOfMastery.text = this.profileSummaryVO.marksOfMasteryText;
         this.tfPersonalScore.text = this.profileSummaryVO.getGlobalRatingStr();
         this.significantAwards.dataProvider = this.profileSummaryVO.significantAchievements;
      }
      
      override protected function onDispose() : void
      {
         this.tfWins.dispose();
         this.tfWins = null;
         this.tfHits.dispose();
         this.tfHits = null;
         this.tfAvgExperience.dispose();
         this.tfAvgExperience = null;
         this.tfAvgDamage.dispose();
         this.tfAvgDamage = null;
         this.tfMaxDestroyed.dispose();
         this.tfMaxDestroyed = null;
         this.tfMaxExperience.dispose();
         this.tfMaxExperience = null;
         this.tfTotalBattles.dispose();
         this.tfTotalBattles = null;
         this.tfMarksOfMastery.dispose();
         this.tfMarksOfMastery = null;
         this.tfPersonalScore.dispose();
         this.tfPersonalScore = null;
         this.footer.dispose();
         this.footer = null;
         this.significantAwards.dispose();
         this.significantAwards = null;
         if(this._lineTextFieldsLayout != null)
         {
            this._lineTextFieldsLayout.dispose();
            this._lineTextFieldsLayout = null;
         }
         if(this.profileSummaryVO)
         {
            this.profileSummaryVO.dispose();
            this.profileSummaryVO = null;
         }
         if(this.summaryInitVO)
         {
            this.summaryInitVO.dispose();
            this.summaryInitVO = null;
         }
         super.onDispose();
      }
      
      override protected function setUserData(param1:ProfileUserVO) : void
      {
         this.footer.setUserData(param1);
      }
      
      protected function applyInitData() : void
      {
         var _loc1_:SummaryCommonScoresVO = this.summaryInitVO.commonScores;
         this.tfWins.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_WINS;
         this.tfHits.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_HITS;
         this.tfAvgExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGEXP;
         this.tfAvgDamage.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_AVGDAMAGE;
         this.tfMaxDestroyed.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXDESTROYED;
         this.tfMaxExperience.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MAXEXP;
         this.tfTotalBattles.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_BATTLESCOUNT;
         this.tfMarksOfMastery.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_MARKOFMASTERY;
         this.tfPersonalScore.description = _loc1_.personalScore.description;
         this.tfMarksOfMastery.description = _loc1_.coolSigns.description;
         this.tfMarksOfMastery.iconSource = _loc1_.coolSigns.icon;
         this.tfWins.description = _loc1_.wins.description;
         this.tfWins.iconSource = _loc1_.wins.icon;
         this.tfHits.iconSource = _loc1_.hits.icon;
         this.tfHits.description = _loc1_.hits.description;
         this.tfAvgExperience.iconSource = _loc1_.avgExperience.icon;
         this.tfAvgExperience.description = _loc1_.avgExperience.description;
         this.tfAvgDamage.iconSource = _loc1_.avgDamage.icon;
         this.tfAvgDamage.description = _loc1_.avgDamage.description;
         this.tfMaxDestroyed.iconSource = _loc1_.maxDestroyed.icon;
         this.tfMaxDestroyed.description = _loc1_.maxDestroyed.description;
         this.tfMaxExperience.iconSource = _loc1_.maxExperience.icon;
         this.tfMaxExperience.description = _loc1_.maxExperience.description;
         this.tfTotalBattles.iconSource = _loc1_.battles.icon;
         this.tfTotalBattles.description = _loc1_.battles.description;
         this.significantAwards.label = this.summaryInitVO.significantAwardsLabel;
         this.significantAwards.errorText = this.summaryInitVO.significantAwardsErrorText;
      }
   }
}
