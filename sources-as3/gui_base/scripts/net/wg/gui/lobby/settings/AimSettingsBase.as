package net.wg.gui.lobby.settings
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.crosshairPanel.ICrosshair;
   import net.wg.gui.components.crosshairPanel.components.CrosshairClipQuantityBar;
   import net.wg.gui.components.crosshairPanel.components.artyShot.ArtyShotIndicatorsPanel;
   import net.wg.gui.components.crosshairPanel.components.gunMarker.IGunMarker;
   import net.wg.gui.components.crosshairPanel.constants.CrosshairConsts;
   import net.wg.gui.lobby.aimSettings.AimContourContent;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class AimSettingsBase extends SettingsBaseView
   {
      
      protected static const RELOADING_TIME:Number = 4.2;
      
      protected static const CROSSHAIR_SCALE:Number = 0.14;
      
      protected static const FORM:String = "Form";
       
      
      public var bg:MovieClip = null;
      
      public var tabs:ButtonBarEx = null;
      
      public var arcadeForm:SettingsArcadeForm = null;
      
      public var sniperForm:SettingsSniperForm = null;
      
      public var spgForm:SettingsArtyForm = null;
      
      public var contourForm:SettingsContourForm = null;
      
      public var arcadeCrosshair:ICrosshair = null;
      
      public var sniperCrosshair:ICrosshair = null;
      
      public var gunMarker:IGunMarker = null;
      
      public var artyZoomPanel:Sprite = null;
      
      public var artyShotNotify:MovieClip = null;
      
      public var contourCrosshair:AimContourContent = null;
      
      public var artyShotIndicatorsPanel:ArtyShotIndicatorsPanel = null;
      
      public function AimSettingsBase()
      {
         super();
      }
      
      override protected function getButtonBar() : ButtonBarEx
      {
         return this.tabs;
      }
      
      override protected function getButtonBarDP() : IDataProvider
      {
         return SettingsConfigHelper.instance.cursorTabsDataProvider;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.arcadeCrosshair.isUseFrameAnimation = false;
         this.arcadeCrosshair.setClipsParam(7,1);
         this.arcadeCrosshair.setAmmoStock(7,CrosshairClipQuantityBar.STATE_RELOAD_FINISHED,true);
         this.sniperCrosshair.isUseFrameAnimation = false;
         this.sniperCrosshair.setClipsParam(7,1);
         this.sniperCrosshair.setAmmoStock(7,CrosshairClipQuantityBar.STATE_RELOAD_FINISHED,true);
         this.gunMarker.setMixingScale(CROSSHAIR_SCALE);
         this.gunMarker.setReloadingParams(1,CrosshairConsts.RELOADING_ENDED);
      }
      
      override protected function onBeforeDispose() : void
      {
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.tabs.dispose();
         this.tabs = null;
         this.gunMarker.dispose();
         this.gunMarker = null;
         this.arcadeCrosshair.dispose();
         this.arcadeCrosshair = null;
         this.sniperCrosshair.dispose();
         this.sniperCrosshair = null;
         this.artyShotIndicatorsPanel.dispose();
         this.artyShotIndicatorsPanel = null;
         this.artyShotNotify = null;
         this.contourCrosshair.dispose();
         this.contourCrosshair = null;
         this.artyZoomPanel = null;
         this.arcadeForm.dispose();
         this.arcadeForm = null;
         this.sniperForm.dispose();
         this.sniperForm = null;
         this.spgForm.dispose();
         this.spgForm = null;
         this.contourForm.dispose();
         this.contourForm = null;
         super.onDispose();
      }
   }
}
