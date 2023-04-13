package net.wg.gui.lobby.settings.feedback.ribbons
{
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.InfoIcon;
   
   public class BattleEfficiencyControlsGroupContent extends GroupContent
   {
       
      
      public var battleEventsBaseCaptureDropCheckbox:CheckBox = null;
      
      public var battleEventsBaseCaptureCheckbox:CheckBox = null;
      
      public var battleEventsEnemyDetectionCheckbox:CheckBox = null;
      
      public var battleEventsEnemyRamAttackCheckbox:CheckBox = null;
      
      public var battleEventsEnemyKillCheckbox:CheckBox = null;
      
      public var battleEventsEnemyTrackDamageCheckbox:CheckBox = null;
      
      public var battleEventsEnemyCriticalHitCheckbox:CheckBox = null;
      
      public var battleEventsEnemyHpDamageCheckbox:CheckBox = null;
      
      public var battleEventsEnemyWorldCollisionCheckbox:CheckBox = null;
      
      public var battleEventsEnemyDetectionDamageCheckbox:CheckBox = null;
      
      public var battleEventsEnemyAssistStunCheckbox:CheckBox = null;
      
      public var battleEventsEnemyBurningCheckbox:CheckBox = null;
      
      public var battleEventsEnemyStunCheckbox:CheckBox = null;
      
      public function BattleEfficiencyControlsGroupContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleEventsBaseCaptureCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_BASECAPTURE;
         this.battleEventsBaseCaptureDropCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_BASECAPTUREDROP;
         this.battleEventsEnemyBurningCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYBURNING;
         this.battleEventsEnemyCriticalHitCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYCRITICALHIT;
         this.battleEventsEnemyDetectionCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYDETECTION;
         this.battleEventsEnemyDetectionDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYDETECTIONDAMAGE;
         this.battleEventsEnemyHpDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYHPDAMAGE;
         this.battleEventsEnemyKillCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYKILL;
         this.battleEventsEnemyRamAttackCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYRAMATTACK;
         this.battleEventsEnemyTrackDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ENEMYTRACKDAMAGE;
         this.battleEventsEnemyWorldCollisionCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_WORLDCOLLISION;
         this.battleEventsEnemyAssistStunCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_ASSISTSTUN;
         this.battleEventsEnemyStunCheckbox.label = SETTINGS.FEEDBACK_TAB_BATTLEEVENTS_CHECKBOX_STUN;
         this.battleEventsEnemyStunCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.battleEventsEnemyStunCheckbox.toolTip = TOOLTIPS.SETTINGS_RIBBONS_ENEMYSTUN;
      }
      
      override protected function onDispose() : void
      {
         this.battleEventsBaseCaptureCheckbox.dispose();
         this.battleEventsBaseCaptureCheckbox = null;
         this.battleEventsBaseCaptureDropCheckbox.dispose();
         this.battleEventsBaseCaptureDropCheckbox = null;
         this.battleEventsEnemyBurningCheckbox.dispose();
         this.battleEventsEnemyBurningCheckbox = null;
         this.battleEventsEnemyCriticalHitCheckbox.dispose();
         this.battleEventsEnemyCriticalHitCheckbox = null;
         this.battleEventsEnemyDetectionCheckbox.dispose();
         this.battleEventsEnemyDetectionCheckbox = null;
         this.battleEventsEnemyDetectionDamageCheckbox.dispose();
         this.battleEventsEnemyDetectionDamageCheckbox = null;
         this.battleEventsEnemyHpDamageCheckbox.dispose();
         this.battleEventsEnemyHpDamageCheckbox = null;
         this.battleEventsEnemyKillCheckbox.dispose();
         this.battleEventsEnemyKillCheckbox = null;
         this.battleEventsEnemyRamAttackCheckbox.dispose();
         this.battleEventsEnemyRamAttackCheckbox = null;
         this.battleEventsEnemyTrackDamageCheckbox.dispose();
         this.battleEventsEnemyTrackDamageCheckbox = null;
         this.battleEventsEnemyWorldCollisionCheckbox.dispose();
         this.battleEventsEnemyWorldCollisionCheckbox = null;
         this.battleEventsEnemyAssistStunCheckbox.dispose();
         this.battleEventsEnemyAssistStunCheckbox = null;
         this.battleEventsEnemyStunCheckbox.dispose();
         this.battleEventsEnemyStunCheckbox = null;
         super.onDispose();
      }
   }
}
