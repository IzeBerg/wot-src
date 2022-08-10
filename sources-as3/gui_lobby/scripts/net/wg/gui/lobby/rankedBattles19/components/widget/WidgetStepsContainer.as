package net.wg.gui.lobby.rankedBattles19.components.widget
{
   import fl.motion.easing.Cubic;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.lobby.rankedBattles19.components.StepsContainer;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IStepArrow;
   import net.wg.gui.lobby.rankedBattles19.events.StepEvent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class WidgetStepsContainer extends StepsContainer
   {
      
      private static const INFO_TF_START_WIDTH:int = 200;
      
      private static const INFO_Y_OFFSET:int = 35;
      
      private static const INFO_HSHIFT:int = 20;
      
      private static const INFO_VSHIFT:int = 40;
      
      private static const TWEEN_TIMER:int = 500;
       
      
      public var infoMc:MovieClip = null;
      
      private var _infoTF:TextField = null;
      
      private var _showTween:Tween = null;
      
      private var _hideTween:Tween = null;
      
      private var _isOneByOneAnimType:Boolean = false;
      
      private var _infoX:int = 0;
      
      private var _infoY:int = 0;
      
      public function WidgetStepsContainer()
      {
         super();
      }
      
      override public function runStepsShineAnimation() : void
      {
         if(StringUtils.isNotEmpty(model.infoText))
         {
            this.infoMc.x = this._infoX - INFO_HSHIFT;
            this.infoMc.y = this._infoY - INFO_VSHIFT;
            this.infoMc.alpha = 0;
            this.infoMc.visible = true;
            this.clearHideTween();
            this._showTween = new Tween(TWEEN_TIMER,this.infoMc,{
               "alpha":1,
               "x":this._infoX,
               "y":this._infoY
            },{
               "ease":Cubic.easeOut,
               "paused":false
            });
         }
         super.runStepsShineAnimation();
      }
      
      override protected function runStepsAnim() : void
      {
         var _loc2_:IStepArrow = null;
         var _loc1_:String = Values.EMPTY_STR;
         if(this._isOneByOneAnimType)
         {
            _loc2_ = steps[stepIdxForAnim];
            _loc2_.runAnimation();
            _loc1_ = _loc2_.state;
         }
         else
         {
            super.runStepsAnim();
            _loc1_ = getStepsState();
         }
         if(RANKEDBATTLES_ALIASES.STEP_NOT_ANIMATED_STATES.indexOf(_loc1_) == Values.DEFAULT_INT)
         {
            dispatchEvent(new StepEvent(StepEvent.STEP_ANIM_IN_PROGRESS,_loc1_));
         }
      }
      
      override protected function stepReadyHandler() : void
      {
         var _loc1_:IStepArrow = null;
         var _loc2_:String = null;
         if(this._isOneByOneAnimType && stepIdxForAnim < steps.length)
         {
            _loc1_ = steps[stepIdxForAnim];
            _loc1_.runAnimation();
            _loc2_ = _loc1_.state;
            if(RANKEDBATTLES_ALIASES.STEP_NOT_ANIMATED_STATES.indexOf(_loc2_) == Values.DEFAULT_INT)
            {
               dispatchEvent(new StepEvent(StepEvent.STEP_ANIM_IN_PROGRESS,_loc2_));
            }
         }
         else
         {
            super.stepReadyHandler();
         }
      }
      
      override protected function allStepsReady() : void
      {
         if(StringUtils.isNotEmpty(model.infoText))
         {
            this.clearShowTween();
            this._hideTween = new Tween(TWEEN_TIMER,this.infoMc,{"alpha":0},{
               "ease":Cubic.easeOut,
               "paused":false,
               "onComplete":this.onHideHandler
            });
         }
         super.allStepsReady();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._infoTF = this.infoMc.infoTF;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(model != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.infoMc.visible = false;
               if(StringUtils.isNotEmpty(model.infoText))
               {
                  this._infoTF.width = INFO_TF_START_WIDTH;
                  this._infoTF.htmlText = model.infoText;
                  App.utils.commons.updateTextFieldSize(this._infoTF);
               }
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(StringUtils.isNotEmpty(model.infoText))
               {
                  this._infoX = width - this.infoMc.width >> 1;
                  this._infoY = this.infoMc.y = hit.y - this.infoMc.height + INFO_Y_OFFSET | 0;
                  this.infoMc.x = this._infoX;
                  this.infoMc.y = this._infoY;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearShowTween();
         this.clearHideTween();
         this.infoMc = null;
         this._infoTF = null;
         super.onDispose();
      }
      
      private function clearShowTween() : void
      {
         if(this._showTween)
         {
            this._showTween.paused = true;
            this._showTween.dispose();
            this._showTween = null;
         }
      }
      
      private function clearHideTween() : void
      {
         if(this._hideTween)
         {
            this._hideTween.paused = true;
            this._hideTween.dispose();
            this._hideTween = null;
         }
      }
      
      private function onHideHandler() : void
      {
         this.infoMc.visible = false;
      }
      
      public function set isOneByOneAnimType(param1:Boolean) : void
      {
         this._isOneByOneAnimType = param1;
      }
   }
}
