package net.wg.gui.lobby.settings
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.components.controls.Slider;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.constants.ToolTipShowType;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class GameSettingsContent extends UIComponentEx
   {
      
      private static const OFFSET_CB_DISABLED:int = -26;
      
      private static const BTN_MIN_WIDTH:int = 128;
      
      private static const MENU_WIDTH:int = 410;
       
      
      public var fieldSetChat:FieldSet = null;
      
      public var fieldSetBattlePanel:FieldSet = null;
      
      public var fieldSetBattleTypes:FieldSet = null;
      
      public var fieldSetBattleCommunication:FieldSet = null;
      
      public var enableOlFilterCheckbox:CheckBox = null;
      
      public var enableSpamFilterCheckbox:CheckBox = null;
      
      public var showDateMessageCheckbox:CheckBox = null;
      
      public var showTimeMessageCheckbox:CheckBox = null;
      
      public var invitesFromFriendsOnlyCheckbox:CheckBox = null;
      
      public var receiveClanInvitesNotificationsCheckbox:CheckBox = null;
      
      public var receiveInvitesInBattleCheckbox:CheckBox = null;
      
      public var receiveFriendshipRequestCheckbox:CheckBox = null;
      
      public var chatContactsListOnlyCheckbox:CheckBox = null;
      
      public var disableBattleChatCheckbox:CheckBox = null;
      
      public var ppShowLevelsCheckbox:CheckBox = null;
      
      public var gameplay_ctfCheckbox:CheckBox = null;
      
      public var gameplay_dominationCheckbox:CheckBox = null;
      
      public var gameplay_assaultCheckbox:CheckBox = null;
      
      public var gameplay_epicDominationCheckbox:CheckBox = null;
      
      public var gameplay_epicStandardCheckbox:CheckBox = null;
      
      public var gameplay_only10ModeCheckbox:CheckBox = null;
      
      public var gameplay_devMapsCheckbox:CheckBox = null;
      
      public var newbiePrebattleHintsCheckbox:CheckBox = null;
      
      public var newbieBattleHintsCheckbox:CheckBox = null;
      
      public var restartNewbieBattleHints:SoundButtonEx = null;
      
      public var battleLoadingInfoLabelControl:LabelControl = null;
      
      public var battleLoadingInfoDropDown:DropdownMenu = null;
      
      public var switchEquipmentCheckbox:CheckBox = null;
      
      public var showCommInPlayerlistCheckbox:CheckBox = null;
      
      public var showStickyMarkersCheckbox:CheckBox = null;
      
      public var showCalloutMessagesCheckbox:CheckBox = null;
      
      public var showLocationMarkersCheckbox:CheckBox = null;
      
      public var showMarkersCheckbox:CheckBox = null;
      
      public var minimapAlphaSlider:Slider = null;
      
      public var enableOpticalSnpEffectCheckbox:CheckBox = null;
      
      public var postmortemModeLabelControl:LabelControl = null;
      
      public var postmortemModeDropDown:DropdownMenu = null;
      
      public var dynamicCameraCheckbox:CheckBox = null;
      
      public var scrollSmoothingCheckbox:CheckBox = null;
      
      public var preCommanderCamCheckbox:CheckBox = null;
      
      public var commanderCamCheckbox:CheckBox = null;
      
      public var horStabilizationSnpCheckbox:CheckBox = null;
      
      public var hullLockEnabledCheckbox:CheckBox = null;
      
      public var increasedZoomCheckbox:CheckBox = null;
      
      public var sniperModeByShiftCheckbox:CheckBox = null;
      
      public var replayEnabledLabel:TextField = null;
      
      public var sniperZoomLabel:TextField = null;
      
      public var replayEnabledDropDown:DropdownMenu = null;
      
      public var sniperZoomDropDown:DropdownMenu = null;
      
      public var useServerAimCheckbox:CheckBox = null;
      
      public var showVehiclesCounterCheckbox:CheckBox = null;
      
      public var anonymizerCheckbox:CheckBox = null;
      
      public var showMarksOnGunCheckbox:CheckBox = null;
      
      public var displayPlatoonMembersCheckbox:CheckBox = null;
      
      public var loginServerSelectionCheckbox:CheckBox = null;
      
      public var showVectorOnMapCheckbox:CheckBox = null;
      
      public var showSectorOnMapCheckbox:CheckBox = null;
      
      public var showVehModelsOnMapLabel:LabelControl = null;
      
      public var showVehModelsOnMapDropDown:DropdownMenu = null;
      
      public var showArtyHitOnMapCheckbox:CheckBox = null;
      
      public var showVehicleHPinPlayersPanelLabel:LabelControl = null;
      
      public var showVehicleHPinPlayersPanelDropDown:DropdownMenu = null;
      
      public var showVehicleHPinMinimapLabel:LabelControl = null;
      
      public var showVehicleHPinMinimapDropDown:DropdownMenu = null;
      
      public var minimapViewRangeCheckbox:CheckBox = null;
      
      public var minimapMaxViewRangeCheckbox:CheckBox = null;
      
      public var minimapDrawRangeCheckbox:CheckBox = null;
      
      public var minimapMinSpottingRangeCheckbox:CheckBox = null;
      
      public var fieldSetMinimap:FieldSet = null;
      
      public var hangarCamPeriodDropDown:DropdownMenu = null;
      
      public var hangarCamLabelControl:LabelControl = null;
      
      public var hangarCamParallaxEnabledCheckbox:CheckBox = null;
      
      public var hangarCamFieldSet:FieldSet = null;
      
      public var carouselTypeFieldSet:FieldSet = null;
      
      public var carouselTypeButtonBar:RadioButtonBar = null;
      
      public var customizationDisplayTypeFieldSet:FieldSet = null;
      
      public var customizationDisplayTypeButtonBar:RadioButtonBar = null;
      
      public var doubleCarouselLabel:TextField = null;
      
      public var doubleCarouselTypeDropDown:DropdownMenu = null;
      
      public var vehicleCarouselStatsCheckbox:CheckBox = null;
      
      public var minimapAlphaEnabledCheckbox:CheckBox = null;
      
      public var showDamageIconCheckbox:CheckBox = null;
      
      public var enableSpeedometerCheckbox:CheckBox = null;
      
      public var enableRepairTimerCheckbox:CheckBox = null;
      
      public var enableBattleNotifierCheckbox:CheckBox = null;
      
      public var showDogTagToKillerCheckbox:CheckBox = null;
      
      public var showVictimsDogTagCheckbox:CheckBox = null;
      
      public var showKillersDogTagCheckbox:CheckBox = null;
      
      private var _initYCarouselTypeFieldSet:int;
      
      private var _initYCarouselTypeButtonBar:int;
      
      private var _initYDoubleCarouselLabel:int;
      
      private var _initYDoubleCarouselTypeDropDown:int;
      
      private var _initYVehicleCarouselStatsCheckbox:int;
      
      private var _initYCustomizationDisplayTypeFieldSet:int;
      
      private var _initYCustomizationDisplayTypeButtonBar:int;
      
      private var _initYReplayEnabledLabel:int;
      
      private var _initYReplayEnabledDropDown:int;
      
      private var _initYShowMarksOnGunCheckbox:int;
      
      private var _initYDisplayPlatoonMembersCheckbox:int;
      
      private var _initYLoginServerSelectionCheckbox:int;
      
      private var _initYAnonymizerCheckbox:int;
      
      private var _initYGameplayOnly10ModeCheckbox:int;
      
      public function GameSettingsContent()
      {
         super();
         this.setDependentVisibleControlsY();
      }
      
      override protected function configUI() : void
      {
         this.fieldSetChat.label = SETTINGS.GAME_FIELDSET_HEADERCHAT;
         this.fieldSetBattlePanel.label = SETTINGS.GAME_BATTLEPANELSETTINGS;
         this.fieldSetBattleTypes.label = SETTINGS.GAME_FIELDSET_HEADERGAMEPLAY;
         this.fieldSetMinimap.label = SETTINGS.GAME_MINIMAPGROUPTITLE;
         this.fieldSetBattleCommunication.label = SETTINGS.GAME_FIELDSET_HEADERBATTLECOMMUNICATION;
         this.customizationDisplayTypeFieldSet.label = SETTINGS.GAME_CUSTOMIZATIONDISPLAYTYPE;
         this.hangarCamFieldSet.label = SETTINGS.GAME_HANGARCAMGROUPTITLE;
         this.enableOlFilterCheckbox.label = SETTINGS.CHAT_CENSORSHIPMESSAGES;
         this.enableSpamFilterCheckbox.label = SETTINGS.CHAT_REMOVESPAM;
         this.showDateMessageCheckbox.label = SETTINGS.CHAT_SHOWDATEMESSAGE;
         this.showTimeMessageCheckbox.label = SETTINGS.CHAT_SHOWTIMEMESSAGE;
         this.invitesFromFriendsOnlyCheckbox.label = SETTINGS.CHAT_INVITESFROMFRIENDSONLY;
         this.receiveClanInvitesNotificationsCheckbox.label = SETTINGS.CHAT_RECEIVECLANINVITESNOTIFICATIONS;
         this.receiveClanInvitesNotificationsCheckbox.toolTip = TOOLTIPS.RECEIVECLANINVITESNOTIFICATIONS;
         this.receiveClanInvitesNotificationsCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.receiveInvitesInBattleCheckbox.label = SETTINGS.CHAT_RECEIVEINVITESINBATTLE;
         this.receiveInvitesInBattleCheckbox.toolTip = TOOLTIPS.RECEIVEINVITESINBATTLE;
         this.receiveInvitesInBattleCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.receiveFriendshipRequestCheckbox.label = SETTINGS.CHAT_RECEIVEFRIENDSHIPREQUEST;
         this.receiveFriendshipRequestCheckbox.toolTip = TOOLTIPS.RECEIVEFRIENDSHIPREQUEST;
         this.receiveFriendshipRequestCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.chatContactsListOnlyCheckbox.label = SETTINGS.CHAT_CHATCONTACTSLISTONLY;
         this.chatContactsListOnlyCheckbox.toolTip = TOOLTIPS.CHATCONTACTSLISTONLY;
         this.chatContactsListOnlyCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.disableBattleChatCheckbox.label = SETTINGS.CHAT_DISABLEBATTLECHAT;
         this.disableBattleChatCheckbox.toolTip = TOOLTIPS.TURNOFFCOMBATCHAT;
         this.disableBattleChatCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showCommInPlayerlistCheckbox.label = SETTINGS.BATTLECOMM_SHOWCOMMINPLAYERLIST;
         this.showCommInPlayerlistCheckbox.toolTip = TOOLTIPS.SHOWCOMMINPLAYERLIST;
         this.showCommInPlayerlistCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showStickyMarkersCheckbox.label = SETTINGS.BATTLECOMM_SHOWSTICKYMARKERS;
         this.showCalloutMessagesCheckbox.label = SETTINGS.BATTLECOMM_SHOWCALLOUTMESSAGES;
         this.showLocationMarkersCheckbox.label = SETTINGS.BATTLECOMM_SHOWLOCATIONMARKERS;
         this.showLocationMarkersCheckbox.tooltipType = ToolTipShowType.SPECIAL;
         this.showLocationMarkersCheckbox.toolTip = TOOLTIPS_CONSTANTS.SETTINGS_SHOW_LOCATION_MARKERS;
         this.showLocationMarkersCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showMarkersCheckbox.label = SETTINGS.BATTLECOMM_SHOWMARKERS;
         this.showMarkersCheckbox.toolTip = TOOLTIPS.SHOWBASEMARKERS;
         this.showMarkersCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.ppShowLevelsCheckbox.label = SETTINGS.GAME_PPSHOWLEVELS;
         this.gameplay_ctfCheckbox.label = SETTINGS.GAMEPLAY_CTF;
         this.gameplay_dominationCheckbox.label = SETTINGS.GAMEPLAY_DOMINATION;
         this.gameplay_assaultCheckbox.label = SETTINGS.GAMEPLAY_ASSAULT;
         this.gameplay_epicDominationCheckbox.label = SETTINGS.GAMEPLAY_EPIC_ENCOUNTER;
         this.gameplay_devMapsCheckbox.label = SETTINGS.GAMEPLAY_DEVMAPS;
         this.gameplay_devMapsCheckbox.toolTip = TOOLTIPS.DEVMAPS;
         this.gameplay_devMapsCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.gameplay_epicDominationCheckbox.visible = false;
         this.gameplay_epicStandardCheckbox.label = SETTINGS.GAMEPLAY_EPIC_STANDARD;
         this.gameplay_epicStandardCheckbox.toolTip = TOOLTIPS.EPICRANDOMSTANDARDNOTIFICATION;
         this.gameplay_epicStandardCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.gameplay_only10ModeCheckbox.label = SETTINGS.GAMEPLAY_ONLY10MODE;
         this.gameplay_only10ModeCheckbox.toolTip = TOOLTIPS.ONLY10MODE;
         this.gameplay_only10ModeCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.newbiePrebattleHintsCheckbox.label = SETTINGS.GAME_NEWBIEPREBATTLEHINTS;
         this.newbiePrebattleHintsCheckbox.toolTip = TOOLTIPS.NEWBIEPREBATTLEHINTS;
         this.newbiePrebattleHintsCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.newbiePrebattleHintsCheckbox.multiline = true;
         this.newbiePrebattleHintsCheckbox.wordWrap = true;
         this.newbieBattleHintsCheckbox.label = SETTINGS.GAME_NEWBIEBATTLEHINTS;
         this.newbieBattleHintsCheckbox.toolTip = TOOLTIPS.NEWBIEBATTLEHINTS;
         this.newbieBattleHintsCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.restartNewbieBattleHints.label = SETTINGS.RESTARTNEWBIEBATTLEHINTS;
         this.restartNewbieBattleHints.minWidth = BTN_MIN_WIDTH;
         this.battleLoadingInfoLabelControl.text = SETTINGS.GAME_BATTLELOADINGINFO;
         this.battleLoadingInfoLabelControl.toolTip = TOOLTIPS.BATTLELOADINGINFO;
         this.battleLoadingInfoLabelControl.infoIcoType = InfoIcon.TYPE_INFO;
         this.switchEquipmentCheckbox.label = SETTINGS.GAME_SWITCHEQUIPMENT;
         this.switchEquipmentCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.switchEquipmentCheckbox.toolTip = TOOLTIPS_CONSTANTS.SETTINGS_SWITCH_EQUIPMENT;
         this.switchEquipmentCheckbox.tooltipType = ToolTipShowType.SPECIAL;
         this.postmortemModeLabelControl.text = SETTINGS.GAME_POSTMORTEMMODE;
         this.postmortemModeLabelControl.toolTip = TOOLTIPS.POSTMORTEMMODE;
         this.postmortemModeLabelControl.infoIcoType = InfoIcon.TYPE_INFO;
         this.postmortemModeDropDown.menuWidth = MENU_WIDTH;
         this.enableOpticalSnpEffectCheckbox.label = SETTINGS.GAME_ENABLEOPTICALSNPEFFECT;
         this.dynamicCameraCheckbox.label = SETTINGS.GAME_DYNAMICCAMERA;
         this.scrollSmoothingCheckbox.label = SETTINGS.AIM_SPG_SCROLLSMOOTHINGENABLED;
         this.horStabilizationSnpCheckbox.label = SETTINGS.GAME_HORSTABILIZATIONSNP;
         this.preCommanderCamCheckbox.label = SETTINGS.GAME_PRECOMMANDERCAMENABLED;
         this.commanderCamCheckbox.label = SETTINGS.GAME_COMMANDERCAMENABLED;
         this.hullLockEnabledCheckbox.label = SETTINGS.GAME_HULLLOCKENABLED;
         this.hullLockEnabledCheckbox.toolTip = TOOLTIPS.HULLLOCKENABLED;
         this.hullLockEnabledCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.sniperModeByShiftCheckbox.label = SETTINGS.GAME_SNIPERMODEBYSHIFT;
         this.increasedZoomCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.replayEnabledLabel.text = SETTINGS.GAME_REPLAYENABLED;
         this.sniperZoomLabel.text = SETTINGS.GAME_SNIPERZOOM;
         this.useServerAimCheckbox.label = SETTINGS.CURSOR_SERVERAIM;
         this.showVehiclesCounterCheckbox.label = SETTINGS.GAME_SHOWVEHICLESCOUNTER;
         this.showMarksOnGunCheckbox.label = SETTINGS.GAME_SHOWMARKSONGUN;
         this.showMarksOnGunCheckbox.toolTip = TOOLTIPS.SHOWMARKSONGUN;
         this.showMarksOnGunCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.anonymizerCheckbox.label = SETTINGS.GAME_ANONYMIZER;
         this.anonymizerCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.displayPlatoonMembersCheckbox.label = SETTINGS.GAME_DISPLAYPLATOONMEMBERS;
         this.displayPlatoonMembersCheckbox.toolTip = TOOLTIPS.DISPLAYPLATOONMEMBERS;
         this.displayPlatoonMembersCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.loginServerSelectionCheckbox.label = SETTINGS.GAME_LOGINSERVERSELECTION;
         this.loginServerSelectionCheckbox.toolTip = TOOLTIPS.LOGINSERVERSELECTION;
         this.loginServerSelectionCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.minimapAlphaEnabledCheckbox.label = SETTINGS.MINIMAP_LABELS_ALPHA;
         this.minimapAlphaEnabledCheckbox.toolTip = TOOLTIPS.MINIMAPALPHA;
         this.minimapAlphaEnabledCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.minimapAlphaEnabledCheckbox.addEventListener(Event.SELECT,this.onGuiGraphicsOptimizationCheckboxSelectHandler);
         this.minimapViewRangeCheckbox.label = SETTINGS.GAME_MINIMAPVIEWRANGE;
         this.minimapViewRangeCheckbox.toolTip = TOOLTIPS_CONSTANTS.SETTINGS_MINIMAP_CIRCLES;
         this.minimapViewRangeCheckbox.tooltipType = ToolTipShowType.SPECIAL;
         this.minimapViewRangeCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.minimapMaxViewRangeCheckbox.label = SETTINGS.GAME_MINIMAPMAXVIEWRANGE;
         this.minimapMaxViewRangeCheckbox.toolTip = TOOLTIPS_CONSTANTS.SETTINGS_MINIMAP_CIRCLES;
         this.minimapMaxViewRangeCheckbox.tooltipType = ToolTipShowType.SPECIAL;
         this.minimapMaxViewRangeCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.minimapMinSpottingRangeCheckbox.label = SETTINGS.GAME_MINIMAPMINSPOTTINGRANGE;
         this.minimapMinSpottingRangeCheckbox.toolTip = TOOLTIPS_CONSTANTS.SETTINGS_MINIMAP_CIRCLES;
         this.minimapMinSpottingRangeCheckbox.tooltipType = ToolTipShowType.SPECIAL;
         this.minimapMinSpottingRangeCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.minimapDrawRangeCheckbox.label = SETTINGS.GAME_MINIMAPDRAWRANGE;
         this.minimapDrawRangeCheckbox.tooltipType = ToolTipShowType.SPECIAL;
         this.minimapDrawRangeCheckbox.toolTip = TOOLTIPS_CONSTANTS.SETTINGS_MINIMAP_CIRCLES;
         this.minimapDrawRangeCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showVectorOnMapCheckbox.label = SETTINGS.GAME_SHOWVECTORONMAP;
         this.showVectorOnMapCheckbox.toolTip = TOOLTIPS.SHOWVECTORONMAP;
         this.showVectorOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showSectorOnMapCheckbox.label = SETTINGS.GAME_SHOWSECTORONMAP;
         this.showSectorOnMapCheckbox.toolTip = TOOLTIPS.SHOWSECTORONMAP;
         this.showSectorOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showVehModelsOnMapLabel.text = SETTINGS.GAME_SHOWVEHMODELSONMAP;
         this.showVehModelsOnMapLabel.toolTip = TOOLTIPS.SHOWVEHMODELSONMAP;
         this.showVehModelsOnMapLabel.infoIcoType = InfoIcon.TYPE_INFO;
         this.showArtyHitOnMapCheckbox.label = SETTINGS.GAME_SHOWARTYHITONMAP;
         this.showArtyHitOnMapCheckbox.toolTip = TOOLTIPS.SHOWARTYHITONMAP;
         this.showArtyHitOnMapCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showVehicleHPinPlayersPanelLabel.text = SETTINGS.GAME_SHOWVEHICLEHPINPLAYERSPANEL;
         this.showVehicleHPinMinimapLabel.text = SETTINGS.GAME_SHOWVEHICLEHPINMINIMAP;
         this.carouselTypeFieldSet.label = SETTINGS.GAME_CAROUSELTYPE;
         this.doubleCarouselLabel.text = SETTINGS.GAME_DOUBLECAROUSEL_LABEL;
         this.vehicleCarouselStatsCheckbox.label = SETTINGS.GAME_CAROUSELVEHICLE_CHECKBOX_STATS;
         this.hangarCamParallaxEnabledCheckbox.label = SETTINGS.GAME_HANGARCAMCHECKBOX;
         this.hangarCamParallaxEnabledCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.hangarCamParallaxEnabledCheckbox.toolTip = TOOLTIPS.HANGARCAMCHECKBOX;
         this.hangarCamLabelControl.text = SETTINGS.GAME_HANGARCAMDROPDOWNTITLE;
         this.hangarCamLabelControl.infoIcoType = InfoIcon.TYPE_INFO;
         this.hangarCamLabelControl.toolTip = TOOLTIPS.HANGARCAMDROPDOWN;
         this.showDamageIconCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.enableSpeedometerCheckbox.label = SETTINGS.GAME_ENABLESPEEDOMETER;
         this.enableRepairTimerCheckbox.label = SETTINGS.GAME_ENABLEREPAIRTIMER;
         this.enableBattleNotifierCheckbox.label = SETTINGS.GAME_ENABLEBATTLENOTIFIER;
         this.showDogTagToKillerCheckbox.label = SETTINGS.GAME_SHOWDOGTAGTOKILLER;
         this.showDogTagToKillerCheckbox.toolTip = TOOLTIPS.SHOWDOGTAG;
         this.showDogTagToKillerCheckbox.infoIcoType = InfoIcon.TYPE_INFO;
         this.showVictimsDogTagCheckbox.label = SETTINGS.GAME_SHOWVICTIMSDOGTAG;
         this.showKillersDogTagCheckbox.label = SETTINGS.GAME_SHOWKILLERSDOGTAG;
         this.customizationDisplayTypeButtonBar.setInfoButton(TOOLTIPS.CUSTOMIZATIONDISPLAYTYPE_HISTORICAL,0);
         this.customizationDisplayTypeButtonBar.setInfoButton(TOOLTIPS.CUSTOMIZATIONDISPLAYTYPE_NOTHISTORICAL,1);
         this.customizationDisplayTypeButtonBar.setInfoButton(TOOLTIPS.CUSTOMIZATIONDISPLAYTYPE_ALL,2);
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         this.fieldSetChat.dispose();
         this.fieldSetChat = null;
         this.fieldSetBattlePanel.dispose();
         this.fieldSetBattlePanel = null;
         this.fieldSetBattleTypes.dispose();
         this.fieldSetBattleTypes = null;
         this.fieldSetMinimap.dispose();
         this.fieldSetMinimap = null;
         this.fieldSetBattleCommunication.dispose();
         this.fieldSetBattleCommunication = null;
         this.customizationDisplayTypeFieldSet.dispose();
         this.customizationDisplayTypeFieldSet = null;
         this.enableOlFilterCheckbox.dispose();
         this.enableOlFilterCheckbox = null;
         this.enableSpamFilterCheckbox.dispose();
         this.enableSpamFilterCheckbox = null;
         this.showDateMessageCheckbox.dispose();
         this.showDateMessageCheckbox = null;
         this.showTimeMessageCheckbox.dispose();
         this.showTimeMessageCheckbox = null;
         this.invitesFromFriendsOnlyCheckbox.dispose();
         this.invitesFromFriendsOnlyCheckbox = null;
         this.receiveClanInvitesNotificationsCheckbox.dispose();
         this.receiveClanInvitesNotificationsCheckbox = null;
         this.receiveInvitesInBattleCheckbox.dispose();
         this.receiveInvitesInBattleCheckbox = null;
         this.receiveFriendshipRequestCheckbox.dispose();
         this.receiveFriendshipRequestCheckbox = null;
         this.chatContactsListOnlyCheckbox.dispose();
         this.chatContactsListOnlyCheckbox = null;
         this.disableBattleChatCheckbox.dispose();
         this.disableBattleChatCheckbox = null;
         this.ppShowLevelsCheckbox.dispose();
         this.ppShowLevelsCheckbox = null;
         this.showCommInPlayerlistCheckbox.dispose();
         this.showCommInPlayerlistCheckbox = null;
         this.showStickyMarkersCheckbox.dispose();
         this.showStickyMarkersCheckbox = null;
         this.showCalloutMessagesCheckbox.dispose();
         this.showCalloutMessagesCheckbox = null;
         this.showLocationMarkersCheckbox.dispose();
         this.showLocationMarkersCheckbox = null;
         this.showMarkersCheckbox.dispose();
         this.showMarkersCheckbox = null;
         this.gameplay_ctfCheckbox.dispose();
         this.gameplay_ctfCheckbox = null;
         this.gameplay_dominationCheckbox.dispose();
         this.gameplay_dominationCheckbox = null;
         this.gameplay_assaultCheckbox.dispose();
         this.gameplay_assaultCheckbox = null;
         this.gameplay_epicDominationCheckbox.dispose();
         this.gameplay_epicDominationCheckbox = null;
         this.gameplay_epicStandardCheckbox.dispose();
         this.gameplay_epicStandardCheckbox = null;
         this.gameplay_only10ModeCheckbox.dispose();
         this.gameplay_only10ModeCheckbox = null;
         this.gameplay_devMapsCheckbox.dispose();
         this.gameplay_devMapsCheckbox = null;
         this.newbiePrebattleHintsCheckbox.dispose();
         this.newbiePrebattleHintsCheckbox = null;
         this.newbieBattleHintsCheckbox.dispose();
         this.newbieBattleHintsCheckbox = null;
         this.restartNewbieBattleHints.dispose();
         this.restartNewbieBattleHints = null;
         this.battleLoadingInfoLabelControl.dispose();
         this.battleLoadingInfoLabelControl = null;
         this.battleLoadingInfoDropDown.dispose();
         this.battleLoadingInfoDropDown = null;
         this.switchEquipmentCheckbox.dispose();
         this.switchEquipmentCheckbox = null;
         this.minimapAlphaSlider.dispose();
         this.minimapAlphaSlider = null;
         this.enableOpticalSnpEffectCheckbox.dispose();
         this.enableOpticalSnpEffectCheckbox = null;
         this.postmortemModeLabelControl = null;
         this.postmortemModeDropDown.dispose();
         this.postmortemModeDropDown = null;
         this.dynamicCameraCheckbox.dispose();
         this.dynamicCameraCheckbox = null;
         this.scrollSmoothingCheckbox.dispose();
         this.scrollSmoothingCheckbox = null;
         this.preCommanderCamCheckbox.dispose();
         this.preCommanderCamCheckbox = null;
         this.commanderCamCheckbox.dispose();
         this.commanderCamCheckbox = null;
         this.horStabilizationSnpCheckbox.dispose();
         this.horStabilizationSnpCheckbox = null;
         this.hullLockEnabledCheckbox.dispose();
         this.hullLockEnabledCheckbox = null;
         this.increasedZoomCheckbox.dispose();
         this.increasedZoomCheckbox = null;
         this.sniperModeByShiftCheckbox.dispose();
         this.sniperModeByShiftCheckbox = null;
         this.replayEnabledLabel = null;
         this.sniperZoomLabel = null;
         this.replayEnabledDropDown.dispose();
         this.replayEnabledDropDown = null;
         this.sniperZoomDropDown.dispose();
         this.sniperZoomDropDown = null;
         this.useServerAimCheckbox.dispose();
         this.useServerAimCheckbox = null;
         this.showVehiclesCounterCheckbox.dispose();
         this.showVehiclesCounterCheckbox = null;
         this.showMarksOnGunCheckbox.dispose();
         this.showMarksOnGunCheckbox = null;
         this.anonymizerCheckbox.dispose();
         this.anonymizerCheckbox = null;
         this.showDogTagToKillerCheckbox.dispose();
         this.showDogTagToKillerCheckbox = null;
         this.showVictimsDogTagCheckbox.dispose();
         this.showVictimsDogTagCheckbox = null;
         this.showKillersDogTagCheckbox.dispose();
         this.showKillersDogTagCheckbox = null;
         this.displayPlatoonMembersCheckbox.dispose();
         this.displayPlatoonMembersCheckbox = null;
         this.loginServerSelectionCheckbox.dispose();
         this.loginServerSelectionCheckbox = null;
         this.showVectorOnMapCheckbox.dispose();
         this.showVectorOnMapCheckbox = null;
         this.showSectorOnMapCheckbox.dispose();
         this.showSectorOnMapCheckbox = null;
         this.showVehModelsOnMapLabel.dispose();
         this.showVehModelsOnMapLabel = null;
         this.showVehicleHPinPlayersPanelLabel.dispose();
         this.showVehicleHPinPlayersPanelLabel = null;
         this.showVehicleHPinMinimapLabel.dispose();
         this.showVehicleHPinMinimapLabel = null;
         this.showVehicleHPinMinimapDropDown.dispose();
         this.showVehicleHPinMinimapDropDown = null;
         this.showVehModelsOnMapDropDown.dispose();
         this.showVehModelsOnMapDropDown = null;
         this.showArtyHitOnMapCheckbox.dispose();
         this.showArtyHitOnMapCheckbox = null;
         this.showVehicleHPinPlayersPanelDropDown.dispose();
         this.showVehicleHPinPlayersPanelDropDown = null;
         this.minimapAlphaEnabledCheckbox.removeEventListener(Event.SELECT,this.onGuiGraphicsOptimizationCheckboxSelectHandler);
         this.minimapAlphaEnabledCheckbox.dispose();
         this.minimapAlphaEnabledCheckbox = null;
         this.minimapViewRangeCheckbox.dispose();
         this.minimapViewRangeCheckbox = null;
         this.minimapMaxViewRangeCheckbox.dispose();
         this.minimapMaxViewRangeCheckbox = null;
         this.minimapMinSpottingRangeCheckbox.dispose();
         this.minimapMinSpottingRangeCheckbox = null;
         this.minimapDrawRangeCheckbox.dispose();
         this.minimapDrawRangeCheckbox = null;
         this.carouselTypeFieldSet.dispose();
         this.carouselTypeFieldSet = null;
         this.carouselTypeButtonBar.dispose();
         this.carouselTypeButtonBar = null;
         this.customizationDisplayTypeButtonBar.dispose();
         this.customizationDisplayTypeButtonBar = null;
         this.doubleCarouselLabel = null;
         this.doubleCarouselTypeDropDown.dispose();
         this.doubleCarouselTypeDropDown = null;
         this.vehicleCarouselStatsCheckbox.dispose();
         this.vehicleCarouselStatsCheckbox = null;
         this.hangarCamFieldSet.dispose();
         this.hangarCamFieldSet = null;
         this.hangarCamLabelControl.dispose();
         this.hangarCamLabelControl = null;
         this.hangarCamParallaxEnabledCheckbox.dispose();
         this.hangarCamParallaxEnabledCheckbox = null;
         this.hangarCamPeriodDropDown.dispose();
         this.hangarCamPeriodDropDown = null;
         this.showDamageIconCheckbox.dispose();
         this.showDamageIconCheckbox = null;
         this.enableSpeedometerCheckbox.dispose();
         this.enableSpeedometerCheckbox = null;
         this.enableRepairTimerCheckbox.dispose();
         this.enableRepairTimerCheckbox = null;
         this.enableBattleNotifierCheckbox.dispose();
         this.enableBattleNotifierCheckbox = null;
         super.onDispose();
      }
      
      public function updateDependentVisibleControls(param1:Boolean, param2:Boolean, param3:Number) : void
      {
         var _loc4_:int = !!param1 ? int(Values.ZERO) : int(OFFSET_CB_DISABLED);
         _loc4_ += !!param2 ? Values.ZERO : OFFSET_CB_DISABLED;
         this.fieldSetBattleTypes.height = param3 + _loc4_;
         if(!param2)
         {
            this.gameplay_only10ModeCheckbox.y = this._initYGameplayOnly10ModeCheckbox + OFFSET_CB_DISABLED;
         }
         this.carouselTypeFieldSet.y = this._initYCarouselTypeFieldSet + _loc4_;
         this.carouselTypeButtonBar.y = this._initYCarouselTypeButtonBar + _loc4_;
         this.doubleCarouselLabel.y = this._initYDoubleCarouselLabel + _loc4_;
         this.doubleCarouselTypeDropDown.y = this._initYDoubleCarouselTypeDropDown + _loc4_;
         this.vehicleCarouselStatsCheckbox.y = this._initYVehicleCarouselStatsCheckbox + _loc4_;
         this.customizationDisplayTypeFieldSet.y = this._initYCustomizationDisplayTypeFieldSet + _loc4_;
         this.customizationDisplayTypeButtonBar.y = this._initYCustomizationDisplayTypeButtonBar + _loc4_;
         this.replayEnabledLabel.y = this._initYReplayEnabledLabel + _loc4_;
         this.replayEnabledDropDown.y = this._initYReplayEnabledDropDown + _loc4_;
         this.showMarksOnGunCheckbox.y = this._initYShowMarksOnGunCheckbox + _loc4_;
         this.displayPlatoonMembersCheckbox.y = this._initYDisplayPlatoonMembersCheckbox + _loc4_;
         this.loginServerSelectionCheckbox.y = this._initYLoginServerSelectionCheckbox + _loc4_;
         this.anonymizerCheckbox.y = this._initYAnonymizerCheckbox + _loc4_;
      }
      
      private function setDependentVisibleControlsY() : void
      {
         this._initYGameplayOnly10ModeCheckbox = this.gameplay_only10ModeCheckbox.y;
         this._initYCarouselTypeFieldSet = this.carouselTypeFieldSet.y;
         this._initYCarouselTypeButtonBar = this.carouselTypeButtonBar.y;
         this._initYDoubleCarouselLabel = this.doubleCarouselLabel.y;
         this._initYDoubleCarouselTypeDropDown = this.doubleCarouselTypeDropDown.y;
         this._initYVehicleCarouselStatsCheckbox = this.vehicleCarouselStatsCheckbox.y;
         this._initYCustomizationDisplayTypeFieldSet = this.customizationDisplayTypeFieldSet.y;
         this._initYCustomizationDisplayTypeButtonBar = this.customizationDisplayTypeButtonBar.y;
         this._initYReplayEnabledLabel = this.replayEnabledLabel.y;
         this._initYReplayEnabledDropDown = this.replayEnabledDropDown.y;
         this._initYShowMarksOnGunCheckbox = this.showMarksOnGunCheckbox.y;
         this._initYDisplayPlatoonMembersCheckbox = this.displayPlatoonMembersCheckbox.y;
         this._initYLoginServerSelectionCheckbox = this.loginServerSelectionCheckbox.y;
         this._initYAnonymizerCheckbox = this.anonymizerCheckbox.y;
      }
      
      private function onGuiGraphicsOptimizationCheckboxSelectHandler(param1:Event) : void
      {
         this.minimapAlphaSlider.enabled = this.minimapAlphaEnabledCheckbox.selected;
      }
   }
}
