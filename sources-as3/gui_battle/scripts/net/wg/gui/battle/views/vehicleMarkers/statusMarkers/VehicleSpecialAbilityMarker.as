package net.wg.gui.battle.views.vehicleMarkers.statusMarkers
{
   import flash.text.TextField;
   import net.wg.gui.battle.views.vehicleMarkers.VMAtlasItemName;
   
   public class VehicleSpecialAbilityMarker extends VehicleStunMarker
   {
       
      
      private const EMPTY_COLOR_STATE:String = "empty";
      
      public function VehicleSpecialAbilityMarker()
      {
         super();
         waveContainer.isAtlasCenterDrawMode = false;
         waveContainer.updateColorSettings(this.EMPTY_COLOR_STATE);
         arrowContainer.updateColorSettings(this.EMPTY_COLOR_STATE);
      }
      
      override public function updateAssets() : void
      {
         super.updateAssets();
         arrowContainer.setIconName(VMAtlasItemName.getStatusMarkerIcon(altasIconAlias,color));
         waveContainer.setIconName(VMAtlasItemName.getStatusMarkerWave(color));
      }
      
      override protected function updateColorSettings(param1:uint) : void
      {
         if(isAtlasSrcMode())
         {
            if(visible)
            {
               this.updateAssets();
            }
         }
         glowContainer.updateColorSettings(color);
         TextField(counterMc.labelTf).textColor = param1;
      }
   }
}
