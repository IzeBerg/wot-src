package net.wg.gui.components.crosshairPanel
{
   import net.wg.gui.components.crosshairPanel.VO.GunMarkerIndicatorVO;
   import net.wg.gui.components.crosshairPanel.VO.ShotFlyTimeVO;
   import net.wg.gui.components.crosshairPanel.components.artyScale.ArtyIndicationScale;
   import net.wg.gui.components.crosshairPanel.components.artyShot.ArtyShotIndicatorsPanel;
   
   public class CrosshairStrategic extends CrosshairBase
   {
       
      
      public var scaleWidget:ArtyIndicationScale = null;
      
      public var artyShotIndicatorsPanel:ArtyShotIndicatorsPanel = null;
      
      public function CrosshairStrategic()
      {
         super();
      }
      
      override public function setGunMarkersData(param1:Vector.<GunMarkerIndicatorVO>, param2:Boolean) : void
      {
         this.artyShotIndicatorsPanel.setGunMarkersData(param1,param2);
      }
      
      override public function updateScaleWidget(param1:Number) : void
      {
         this.scaleWidget.updateData(param1);
      }
      
      override protected function onDispose() : void
      {
         this.scaleWidget.dispose();
         this.scaleWidget = null;
         this.artyShotIndicatorsPanel.dispose();
         this.artyShotIndicatorsPanel = null;
         super.onDispose();
      }
      
      public function setShotFlyTimesData(param1:Vector.<ShotFlyTimeVO>) : void
      {
         this.artyShotIndicatorsPanel.setShotFlyTimesData(param1);
      }
      
      override public function set scaleWidgetEnabled(param1:Boolean) : void
      {
         this.scaleWidget.visible = param1;
      }
      
      override public function setAverageDamage(param1:String) : void
      {
      }
      
      override public function clearAverageDamage(param1:Boolean) : void
      {
      }
   }
}
