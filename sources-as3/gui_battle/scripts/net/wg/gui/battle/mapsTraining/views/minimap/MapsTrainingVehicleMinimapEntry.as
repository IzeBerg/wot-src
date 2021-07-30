package net.wg.gui.battle.mapsTraining.views.minimap
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleAnimationMinimapEntry;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleMinimapEntry;
   
   public class MapsTrainingVehicleMinimapEntry extends VehicleMinimapEntry
   {
      
      private static const STATE_SPOTTED:uint = 1;
      
      private static const STATE_TARGET:uint = 1 << 1;
       
      
      public var eyeMc:VehicleAnimationMinimapEntry = null;
      
      public var targetMc:MovieClip = null;
      
      private var _state:uint = 0;
      
      public function MapsTrainingVehicleMinimapEntry()
      {
         super();
      }
      
      private static function updateMovieClip(param1:MovieClip, param2:Boolean) : void
      {
         if(param2)
         {
            if(param1.currentFrame == 1)
            {
               param1.play();
            }
         }
         else
         {
            param1.gotoAndStop(1);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.eyeMc.drawEntry(BATTLEATLAS.MT_EYE);
      }
      
      public function setState(param1:uint) : void
      {
         this._state = param1;
         invalidate(VehicleMinimapEntry.INVALID_MT_STATE);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(VehicleMinimapEntry.INVALID_MT_STATE))
         {
            updateMovieClip(this.eyeMc,(this._state & STATE_SPOTTED) > 0);
            updateMovieClip(this.targetMc,(this._state & STATE_TARGET) > 0);
         }
      }
      
      override protected function onDispose() : void
      {
         this.eyeMc.dispose();
         this.eyeMc = null;
         this.targetMc = null;
         super.onDispose();
      }
   }
}
