package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   
   public class VehicleFLBasicMarker extends VehicleAnimatedStatusBaseMarker
   {
       
      
      public var iconMc:MovieClip = null;
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public function VehicleFLBasicMarker()
      {
         super();
      }
      
      override public function showEffectTimer(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean = true) : void
      {
         this.iconMc.gotoAndStop(color);
         super.showEffectTimer(param1,param2,param3,param4);
      }
      
      override protected function onDispose() : void
      {
         stop();
         this.iconMc = null;
         this.glowContainer.dispose();
         this.glowContainer = null;
         super.onDispose();
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         this.glowContainer.updateColorSettings(color);
      }
   }
}
