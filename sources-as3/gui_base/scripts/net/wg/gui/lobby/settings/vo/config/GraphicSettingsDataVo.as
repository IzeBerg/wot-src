package net.wg.gui.lobby.settings.vo.config
{
   import net.wg.gui.lobby.settings.config.ControlsFactory;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.vo.SettingsControlProp;
   import net.wg.gui.lobby.settings.vo.base.SettingsDataVo;
   
   public class GraphicSettingsDataVo extends SettingsDataVo
   {
       
      
      public var monitor:SettingsControlProp = null;
      
      public var CUSTOM_AA_MODE:SettingsControlProp = null;
      
      public var MSAA_QUALITY:SettingsControlProp = null;
      
      public var gammaSetting:SettingsControlProp = null;
      
      public var sizes:SettingsControlProp = null;
      
      public var windowSize:SettingsControlProp = null;
      
      public var resolution:SettingsControlProp = null;
      
      public var borderlessSize:SettingsControlProp = null;
      
      public var refreshRate:SettingsControlProp = null;
      
      public var interfaceScale:SettingsControlProp = null;
      
      public var dynamicRenderer:SettingsControlProp = null;
      
      public var fov:SettingsControlProp = null;
      
      public var dynamicFov:SettingsControlProp = null;
      
      public var HAVOK_ENABLED:SettingsControlProp = null;
      
      public var colorFilter:SettingsControlProp = null;
      
      public var screenMode:SettingsControlProp = null;
      
      public var vertSync:SettingsControlProp = null;
      
      public var tripleBuffered:SettingsControlProp = null;
      
      public var igbHardwareAcceleration:SettingsControlProp = null;
      
      public var isColorBlind:SettingsControlProp = null;
      
      public var graphicsQuality:SettingsControlProp = null;
      
      public var graphicsQualityHDSD:SettingsControlProp = null;
      
      public var graphicsQualityHDSDHigh:SettingsControlProp = null;
      
      public var RENDER_PIPELINE:SettingsControlProp = null;
      
      public var TEXTURE_QUALITY:SettingsControlProp = null;
      
      public var SHADOWS_QUALITY:SettingsControlProp = null;
      
      public var TERRAIN_QUALITY:SettingsControlProp = null;
      
      public var WATER_QUALITY:SettingsControlProp = null;
      
      public var LIGHTING_QUALITY:SettingsControlProp = null;
      
      public var SPEEDTREE_QUALITY:SettingsControlProp = null;
      
      public var FLORA_QUALITY:SettingsControlProp = null;
      
      public var EFFECTS_QUALITY:SettingsControlProp = null;
      
      public var POST_PROCESSING_QUALITY:SettingsControlProp = null;
      
      public var MOTION_BLUR_QUALITY:SettingsControlProp = null;
      
      public var FAR_PLANE:SettingsControlProp = null;
      
      public var OBJECT_LOD:SettingsControlProp = null;
      
      public var SNIPER_MODE_EFFECTS_QUALITY:SettingsControlProp = null;
      
      public var SNIPER_MODE_GRASS_ENABLED:SettingsControlProp = null;
      
      public var VEHICLE_DUST_ENABLED:SettingsControlProp = null;
      
      public var VEHICLE_TRACES_ENABLED:SettingsControlProp = null;
      
      public var DRR_AUTOSCALER_ENABLED:SettingsControlProp = null;
      
      public var SEMITRANSPARENT_LEAVES_ENABLED:SettingsControlProp = null;
      
      public var TERRAIN_TESSELLATION_ENABLED:SettingsControlProp = null;
      
      public var SNIPER_MODE_TERRAIN_TESSELLATION_ENABLED:SettingsControlProp = null;
      
      public var tessellationSupported:SettingsControlProp = null;
      
      public var isSDQuality:SettingsControlProp = null;
      
      public var nativeResolution:SettingsControlProp = null;
      
      public var presets:SettingsDataVo = null;
      
      public var qualityOrder:Vector.<String> = null;
      
      public var colorFilterImages:Object = null;
      
      public function GraphicSettingsDataVo()
      {
         super({
            "monitor":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "CUSTOM_AA_MODE":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "MSAA_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "gammaSetting":createControl(ControlsFactory.TYPE_BUTTON).build(),
            "sizes":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "windowSize":createControl(ControlsFactory.TYPE_DROPDOWN).readOnly(true).build(),
            "resolution":createControl(ControlsFactory.TYPE_DROPDOWN).readOnly(true).build(),
            "borderlessSize":createControl(ControlsFactory.TYPE_DROPDOWN).readOnly(true).build(),
            "refreshRate":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "interfaceScale":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "dynamicRenderer":createControl(ControlsFactory.TYPE_SLIDER).hasValue(true).build(),
            "fov":createControl(ControlsFactory.TYPE_RANGE_SLIDER).build(),
            "dynamicFov":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "colorFilter":createControl(ControlsFactory.TYPE_BUTTON).hasValue(true).build(),
            "screenMode":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "igbHardwareAcceleration":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "vertSync":createControl(ControlsFactory.TYPE_CHECKBOX).isDependOn(SettingsConfigHelper.TRIPLE_BUFFERED).build(),
            "tripleBuffered":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "isColorBlind":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "graphicsQuality":createControl(ControlsFactory.TYPE_DROPDOWN).build(),
            "graphicsQualityHDSD":createControl(ControlsFactory.TYPE_LABEL).build(),
            "graphicsQualityHDSDHigh":createControl(ControlsFactory.TYPE_LABEL).build(),
            "RENDER_PIPELINE":createControl(ControlsFactory.TYPE_BUTTON_BAR).build(),
            "TEXTURE_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SHADOWS_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "TERRAIN_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).isDependOn(SettingsConfigHelper.TERRAIN_TESSELLATION_ENABLED).build(),
            "WATER_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "LIGHTING_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SPEEDTREE_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "FLORA_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "EFFECTS_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "POST_PROCESSING_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "MOTION_BLUR_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "FAR_PLANE":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "OBJECT_LOD":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SNIPER_MODE_EFFECTS_QUALITY":createControl(ControlsFactory.TYPE_STEP_SLIDER).hasLabel(true).build(),
            "SNIPER_MODE_GRASS_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "VEHICLE_DUST_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "HAVOK_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "VEHICLE_TRACES_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "DRR_AUTOSCALER_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "SEMITRANSPARENT_LEAVES_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "TERRAIN_TESSELLATION_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).isDependOn(SettingsConfigHelper.SNIPER_MODE_TERRAIN_TESSELLATION_ENABLED).build(),
            "SNIPER_MODE_TERRAIN_TESSELLATION_ENABLED":createControl(ControlsFactory.TYPE_CHECKBOX).build(),
            "qualityOrder":new Vector.<String>(),
            "presets":null,
            "tessellationSupported":createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build(),
            "nativeResolution":createControl(ControlsFactory.TYPE_VALUE).readOnly(true).build(),
            "isSDQuality":createControl(ControlsFactory.TYPE_CHECKBOX).readOnly(true).build()
         });
      }
      
      override protected function onDispose() : void
      {
         this.monitor = null;
         this.CUSTOM_AA_MODE = null;
         this.MSAA_QUALITY = null;
         this.gammaSetting = null;
         this.sizes = null;
         this.borderlessSize = null;
         this.screenMode = null;
         this.windowSize = null;
         this.resolution = null;
         this.refreshRate = null;
         this.interfaceScale = null;
         this.dynamicRenderer = null;
         this.fov = null;
         this.dynamicFov = null;
         this.HAVOK_ENABLED = null;
         this.colorFilter = null;
         this.colorFilterImages = null;
         this.vertSync = null;
         this.tripleBuffered = null;
         this.igbHardwareAcceleration = null;
         this.isColorBlind = null;
         this.graphicsQuality = null;
         this.graphicsQualityHDSD = null;
         this.graphicsQualityHDSDHigh = null;
         this.RENDER_PIPELINE = null;
         this.TEXTURE_QUALITY = null;
         this.SHADOWS_QUALITY = null;
         this.TERRAIN_QUALITY = null;
         this.WATER_QUALITY = null;
         this.LIGHTING_QUALITY = null;
         this.SPEEDTREE_QUALITY = null;
         this.FLORA_QUALITY = null;
         this.EFFECTS_QUALITY = null;
         this.POST_PROCESSING_QUALITY = null;
         this.MOTION_BLUR_QUALITY = null;
         this.FAR_PLANE = null;
         this.OBJECT_LOD = null;
         this.SNIPER_MODE_EFFECTS_QUALITY = null;
         this.SNIPER_MODE_GRASS_ENABLED = null;
         this.VEHICLE_DUST_ENABLED = null;
         this.HAVOK_ENABLED = null;
         this.VEHICLE_TRACES_ENABLED = null;
         this.DRR_AUTOSCALER_ENABLED = null;
         this.SEMITRANSPARENT_LEAVES_ENABLED = null;
         this.TERRAIN_TESSELLATION_ENABLED = null;
         this.SNIPER_MODE_TERRAIN_TESSELLATION_ENABLED = null;
         this.qualityOrder = null;
         this.presets = null;
         this.tessellationSupported = null;
         this.nativeResolution = null;
         this.isSDQuality = null;
         super.onDispose();
      }
   }
}
