package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.Graphics;
   import net.wg.data.constants.generated.DUAL_GUN_MARKER_STATE;
   
   public class GunMarkerMixingDualGunSniper extends GunMarkerMixingDualGun
   {
      
      private static const SNIPER_MODE_GAP_ANGLE:Number = Math.PI / 30;
      
      private static const NOTCH_SHIFT_X:Number = RADIUS * Math.sin(SNIPER_MODE_GAP_ANGLE / 2);
      
      private static const NOTCH_SHIFT_Y:Number = RADIUS * Math.cos(SNIPER_MODE_GAP_ANGLE / 2);
      
      private static const NOTCH_SIZE:Number = 30;
       
      
      public function GunMarkerMixingDualGunSniper()
      {
         super();
      }
      
      protected static function drawNotch(param1:Graphics, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:int = !!param3 ? int(-1) : int(1);
         var _loc5_:int = !!param2 ? int(-1) : int(1);
         param1.moveTo(_loc4_ * NOTCH_SHIFT_X,_loc5_ * NOTCH_SHIFT_Y);
         param1.lineTo(_loc4_ * NOTCH_SHIFT_X,_loc5_ * (NOTCH_SHIFT_Y + NOTCH_SIZE));
      }
      
      override protected function getDashedGap() : Number
      {
         return SNIPER_MODE_GAP_ANGLE;
      }
      
      override protected function getSolidGap() : Number
      {
         return SNIPER_MODE_GAP_ANGLE;
      }
      
      override protected function isLeftHalfActive() : Boolean
      {
         return markerState == DUAL_GUN_MARKER_STATE.LEFT_PART_ACTIVE || markerState == DUAL_GUN_MARKER_STATE.VISIBLE;
      }
      
      override protected function isRightHalfActive() : Boolean
      {
         return markerState == DUAL_GUN_MARKER_STATE.RIGHT_PART_ACTIVE || markerState == DUAL_GUN_MARKER_STATE.VISIBLE;
      }
      
      override protected function drawMarker(param1:int, param2:int, param3:int) : void
      {
         super.drawMarker(param1,param2,param3);
         this.drawNotches();
      }
      
      private function drawNotches() : void
      {
         var _loc1_:Graphics = hairlineGraphics;
         var _loc2_:uint = !!this.isLeftHalfActive() ? uint(ACTIVE_COLOR) : uint(DASHED_COLOR);
         var _loc3_:uint = !!this.isRightHalfActive() ? uint(ACTIVE_COLOR) : uint(DASHED_COLOR);
         updateLineStyle(_loc1_,HAIRLINE_THICKNESS,_loc2_);
         drawNotch(_loc1_,true,true);
         drawNotch(_loc1_,false,true);
         updateLineStyle(_loc1_,HAIRLINE_THICKNESS,_loc3_);
         drawNotch(_loc1_,true,false);
         drawNotch(_loc1_,false,false);
      }
   }
}
