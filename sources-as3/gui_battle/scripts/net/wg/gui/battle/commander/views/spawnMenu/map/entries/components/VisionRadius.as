package net.wg.gui.battle.commander.views.spawnMenu.map.entries.components
{
   import flash.display.BlendMode;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class VisionRadius extends BattleUIComponent
   {
      
      private static const _RADIUS_THICKNESS:Number = 1;
      
      private static const _RADIUS_SHADOW_ALPHA:Number = 0.7;
      
      private static const _RADIUS_SHADOW_COLOR:Number = 0;
      
      private static const _RADIUS_SHADOW_THICKNESS:uint = 2;
      
      private static const _RADIUS_INITIAL_ALPHA:Number = 1;
      
      private static const _RADIUS_SELECTED_ALPHA:Number = 0.8;
      
      private static const _RADIUS_HOVERED_ALPHA:Number = 0.8;
      
      private static const _RADIUS_DEFAULT_ALPHA:Number = 0;
      
      private static const _VISION_RADIUS_COLOR:Number = 712199;
      
      private static const _ENGAGEMENT_RADIUS_COLOR:Number = 16776960;
       
      
      private var _visionRadius:int;
      
      private var _engagementRadius:int;
      
      private var _scale:Number;
      
      private var _useConeRadius:Boolean = false;
      
      private var _leftAngle:Number = 0;
      
      private var _rightAngle:Number = 90;
      
      private var _visionCircle:VisionRadiusCircle = null;
      
      private var _visionCircleShadow:VisionRadiusCircle = null;
      
      private var _engagementCircle:VisionRadiusCircle = null;
      
      private var _engagementCone:VisionRadiusCone = null;
      
      public function VisionRadius()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._visionCircleShadow = new VisionRadiusCircle(this,_RADIUS_SHADOW_THICKNESS,_RADIUS_SHADOW_COLOR,_RADIUS_SHADOW_ALPHA);
         this._visionCircle = new VisionRadiusCircle(this,_RADIUS_THICKNESS,_VISION_RADIUS_COLOR,_RADIUS_INITIAL_ALPHA);
         this._engagementCircle = new VisionRadiusCircle(this,_RADIUS_THICKNESS,_ENGAGEMENT_RADIUS_COLOR,_RADIUS_INITIAL_ALPHA);
         this._engagementCone = new VisionRadiusCone(this,_RADIUS_THICKNESS,_ENGAGEMENT_RADIUS_COLOR,_RADIUS_INITIAL_ALPHA);
         blendMode = BlendMode.ADD;
      }
      
      override protected function onDispose() : void
      {
         this._visionCircle.dispose();
         this._visionCircleShadow.dispose();
         this._engagementCircle.dispose();
         this._engagementCone.dispose();
         this._visionCircle = null;
         this._visionCircleShadow = null;
         this._engagementCircle = null;
         this._engagementCone = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._visionRadius > 0;
            _loc2_ = this._engagementRadius > 0;
            if(_loc1_)
            {
               _loc3_ = this._visionRadius * this._scale;
               this._visionCircleShadow.drawCircle(_loc3_);
               this._visionCircle.drawCircle(_loc3_);
            }
            this._engagementCone.hide();
            this._engagementCircle.hide();
            if(_loc2_)
            {
               _loc4_ = this._engagementRadius * this._scale;
               if(this._useConeRadius)
               {
                  this._engagementCone.drawCone(_loc4_,this._leftAngle,this._rightAngle);
               }
               else
               {
                  this._engagementCircle.drawCircle(_loc4_);
               }
            }
            visible = _loc1_ || _loc2_;
         }
      }
      
      public function setConeAngles(param1:Number, param2:Number) : void
      {
         if(this._leftAngle != param1)
         {
            this._leftAngle = param1;
            invalidateData();
         }
         if(this._rightAngle != param2)
         {
            this._rightAngle = param2;
            invalidateData();
         }
      }
      
      public function setUseConeRadius(param1:Boolean) : void
      {
         if(this._useConeRadius != param1)
         {
            this._useConeRadius = param1;
            invalidateData();
         }
      }
      
      public function setRadius(param1:Number, param2:Number) : void
      {
         if(param1 != this._visionRadius || param2 != this._engagementRadius)
         {
            this._engagementRadius = param2;
            this._visionRadius = param1;
            invalidateData();
         }
      }
      
      public function setScale(param1:Number) : void
      {
         if(param1 != this._scale)
         {
            this._scale = param1;
            invalidateData();
         }
      }
      
      public function setState(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            alpha = _RADIUS_SELECTED_ALPHA;
         }
         else if(param1)
         {
            alpha = _RADIUS_HOVERED_ALPHA;
         }
         else
         {
            alpha = _RADIUS_DEFAULT_ALPHA;
         }
      }
   }
}
