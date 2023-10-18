package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.BlendMode;
   import flash.display.CapsStyle;
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.display.Shape;
   import net.wg.data.constants.generated.DUAL_GUN_MARKER_STATE;
   import net.wg.gui.utils.GraphicsUtilities;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerMixingDualGun extends SimpleContainer
   {
      
      protected static const RADIUS:int = 256;
      
      protected static const ACTIVE_COLOR:uint = 16771755;
      
      protected static const DASHED_COLOR:uint = 16745484;
      
      protected static const HAIRLINE_COLOR:uint = 16745484;
      
      protected static const CIRCLE_HALF_LENGTH_RAD:Number = Math.PI;
      
      protected static const MARKER_CENTER_ANGLE:Number = Math.PI * 3 / 2;
      
      protected static const HAIRLINE_THICKNESS:uint = 1;
      
      private static const MIN_CHARGE_LINE_THICKNESS:uint = 3;
      
      private static const MAX_CHARGE_LINE_THICKNESS:uint = 4;
      
      private static const TOTAL_DASHES_PER_HALF:uint = 6;
      
      private static const DASH_SPACING_RATIO:uint = 1;
      
      private static const DASH_LENGTH:Number = DASH_SPACING_RATIO * CIRCLE_HALF_LENGTH_RAD / (TOTAL_DASHES_PER_HALF * (DASH_SPACING_RATIO + 1) - 1);
      
      private static const DASH_SPACING_LENGTH:Number = DASH_LENGTH / DASH_SPACING_RATIO;
      
      private static const INVALID_CHARGE_PROGRESS:String = "invalidChargeProgress";
      
      private static const SCALE_BREAK_POINT:Number = 0.2;
      
      private static const DIRECTION_RIGHT:int = 1;
      
      private static const DIRECTION_LEFT:int = -1;
       
      
      protected var hairlineGraphics:Graphics;
      
      protected var chargeGraphics:Graphics;
      
      protected var markerState:int;
      
      private var _charge:Number;
      
      public function GunMarkerMixingDualGun()
      {
         super();
      }
      
      protected static function updateLineStyle(param1:Graphics, param2:Number, param3:uint) : void
      {
         param1.lineStyle(param2,param3,1,false,LineScaleMode.NONE,CapsStyle.NONE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Shape = new Shape();
         var _loc2_:Shape = new Shape();
         this.hairlineGraphics = _loc1_.graphics;
         this.chargeGraphics = _loc2_.graphics;
         addChild(_loc1_);
         addChild(_loc2_);
         blendMode = BlendMode.SCREEN;
      }
      
      override protected function onDispose() : void
      {
         while(numChildren)
         {
            removeChildAt(0);
         }
         this.hairlineGraphics = null;
         this.chargeGraphics = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(INVALID_CHARGE_PROGRESS))
         {
            _loc1_ = scaleX < SCALE_BREAK_POINT ? int(MIN_CHARGE_LINE_THICKNESS) : int(MAX_CHARGE_LINE_THICKNESS);
            _loc2_ = RADIUS + (HAIRLINE_THICKNESS >> 1);
            _loc3_ = RADIUS + (_loc1_ >> 1);
            this.hairlineGraphics.clear();
            this.chargeGraphics.clear();
            this.drawMarker(_loc1_,_loc3_,_loc2_);
         }
      }
      
      public function setChargeProgress(param1:Number) : void
      {
         if(this._charge == param1)
         {
            return;
         }
         this._charge = param1;
         invalidate(INVALID_CHARGE_PROGRESS);
      }
      
      public function updateMakerState(param1:int) : void
      {
         if(this.markerState != param1)
         {
            this.markerState = param1;
            invalidate(INVALID_CHARGE_PROGRESS);
         }
      }
      
      protected function isLeftHalfActive() : Boolean
      {
         return this.markerState != DUAL_GUN_MARKER_STATE.DIMMED;
      }
      
      protected function isRightHalfActive() : Boolean
      {
         return this.markerState != DUAL_GUN_MARKER_STATE.DIMMED;
      }
      
      protected function getDashedGap() : Number
      {
         return DASH_SPACING_LENGTH;
      }
      
      protected function getSolidGap() : Number
      {
         return 0;
      }
      
      protected function drawMarker(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:Boolean = false;
         _loc4_ = this.isLeftHalfActive();
         var _loc5_:Boolean = this.isRightHalfActive();
         var _loc6_:uint = !!_loc4_ ? uint(ACTIVE_COLOR) : uint(DASHED_COLOR);
         var _loc7_:uint = !!_loc5_ ? uint(ACTIVE_COLOR) : uint(DASHED_COLOR);
         updateLineStyle(this.hairlineGraphics,HAIRLINE_THICKNESS,HAIRLINE_COLOR);
         updateLineStyle(this.chargeGraphics,param1,_loc6_);
         this.drawArc(this.hairlineGraphics,CIRCLE_HALF_LENGTH_RAD,_loc4_,param3,DIRECTION_LEFT);
         this.drawArc(this.chargeGraphics,this._charge * CIRCLE_HALF_LENGTH_RAD,_loc4_,param2,DIRECTION_LEFT);
         updateLineStyle(this.chargeGraphics,param1,_loc7_);
         this.drawArc(this.hairlineGraphics,CIRCLE_HALF_LENGTH_RAD,_loc5_,param3,DIRECTION_RIGHT);
         this.drawArc(this.chargeGraphics,this._charge * CIRCLE_HALF_LENGTH_RAD,_loc5_,param2,DIRECTION_RIGHT);
      }
      
      private function drawArc(param1:Graphics, param2:Number, param3:Boolean, param4:Number, param5:int) : void
      {
         var _loc8_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc6_:Number = !!param3 ? Number(this.getSolidGap()) : Number(this.getDashedGap());
         var _loc7_:Number = MARKER_CENTER_ANGLE + param5 * _loc6_ / 2;
         _loc8_ = 1 - _loc6_ / CIRCLE_HALF_LENGTH_RAD;
         var _loc9_:Number = param5 * param2 * _loc8_;
         if(param3)
         {
            GraphicsUtilities.drawArc(param1,0,0,_loc7_,_loc9_,param4);
         }
         else
         {
            _loc10_ = _loc8_ * DASH_LENGTH;
            _loc11_ = _loc8_ * DASH_SPACING_LENGTH;
            GraphicsUtilities.drawDashedArc(param1,0,0,_loc7_,_loc9_,param4,_loc10_,_loc11_);
         }
      }
   }
}
