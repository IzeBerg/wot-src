package net.wg.gui.components.crosshairPanel.components.artyScale
{
   import fl.motion.easing.Quadratic;
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.SimpleContainer;
   import scaleform.clik.motion.Tween;
   
   public class ArtyIndicationScale extends SimpleContainer
   {
      
      private static const FRAME_STATE_LBL:String = "state_";
       
      
      public var scaleBG:MovieClip;
      
      private var _currentFrameNumber:int = 0;
      
      private var _tweenProps:Object;
      
      private var _tween:Tween;
      
      private var _framesCount:int = 0;
      
      private var _curStepsCount:int = -1;
      
      private var _currentFinalPosition:int = 0;
      
      public function ArtyIndicationScale()
      {
         this._tweenProps = new TweenProps();
         this._tween = new Tween(500,this._tweenProps,{"position":TweenProps.TWEEN_END},{
            "paused":true,
            "onChange":this.onChange,
            "ease":Quadratic.easeOut
         });
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._framesCount = totalFrames;
         this._currentFinalPosition = totalFrames >> 1;
      }
      
      override protected function onDispose() : void
      {
         this.scaleBG = null;
         this._tweenProps = null;
         this._tween.dispose();
         this._tween = null;
         super.onDispose();
      }
      
      public function updateData(param1:Number) : void
      {
         var _loc2_:int = Math.round(this._framesCount * param1) + 1;
         if(this._currentFrameNumber != _loc2_)
         {
            this._currentFrameNumber = _loc2_;
            this._tweenProps.update(currentFrame,_loc2_);
            this._tween.reset();
            this._tween.paused = false;
            this._currentFinalPosition = _loc2_;
         }
      }
      
      public function updateSteps(param1:int) : void
      {
         var _loc2_:String = null;
         if(this._curStepsCount != param1)
         {
            this._curStepsCount = param1;
            if(this.scaleBG)
            {
               _loc2_ = FRAME_STATE_LBL + param1;
               this.scaleBG.gotoAndStop(_loc2_);
               if(this.scaleBG.currentFrameLabel != _loc2_)
               {
                  DebugUtils.LOG_ERROR("Invalid count of steps: ",param1);
                  this.scaleBG.gotoAndStop(1);
               }
               gotoAndStop(this._currentFinalPosition);
            }
         }
      }
      
      private function onChange(param1:Tween) : void
      {
         var _loc2_:int = this._tweenProps.startFrame + this._tweenProps.delta * this._tweenProps.position;
         if(currentFrame != _loc2_)
         {
            gotoAndStop(_loc2_);
         }
      }
   }
}

class TweenProps
{
   
   public static const TWEEN_END:Number = 1;
    
   
   public var position:Number = 0;
   
   public var startFrame:int = 0;
   
   public var currentFrame:int = 0;
   
   public var delta:int = 0;
   
   function TweenProps()
   {
      super();
   }
   
   public function update(param1:int, param2:int) : void
   {
      this.position = 0;
      this.startFrame = param1;
      this.currentFrame = param1;
      this.delta = param2 - param1;
   }
}
