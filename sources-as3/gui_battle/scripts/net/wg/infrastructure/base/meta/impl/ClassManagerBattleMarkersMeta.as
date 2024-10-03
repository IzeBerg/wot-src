package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.battle.views.staticMarkers.epic.ObjectiveIdReplyState;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterActionMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterAnimation;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterLifeStates;
   import net.wg.gui.battle.views.staticMarkers.epic.headquarter.HeadquarterMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint.ResupplyIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.resupplyPoint.ResupplyMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorWarning.SectorWarningMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorWaypoint.SectorWaypointMarker;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseActions;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseIcon;
   import net.wg.gui.battle.views.staticMarkers.epic.sectorbase.SectorBaseMarker;
   import net.wg.gui.battle.views.staticMarkers.flag.FlagIcon;
   import net.wg.gui.battle.views.staticMarkers.flag.FlagMarker;
   import net.wg.gui.battle.views.staticMarkers.flag.constant.FlagMarkerState;
   import net.wg.gui.battle.views.staticMarkers.interestPoint.InterestPointMarker;
   import net.wg.gui.battle.views.staticMarkers.interestPoint.MarkerPoiProgressCircle;
   import net.wg.gui.battle.views.staticMarkers.location.FlagLocationActionMarker;
   import net.wg.gui.battle.views.staticMarkers.location.LocationActionMarker;
   import net.wg.gui.battle.views.staticMarkers.location.LocationMarker;
   import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointIcon;
   import net.wg.gui.battle.views.staticMarkers.repairPoint.RepairPointMarker;
   import net.wg.gui.battle.views.staticMarkers.safeZone.SafeZoneMarker;
   import net.wg.gui.battle.views.staticMarkers.scenario.ScenarioMarker;
   import net.wg.gui.battle.views.staticMarkers.scenario.ScenarioMarkerProgressCircle;
   import net.wg.gui.battle.views.vehicleMarkers.ActionIconStateMarker;
   import net.wg.gui.battle.views.vehicleMarkers.AnimateExplosion;
   import net.wg.gui.battle.views.vehicleMarkers.BranderVehicle2dMarker;
   import net.wg.gui.battle.views.vehicleMarkers.Comp7VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.DamageLabel;
   import net.wg.gui.battle.views.vehicleMarkers.FlagContainer;
   import net.wg.gui.battle.views.vehicleMarkers.FortConsumablesMarker;
   import net.wg.gui.battle.views.vehicleMarkers.HPFieldContainer;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBar;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedLabel;
   import net.wg.gui.battle.views.vehicleMarkers.HealthBarAnimatedPart;
   import net.wg.gui.battle.views.vehicleMarkers.IMarkerManagerHandler;
   import net.wg.gui.battle.views.vehicleMarkers.IVehicleMarkerInvokable;
   import net.wg.gui.battle.views.vehicleMarkers.IVehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.StaticArtyMarker;
   import net.wg.gui.battle.views.vehicleMarkers.StaticObjectMarker;
   import net.wg.gui.battle.views.vehicleMarkers.TargetMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   import net.wg.gui.battle.views.vehicleMarkers.VO.CrossOffset;
   import net.wg.gui.battle.views.vehicleMarkers.VO.HPDisplayMode;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerFlags;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerPart;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerSettings;
   import net.wg.gui.battle.views.vehicleMarkers.VO.VehicleMarkerVO;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleActionMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleDistance;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleIconAnimation;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersLinkages;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleStatusContainerMarker;
   import net.wg.gui.battle.views.vehicleMarkers.events.StatusAnimationEvent;
   import net.wg.gui.battle.views.vehicleMarkers.events.TimelineEvent;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.MarkerAssetContainer;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.MarkerTimer;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleAnimatedStatusBaseMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleBerserkerMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleEngineerEffectMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleFLBasicMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleInspireTargetMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleSpecialAbilityMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStatusIconMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStatusMarker;
   import net.wg.gui.battle.views.vehicleMarkers.statusMarkers.VehicleStunMarker;
   
   public class ClassManagerBattleMarkersMeta
   {
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_OBJECTIVEIDREPLYSTATE:Class = ObjectiveIdReplyState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERACTIONMARKER:Class = HeadquarterActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERANIMATION:Class = HeadquarterAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERICON:Class = HeadquarterIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERLIFESTATES:Class = HeadquarterLifeStates;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_HEADQUARTER_HEADQUARTERMARKER:Class = HeadquarterMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_RESUPPLYPOINT_RESUPPLYICON:Class = ResupplyIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_RESUPPLYPOINT_RESUPPLYMARKER:Class = ResupplyMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEACTIONS:Class = SectorBaseActions;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEICON:Class = SectorBaseIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORBASE_SECTORBASEMARKER:Class = SectorBaseMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWARNING_SECTORWARNINGMARKER:Class = SectorWarningMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWAYPOINT_SECTORWAYPOINTICON:Class = SectorWaypointIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_EPIC_SECTORWAYPOINT_SECTORWAYPOINTMARKER:Class = SectorWaypointMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGICON:Class = FlagIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_FLAGMARKER:Class = FlagMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_FLAG_CONSTANT_FLAGMARKERSTATE:Class = FlagMarkerState;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_INTERESTPOINT_INTERESTPOINTMARKER:Class = InterestPointMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_INTERESTPOINT_MARKERPOIPROGRESSCIRCLE:Class = MarkerPoiProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_LOCATION_FLAGLOCATIONACTIONMARKER:Class = FlagLocationActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_LOCATION_LOCATIONACTIONMARKER:Class = LocationActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_LOCATION_LOCATIONMARKER:Class = LocationMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTICON:Class = RepairPointIcon;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_REPAIRPOINT_REPAIRPOINTMARKER:Class = RepairPointMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SAFEZONE_SAFEZONEMARKER:Class = SafeZoneMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SCENARIO_SCENARIOMARKER:Class = ScenarioMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_STATICMARKERS_SCENARIO_SCENARIOMARKERPROGRESSCIRCLE:Class = ScenarioMarkerProgressCircle;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_ACTIONICONSTATEMARKER:Class = ActionIconStateMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_ANIMATEEXPLOSION:Class = AnimateExplosion;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_BRANDERVEHICLE2DMARKER:Class = BranderVehicle2dMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_COMP7VEHICLEMARKER:Class = Comp7VehicleMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_DAMAGELABEL:Class = DamageLabel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FLAGCONTAINER:Class = FlagContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_FORTCONSUMABLESMARKER:Class = FortConsumablesMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBAR:Class = HealthBar;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDLABEL:Class = HealthBarAnimatedLabel;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HEALTHBARANIMATEDPART:Class = HealthBarAnimatedPart;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_HPFIELDCONTAINER:Class = HPFieldContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IMARKERMANAGERHANDLER:Class = IMarkerManagerHandler;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IVEHICLEMARKERINVOKABLE:Class = IVehicleMarkerInvokable;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_IVEHICLEMARKERSMANAGER:Class = IVehicleMarkersManager;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICARTYMARKER:Class = StaticArtyMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATICOBJECTMARKER:Class = StaticObjectMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_TARGETMARKER:Class = TargetMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEACTIONMARKER:Class = VehicleActionMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEDISTANCE:Class = VehicleDistance;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEICONANIMATION:Class = VehicleIconAnimation;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKER:Class = VehicleMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSCONSTANTS:Class = VehicleMarkersConstants;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSLINKAGES:Class = VehicleMarkersLinkages;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLEMARKERSMANAGER:Class = VehicleMarkersManager;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VEHICLESTATUSCONTAINERMARKER:Class = VehicleStatusContainerMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VMATLASITEMNAME:Class = VMAtlasItemName;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_STATUSANIMATIONEVENT:Class = StatusAnimationEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_TIMELINEEVENT:Class = TimelineEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_EVENTS_VEHICLEMARKERSMANAGEREVENT:Class = VehicleMarkersManagerEvent;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_MARKERASSETCONTAINER:Class = MarkerAssetContainer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_MARKERTIMER:Class = MarkerTimer;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEANIMATEDSTATUSBASEMARKER:Class = VehicleAnimatedStatusBaseMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEBERSERKERMARKER:Class = VehicleBerserkerMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEENGINEEREFFECTMARKER:Class = VehicleEngineerEffectMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEFLBASICMARKER:Class = VehicleFLBasicMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEINSPIREMARKER:Class = VehicleInspireMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLEINSPIRETARGETMARKER:Class = VehicleInspireTargetMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESPECIALABILITYMARKER:Class = VehicleSpecialAbilityMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTATUSICONMARKER:Class = VehicleStatusIconMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTATUSMARKER:Class = VehicleStatusMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_STATUSMARKERS_VEHICLESTUNMARKER:Class = VehicleStunMarker;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_CROSSOFFSET:Class = CrossOffset;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_HPDISPLAYMODE:Class = HPDisplayMode;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERFLAGS:Class = VehicleMarkerFlags;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERPART:Class = VehicleMarkerPart;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERSETTINGS:Class = VehicleMarkerSettings;
      
      public static const NET_WG_GUI_BATTLE_VIEWS_VEHICLEMARKERS_VO_VEHICLEMARKERVO:Class = VehicleMarkerVO;
       
      
      public function ClassManagerBattleMarkersMeta()
      {
         super();
      }
   }
}
