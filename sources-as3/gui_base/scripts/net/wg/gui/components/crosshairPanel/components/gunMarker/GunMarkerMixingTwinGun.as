package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.BitmapData;
   import flash.display.CapsStyle;
   import flash.display.LineScaleMode;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.utils.getDefinitionByName;
   import net.wg.data.constants.generated.DUAL_GUN_MARKER_STATE;
   import net.wg.gui.utils.GraphicsUtilities;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerMixingTwinGun extends SimpleContainer
   {
      
      private static const RADIUS:uint = 256;
      
      private static const RELOAD_COLOR:uint = 520967;
      
      private static const HAIRLINE_COLOR:uint = 15665160;
      
      private static const ARC_ANGLE:Number = Math.PI / 3;
      
      private static const HAIRLINE_START_ANGLE:Number = Math.PI / 2;
      
      private static const RELOAD_START_ANGLE:Number = HAIRLINE_START_ANGLE + Math.PI;
      
      private static const DIRECTION_CLOCKWISE:int = -1;
      
      private static const DIRECTION_COUNTERCLOCKWISE:int = 1;
      
      private static const NOTCH_ANGLE_HUGE:Number = Math.PI / 90;
      
      private static const NOTCH_ANGLE_LARGE:Number = Math.PI / 135;
      
      private static const NOTCH_ANGLE_MEDIUM:Number = Math.PI / 180;
      
      private static const NOTCH_ANGLE_SMALL:Number = Math.PI / 270;
      
      private static const NOTCH_ANGLE_TINY:Number = Math.PI / 360;
      
      private static const NOTCH_LENGTH_HUGE:uint = 38;
      
      private static const NOTCH_LENGTH_LARGE:uint = 28;
      
      private static const NOTCH_LENGTH_MEDIUM:uint = 20;
      
      private static const NOTCH_LENGTH_SMALL:uint = 14;
      
      private static const NOTCH_LENGTH_TINY:uint = 12;
      
      private static const ARC_THICKNESS_SMALL:uint = 2;
      
      private static const ARC_THICKNESS_LARGE:uint = 3;
      
      private static const DASH_ANGLE_SMALL:Number = Math.PI / 34;
      
      private static const DASH_ANGLE_LARGE:Number = Math.PI / 50;
      
      private static const DASH_GRADATION_SMALL:uint = 4;
      
      private static const DASH_GRADATION_LARGE:uint = 6;
      
      private static const RELOAD_PROGRESS_MAX:Number = 1;
      
      private static const GLOW_RADIUS:uint = 350;
      
      private static const RENDER_AREA_SIZE:uint = 700;
      
      private static const ZOOM_FACTOR_BREAKPOINT_SMALL:Number = 2;
      
      private static const ZOOM_FACTOR_BREAKPOINT_MEDIUM:Number = 8;
      
      private static const ZOOM_FACTOR_BREAKPOINT_LARGE:Number = 16;
      
      private static const ZOOM_FACTOR_BREAKPOINT_HUGE:Number = 25;
      
      private static const GLOW_ARCADE_BITMAP_LINKAGE:String = "TwinGunGlowArcadeUI";
      
      private static const GLOW_SNIPER_BITMAP_LINKAGE:String = "TwinGunGlowSniperUI";
      
      private static const MARKER_DRAW_INVALID:String = "invalidMarker";
       
      
      private var _markerState:uint = 3;
      
      private var _reloadProgress:Number = 0;
      
      private var _zoomFactor:Number = 1.0;
      
      private var _glowMatrix:Matrix = null;
      
      private var _glowArcadeBD:BitmapData = null;
      
      private var _glowSniperBD:BitmapData = null;
      
      public function GunMarkerMixingTwinGun()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:Class = getDefinitionByName(GLOW_ARCADE_BITMAP_LINKAGE) as Class;
         this._glowArcadeBD = new _loc1_();
         _loc1_ = getDefinitionByName(GLOW_SNIPER_BITMAP_LINKAGE) as Class;
         this._glowSniperBD = new _loc1_();
         this._glowMatrix = new Matrix();
         this._glowMatrix.translate(-GLOW_RADIUS,-GLOW_RADIUS);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(MARKER_DRAW_INVALID))
         {
            graphics.clear();
            this.drawMarker();
         }
      }
      
      override public function validateNow(param1:Event = null) : void
      {
         if(!visible)
         {
            return;
         }
         super.validateNow(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this._glowArcadeBD != null)
         {
            this._glowArcadeBD.dispose();
            this._glowArcadeBD = null;
         }
         if(this._glowSniperBD != null)
         {
            this._glowSniperBD.dispose();
            this._glowSniperBD = null;
         }
         this._glowMatrix = null;
         super.onDispose();
      }
      
      override public function set alpha(param1:Number) : void
      {
         super.alpha = param1;
         this.cacheAsBitmap = param1 < 1 && param1 > 0;
      }
      
      public function set reloadProgress(param1:Number) : void
      {
         param1 = Math.min(param1,RELOAD_PROGRESS_MAX);
         if(param1 == this._reloadProgress)
         {
            return;
         }
         this._reloadProgress = param1;
         invalidate(MARKER_DRAW_INVALID);
      }
      
      public function set zoomFactor(param1:Number) : void
      {
         if(param1 == this._zoomFactor)
         {
            return;
         }
         this._zoomFactor = param1;
         invalidate(MARKER_DRAW_INVALID);
      }
      
      public function set markerState(param1:uint) : void
      {
         if(param1 == this._markerState)
         {
            return;
         }
         this._markerState = param1;
         invalidate(MARKER_DRAW_INVALID);
      }
      
      private function drawMarker() : void
      {
         this.drawRenderArea();
         var _loc1_:Number = 1 - this._reloadProgress;
         if(_loc1_ > 0)
         {
            graphics.lineStyle(this.arcThickness,HAIRLINE_COLOR,1,false,LineScaleMode.NONE,CapsStyle.NONE);
            this.drawArc(HAIRLINE_START_ANGLE,DIRECTION_COUNTERCLOCKWISE,_loc1_,this.isLeftGunActive);
            this.drawArc(HAIRLINE_START_ANGLE,DIRECTION_CLOCKWISE,_loc1_,this.isRightGunActive);
            graphics.lineStyle(0,HAIRLINE_COLOR,1,false,LineScaleMode.NONE,CapsStyle.NONE);
            graphics.beginFill(HAIRLINE_COLOR);
            this.drawNotches(HAIRLINE_START_ANGLE,DIRECTION_COUNTERCLOCKWISE,_loc1_);
            this.drawNotches(HAIRLINE_START_ANGLE,DIRECTION_CLOCKWISE,_loc1_);
            graphics.endFill();
         }
         if(this._reloadProgress > 0)
         {
            if(this._reloadProgress == RELOAD_PROGRESS_MAX)
            {
               if(this.isLeftGunActive)
               {
                  this.drawGlow(RELOAD_START_ANGLE,DIRECTION_CLOCKWISE);
               }
               if(this.isRightGunActive)
               {
                  this.drawGlow(RELOAD_START_ANGLE,DIRECTION_COUNTERCLOCKWISE);
               }
            }
            graphics.lineStyle(this.arcThickness,RELOAD_COLOR,1,false,LineScaleMode.NONE,CapsStyle.NONE);
            this.drawArc(RELOAD_START_ANGLE,DIRECTION_CLOCKWISE,this._reloadProgress,this.isLeftGunActive);
            this.drawArc(RELOAD_START_ANGLE,DIRECTION_COUNTERCLOCKWISE,this._reloadProgress,this.isRightGunActive);
            graphics.lineStyle(0,RELOAD_COLOR,1,false,LineScaleMode.NONE,CapsStyle.NONE);
            graphics.beginFill(RELOAD_COLOR);
            this.drawNotches(RELOAD_START_ANGLE,DIRECTION_CLOCKWISE,this._reloadProgress);
            this.drawNotches(RELOAD_START_ANGLE,DIRECTION_COUNTERCLOCKWISE,this._reloadProgress);
            graphics.endFill();
         }
      }
      
      private function drawArc(param1:Number, param2:int, param3:Number, param4:Boolean) : void
      {
         var _loc7_:Number = NaN;
         var _loc5_:Number = param1 + param2 * (Math.PI - ARC_ANGLE) / 2;
         var _loc6_:Number = param2 * param3 * ARC_ANGLE;
         if(param4)
         {
            GraphicsUtilities.drawArc(graphics,0,0,_loc5_,_loc6_,RADIUS);
         }
         else
         {
            _loc7_ = (ARC_ANGLE - this.dashAngle * (this.dashGradation + 1)) / this.dashGradation;
            GraphicsUtilities.drawDashedArc(graphics,0,0,_loc5_,_loc6_,RADIUS,this.dashAngle,_loc7_);
         }
      }
      
      private function drawNotches(param1:Number, param2:int, param3:Number) : void
      {
         var _loc4_:Number = param1 + param2 * (Math.PI - ARC_ANGLE) / 2;
         this.drawNotch(_loc4_,param2);
         if(param3 == RELOAD_PROGRESS_MAX)
         {
            _loc4_ += param2 * ARC_ANGLE;
            this.drawNotch(_loc4_,-param2);
         }
      }
      
      private function drawNotch(param1:Number, param2:int) : void
      {
         var _loc3_:Number = RADIUS * Math.cos(param1);
         var _loc4_:Number = RADIUS * Math.sin(-param1);
         graphics.moveTo(_loc3_,_loc4_);
         _loc3_ += this.notchLength * Math.cos(param1);
         _loc4_ += this.notchLength * Math.sin(-param1);
         graphics.lineTo(_loc3_,_loc4_);
         param1 += this.notchAngle * param2 / 2;
         _loc3_ = (RADIUS + this.notchLength) * Math.cos(param1);
         _loc4_ = (RADIUS + this.notchLength) * Math.sin(-param1);
         graphics.lineTo(_loc3_,_loc4_);
         param1 += this.notchAngle * param2 / 2;
         _loc3_ = RADIUS * Math.cos(param1);
         _loc4_ = RADIUS * Math.sin(-param1);
         graphics.lineTo(_loc3_,_loc4_);
      }
      
      private function drawGlow(param1:Number, param2:int) : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = param1 + param2 * (Math.PI - ARC_ANGLE) / 2;
         var _loc4_:Number = GLOW_RADIUS * Math.cos(_loc3_);
         var _loc5_:Number = GLOW_RADIUS * Math.sin(-_loc3_);
         var _loc6_:Number = param2 * ARC_ANGLE;
         graphics.lineStyle();
         graphics.beginBitmapFill(this.glowBitmapData,this._glowMatrix,false,true);
         graphics.lineTo(_loc4_,_loc5_);
         GraphicsUtilities.drawArc(graphics,0,0,_loc3_,_loc6_,GLOW_RADIUS);
         graphics.lineTo(0,0);
         graphics.endFill();
      }
      
      private function drawRenderArea() : void
      {
         graphics.lineStyle();
         graphics.beginFill(0,0);
         graphics.drawRect(-RENDER_AREA_SIZE >> 1,-RENDER_AREA_SIZE >> 1,RENDER_AREA_SIZE,RENDER_AREA_SIZE);
         graphics.endFill();
      }
      
      private function get arcThickness() : uint
      {
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_MEDIUM)
         {
            return ARC_THICKNESS_SMALL;
         }
         return ARC_THICKNESS_LARGE;
      }
      
      private function get notchAngle() : Number
      {
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_SMALL)
         {
            return NOTCH_ANGLE_HUGE;
         }
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_MEDIUM)
         {
            return NOTCH_ANGLE_LARGE;
         }
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_LARGE)
         {
            return NOTCH_ANGLE_MEDIUM;
         }
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_HUGE)
         {
            return NOTCH_ANGLE_SMALL;
         }
         return NOTCH_ANGLE_TINY;
      }
      
      private function get notchLength() : uint
      {
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_SMALL)
         {
            return NOTCH_LENGTH_HUGE;
         }
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_MEDIUM)
         {
            return NOTCH_LENGTH_LARGE;
         }
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_LARGE)
         {
            return NOTCH_LENGTH_MEDIUM;
         }
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_HUGE)
         {
            return NOTCH_LENGTH_SMALL;
         }
         return NOTCH_LENGTH_TINY;
      }
      
      private function get dashAngle() : Number
      {
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_SMALL)
         {
            return DASH_ANGLE_SMALL;
         }
         return DASH_ANGLE_LARGE;
      }
      
      private function get dashGradation() : uint
      {
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_SMALL)
         {
            return DASH_GRADATION_SMALL;
         }
         return DASH_GRADATION_LARGE;
      }
      
      private function get glowBitmapData() : BitmapData
      {
         if(this._zoomFactor < ZOOM_FACTOR_BREAKPOINT_SMALL)
         {
            return this._glowArcadeBD;
         }
         return this._glowSniperBD;
      }
      
      private function get isLeftGunActive() : Boolean
      {
         return (this._markerState & DUAL_GUN_MARKER_STATE.LEFT_PART_ACTIVE) > 0;
      }
      
      private function get isRightGunActive() : Boolean
      {
         return (this._markerState & DUAL_GUN_MARKER_STATE.RIGHT_PART_ACTIVE) > 0;
      }
   }
}
