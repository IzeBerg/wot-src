package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.filters.GlowFilter;
   
   public class EventVehicleMarker extends VehicleMarker
   {
      
      private static const BOMB_CARRIER_SCHEME_NAME:String = "vm_hunter";
      
      private static const HP_FIELD_COLOR_DEFAULT:uint = 16777215;
      
      private static const HP_FIELD_COLOR_CARRIER:uint = 0;
      
      private static const STUN_NAME_PREFIX:String = "event_";
       
      
      private var _isCarrier:Boolean = false;
      
      private var _textFilters:Array = null;
      
      public function EventVehicleMarker()
      {
         super();
         this._textFilters = [new GlowFilter(2509311,0.5,2,2,1,2),new GlowFilter(2502655,0.5,4,4,1,2),new GlowFilter(6040802,0.5,8,8,1,2)];
      }
      
      override protected function onDispose() : void
      {
         this._textFilters.length = 0;
         this._textFilters = null;
         super.onDispose();
      }
      
      public function setIsBombCarrier(param1:Boolean) : void
      {
         this._isCarrier = param1;
      }
      
      override protected function get markerSchemeName() : String
      {
         return !!this._isCarrier ? BOMB_CARRIER_SCHEME_NAME : super.markerSchemeName;
      }
      
      override protected function updateMarkerSettings() : void
      {
         super.updateMarkerSettings();
         if(vehicleNameField.visible)
         {
            vehicleNameField.filters = !!this._isCarrier ? this._textFilters : null;
         }
         if(playerNameField.visible)
         {
            playerNameField.filters = !!this._isCarrier ? this._textFilters : null;
         }
         if(hpField.visible && !vehicleDestroyed)
         {
            hpField.textColor = this._isCarrier && healthBar.visible ? uint(HP_FIELD_COLOR_CARRIER) : uint(HP_FIELD_COLOR_DEFAULT);
            hpField.filters = this._isCarrier && !healthBar.visible ? this._textFilters : null;
         }
      }
      
      override protected function updateEffectColor() : void
      {
         var _loc1_:String = this.stunSchemeName;
         var _loc2_:String = _vmManager.getAliasColor(_loc1_);
         var _loc3_:uint = _vmManager.getRGB(_loc1_);
         statusContainer.setEffectColor(_loc2_,_loc3_);
         statusContainer.stunMarker.setEffectColor(STUN_NAME_PREFIX + _loc2_,_loc3_);
      }
   }
}
