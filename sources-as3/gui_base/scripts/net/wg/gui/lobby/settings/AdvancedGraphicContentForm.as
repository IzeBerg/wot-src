package net.wg.gui.lobby.settings
{
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.FieldSet;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.LabelControl;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.components.SettingsStepSlider;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AdvancedGraphicContentForm extends UIComponentEx
   {
      
      private static const RADIO_BAR_OFFSET:Number = 12;
       
      
      public var blockMain:FieldSet = null;
      
      public var blockLightingAndShadows:FieldSet = null;
      
      public var blockLandscapeAndWater:FieldSet = null;
      
      public var blockGreenery:FieldSet = null;
      
      public var blockEffects:FieldSet = null;
      
      public var RENDER_PIPELINELabel:LabelControl = null;
      
      public var RENDER_PIPELINEButtonBar:RadioButtonBar = null;
      
      public var TEXTURE_QUALITYLabel:LabelControl = null;
      
      public var TEXTURE_QUALITYValue:LabelControl = null;
      
      public var TEXTURE_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var SHADOWS_QUALITYLabel:LabelControl = null;
      
      public var SHADOWS_QUALITYValue:LabelControl = null;
      
      public var SHADOWS_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var TERRAIN_QUALITYLabel:LabelControl = null;
      
      public var TERRAIN_QUALITYValue:LabelControl = null;
      
      public var TERRAIN_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var WATER_QUALITYLabel:LabelControl = null;
      
      public var WATER_QUALITYValue:LabelControl = null;
      
      public var WATER_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var LIGHTING_QUALITYLabel:LabelControl = null;
      
      public var LIGHTING_QUALITYValue:LabelControl = null;
      
      public var LIGHTING_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var SPEEDTREE_QUALITYLabel:LabelControl = null;
      
      public var SPEEDTREE_QUALITYValue:LabelControl = null;
      
      public var SPEEDTREE_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var FLORA_QUALITYLabel:LabelControl = null;
      
      public var FLORA_QUALITYValue:LabelControl = null;
      
      public var FLORA_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var EFFECTS_QUALITYLabel:LabelControl = null;
      
      public var EFFECTS_QUALITYValue:LabelControl = null;
      
      public var EFFECTS_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var TRACK_PHYSICS_QUALITYLabel:LabelControl = null;
      
      public var TRACK_PHYSICS_QUALITYValue:LabelControl = null;
      
      public var TRACK_PHYSICS_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var POST_PROCESSING_QUALITYLabel:LabelControl = null;
      
      public var POST_PROCESSING_QUALITYValue:LabelControl = null;
      
      public var POST_PROCESSING_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var MOTION_BLUR_QUALITYLabel:LabelControl = null;
      
      public var MOTION_BLUR_QUALITYValue:LabelControl = null;
      
      public var MOTION_BLUR_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var FAR_PLANELabel:LabelControl = null;
      
      public var FAR_PLANEValue:LabelControl = null;
      
      public var FAR_PLANEStepSlider:SettingsStepSlider = null;
      
      public var OBJECT_LODLabel:LabelControl = null;
      
      public var OBJECT_LODValue:LabelControl = null;
      
      public var OBJECT_LODStepSlider:SettingsStepSlider = null;
      
      public var SNIPER_MODE_EFFECTS_QUALITYLabel:LabelControl = null;
      
      public var SNIPER_MODE_EFFECTS_QUALITYValue:LabelControl = null;
      
      public var SNIPER_MODE_EFFECTS_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var CUSTOM_AA_MODELabel:LabelControl = null;
      
      public var CUSTOM_AA_MODEValue:LabelControl = null;
      
      public var CUSTOM_AA_MODEStepSlider:SettingsStepSlider = null;
      
      public var MSAA_QUALITYLabel:LabelControl = null;
      
      public var MSAA_QUALITYValue:LabelControl = null;
      
      public var MSAA_QUALITYStepSlider:SettingsStepSlider = null;
      
      public var SNIPER_MODE_GRASS_ENABLEDCheckbox:CheckBox = null;
      
      public var HAVOK_ENABLEDCheckbox:CheckBox = null;
      
      public var VEHICLE_DUST_ENABLEDCheckbox:CheckBox = null;
      
      public var VEHICLE_TRACES_ENABLEDCheckbox:CheckBox = null;
      
      public var SEMITRANSPARENT_LEAVES_ENABLEDCheckbox:CheckBox = null;
      
      public var TERRAIN_TESSELLATION_ENABLEDCheckbox:CheckBox = null;
      
      public var SNIPER_MODE_TERRAIN_TESSELLATION_ENABLEDCheckbox:CheckBox = null;
      
      public function AdvancedGraphicContentForm()
      {
         super();
         this.initTexts();
         visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.blockMain.label = SETTINGS.GRAPHICS_BLOCK_MAIN;
         this.blockLightingAndShadows.label = SETTINGS.GRAPHICS_BLOCK_LIGHTINGANDSHADOWS;
         this.blockLandscapeAndWater.label = SETTINGS.GRAPHICS_BLOCK_LANDSCAPEANDWATER;
         this.blockGreenery.label = SETTINGS.GRAPHICS_BLOCK_GREENERY;
         this.blockEffects.label = SETTINGS.GRAPHICS_BLOCK_EFFECTS;
         this.RENDER_PIPELINELabel.text = SETTINGS.RENDER_PIPELINE_LABEL;
         this.RENDER_PIPELINELabel.validateNow();
         this.RENDER_PIPELINEButtonBar.x = this.RENDER_PIPELINELabel.x + this.RENDER_PIPELINELabel.width + RADIO_BAR_OFFSET;
         dispatchEvent(new Event(Event.RESIZE));
         visible = true;
      }
      
      override protected function onDispose() : void
      {
         this.RENDER_PIPELINELabel.dispose();
         this.RENDER_PIPELINEButtonBar.dispose();
         this.TEXTURE_QUALITYLabel.dispose();
         this.TEXTURE_QUALITYValue.dispose();
         this.TEXTURE_QUALITYStepSlider.dispose();
         this.SHADOWS_QUALITYLabel.dispose();
         this.SHADOWS_QUALITYValue.dispose();
         this.SHADOWS_QUALITYStepSlider.dispose();
         this.TERRAIN_QUALITYLabel.dispose();
         this.TERRAIN_QUALITYValue.dispose();
         this.TERRAIN_QUALITYStepSlider.dispose();
         this.WATER_QUALITYLabel.dispose();
         this.WATER_QUALITYValue.dispose();
         this.WATER_QUALITYStepSlider.dispose();
         this.LIGHTING_QUALITYLabel.dispose();
         this.LIGHTING_QUALITYValue.dispose();
         this.LIGHTING_QUALITYStepSlider.dispose();
         this.SPEEDTREE_QUALITYLabel.dispose();
         this.SPEEDTREE_QUALITYValue.dispose();
         this.SPEEDTREE_QUALITYStepSlider.dispose();
         this.FLORA_QUALITYLabel.dispose();
         this.FLORA_QUALITYValue.dispose();
         this.FLORA_QUALITYStepSlider.dispose();
         this.EFFECTS_QUALITYLabel.dispose();
         this.EFFECTS_QUALITYValue.dispose();
         this.EFFECTS_QUALITYStepSlider.dispose();
         this.TRACK_PHYSICS_QUALITYLabel.dispose();
         this.TRACK_PHYSICS_QUALITYValue.dispose();
         this.TRACK_PHYSICS_QUALITYStepSlider.dispose();
         this.POST_PROCESSING_QUALITYLabel.dispose();
         this.POST_PROCESSING_QUALITYValue.dispose();
         this.POST_PROCESSING_QUALITYStepSlider.dispose();
         this.MOTION_BLUR_QUALITYLabel.dispose();
         this.MOTION_BLUR_QUALITYValue.dispose();
         this.MOTION_BLUR_QUALITYStepSlider.dispose();
         this.FAR_PLANELabel.dispose();
         this.FAR_PLANEValue.dispose();
         this.FAR_PLANEStepSlider.dispose();
         this.OBJECT_LODLabel.dispose();
         this.OBJECT_LODValue.dispose();
         this.OBJECT_LODStepSlider.dispose();
         this.SNIPER_MODE_EFFECTS_QUALITYLabel.dispose();
         this.SNIPER_MODE_EFFECTS_QUALITYValue.dispose();
         this.SNIPER_MODE_EFFECTS_QUALITYStepSlider.dispose();
         this.SNIPER_MODE_GRASS_ENABLEDCheckbox.dispose();
         this.HAVOK_ENABLEDCheckbox.dispose();
         this.VEHICLE_DUST_ENABLEDCheckbox.dispose();
         this.VEHICLE_TRACES_ENABLEDCheckbox.dispose();
         this.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox.dispose();
         this.TERRAIN_TESSELLATION_ENABLEDCheckbox.dispose();
         this.SNIPER_MODE_TERRAIN_TESSELLATION_ENABLEDCheckbox.dispose();
         this.CUSTOM_AA_MODELabel.dispose();
         this.CUSTOM_AA_MODEValue.dispose();
         this.CUSTOM_AA_MODEStepSlider.dispose();
         this.MSAA_QUALITYLabel.dispose();
         this.MSAA_QUALITYValue.dispose();
         this.MSAA_QUALITYStepSlider.dispose();
         this.RENDER_PIPELINELabel = null;
         this.RENDER_PIPELINEButtonBar = null;
         this.TEXTURE_QUALITYLabel = null;
         this.TEXTURE_QUALITYValue = null;
         this.TEXTURE_QUALITYStepSlider = null;
         this.SHADOWS_QUALITYLabel = null;
         this.SHADOWS_QUALITYValue = null;
         this.SHADOWS_QUALITYStepSlider = null;
         this.TERRAIN_QUALITYLabel = null;
         this.TERRAIN_QUALITYValue = null;
         this.TERRAIN_QUALITYStepSlider = null;
         this.WATER_QUALITYLabel = null;
         this.WATER_QUALITYValue = null;
         this.WATER_QUALITYStepSlider = null;
         this.LIGHTING_QUALITYLabel = null;
         this.LIGHTING_QUALITYValue = null;
         this.LIGHTING_QUALITYStepSlider = null;
         this.SPEEDTREE_QUALITYLabel = null;
         this.SPEEDTREE_QUALITYValue = null;
         this.SPEEDTREE_QUALITYStepSlider = null;
         this.FLORA_QUALITYLabel = null;
         this.FLORA_QUALITYValue = null;
         this.FLORA_QUALITYStepSlider = null;
         this.EFFECTS_QUALITYLabel = null;
         this.EFFECTS_QUALITYValue = null;
         this.EFFECTS_QUALITYStepSlider = null;
         this.TRACK_PHYSICS_QUALITYLabel = null;
         this.TRACK_PHYSICS_QUALITYValue = null;
         this.TRACK_PHYSICS_QUALITYStepSlider = null;
         this.POST_PROCESSING_QUALITYLabel = null;
         this.POST_PROCESSING_QUALITYValue = null;
         this.POST_PROCESSING_QUALITYStepSlider = null;
         this.MOTION_BLUR_QUALITYLabel = null;
         this.MOTION_BLUR_QUALITYValue = null;
         this.MOTION_BLUR_QUALITYStepSlider = null;
         this.FAR_PLANELabel = null;
         this.FAR_PLANEValue = null;
         this.FAR_PLANEStepSlider = null;
         this.OBJECT_LODLabel = null;
         this.OBJECT_LODValue = null;
         this.OBJECT_LODStepSlider = null;
         this.SNIPER_MODE_EFFECTS_QUALITYLabel = null;
         this.SNIPER_MODE_EFFECTS_QUALITYValue = null;
         this.SNIPER_MODE_EFFECTS_QUALITYStepSlider = null;
         this.SNIPER_MODE_GRASS_ENABLEDCheckbox = null;
         this.HAVOK_ENABLEDCheckbox = null;
         this.VEHICLE_DUST_ENABLEDCheckbox = null;
         this.VEHICLE_TRACES_ENABLEDCheckbox = null;
         this.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox = null;
         this.TERRAIN_TESSELLATION_ENABLEDCheckbox = null;
         this.SNIPER_MODE_TERRAIN_TESSELLATION_ENABLEDCheckbox = null;
         this.CUSTOM_AA_MODELabel = null;
         this.CUSTOM_AA_MODEValue = null;
         this.CUSTOM_AA_MODEStepSlider = null;
         this.MSAA_QUALITYLabel = null;
         this.MSAA_QUALITYValue = null;
         this.MSAA_QUALITYStepSlider = null;
         this.blockMain.dispose();
         this.blockMain = null;
         this.blockLightingAndShadows.dispose();
         this.blockLightingAndShadows = null;
         this.blockLandscapeAndWater.dispose();
         this.blockLandscapeAndWater = null;
         this.blockGreenery.dispose();
         this.blockGreenery = null;
         this.blockEffects.dispose();
         this.blockEffects = null;
         super.onDispose();
      }
      
      private function initTexts() : void
      {
         this.RENDER_PIPELINELabel.text = Values.EMPTY_STR;
         this.TEXTURE_QUALITYLabel.text = Values.EMPTY_STR;
         this.SHADOWS_QUALITYLabel.text = Values.EMPTY_STR;
         this.TERRAIN_QUALITYLabel.text = Values.EMPTY_STR;
         this.WATER_QUALITYLabel.text = Values.EMPTY_STR;
         this.LIGHTING_QUALITYLabel.text = Values.EMPTY_STR;
         this.SPEEDTREE_QUALITYLabel.text = Values.EMPTY_STR;
         this.FLORA_QUALITYLabel.text = Values.EMPTY_STR;
         this.CUSTOM_AA_MODELabel.text = Values.EMPTY_STR;
         this.MSAA_QUALITYLabel.text = Values.EMPTY_STR;
         this.EFFECTS_QUALITYLabel.text = Values.EMPTY_STR;
         this.TRACK_PHYSICS_QUALITYLabel.text = Values.EMPTY_STR;
         this.POST_PROCESSING_QUALITYLabel.text = Values.EMPTY_STR;
         this.MOTION_BLUR_QUALITYLabel.text = Values.EMPTY_STR;
         this.FAR_PLANELabel.text = Values.EMPTY_STR;
         this.OBJECT_LODLabel.text = Values.EMPTY_STR;
         this.SNIPER_MODE_EFFECTS_QUALITYLabel.text = Values.EMPTY_STR;
         this.SNIPER_MODE_GRASS_ENABLEDCheckbox.label = Values.EMPTY_STR;
         this.HAVOK_ENABLEDCheckbox.label = Values.EMPTY_STR;
         this.VEHICLE_DUST_ENABLEDCheckbox.label = Values.EMPTY_STR;
         this.VEHICLE_TRACES_ENABLEDCheckbox.label = Values.EMPTY_STR;
         this.SEMITRANSPARENT_LEAVES_ENABLEDCheckbox.label = Values.EMPTY_STR;
         this.TERRAIN_TESSELLATION_ENABLEDCheckbox.label = Values.EMPTY_STR;
         this.SNIPER_MODE_TERRAIN_TESSELLATION_ENABLEDCheckbox.label = Values.EMPTY_STR;
      }
   }
}
