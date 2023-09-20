package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   
   public class VehicleStatusMarker extends VehicleAnimatedStatusBaseMarker
   {
       
      
      public var iconContainer:MarkerAssetContainer = null;
      
      public var glowContainer:MarkerAssetContainer = null;
      
      public var timer:MarkerTimer = null;
      
      private var _hasTimer:Boolean = true;
      
      public function VehicleStatusMarker()
      {
         super();
      }
      
      override public function showEffectTimer(param1:Number, param2:Boolean, param3:Boolean, param4:Boolean = true, param5:Boolean = true) : void
      {
         this.switchTimerVisible(param2);
         this.iconContainer.setAnimated(param5);
         this.glowContainer.setAnimated(param5);
         super.showEffectTimer(param1,param2,param3,param4,param5);
      }
      
      override public function updateAssets() : void
      {
         super.updateAssets();
         this.iconContainer.setIconName(VMAtlasItemName.getStatusMarkerIcon(altasIconAlias,color));
         this.glowContainer.setIconName(VMAtlasItemName.getStatusMarkerGlow(color));
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         super.updateColorSettings(param1);
         if(isAtlasSrcMode())
         {
            if(visible)
            {
               this.updateAssets();
            }
         }
         else
         {
            this.iconContainer.updateColorSettings(color);
            this.glowContainer.updateColorSettings(color);
         }
         if(this._hasTimer)
         {
            this.timer.color = param1;
         }
      }
      
      override protected function onDispose() : void
      {
         this.iconContainer.dispose();
         this.iconContainer = null;
         this.glowContainer.dispose();
         this.glowContainer = null;
         this.timer.dispose();
         this.timer = null;
         super.onDispose();
      }
      
      public function setSecondString(param1:String) : void
      {
         if(this._hasTimer)
         {
            this.timer.timeUnits = param1;
         }
      }
      
      public function switchTimerVisible(param1:Boolean) : void
      {
         this._hasTimer = param1;
         this.timer.visible = this._hasTimer;
      }
   }
}
