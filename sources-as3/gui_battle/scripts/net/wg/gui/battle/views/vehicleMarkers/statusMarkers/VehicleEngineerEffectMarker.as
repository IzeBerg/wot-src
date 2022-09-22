package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.display.MovieClip;
   
   public class VehicleEngineerEffectMarker extends VehicleAnimatedStatusBaseMarker
   {
      
      protected static const DEFENDER_PREFIX:String = "defender_";
      
      protected static const ATTACKER_PREFIX:String = "attacker_";
       
      
      public var iconMc:MovieClip = null;
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public function VehicleEngineerEffectMarker()
      {
         super();
      }
      
      override public function showEffectTimer(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean = true, param5:Boolean = true) : void
      {
         this.iconMc.gotoAndStop((!!param2 ? ATTACKER_PREFIX : DEFENDER_PREFIX) + color);
         super.showEffectTimer(param1,param2,param3,param4,param5);
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
