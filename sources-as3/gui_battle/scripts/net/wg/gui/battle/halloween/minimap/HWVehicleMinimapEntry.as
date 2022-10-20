package net.wg.gui.battle.halloween.minimap
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.minimap.components.entries.vehicle.VehicleMinimapEntry;
   import net.wg.gui.battle.views.vehicleMarkers.VehicleMarkersConstants;
   
   public class HWVehicleMinimapEntry extends VehicleMinimapEntry
   {
      
      private static const ORANGE:String = "orange";
      
      private static const INVALID_BUFF_STATE:int = InvalidationType.SYSTEM_FLAGS_BORDER << 7;
       
      
      public var buffBG:HWBuffCircle = null;
      
      private var _showBuff:Boolean = false;
      
      public function HWVehicleMinimapEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.buffBG.stop();
         this.buffBG.dispose();
         this.buffBG = null;
         super.onDispose();
      }
      
      public function setBuff(param1:Boolean) : void
      {
         if(this._showBuff != param1)
         {
            this._showBuff = param1;
            invalidate(INVALID_BUFF_STATE);
         }
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(INVALID_BUFF_STATE))
         {
            this.buffBG.visible = this._showBuff;
            if(this.buffBG)
            {
               this.buffBG.gotoAndPlay(1);
            }
            else
            {
               this.buffBG.stop();
            }
         }
         var _loc1_:String = getGUILabel();
         if(_loc1_ != Values.EMPTY_STR && isInvalid(INVALID_CHANGE_VEHICLE_ANIMATION_TYPE))
         {
            _loc2_ = getIsColorBlind();
            if(_loc1_ == VehicleMarkersConstants.ENTITY_NAME_ENEMY)
            {
               this.buffBG.setColor(!!_loc2_ ? VehicleMarkersConstants.COLOR_PURPLE : VehicleMarkersConstants.COLOR_RED);
            }
            else if(_loc1_ == LABEL_SQUADMAN)
            {
               this.buffBG.setColor(!!_loc2_ ? VehicleMarkersConstants.COLOR_YELLOW : ORANGE);
            }
            else
            {
               this.buffBG.setColor(VehicleMarkersConstants.COLOR_GREEN);
            }
         }
      }
   }
}
