package net.wg.gui.lobby.settings.feedback.damageLog
{
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.components.battleDamagePanel.BattleDamageLogPanel;
   import net.wg.gui.components.battleDamagePanel.constants.BattleDamageLogConstants;
   import net.wg.gui.components.battleDamagePanel.models.MessageRenderModel;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
   import net.wg.gui.lobby.settings.feedback.damageLog.data.SettingsDamageLogData;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class DamageLogPanelForm extends FeedbackBaseForm
   {
      
      private static const TEXT_PADDING:int = 4;
      
      private static const INFO_DELTA:int = 5;
      
      private static const DAMAGE_LOG_TOTAL_DAMAGE_ID:String = "damageLogTotalDamage";
      
      private static const DAMAGE_LOG_BLOCKED_DAMAGE_ID:String = "damageLogBlockedDamage";
      
      private static const DAMAGE_LOG_ASSIST_DAMAGE_ID:String = "damageLogAssistDamage";
      
      private static const DAMAGE_LOG_ASSIST_STUN_ID:String = "damageLogAssistStun";
      
      private static const DAMAGE_LOG_SHOW_DETAILS_ID:String = "damageLogShowDetails";
      
      private static const DAMAGE_LOG_EVENT_TYPE_ID:String = "damageLogShowEventTypes";
      
      private static const DAMAGE_LOG_POSITION_ID:String = "damageLogEventsPosition";
      
      private static const DETAILS_LOG_DOESNT_SHOW:int = 2;
      
      private static const DETAILS_LOG_ALL_EVENTS_IDX:int = 0;
      
      private static const DETAILS_LOG_POSITIVE_EVENTS_IDX:int = 1;
      
      private static const DETAILS_LOG_NEGATIVE_EVENTS_IDX:int = 2;
      
      private static const DETAILS_LOG_BOTTOM_POSITION_IDX:int = 0;
      
      private static const DAMAGE_LOG_COUNTER_CONTAINER_ID:String = "DAMAGE_LOG_COUNTER_CONTAINER_ID ";
       
      
      public var screenSizeAlert:ScreenSizeAlert = null;
      
      public var damageLogDamageLabel:TextField = null;
      
      public var damageLogTotalDamageCheckbox:CheckBox = null;
      
      public var damageLogBlockedDamageCheckbox:CheckBox = null;
      
      public var damageLogAssistDamageCheckbox:CheckBox = null;
      
      public var damageLogAssistStunCheckbox:CheckBox = null;
      
      public var damageLogDetailsLabel:TextField = null;
      
      public var damageLogPositionLabel:TextField = null;
      
      public var damageLogEventTypesLabel:TextField = null;
      
      public var damageLogDetailsInfoIcon:InfoIcon = null;
      
      public var damageLogShowDetailsButtonBar:RadioButtonBar;
      
      public var damageLogShowEventTypesButtonBar:RadioButtonBar;
      
      public var damageLogEventsPositionButtonBar:RadioButtonBar;
      
      public var damageLogPanelComponent:BattleDamageLogPanel;
      
      private var _colorMgr:IColorSchemeManager;
      
      public function DamageLogPanelForm()
      {
         this._colorMgr = App.colorSchemeMgr;
         super();
         this.damageLogPanelComponent.init(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY);
         this.damageLogPanelComponent.setSettingsDamageLogComponent(true,false);
         this.damageLogPanelComponent.setDetailActionCount(BattleDamageLogConstants.SETTINGS_POOL_COUNT);
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.updateSettings();
      }
      
      override public function updateContent(param1:Object) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:Vector.<MessageRenderModel> = null;
         super.updateContent(param1);
         var _loc2_:int = param1[DAMAGE_LOG_EVENT_TYPE_ID];
         var _loc3_:Boolean = param1[DAMAGE_LOG_SHOW_DETAILS_ID] != DETAILS_LOG_DOESNT_SHOW;
         if(param1[DAMAGE_LOG_TOTAL_DAMAGE_ID])
         {
            _loc4_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYDAMAGE;
         }
         if(param1[DAMAGE_LOG_BLOCKED_DAMAGE_ID])
         {
            _loc5_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYBLOCK;
         }
         if(param1[DAMAGE_LOG_ASSIST_DAMAGE_ID])
         {
            _loc6_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYASSIST;
         }
         if(param1[DAMAGE_LOG_ASSIST_STUN_ID])
         {
            _loc7_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYASSISTSTUN;
         }
         this.damageLogPanelComponent.setSummaryStats(_loc4_,_loc5_,_loc6_,_loc7_);
         var _loc9_:Boolean = true;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = _loc2_ == DETAILS_LOG_POSITIVE_EVENTS_IDX;
         if(param1[DAMAGE_LOG_POSITION_ID] == DETAILS_LOG_BOTTOM_POSITION_IDX)
         {
            if(_loc2_ == DETAILS_LOG_ALL_EVENTS_IDX)
            {
               _loc8_ = SettingsDamageLogData.getTotal();
            }
            else if(_loc11_)
            {
               _loc8_ = SettingsDamageLogData.getPositive();
               _loc9_ = false;
            }
            else
            {
               _loc8_ = SettingsDamageLogData.getNegative();
            }
            this.damageLogPanelComponent.settingsDetailStatsBottom(_loc3_,_loc11_,_loc8_);
            this.damageLogPanelComponent.settingsDetailStatsTop(_loc3_,SettingsDamageLogData.getEmpty());
         }
         else
         {
            if(_loc11_ || _loc2_ == DETAILS_LOG_ALL_EVENTS_IDX)
            {
               this.damageLogPanelComponent.settingsDetailStatsBottom(_loc3_,true,SettingsDamageLogData.getPositive());
            }
            if(_loc11_)
            {
               this.damageLogPanelComponent.settingsDetailStatsTop(_loc3_,SettingsDamageLogData.getEmpty());
               _loc9_ = false;
            }
            if(_loc2_ == DETAILS_LOG_NEGATIVE_EVENTS_IDX || _loc2_ == DETAILS_LOG_ALL_EVENTS_IDX)
            {
               _loc10_ = true;
               this.damageLogPanelComponent.settingsDetailStatsTop(_loc3_,SettingsDamageLogData.getNegative());
               if(_loc2_ == DETAILS_LOG_NEGATIVE_EVENTS_IDX)
               {
                  this.damageLogPanelComponent.settingsDetailStatsBottom(_loc3_,true,SettingsDamageLogData.getEmpty());
               }
            }
         }
         this.damageLogEventsPositionButtonBar.enabled = _loc9_ && !getControlPropsByKey(DAMAGE_LOG_POSITION_ID).readOnly;
         this.screenSizeAlert.visible = _loc10_ && _loc3_;
      }
      
      override protected function getContainerId() : String
      {
         return DAMAGE_LOG_COUNTER_CONTAINER_ID;
      }
      
      override protected function onDispose() : void
      {
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorMgr = null;
         this.screenSizeAlert.dispose();
         this.screenSizeAlert = null;
         this.damageLogShowEventTypesButtonBar.dispose();
         this.damageLogShowEventTypesButtonBar = null;
         this.damageLogEventsPositionButtonBar.dispose();
         this.damageLogEventsPositionButtonBar = null;
         this.damageLogBlockedDamageCheckbox.dispose();
         this.damageLogBlockedDamageCheckbox = null;
         this.damageLogAssistDamageCheckbox.dispose();
         this.damageLogAssistDamageCheckbox = null;
         this.damageLogAssistStunCheckbox.dispose();
         this.damageLogAssistStunCheckbox = null;
         this.damageLogTotalDamageCheckbox.dispose();
         this.damageLogTotalDamageCheckbox = null;
         this.damageLogDetailsLabel = null;
         this.damageLogPositionLabel = null;
         this.damageLogEventTypesLabel = null;
         this.damageLogShowDetailsButtonBar.dispose();
         this.damageLogShowDetailsButtonBar = null;
         this.damageLogDamageLabel = null;
         this.damageLogDetailsInfoIcon.dispose();
         this.damageLogDetailsInfoIcon = null;
         this.damageLogPanelComponent.dispose();
         this.damageLogPanelComponent = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.damageLogDamageLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMLABEL;
         this.damageLogTotalDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_DAMAGEDONE;
         this.damageLogBlockedDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_BLOCKEDDAMAGE;
         this.damageLogAssistDamageCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_DAMAGEASSIST;
         this.damageLogAssistStunCheckbox.multiline = true;
         this.damageLogAssistStunCheckbox.wordWrap = true;
         this.damageLogAssistStunCheckbox.label = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_ASSISTSTUN;
         this.damageLogDetailsLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_DETAILSLABEL;
         this.damageLogDetailsLabel.width = this.damageLogDetailsLabel.textWidth + TEXT_PADDING;
         this.damageLogPositionLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_EVENTPOSITIONSLABEL;
         this.damageLogEventTypesLabel.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_EVENTTYPES_EVENTTYPESLABEL;
         this.damageLogDetailsInfoIcon.icoType = InfoIcon.TYPE_INFO;
         this.damageLogDetailsInfoIcon.tooltip = TOOLTIPS.SETTINGS_DAMAGELOG_DETAILS;
         this.damageLogDetailsInfoIcon.x = this.damageLogDetailsLabel.x + this.damageLogDetailsLabel.width + INFO_DELTA ^ 0;
         this.screenSizeAlert.alertIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_ICON_ALERT_32X32;
         this.screenSizeAlert.tf.text = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SCREENALERT;
      }
      
      private function updateSettings() : void
      {
         this.damageLogPanelComponent.setSettingsDamageLogComponent(true,this._colorMgr.getIsColorBlindS());
      }
      
      override public function get formId() : String
      {
         return Linkages.FEEDBACK_DAMAGE_LOG;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateSettings();
      }
   }
}
