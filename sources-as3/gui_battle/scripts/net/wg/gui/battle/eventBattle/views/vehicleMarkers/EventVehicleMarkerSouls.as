package net.wg.gui.battle.eventBattle.views.vehicleMarkers
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersManager;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventVehicleMarkerSouls extends MovieClip implements IDisposable
   {
       
      
      public var soulIcon:MovieClip = null;
      
      public var txtField:TextField = null;
      
      private var _vmManager:VehicleMarkersManager = null;
      
      public function EventVehicleMarkerSouls()
      {
         super();
         this._vmManager = VehicleMarkersManager.getInstance();
      }
      
      public function setSoulIcon(param1:String) : void
      {
         this._vmManager.drawWithCenterAlign(param1,this.soulIcon.graphics,true,true);
      }
      
      public function setText(param1:String) : void
      {
         this.txtField.text = param1;
      }
      
      public final function dispose() : void
      {
         this.soulIcon = null;
         this.txtField = null;
         this._vmManager = null;
      }
   }
}
