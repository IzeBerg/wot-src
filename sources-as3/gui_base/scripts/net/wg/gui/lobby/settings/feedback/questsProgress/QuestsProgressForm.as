package net.wg.gui.lobby.settings.feedback.questsProgress
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   
   public class QuestsProgressForm extends FeedbackBaseForm
   {
      
      private static const STANDARD_SETTINGS_ID:int = 0;
      
      private static const SHOW_ALL_SETTINGS_ID:int = 0;
      
      private static const SCORE_PANEL_SHOW_HP_BAR_ID:String = "showHPBar";
      
      private static const SCORE_PANEL_SHOW_HP_VALUES_ID:String = "showHPValues";
      
      private static const SCORE_PANEL_SHOW_HP_DIFFERENCE_ID:String = "showHPDifference";
      
      private static const SCORE_PANEL_ENABLE_TIER_GROUPING_ID:String = "enableTierGrouping";
      
      private static const PROGRESS_VIEW_TYPE_CONTROL_ID:String = "progressViewType";
      
      private static const ALLOW_QUEST_PROGRESS:String = "allowQuestProgress";
      
      private static const PROGRESS_VIEW_CONDITIONS_CONTROL_ID:String = "progressViewConditions";
      
      private static const QUESTS_PROGRESS_COUNTER_CONTAINER_ID:String = "QUESTS_PROGRESS_COUNTER_CONTAINER_ID";
      
      private static const PROGRESS_VIEW_CONDITIONS_LABEL_ENABLED_ALPHA:Number = 1;
      
      private static const PROGRESS_VIEW_CONDITIONS_LABEL_DISABLED_ALPHA:Number = 0.5;
      
      private static const TRUE_VALUE_ID:int = 1;
      
      private static const DEFAULT_TEXT_LABEL_HEIGHT:int = 20;
      
      private static const ADDITIONAL_OFFSET:int = 15;
       
      
      public var battleScoreLabel:TextField = null;
      
      public var showHPBarCheckbox:CheckBox = null;
      
      public var showHPValuesCheckbox:CheckBox = null;
      
      public var showHPDifferenceCheckbox:CheckBox = null;
      
      public var enableTierGroupingCheckbox:CheckBox = null;
      
      public var scorePanelControls:ScorePanelControls = null;
      
      public var questsProgressControls:QuestsProgressControls = null;
      
      public var progressViewTypeLabel:TextField = null;
      
      public var progressViewConditionsLabel:TextField = null;
      
      public var progressViewTypeButtonBar:RadioButtonBar = null;
      
      public var progressViewConditionsButtonBar:RadioButtonBar = null;
      
      public var bg:MovieClip = null;
      
      private var _colorMgr:IColorSchemeManager = null;
      
      private var _data:Object = null;
      
      private var _initialShowHPValuesCheckboxY:int = 0;
      
      private var _initialShowHPDifferenceCheckboxY:int = 0;
      
      private var _initialEnableTierGroupingCheckboxY:int = 0;
      
      private var _initialProgressViewTypeLabelY:int = 0;
      
      private var _initialProgressViewConditionsLabelY:int = 0;
      
      private var _initialProgressViewTypeButtonBarY:int = 0;
      
      private var _initialProgressViewConditionsButtonBarY:int = 0;
      
      public function QuestsProgressForm()
      {
         super();
         this._colorMgr = App.colorSchemeMgr;
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._initialEnableTierGroupingCheckboxY = this.enableTierGroupingCheckbox.y;
         this._initialProgressViewConditionsButtonBarY = this.progressViewConditionsButtonBar.y;
         this._initialProgressViewConditionsLabelY = this.progressViewConditionsLabel.y;
         this._initialProgressViewTypeButtonBarY = this.progressViewTypeButtonBar.y;
         this._initialProgressViewTypeLabelY = this.progressViewTypeLabel.y;
         this._initialShowHPDifferenceCheckboxY = this.showHPDifferenceCheckbox.y;
         this._initialShowHPValuesCheckboxY = this.showHPValuesCheckbox.y;
      }
      
      override public function updateContent(param1:Object) : void
      {
         super.updateContent(param1);
         this._data = param1;
         var _loc2_:Boolean = param1[PROGRESS_VIEW_TYPE_CONTROL_ID] == STANDARD_SETTINGS_ID;
         var _loc3_:Boolean = param1[PROGRESS_VIEW_CONDITIONS_CONTROL_ID] == SHOW_ALL_SETTINGS_ID;
         this.questsProgressControls.setFlagVisible(_loc3_);
         this.progressViewTypeButtonBar.validateNow();
         this.progressViewConditionsButtonBar.validateNow();
         var _loc4_:Boolean = param1[SCORE_PANEL_SHOW_HP_BAR_ID] == TRUE_VALUE_ID;
         var _loc5_:Boolean = param1[SCORE_PANEL_SHOW_HP_VALUES_ID] == TRUE_VALUE_ID;
         var _loc6_:Boolean = param1[SCORE_PANEL_SHOW_HP_DIFFERENCE_ID] == TRUE_VALUE_ID;
         var _loc7_:Boolean = param1[SCORE_PANEL_ENABLE_TIER_GROUPING_ID] == TRUE_VALUE_ID;
         this.scorePanelControls.setVisibilityFlags(_loc4_,_loc5_,_loc6_,_loc7_);
         this.updateControls(_loc2_);
         this.onShowHPBarCheckboxSelectHandler(null);
         var _loc8_:Boolean = param1[ALLOW_QUEST_PROGRESS] == TRUE_VALUE_ID;
         this.setQuestProgressElementsVisibility(_loc8_);
         this.updateCheckBoxPosition();
      }
      
      override protected function getContainerId() : String
      {
         return QUESTS_PROGRESS_COUNTER_CONTAINER_ID;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.battleScoreLabel.text = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_BATTLESCORELABEL;
         this.showHPBarCheckbox.label = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_SHOWHPBAR;
         this.showHPBarCheckbox.addEventListener(Event.SELECT,this.onShowHPBarCheckboxSelectHandler);
         this.showHPValuesCheckbox.label = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_SHOWHPVALUES;
         this.showHPDifferenceCheckbox.label = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_SHOWHPDIFFERENCE;
         this.enableTierGroupingCheckbox.multiline = true;
         this.enableTierGroupingCheckbox.wordWrap = true;
         this.enableTierGroupingCheckbox.label = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_ENABLETIERGROUPING;
         this.enableTierGroupingCheckbox.toolTip = TOOLTIPS.ENABLETIERGROUPING;
         this.enableTierGroupingCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.progressViewTypeLabel.text = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_TYPELABEL;
         this.progressViewConditionsLabel.text = SETTINGS.FEEDBACK_TAB_QUESTSPROGRESS_CONDITIONSLABEL;
      }
      
      override protected function onDispose() : void
      {
         this.battleScoreLabel = null;
         this.showHPBarCheckbox.removeEventListener(Event.SELECT,this.onShowHPBarCheckboxSelectHandler);
         this.showHPBarCheckbox.dispose();
         this.showHPBarCheckbox = null;
         this.showHPValuesCheckbox.dispose();
         this.showHPValuesCheckbox = null;
         this.showHPDifferenceCheckbox.dispose();
         this.showHPDifferenceCheckbox = null;
         this.enableTierGroupingCheckbox.dispose();
         this.enableTierGroupingCheckbox = null;
         this.questsProgressControls.dispose();
         this.questsProgressControls = null;
         this.scorePanelControls.dispose();
         this.scorePanelControls = null;
         this.progressViewTypeLabel = null;
         this.progressViewConditionsLabel = null;
         this.progressViewTypeButtonBar.dispose();
         this.progressViewTypeButtonBar = null;
         this.progressViewConditionsButtonBar.dispose();
         this.progressViewConditionsButtonBar = null;
         this.bg = null;
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function onButtonBarIndexChange(param1:RadioButtonBar) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         super.onButtonBarIndexChange(param1);
         var _loc2_:int = param1.dataProvider[param1.selectedIndex].data;
         if(param1 == this.progressViewTypeButtonBar)
         {
            _loc3_ = _loc2_ == STANDARD_SETTINGS_ID;
            this.updateControls(_loc3_);
         }
         else if(param1 == this.progressViewConditionsButtonBar)
         {
            _loc4_ = _loc2_ == SHOW_ALL_SETTINGS_ID;
            this.questsProgressControls.setFlagVisible(_loc4_);
         }
      }
      
      private function onShowHPBarCheckboxSelectHandler(param1:Event) : void
      {
         this.showHPValuesCheckbox.enabled = this.showHPDifferenceCheckbox.enabled = this.showHPBarCheckbox.selected;
      }
      
      private function updateControls(param1:Boolean) : void
      {
         setElementEnabled(this.progressViewConditionsButtonBar,param1);
         this.progressViewConditionsButtonBar.enabled = param1;
         this.progressViewConditionsLabel.alpha = !!param1 ? Number(PROGRESS_VIEW_CONDITIONS_LABEL_ENABLED_ALPHA) : Number(PROGRESS_VIEW_CONDITIONS_LABEL_DISABLED_ALPHA);
         this.questsProgressControls.visible = param1;
         this.scorePanelControls.updateColorScheme(this._colorMgr.getIsColorBlindS());
      }
      
      private function updateCheckBoxPosition() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         this.showHPDifferenceCheckbox.validateNow();
         this.showHPBarCheckbox.validateNow();
         this.showHPValuesCheckbox.validateNow();
         this.enableTierGroupingCheckbox.validateNow();
         _loc1_ += this.showHPBarCheckbox.textField.height >= DEFAULT_TEXT_LABEL_HEIGHT ? ADDITIONAL_OFFSET : 0;
         this.showHPValuesCheckbox.y = this._initialShowHPValuesCheckboxY + _loc1_;
         _loc1_ += this.showHPValuesCheckbox.textField.height >= DEFAULT_TEXT_LABEL_HEIGHT ? ADDITIONAL_OFFSET : 0;
         this.showHPDifferenceCheckbox.y = this._initialShowHPDifferenceCheckboxY + _loc1_;
         _loc1_ += this.showHPDifferenceCheckbox.textField.height >= DEFAULT_TEXT_LABEL_HEIGHT ? ADDITIONAL_OFFSET : 0;
         this.enableTierGroupingCheckbox.y = this._initialEnableTierGroupingCheckboxY + _loc1_;
         _loc1_ += this.enableTierGroupingCheckbox.textField.height >= DEFAULT_TEXT_LABEL_HEIGHT ? ADDITIONAL_OFFSET : 0;
         this.progressViewTypeButtonBar.y = this._initialProgressViewTypeButtonBarY + _loc1_;
         this.progressViewConditionsButtonBar.y = this._initialProgressViewConditionsButtonBarY + _loc1_;
         this.progressViewTypeLabel.y = this._initialProgressViewTypeLabelY + _loc1_;
         this.progressViewConditionsLabel.y = this._initialProgressViewConditionsLabelY + _loc1_;
         this.enableTierGroupingCheckbox.invalidateState();
         this.enableTierGroupingCheckbox.validateNow();
      }
      
      private function setQuestProgressElementsVisibility(param1:Boolean) : void
      {
         this.progressViewTypeLabel.visible = param1;
         this.progressViewConditionsLabel.visible = param1;
         this.progressViewTypeButtonBar.visible = param1;
         this.progressViewConditionsButtonBar.visible = param1;
      }
      
      override public function get formId() : String
      {
         return Linkages.FEEDBACK_QUESTS_PROGRESS;
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.updateContent(this._data);
      }
      
      public function setIsEvent(param1:Boolean) : void
      {
         this.scorePanelControls.visible = !param1;
      }
   }
}
