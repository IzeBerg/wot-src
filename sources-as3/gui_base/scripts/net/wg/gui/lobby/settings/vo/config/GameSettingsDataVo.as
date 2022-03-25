package net.wg.gui.lobby.settings.vo.config
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class GameSettingsDataVo extends SettingsDataVo
   {
       
      
      public var enableOlFilter:SettingsControlProp = null;
      
      public var enableSpamFilter:SettingsControlProp = null;
      
      public var showDateMessage:SettingsControlProp = null;
      
      public var showTimeMessage:SettingsControlProp = null;
      
      public var invitesFromFriendsOnly:SettingsControlProp = null;
      
      public var receiveFriendshipRequest:SettingsControlProp = null;
      
      public var receiveInvitesInBattle:SettingsControlProp = null;
      
      public var chatContactsListOnly:SettingsControlProp = null;
      
      public var dynamicCamera:SettingsControlProp = null;
      
      public var scrollSmoothing:SettingsControlProp = null;
      
      public var preCommanderCam:SettingsControlProp = null;
      
      public var commanderCam:SettingsControlProp = null;
      
      public var horStabilizationSnp:SettingsControlProp = null;
      
      public var hullLockEnabled:SettingsControlProp = null;
      
      public var disableBattleChat:SettingsControlProp = null;
      
      public var ppShowLevels:SettingsControlProp = null;
      
      public var gameplay_ctf:SettingsControlProp = null;
      
      public var gameplay_domination:SettingsControlProp = null;
      
      public var gameplay_assault:SettingsControlProp = null;
      
      public var gameplay_epicStandard:SettingsControlProp = null;
      
      public var gameplay_only10Mode:SettingsControlProp = null;
      
      public var gameplay_epicDomination:SettingsControlProp = null;
      
      public var minimapAlpha:SettingsControlProp = null;
      
      public var enablePostMortemDelay:SettingsControlProp = null;
      
      public var enableOpticalSnpEffect:SettingsControlProp = null;
      
      public var replayEnabled:SettingsControlProp = null;
      
      public var sniperZoom:SettingsControlProp = null;
      
      public var hangarCamPeriod:SettingsControlProp = null;
      
      public var hangarCamParallaxEnabled:SettingsControlProp = null;
      
      public var useServerAim:SettingsControlProp = null;
      
      public var showVehiclesCounter:SettingsControlProp = null;
      
      public var showMarksOnGun:SettingsControlProp = null;
      
      public var anonymizer:SettingsControlProp = null;
      
      public var showVictimsDogTag:SettingsControlProp = null;
      
      public var showDogTagToKiller:SettingsControlProp = null;
      
      public var displayPlatoonMembers:SettingsControlProp = null;
      
      public var loginServerSelection:SettingsControlProp = null;
      
      public var showVehicleHPinMinimap:SettingsControlProp = null;
      
      public var showVehModelsOnMap:SettingsControlProp = null;
      
      public var showVehicleHPinPlayersPanel:SettingsControlProp = null;
      
      public var minimapViewRange:SettingsControlProp = null;
      
      public var minimapMaxViewRange:SettingsControlProp = null;
      
      public var minimapMinSpottingRange:SettingsControlProp = null;
      
      public var increasedZoom:SettingsControlProp = null;
      
      public var sniperModeByShift:SettingsControlProp = null;
      
      public var minimapDrawRange:SettingsControlProp = null;
      
      public var showVectorOnMap:SettingsControlProp = null;
      
      public var showSectorOnMap:SettingsControlProp = null;
      
      public var showArtyHitOnMap:SettingsControlProp = null;
      
      public var showDamageIcon:SettingsControlProp = null;
      
      public var enableSpeedometer:SettingsControlProp = null;
      
      public var enableRepairTimer:SettingsControlProp = null;
      
      public var enableBattleNotifier:SettingsControlProp = null;
      
      public var battleLoadingInfo:SettingsControlProp = null;
      
      public var battleLoadingRankedInfo:SettingsControlProp = null;
      
      public var receiveClanInvitesNotifications:SettingsControlProp = null;
      
      public var customizationDisplayType:SettingsControlProp = null;
      
      public var carouselType:SettingsControlProp = null;
      
      public var doubleCarouselType:SettingsControlProp = null;
      
      public var vehicleCarouselStats:SettingsControlProp = null;
      
      public var minimapAlphaEnabled:SettingsControlProp = null;
      
      public var showCommInPlayerlist:SettingsControlProp = null;
      
      public var showStickyMarkers:SettingsControlProp = null;
      
      public var showCalloutMessages:SettingsControlProp = null;
      
      public var showLocationMarkers:SettingsControlProp = null;
      
      public var showMarkers:SettingsControlProp = null;
      
      public var switchEquipment:SettingsControlProp = null;
      
      public function GameSettingsDataVo()
      {
         super({
            "enableOlFilter":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableSpamFilter":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showDateMessage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showTimeMessage":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "invitesFromFriendsOnly":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "receiveFriendshipRequest":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "receiveInvitesInBattle":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "chatContactsListOnly":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "dynamicCamera":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "scrollSmoothing":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "preCommanderCam":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "commanderCam":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "horStabilizationSnp":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "hullLockEnabled":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "disableBattleChat":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "receiveClanInvitesNotifications":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "sniperModeByShift":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "increasedZoom":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "ppShowLevels":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_ctf":createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
            "gameplay_domination":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_assault":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_epicStandard":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_only10Mode":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "gameplay_epicDomination":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapAlpha":createControl(ControlsFactory.TYPE_SLIDER).build(),
            "enablePostMortemDelay":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableOpticalSnpEffect":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapAlphaEnabled":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "hangarCamPeriod":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "hangarCamParallaxEnabled":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "replayEnabled":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "sniperZoom":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "useServerAim":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showVehiclesCounter":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "displayPlatoonMembers":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "loginServerSelection":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showMarksOnGun":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "anonymizer":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showVictimsDogTag":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showDogTagToKiller":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapViewRange":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapMaxViewRange":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapDrawRange":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "minimapMinSpottingRange":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showVehModelsOnMap":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "showVehicleHPinPlayersPanel":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "showVehicleHPinMinimap":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "showVectorOnMap":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showSectorOnMap":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showArtyHitOnMap":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showDamageIcon":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableSpeedometer":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableRepairTimer":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "enableBattleNotifier":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "battleLoadingInfo":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "battleLoadingRankedInfo":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "carouselType":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "doubleCarouselType":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "customizationDisplayType":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "vehicleCarouselStats":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showCommInPlayerlist":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showStickyMarkers":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showCalloutMessages":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showLocationMarkers":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "showMarkers":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "switchEquipment":createControl(ControlsFactory.TYPE_CHECKBOX).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.enableOlFilter.dispose();
         this.enableOlFilter = null;
         this.enableSpamFilter.dispose();
         this.enableSpamFilter = null;
         this.showDateMessage.dispose();
         this.showDateMessage = null;
         this.showTimeMessage.dispose();
         this.showTimeMessage = null;
         this.invitesFromFriendsOnly.dispose();
         this.invitesFromFriendsOnly = null;
         this.receiveFriendshipRequest.dispose();
         this.receiveFriendshipRequest = null;
         this.receiveInvitesInBattle.dispose();
         this.receiveInvitesInBattle = null;
         this.chatContactsListOnly.dispose();
         this.chatContactsListOnly = null;
         this.dynamicCamera.dispose();
         this.dynamicCamera = null;
         this.scrollSmoothing.dispose();
         this.scrollSmoothing = null;
         this.preCommanderCam.dispose();
         this.preCommanderCam = null;
         this.commanderCam.dispose();
         this.commanderCam = null;
         this.horStabilizationSnp.dispose();
         this.horStabilizationSnp = null;
         this.hullLockEnabled.dispose();
         this.hullLockEnabled = null;
         this.disableBattleChat.dispose();
         this.disableBattleChat = null;
         this.ppShowLevels.dispose();
         this.ppShowLevels = null;
         this.gameplay_ctf.dispose();
         this.gameplay_ctf = null;
         this.gameplay_domination.dispose();
         this.gameplay_domination = null;
         this.gameplay_assault.dispose();
         this.gameplay_assault = null;
         this.gameplay_epicStandard.dispose();
         this.gameplay_epicStandard = null;
         this.gameplay_only10Mode.dispose();
         this.gameplay_only10Mode = null;
         this.gameplay_epicDomination.dispose();
         this.gameplay_epicDomination = null;
         this.minimapAlpha.dispose();
         this.minimapAlpha = null;
         this.enablePostMortemDelay.dispose();
         this.enablePostMortemDelay = null;
         this.enableOpticalSnpEffect.dispose();
         this.enableOpticalSnpEffect = null;
         this.replayEnabled.dispose();
         this.replayEnabled = null;
         this.sniperZoom.dispose();
         this.sniperZoom = null;
         this.hangarCamPeriod.dispose();
         this.hangarCamPeriod = null;
         this.hangarCamParallaxEnabled.dispose();
         this.hangarCamParallaxEnabled = null;
         this.useServerAim.dispose();
         this.useServerAim = null;
         this.showVehiclesCounter.dispose();
         this.showVehiclesCounter = null;
         this.showMarksOnGun.dispose();
         this.showMarksOnGun = null;
         this.anonymizer.dispose();
         this.anonymizer = null;
         this.showVictimsDogTag.dispose();
         this.showVictimsDogTag = null;
         this.showDogTagToKiller.dispose();
         this.showDogTagToKiller = null;
         this.loginServerSelection.dispose();
         this.loginServerSelection = null;
         this.displayPlatoonMembers.dispose();
         this.displayPlatoonMembers = null;
         this.showVehModelsOnMap.dispose();
         this.showVehModelsOnMap = null;
         this.showVehicleHPinPlayersPanel.dispose();
         this.showVehicleHPinPlayersPanel = null;
         this.showVectorOnMap.dispose();
         this.showVectorOnMap = null;
         this.showSectorOnMap.dispose();
         this.showSectorOnMap = null;
         this.showArtyHitOnMap.dispose();
         this.showArtyHitOnMap = null;
         this.showDamageIcon.dispose();
         this.showDamageIcon = null;
         this.enableSpeedometer.dispose();
         this.enableSpeedometer = null;
         this.enableRepairTimer.dispose();
         this.enableRepairTimer = null;
         this.enableBattleNotifier.dispose();
         this.enableBattleNotifier = null;
         this.minimapViewRange.dispose();
         this.minimapViewRange = null;
         this.minimapMaxViewRange.dispose();
         this.minimapMaxViewRange = null;
         this.minimapDrawRange.dispose();
         this.minimapDrawRange = null;
         this.minimapMinSpottingRange.dispose();
         this.minimapMinSpottingRange = null;
         this.increasedZoom.dispose();
         this.increasedZoom = null;
         this.sniperModeByShift.dispose();
         this.sniperModeByShift = null;
         this.battleLoadingInfo.dispose();
         this.battleLoadingInfo = null;
         this.battleLoadingRankedInfo.dispose();
         this.battleLoadingRankedInfo = null;
         this.receiveClanInvitesNotifications.dispose();
         this.receiveClanInvitesNotifications = null;
         this.carouselType.dispose();
         this.carouselType = null;
         this.customizationDisplayType.dispose();
         this.customizationDisplayType = null;
         this.doubleCarouselType.dispose();
         this.doubleCarouselType = null;
         this.vehicleCarouselStats.dispose();
         this.vehicleCarouselStats = null;
         this.minimapAlphaEnabled.dispose();
         this.minimapAlphaEnabled = null;
         this.showCommInPlayerlist.dispose();
         this.showCommInPlayerlist = null;
         this.showStickyMarkers.dispose();
         this.showStickyMarkers = null;
         this.showCalloutMessages.dispose();
         this.showCalloutMessages = null;
         this.showLocationMarkers.dispose();
         this.showLocationMarkers = null;
         this.showMarkers.dispose();
         this.showMarkers = null;
         this.showVehicleHPinMinimap.dispose();
         this.showVehicleHPinMinimap = null;
         this.switchEquipment.dispose();
         this.switchEquipment = null;
         super.onDispose();
      }
   }
}
