package net.wg.infrastructure.base.meta.impl
{
   import net.wg.gui.components.crosshairPanel.CrosshairArcade;
   import net.wg.gui.components.crosshairPanel.CrosshairBase;
   import net.wg.gui.components.crosshairPanel.CrosshairDistanceContainer;
   import net.wg.gui.components.crosshairPanel.CrosshairDistanceField;
   import net.wg.gui.components.crosshairPanel.CrosshairPanelContainer;
   import net.wg.gui.components.crosshairPanel.CrosshairPanelEvent;
   import net.wg.gui.components.crosshairPanel.CrosshairPanelSniperCameraTransitionFx;
   import net.wg.gui.components.crosshairPanel.CrosshairPostmortem;
   import net.wg.gui.components.crosshairPanel.CrosshairSniper;
   import net.wg.gui.components.crosshairPanel.CrosshairStrategic;
   import net.wg.gui.components.crosshairPanel.CrosshairWithCassette;
   import net.wg.gui.components.crosshairPanel.GunMarkersManager;
   import net.wg.gui.components.crosshairPanel.ICrosshair;
   import net.wg.gui.components.crosshairPanel.ICrosshairPanelContainer;
   import net.wg.gui.components.crosshairPanel.VO.CrosshairSettingsVO;
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.VO.ShotFlyTimeVO;
   import net.wg.gui.components.crosshairPanel.WTCrosshairBase;
   import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBar;
   import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBarContainer;
   import net.wg.gui.components.crosshairPanel.components.OverheatBar;
   import net.wg.gui.components.crosshairPanel.components.artyScale.ArtyIndicationScale;
   import net.wg.gui.components.crosshairPanel.components.artyShot.ArtyShotIndicator;
   import net.wg.gui.components.crosshairPanel.components.artyShot.ArtyShotIndicatorText;
   import net.wg.gui.components.crosshairPanel.components.artyShot.ArtyShotIndicatorsPanel;
   import net.wg.gui.components.crosshairPanel.components.autoloader.AutoloaderIndicator;
   import net.wg.gui.components.crosshairPanel.components.autoloader.AutoloaderShellsCassette;
   import net.wg.gui.components.crosshairPanel.components.autoloader.AutoloaderTimer;
   import net.wg.gui.components.crosshairPanel.components.autoloader.AutoloaderTimerText;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicator;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicatorElement;
   import net.wg.gui.components.crosshairPanel.components.autoloader.BoostIndicatorStateParamsVO;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.DualGunMarker;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.DualGunMarkerDebug;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarker;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerArtillery;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerDebug;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerDebugStrategic;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerDispersionCircle;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerMixing;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerMixingDualGun;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerMixingDualGunSniper;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerMixingSolid;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerMixingStepPoints;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerMixingWithoutProgress;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerStrategic;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.GunMarkerTag;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarkerMixing;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.constants.GunMarkerConsts;
   import net.wg.gui.components.crosshairPanel.components.speedometer.Speedometer;
   import net.wg.gui.components.crosshairPanel.components.speedometer.SpeedometerWarningAnim;
   import net.wg.gui.components.crosshairPanel.components.wt.PlasmaDamageTF;
   import net.wg.gui.components.crosshairPanel.components.wt.PlasmaIndicator;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   
   public class ClassManagerBattleCrosshairsMeta
   {
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRARCADE:Class = CrosshairArcade;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRBASE:Class = CrosshairBase;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRDISTANCECONTAINER:Class = CrosshairDistanceContainer;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRDISTANCEFIELD:Class = CrosshairDistanceField;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRPANELCONTAINER:Class = CrosshairPanelContainer;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRPANELEVENT:Class = CrosshairPanelEvent;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRPANELSNIPERCAMERATRANSITIONFX:Class = CrosshairPanelSniperCameraTransitionFx;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRPOSTMORTEM:Class = CrosshairPostmortem;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRSNIPER:Class = CrosshairSniper;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRSTRATEGIC:Class = CrosshairStrategic;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CROSSHAIRWITHCASSETTE:Class = CrosshairWithCassette;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_GUNMARKERSMANAGER:Class = GunMarkersManager;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_ICROSSHAIR:Class = ICrosshair;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_ICROSSHAIRPANELCONTAINER:Class = ICrosshairPanelContainer;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_WTCROSSHAIRBASE:Class = WTCrosshairBase;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_CROSSHAIRCLIPQUANTITYBAR:Class = CrosshairClipQuantityBar;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_CROSSHAIRCLIPQUANTITYBARCONTAINER:Class = CrosshairClipQuantityBarContainer;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_OVERHEATBAR:Class = OverheatBar;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_ARTYSCALE_ARTYINDICATIONSCALE:Class = ArtyIndicationScale;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_ARTYSHOT_ARTYSHOTINDICATOR:Class = ArtyShotIndicator;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_ARTYSHOT_ARTYSHOTINDICATORSPANEL:Class = ArtyShotIndicatorsPanel;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_ARTYSHOT_ARTYSHOTINDICATORTEXT:Class = ArtyShotIndicatorText;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_AUTOLOADERINDICATOR:Class = AutoloaderIndicator;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_AUTOLOADERSHELLSCASSETTE:Class = AutoloaderShellsCassette;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_AUTOLOADERTIMER:Class = AutoloaderTimer;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_AUTOLOADERTIMERTEXT:Class = AutoloaderTimerText;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_BOOSTINDICATOR:Class = BoostIndicator;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_BOOSTINDICATORELEMENT:Class = BoostIndicatorElement;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_AUTOLOADER_BOOSTINDICATORSTATEPARAMSVO:Class = BoostIndicatorStateParamsVO;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_DUALGUNMARKER:Class = DualGunMarker;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_DUALGUNMARKERDEBUG:Class = DualGunMarkerDebug;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKER:Class = GunMarker;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERARTILLERY:Class = GunMarkerArtillery;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERDEBUG:Class = GunMarkerDebug;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERDEBUGSTRATEGIC:Class = GunMarkerDebugStrategic;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERDISPERSIONCIRCLE:Class = GunMarkerDispersionCircle;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERMIXING:Class = GunMarkerMixing;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERMIXINGDUALGUN:Class = GunMarkerMixingDualGun;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERMIXINGDUALGUNSNIPER:Class = GunMarkerMixingDualGunSniper;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERMIXINGSOLID:Class = GunMarkerMixingSolid;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERMIXINGSTEPPOINTS:Class = GunMarkerMixingStepPoints;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERMIXINGWITHOUTPROGRESS:Class = GunMarkerMixingWithoutProgress;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERSTRATEGIC:Class = GunMarkerStrategic;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_GUNMARKERTAG:Class = GunMarkerTag;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_IGUNMARKER:Class = IGunMarker;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_IGUNMARKERMIXING:Class = IGunMarkerMixing;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_GUNMARKER_CONSTANTS_GUNMARKERCONSTS:Class = GunMarkerConsts;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_SPEEDOMETER_SPEEDOMETER:Class = Speedometer;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_SPEEDOMETER_SPEEDOMETERWARNINGANIM:Class = SpeedometerWarningAnim;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_WT_PLASMADAMAGETF:Class = PlasmaDamageTF;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_COMPONENTS_WT_PLASMAINDICATOR:Class = PlasmaIndicator;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_CONSTANTS_CROSSHAIRCONSTS:Class = CrosshairConsts;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_VO_CROSSHAIRSETTINGSVO:Class = CrosshairSettingsVO;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_VO_GUNMARKERINDICATORVO:Class = GunMarkerIndicatorVO;
      
      public static const NET_WG_GUI_COMPONENTS_CROSSHAIRPANEL_VO_SHOTFLYTIMEVO:Class = ShotFlyTimeVO;
       
      
      public function ClassManagerBattleCrosshairsMeta()
      {
         super();
      }
   }
}
