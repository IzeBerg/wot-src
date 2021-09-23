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
      
      private var _colorMgr:IColorSchemeManager = null;
      
      public function DamageLogPanelForm()
      {
         super();
         this._colorMgr = App.colorSchemeMgr;
         this.damageLogPanelComponent.init(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY);
         this.damageLogPanelComponent.setSettingsDamageLogComponent(true,false);
         this.damageLogPanelComponent.setDetailActionCount(BattleDamageLogConstants.SETTINGS_POOL_COUNT);
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this.updateSettings();
      }
      
      override public function updateContent(param1:Object) : void
      {
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Vector.<MessageRenderModel> = null;
         super.updateContent(param1);
         var _loc2_:Boolean = param1[DAMAGE_LOG_TOTAL_DAMAGE_ID];
         var _loc3_:Boolean = param1[DAMAGE_LOG_ASSIST_DAMAGE_ID];
         var _loc4_:Boolean = param1[DAMAGE_LOG_BLOCKED_DAMAGE_ID];
         var _loc5_:Boolean = param1[DAMAGE_LOG_ASSIST_STUN_ID];
         var _loc6_:int = param1[DAMAGE_LOG_SHOW_DETAILS_ID];
         var _loc7_:int = param1[DAMAGE_LOG_EVENT_TYPE_ID];
         var _loc8_:int = param1[DAMAGE_LOG_POSITION_ID];
         var _loc9_:Boolean = _loc6_ != DETAILS_LOG_DOESNT_SHOW;
         if(_loc2_)
         {
            _loc10_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYDAMAGE;
         }
         if(_loc4_)
         {
            _loc11_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYBLOCK;
         }
         if(_loc3_)
         {
            _loc12_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYASSIST;
         }
         if(_loc5_)
         {
            _loc13_ = SETTINGS.FEEDBACK_TAB_DAMAGELOGPANEL_SUMMARYASSISTSTUN;
         }
         this.damageLogPanelComponent.setSummaryStats(_loc10_,_loc11_,_loc12_,_loc13_);
         var _loc15_:Boolean = true;
         var _loc16_:Boolean = false;
         var _loc17_:Boolean = _loc7_ == DETAILS_LOG_POSITIVE_EVENTS_IDX;
         if(_loc8_ == DETAILS_LOG_BOTTOM_POSITION_IDX)
         {
            if(_loc7_ == DETAILS_LOG_ALL_EVENTS_IDX)
            {
               _loc14_ = SettingsDamageLogData.getTotal();
            }
            else if(_loc17_)
            {
               _loc14_ = SettingsDamageLogData.getPositive();
               _loc15_ = false;
            }
            else
            {
               _loc14_ = SettingsDamageLogData.getNegative();
            }
            this.damageLogPanelComponent.settingsDetailStatsBottom(_loc9_,_loc17_,_loc14_);
            this.damageLogPanelComponent.settingsDetailStatsTop(_loc9_,SettingsDamageLogData.getEmpty());
         }
         else
         {
            if(_loc17_ || _loc7_ == DETAILS_LOG_ALL_EVENTS_IDX)
            {
               this.damageLogPanelComponent.settingsDetailStatsBottom(_loc9_,true,SettingsDamageLogData.getPositive());
            }
            if(_loc17_)
            {
               this.damageLogPanelComponent.settingsDetailStatsTop(_loc9_,SettingsDamageLogData.getEmpty());
               _loc15_ = false;
            }
            if(_loc7_ == DETAILS_LOG_NEGATIVE_EVENTS_IDX || _loc7_ == DETAILS_LOG_ALL_EVENTS_IDX)
            {
               _loc16_ = true;
               this.damageLogPanelComponent.settingsDetailStatsTop(_loc9_,SettingsDamageLogData.getNegative());
               if(_loc7_ == DETAILS_LOG_NEGATIVE_EVENTS_IDX)
               {
                  this.damageLogPanelComponent.settingsDetailStatsBottom(_loc9_,true,SettingsDamageLogData.getEmpty());
               }
            }
         }
         this.damageLogEventsPositionButtonBar.enabled = _loc15_ && !getControlPropsByKey(DAMAGE_LOG_POSITION_ID).readOnly;
         this.screenSizeAlert.visible = _loc16_ && _loc9_;
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
