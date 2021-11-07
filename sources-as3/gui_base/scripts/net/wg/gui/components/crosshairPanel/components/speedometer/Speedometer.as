package net.wg.gui.components.crosshairPanel.components.speedometer
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class Speedometer extends SimpleContainer
   {
      
      private static const STATE_ON:String = "on";
      
      private static const STATE_OFF:String = "off";
      
      private static const MAX_SPEED:uint = 120;
      
      private static const START_BURN_FRAME:uint = 1;
      
      private static const FULL_BURNOUT_VALUE:uint = 1;
      
      private static const TEXTFIELD_PADDING:uint = 5;
      
      private static const MAX_ROTATION:uint = 270;
       
      
      public var wheelState:MovieClip = null;
      
      public var burnout:MovieClip = null;
      
      public var burnoutFlash:MovieClip = null;
      
      public var burnoutBlink:MovieClip = null;
      
      public var orangeLimit:MovieClip = null;
      
      public var redLimit:MovieClip = null;
      
      public var flash:MovieClip = null;
      
      public var speed:TextField = null;
      
      public var warning:TextField = null;
      
      public var warningIcon:Sprite = null;
      
      public var engineError:SpeedometerWarningAnim = null;
      
      private var _isBurnFlash:Boolean = false;
      
      private var _burnValue:Number = 0;
      
      private var _warningText:String = "";
      
      private var _engineErrorText:String = "";
      
      private var _warningColorTransform:ColorTransform;
      
      private var _burnoutMaxFrame:int;
      
      private var _frameCoef:Number;
      
      private var _rotationCoef:Number;
      
      public function Speedometer()
      {
         super();
         this._burnoutMaxFrame = this.burnout.totalFrames;
         this._frameCoef = totalFrames / MAX_SPEED;
         this._rotationCoef = MAX_ROTATION / totalFrames;
         this.warning.visible = this.warningIcon.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.burnoutBlink.stop();
         this.burnoutBlink.visible = false;
         this._warningColorTransform = new ColorTransform();
         this._warningColorTransform.redMultiplier = 1;
         this._warningColorTransform.greenMultiplier = 0;
         this._warningColorTransform.blueMultiplier = 0;
      }
      
      override protected function onDispose() : void
      {
         this.wheelState = null;
         this.speed = null;
         this.burnout = null;
         this.burnoutFlash = null;
         this.burnoutBlink = null;
         this.orangeLimit = null;
         this.redLimit = null;
         this.flash = null;
         this.engineError.dispose();
         this.engineError = null;
         this.warningIcon = null;
         this.warning = null;
         this._warningColorTransform = null;
         super.onDispose();
      }
      
      public function changeState(param1:Boolean) : void
      {
         if(param1)
         {
            this.wheelState.gotoAndStop(STATE_ON);
         }
         else
         {
            this.wheelState.gotoAndStop(STATE_OFF);
         }
      }
      
      public function setBurnout(param1:Number) : void
      {
         this.burnout.gotoAndStop(this._burnoutMaxFrame * param1);
         if(this._isBurnFlash && param1 < this._burnValue)
         {
            this.burnoutBlink.stop();
            this.burnoutBlink.visible = false;
            if(param1 != 0)
            {
               this.burnoutFlash.gotoAndPlay(START_BURN_FRAME);
            }
         }
         this._isBurnFlash = param1 >= FULL_BURNOUT_VALUE;
         if(this._isBurnFlash)
         {
            this.burnoutBlink.play();
            this.burnoutBlink.visible = true;
         }
         this._burnValue = param1;
      }
      
      public function setEngineCrushError(param1:String) : void
      {
         if(this._engineErrorText != param1)
         {
            this._engineErrorText = param1;
            this.engineError.setText(param1);
         }
         if(this.engineError.currentFrame == 1)
         {
            this.engineError.play();
         }
      }
      
      public function setMaxSpeedNormalMode(param1:int) : void
      {
         this.orangeLimit.gotoAndStop(this.getFrame(param1));
         this.orangeLimit.cacheAsBitmap = true;
      }
      
      public function setMaxSpeedSpeedMode(param1:int) : void
      {
         this.redLimit.visible = param1 > 0;
         if(!this.redLimit.visible)
         {
            return;
         }
         this.redLimit.gotoAndStop(this.getFrame(param1));
         this.redLimit.cacheAsBitmap = true;
      }
      
      public function setSpeed(param1:int) : void
      {
         this.speed.text = param1.toString();
         var _loc2_:int = this._frameCoef * param1;
         if(_loc2_ < 0)
         {
            _loc2_ *= -1;
         }
         this.flash.flashBg.rotation = -this._rotationCoef * _loc2_;
         gotoAndStop(_loc2_);
      }
      
      public function setWarning(param1:String) : void
      {
         var _loc2_:int = 0;
         if(this._warningText != param1)
         {
            _loc2_ = this.warning.x + this.warning.width;
            this._warningText = param1;
            this.warning.text = param1;
            this.warning.width = this.warning.textWidth + TEXTFIELD_PADDING | 0;
            this.warning.x = _loc2_ - this.warning.width;
         }
         this.warning.visible = this.warningIcon.visible = true;
         this.burnout.transform.colorTransform = this._warningColorTransform;
         this.burnoutBlink.transform.colorTransform = this._warningColorTransform;
         this.burnoutFlash.transform.colorTransform = this._warningColorTransform;
      }
      
      public function stopEngineCrushError() : void
      {
         this.engineError.gotoAndStop(0);
      }
      
      public function stopWarning() : void
      {
         this.warning.visible = this.warningIcon.visible = false;
         this.burnout.transform.colorTransform = null;
         this.burnoutBlink.transform.colorTransform = null;
         this.burnoutFlash.transform.colorTransform = null;
      }
      
      private function getFrame(param1:int) : int
      {
         return this._frameCoef * param1;
      }
   }
}
