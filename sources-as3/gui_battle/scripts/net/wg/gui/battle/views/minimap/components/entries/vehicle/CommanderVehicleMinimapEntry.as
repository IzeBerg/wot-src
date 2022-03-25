package net.wg.gui.battle.views.minimap.components.entries.vehicle
{
   import net.wg.gui.battle.views.minimap.components.entries.constants.VehicleMinimapEntryConst;
   
   public class CommanderVehicleMinimapEntry extends VehicleMinimapEntry
   {
       
      
      private var _isSupplyAndSpotted:Boolean = false;
      
      private var _isSelected:Boolean = false;
      
      public function CommanderVehicleMinimapEntry()
      {
         super();
         mouseEnabled = mouseChildren = false;
      }
      
      public function setSupplySpotted() : void
      {
         var _loc1_:uint = 0;
         if(!this._isSupplyAndSpotted)
         {
            this._isSupplyAndSpotted = true;
            _loc1_ = 0;
            _loc1_ |= INVALID_CHANGE_VEHICLE_ANIMATION_TYPE;
            invalidate(_loc1_);
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         this._isSelected = param1;
         var _loc2_:uint = 0;
         _loc2_ |= INVALID_CHANGE_VEHICLE_ANIMATION_TYPE;
         _loc2_ |= INVALID_VEHICLE_LABEL;
         invalidate(_loc2_);
      }
      
      override protected function getAtlasItemName() : String
      {
         var _loc1_:String = super.getAtlasItemName();
         if(this._isSupplyAndSpotted)
         {
            _loc1_ += ATLAS_NAME_DELIMITER + "spotted";
         }
         if(this._isSelected)
         {
            _loc1_ = getClassTagName() + ATLAS_NAME_DELIMITER + "selected" + ATLAS_NAME_DELIMITER + "green";
         }
         return _loc1_;
      }
      
      override protected function getTextColorSchema() : String
      {
         if(!this._isSelected)
         {
            return super.getTextColorSchema();
         }
         return VehicleMinimapEntryConst.TEXT_COLOR_SCHEME_PREFIX + "rts_selected" + VehicleMinimapEntryConst.TEXT_COLOR_SCHEME_POSTFIX;
      }
   }
}
