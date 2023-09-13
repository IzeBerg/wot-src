package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.Shape;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerMixingSolid extends SimpleContainer implements IGunMarkerMixing
   {
      
      private static const GREEN_COLOR:int = 9305906;
      
      private static const RED_COLOR:int = 16711680;
      
      private static const LINE_NO_SCALE:String = "none";
      
      private static const DEFAULT_ANGLE_STEP:Number = Math.PI / 4;
      
      private static const DEFAULT_PERCENT_STEP:Number = 12.5;
      
      private static const RADIUS:int = 256;
      
      private static const CIRCLE_ALPHA:int = 1;
      
      private static const PERCENTS_TO_ANGLE_COEF:Number = Math.PI * 0.02;
      
      private static const PI8:Number = Math.PI * 0.125;
      
      private static const PI2:Number = Math.PI * 0.5;
      
      private static const STANDARD_DISTANCE:Number = RADIUS / Math.sin(3 * PI8);
      
      private static const DEFAULT_ROTATION_ANGLE:Number = -90;
      
      private static const ANGLE_DELTA_MULTIPLIER:Number = 0.5;
       
      
      private var _curPercents:Number;
      
      private var _thickness:int = 1;
      
      private var _defaultStepsPoints:Vector.<GunMarkerMixingStepPoints> = null;
      
      private var _circleShape:Shape = null;
      
      public function GunMarkerMixingSolid()
      {
         super();
         this._circleShape = new Shape();
         addChild(this._circleShape);
         this._defaultStepsPoints = new Vector.<GunMarkerMixingStepPoints>();
         var _loc1_:Number = DEFAULT_ANGLE_STEP;
         var _loc2_:Number = 2 * Math.PI;
         while(_loc1_ <= _loc2_)
         {
            this._defaultStepsPoints.push(new GunMarkerMixingStepPoints(STANDARD_DISTANCE * Math.cos(_loc1_ - PI8),STANDARD_DISTANCE * Math.sin(_loc1_ - PI8),RADIUS * Math.cos(_loc1_),RADIUS * Math.sin(_loc1_)));
            _loc1_ += DEFAULT_ANGLE_STEP;
         }
         rotation = DEFAULT_ROTATION_ANGLE;
         this.setReloadingAsPercent(100);
      }
      
      public function setReloadingState(param1:String) : void
      {
      }
      
      public function setReloadingAsPercent(param1:Number, param2:Boolean = false) : void
      {
         if(this._curPercents != param1 || param2)
         {
            this._curPercents = param1;
            this._circleShape.graphics.clear();
            this.drawCircle(RED_COLOR,CIRCLE_ALPHA,this._curPercents,100);
            this.drawCircle(GREEN_COLOR,CIRCLE_ALPHA,0,this._curPercents);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._defaultStepsPoints)
         {
            this._defaultStepsPoints.splice(0,this._defaultStepsPoints.length);
            this._defaultStepsPoints = null;
         }
         this._circleShape = null;
         super.onDispose();
      }
      
      private function drawCircle(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc12_:GunMarkerMixingStepPoints = null;
         if(this._defaultStepsPoints != null)
         {
            if(param3 >= 1)
            {
               return;
            }
            this._circleShape.graphics.lineStyle(this._thickness,param1,param2,false,LINE_NO_SCALE);
            this._circleShape.graphics.moveTo(RADIUS,0);
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = param3 < 1 ? Number(PERCENTS_TO_ANGLE_COEF * param3 * 100) : Number(0);
            _loc8_ = param4 < 1 ? Number(PERCENTS_TO_ANGLE_COEF * param4 * 100) : Number(PERCENTS_TO_ANGLE_COEF * 100);
            _loc9_ = _loc7_ > 0 ? Number(_loc7_) : Number(0);
            _loc10_ = _loc7_ > 0;
            _loc11_ = param4 % DEFAULT_PERCENT_STEP == 0;
            if(_loc10_)
            {
               this._circleShape.graphics.moveTo(RADIUS * Math.cos(_loc7_),RADIUS * Math.sin(_loc7_));
               _loc9_ = DEFAULT_ANGLE_STEP * (1 + _loc9_ / DEFAULT_ANGLE_STEP ^ 0);
               _loc5_ = (_loc9_ - _loc7_) * ANGLE_DELTA_MULTIPLIER;
               _loc6_ = RADIUS / Math.sin(PI2 - _loc5_);
               this._circleShape.graphics.curveTo(_loc6_ * Math.cos(_loc9_ - _loc5_),_loc6_ * Math.sin(_loc9_ - _loc5_),RADIUS * Math.cos(_loc9_),RADIUS * Math.sin(_loc9_));
            }
            _loc9_ += DEFAULT_ANGLE_STEP;
            _loc5_ = PI8;
            _loc6_ = STANDARD_DISTANCE;
            while(_loc9_ <= _loc8_)
            {
               _loc12_ = this._defaultStepsPoints[_loc9_ / DEFAULT_ANGLE_STEP - 1];
               this._circleShape.graphics.curveTo(_loc12_.step0,_loc12_.step1,_loc12_.step2,_loc12_.step3);
               _loc9_ += DEFAULT_ANGLE_STEP;
            }
            if(!_loc11_)
            {
               _loc5_ = _loc8_ % DEFAULT_ANGLE_STEP * ANGLE_DELTA_MULTIPLIER;
               _loc6_ = RADIUS / Math.sin(PI2 - _loc5_);
               this._circleShape.graphics.curveTo(_loc6_ * Math.cos(_loc8_ - _loc5_),_loc6_ * Math.sin(_loc8_ - _loc5_),RADIUS * Math.cos(_loc8_),RADIUS * Math.sin(_loc8_));
            }
         }
      }
      
      public function set thickness(param1:int) : void
      {
         this._thickness = param1;
         this.setReloadingAsPercent(this._curPercents,true);
      }
   }
}
