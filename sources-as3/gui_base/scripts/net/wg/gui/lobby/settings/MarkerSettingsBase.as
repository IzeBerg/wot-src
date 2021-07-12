package net.wg.gui.lobby.settings
{
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.ButtonBarEx;
   import net.wg.gui.components.common.VehicleMarkerAlly;
   import net.wg.gui.components.common.VehicleMarkerEnemy;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MarkerSettingsBase extends SettingsBaseView
   {
       
      
      public var tabs:ButtonBarEx = null;
      
      public var bg:MovieClip = null;
      
      public var enemyForm:SettingsMarkersForm = null;
      
      public var allyForm:SettingsMarkersForm = null;
      
      public var deadForm:SettingsMarkersForm = null;
      
      public var markerEnemy:VehicleMarkerEnemy = null;
      
      public var markerEnemyAlt:VehicleMarkerEnemy = null;
      
      public var markerAlly:VehicleMarkerAlly = null;
      
      public var markerAllyAlt:VehicleMarkerAlly = null;
      
      public var markerDead:VehicleMarkerAlly = null;
      
      public var markerDeadAlt:VehicleMarkerAlly = null;
      
      public var autoAimMarker:MovieClip = null;
      
      public var autoAimMarkerAlt:MovieClip = null;
      
      public function MarkerSettingsBase()
      {
         super();
      }
      
      override protected function getButtonBar() : ButtonBarEx
      {
         return this.tabs;
      }
      
      override protected function getButtonBarDP() : IDataProvider
      {
         return SettingsConfigHelper.instance.markerTabsDataProvider;
      }
      
      override protected function onDispose() : void
      {
         this.tabs.dispose();
         this.tabs = null;
         this.bg = null;
         this.enemyForm.dispose();
         this.enemyForm = null;
         this.allyForm.dispose();
         this.allyForm = null;
         this.deadForm.dispose();
         this.deadForm = null;
         this.markerEnemy.dispose();
         this.markerEnemy = null;
         this.markerEnemyAlt.dispose();
         this.markerEnemyAlt = null;
         this.markerAlly.dispose();
         this.markerAlly = null;
         this.markerAllyAlt.dispose();
         this.markerAllyAlt = null;
         this.markerDead.dispose();
         this.markerDead = null;
         this.markerDeadAlt.dispose();
         this.markerDeadAlt = null;
         this.autoAimMarker = null;
         this.autoAimMarkerAlt = null;
         super.onDispose();
      }
   }
}
