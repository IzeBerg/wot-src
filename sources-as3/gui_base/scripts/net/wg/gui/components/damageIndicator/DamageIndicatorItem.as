package net.wg.gui.components.damageIndicator
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DamageIndicatorItem extends Sprite implements IDisposable
   {
      
      private static const SHOW_WITHOUT_ANIMATION_FRAME:int = 12;
      
      private static const START_FRAME:int = 1;
      
      private static const FRAME_OFFSET:int = 2;
      
      private static const DEGREE_180:int = 180;
       
      
      public var standardAnimation:AnimationContainer = null;
      
      public var extendedAnimation:AnimationContainer = null;
      
      private var _isStandard:Boolean = false;
      
      private var _standardStateContainer:StandardStateContainer = null;
      
      private var _extendedStateContainer:ExtendedStateContainer = null;
      
      private var _settingIsWithAnimation:Boolean = true;
      
      private var _yawDegrees:Number = 0;
      
      private var _rotateInfo:Boolean = false;
      
      public function DamageIndicatorItem()
      {
         super();
         visible = false;
         this._standardStateContainer = this.standardAnimation.stateContainer;
         this._extendedStateContainer = ExtendedStateContainer(this.extendedAnimation.stateContainer);
         this._extendedStateContainer.addFrameScript(this._extendedStateContainer.totalFrames - FRAME_OFFSET,this.onAnimFinished);
         this.extendedAnimation.visible = false;
      }
      
      public final function dispose() : void
      {
         this._standardStateContainer = null;
         this._extendedStateContainer = null;
         this.standardAnimation.dispose();
         this.standardAnimation = null;
         this.extendedAnimation.dispose();
         this.extendedAnimation = null;
      }
      
      public function hide() : void
      {
         visible = false;
         if(!this._isStandard)
         {
            this.extendedAnimation.gotoAndStop(START_FRAME);
         }
      }
      
      public function init() : void
      {
         this._standardStateContainer.init();
         this._extendedStateContainer.init();
      }
      
      public function setYOffset(param1:Number) : void
      {
         this.standardAnimation.stateContainer.setYOffset(param1);
         this.extendedAnimation.stateContainer.setYOffset(param1);
      }
      
      public function setYaw(param1:Number) : void
      {
         this._yawDegrees = param1 * DEGREE_180 / Math.PI;
         if(this._isStandard)
         {
            this.standardAnimation.rotation = this._yawDegrees;
         }
         else
         {
            this.extendedAnimation.rotation = this._yawDegrees;
            if(this._rotateInfo)
            {
               this.extendedAnimation.rotateInfo(this._yawDegrees);
            }
         }
      }
      
      public function showExtended(param1:String, param2:String, param3:int, param4:String, param5:String, param6:String, param7:Boolean, param8:String) : void
      {
         visible = true;
         this.extendedAnimation.visible = true;
         if(!this._settingIsWithAnimation)
         {
            this.extendedAnimation.gotoAndStop(SHOW_WITHOUT_ANIMATION_FRAME);
         }
         else
         {
            this.extendedAnimation.gotoAndPlay(param3);
         }
         this._extendedStateContainer.setExtendedData(param1,param2,param4,param5,param6,param7,param8);
      }
      
      public function showSettingExtended(param1:String, param2:String, param3:String, param4:String, param5:String, param6:Boolean) : void
      {
         visible = true;
         this.extendedAnimation.visible = true;
         this.extendedAnimation.gotoAndStop(SHOW_WITHOUT_ANIMATION_FRAME);
         this._extendedStateContainer.setExtendedData(param1,param2,param3,param4,param5,param6,"",false);
      }
      
      public function showSettingStandard(param1:String) : void
      {
         visible = true;
         this.standardAnimation.visible = true;
         this.standardAnimation.gotoAndStop(SHOW_WITHOUT_ANIMATION_FRAME);
         this._standardStateContainer.updateBGState(param1);
      }
      
      public function showStandard(param1:String, param2:int) : void
      {
         visible = true;
         this.standardAnimation.visible = true;
         this.standardAnimation.gotoAndPlay(param2);
         this._standardStateContainer.updateBGState(param1);
      }
      
      public function updateSettings(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this._settingIsWithAnimation = param3;
         if(this._isStandard == param1)
         {
            this.standardAnimation.rotation = this._yawDegrees;
         }
         else
         {
            this.extendedAnimation.rotation = this._yawDegrees;
            if(this._rotateInfo)
            {
               this.extendedAnimation.rotateInfo(this._yawDegrees);
            }
            this._isStandard = param1;
            this.standardAnimation.visible = this._isStandard;
            this.extendedAnimation.visible = !this._isStandard;
         }
         this._extendedStateContainer.updateSettings(param2,param4);
      }
      
      private function onAnimFinished() : void
      {
         this.extendedAnimation.visible = false;
      }
      
      public function set rotateInfo(param1:Boolean) : void
      {
         this._rotateInfo = param1;
      }
   }
}
