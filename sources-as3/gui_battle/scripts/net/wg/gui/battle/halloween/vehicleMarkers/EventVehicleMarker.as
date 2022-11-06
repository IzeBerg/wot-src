package net.wg.gui.battle.halloween.vehicleMarkers
{
   import flash.display.MovieClip;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarker;
   import net.wg.gui.battle.views.vehicleMarkers.events.VehicleMarkersManagerEvent;
   
   public class EventVehicleMarker extends VehicleMarker
   {
      
      private static const UNDERSCORE_STR:String = "_";
      
      private static const INVALIDATE_BUFF:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var buffIcon:MovieClip = null;
      
      private var _name:String = "";
      
      public function EventVehicleMarker()
      {
         super();
         this.buffIcon.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._name.length != 0 && isInvalid(INVALIDATE_BUFF))
         {
            this.buffIcon.visible = true;
            _loc1_ = markerColor + UNDERSCORE_STR + this._name;
            vmManager.drawWithCenterAlign(_loc1_,this.buffIcon.graphics,true,true);
         }
      }
      
      override protected function onDispose() : void
      {
         this.buffIcon = null;
         super.onDispose();
      }
      
      override protected function onUpdateColorsHandler(param1:VehicleMarkersManagerEvent) : void
      {
         super.onUpdateColorsHandler(param1);
         if(this._name.length != 0 && this.buffIcon.visible)
         {
            this.showBuff(this._name);
         }
      }
      
      override protected function updateMarkerSettings() : void
      {
         markerSettings[MARKER + BASE + HEALTH_BAR] = markerSettings[MARKER + ALT + HEALTH_BAR] = 1;
         super.updateMarkerSettings();
      }
      
      public function showBuff(param1:String) : void
      {
         this._name = param1;
         invalidate(INVALIDATE_BUFF);
      }
      
      public function hideBuff() : void
      {
         this.buffIcon.visible = false;
      }
   }
}
