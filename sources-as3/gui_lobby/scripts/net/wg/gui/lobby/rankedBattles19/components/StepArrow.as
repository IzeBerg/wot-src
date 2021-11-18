package net.wg.gui.lobby.rankedBattles19.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.lobby.rankedBattles19.components.interfaces.IStepArrow;
   import net.wg.gui.lobby.rankedBattles19.events.StepEvent;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IFramesHelper;
   
   public class StepArrow extends MovieClip implements IStepArrow
   {
      
      private static const TRANSPARENT_ALPHA:Number = 0.3;
      
      private static const STEP_SHINE_POSITIVE_LONG_LABEL:String = "positive_long";
      
      private static const STEP_SHINE_POSITIVE_LONG_END_LABEL:String = "positive_long_end";
      
      private static const STEP_SHINE_SHOW_STEP_LABEL:String = "show_step";
      
      private static const STEP_SHINE_POSITIVE_SHORT_LABEL:String = "positive_short";
      
      private static const STEP_SHINE_POSITIVE_SHORT_END_LABEL:String = "positive_short_end";
      
      private static const STEP_SHINE_SHOW_STEP_SHORT_LABEL:String = "show_step_short";
      
      private static const STEP_SHINE_NEGATIVE_LABEL:String = "negative";
      
      private static const STEP_SHINE_NEGATIVE_END_LABEL:String = "negative_end";
      
      private static const STEP_SHINE_NEGATIVE_SHORT_LABEL:String = "negative_short";
      
      private static const STEP_SHINE_NEGATIVE_SHORT_END_LABEL:String = "negative_short_end";
      
      private static const STEP_SHINE_BONUS_LONG_LABEL:String = "bonus_long";
      
      private static const STEP_SHINE_BONUS_LONG_END_LABEL:String = "bonus_long_end";
      
      private static const STEP_SHINE_SHOW_STEP_BONUS_LONG_LABEL:String = "show_step_bonus_long";
      
      private static const STEP_SHINE_BONUS_SHORT_LABEL:String = "bonus_short";
      
      private static const STEP_SHINE_BONUS_SHORT_END_LABEL:String = "bonus_short_end";
      
      private static const STEP_SHINE_SHOW_STEP_BONUS_SHORT_LABEL:String = "show_step_bonus_short";
      
      private static const STEP_NORMAL_NORMAL_LABEL:String = "normal";
      
      private static const STEP_NORMAL_POSITIVE_LABEL:String = "positive";
      
      private static const STEP_NORMAL_BONUS_LABEL:String = "bonus";
      
      private static const STEP_BLINK_POSITIVE_LABEL:String = "positive";
      
      private static const STEP_BLINK_NEGATIVE_LABEL:String = "negative";
      
      private static const STEP_BLINK_BONUS_LABEL:String = "bonus";
       
      
      public var stepBlink:MovieClip = null;
      
      public var stepNormal:MovieClip = null;
      
      public var stepShine:MovieClip = null;
      
      public var hit:Sprite = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _stepSize:String = "";
      
      private var _setAlphaFrameLabel:String = "";
      
      private var _state:String = "";
      
      private var _stepShineFrameHelper:IFramesHelper = null;
      
      private var _stepEndShineLabel:String = "";
      
      public function StepArrow()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.addListeners();
         hitArea = this.hit;
         mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this.removeListeners();
         this.clearStepShineFrameHelper();
         this.stepBlink = null;
         this.stepNormal = null;
         this.stepShine = null;
         hitArea = null;
         this.hit = null;
         this._toolTipMgr = null;
      }
      
      public function runAnimation() : void
      {
         this._setAlphaFrameLabel = Values.EMPTY_STR;
         this._stepEndShineLabel = null;
         switch(this._state)
         {
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_POSITIVE_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BONUS_STATE:
            case RANKEDBATTLES_ALIASES.STEP_NOT_RECEIVED_STATE:
               this.onStepReady();
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_STATE:
               this._setAlphaFrameLabel = STEP_SHINE_SHOW_STEP_LABEL;
               this._stepEndShineLabel = STEP_SHINE_POSITIVE_LONG_END_LABEL;
               this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),this.onStepReady);
               this.stepShine.gotoAndPlay(STEP_SHINE_POSITIVE_LONG_LABEL);
               this.runStepBlinkAnim(STEP_BLINK_POSITIVE_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_LOST_STATE:
               this._stepEndShineLabel = STEP_SHINE_NEGATIVE_END_LABEL;
               this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),this.onStepReady);
               this.stepShine.gotoAndPlay(STEP_SHINE_NEGATIVE_LABEL);
               this.runStepBlinkAnim(STEP_BLINK_NEGATIVE_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_STATE:
               this._setAlphaFrameLabel = STEP_SHINE_SHOW_STEP_SHORT_LABEL;
               this._stepEndShineLabel = STEP_SHINE_POSITIVE_SHORT_END_LABEL;
               this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),this.onStepReady);
               this.stepShine.gotoAndPlay(STEP_SHINE_POSITIVE_SHORT_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_LOST_SHORT_STATE:
            case RANKEDBATTLES_ALIASES.STEP_LOST_BLINK_STATE:
               this._stepEndShineLabel = STEP_SHINE_NEGATIVE_SHORT_END_LABEL;
               this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),this.onStepReady);
               this.stepShine.gotoAndPlay(STEP_SHINE_NEGATIVE_SHORT_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_BONUS_STATE:
               this._setAlphaFrameLabel = STEP_SHINE_SHOW_STEP_BONUS_LONG_LABEL;
               this._stepEndShineLabel = STEP_SHINE_BONUS_LONG_END_LABEL;
               this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),this.onStepReady);
               this.stepShine.gotoAndPlay(STEP_SHINE_BONUS_LONG_LABEL);
               this.runStepBlinkAnim(STEP_BLINK_BONUS_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_BONUS_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_BONUS_STATE:
               this._setAlphaFrameLabel = STEP_SHINE_SHOW_STEP_BONUS_SHORT_LABEL;
               this._stepEndShineLabel = STEP_SHINE_BONUS_SHORT_END_LABEL;
               this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),this.onStepReady);
               this.stepShine.gotoAndPlay(STEP_SHINE_BONUS_SHORT_LABEL);
               break;
            default:
               App.utils.asserter.assert(false,this._state + Errors.WASNT_FOUND);
         }
         this.trySetAlphaFrameScript();
      }
      
      public function useButtonMode(param1:Boolean) : void
      {
         this.stepNormal.useHandCursor = this.stepNormal.buttonMode = param1;
         this.stepShine.useHandCursor = this.stepShine.buttonMode = param1;
      }
      
      private function runStepBlinkAnim(param1:String) : void
      {
         if(this.stepBlink != null && this._stepSize == RANKEDBATTLES_ALIASES.WIDGET_HUGE)
         {
            this.stepBlink.gotoAndPlay(param1);
         }
      }
      
      private function setupForNewState() : void
      {
         this.setStepShineParams();
         this.setStepNormalState();
         switch(this._state)
         {
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_POSITIVE_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BONUS_STATE:
               this.stepNormal.alpha = 1;
               break;
            default:
               this.stepNormal.alpha = TRANSPARENT_ALPHA;
         }
      }
      
      private function setStepShineParams() : void
      {
         this.stepShine.visible = true;
         switch(this._state)
         {
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_POSITIVE_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BONUS_STATE:
            case RANKEDBATTLES_ALIASES.STEP_NOT_RECEIVED_STATE:
               this.stepShine.visible = false;
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_STATE:
               this.stepShine.gotoAndStop(STEP_SHINE_POSITIVE_LONG_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_LOST_STATE:
               this.stepShine.gotoAndStop(STEP_SHINE_NEGATIVE_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_STATE:
               this.stepShine.gotoAndStop(STEP_SHINE_POSITIVE_SHORT_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_LOST_SHORT_STATE:
            case RANKEDBATTLES_ALIASES.STEP_LOST_BLINK_STATE:
               this.stepShine.gotoAndStop(STEP_SHINE_NEGATIVE_SHORT_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_BONUS_STATE:
               this.stepShine.gotoAndStop(STEP_SHINE_BONUS_LONG_LABEL);
               break;
            case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_BONUS_STATE:
            case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_BONUS_STATE:
               this.stepShine.gotoAndStop(STEP_SHINE_BONUS_SHORT_LABEL);
         }
      }
      
      private function setStepNormalState() : void
      {
         if(this._stepSize == RANKEDBATTLES_ALIASES.WIDGET_HUGE)
         {
            switch(this._state)
            {
               case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_STATE:
               case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_STATE:
               case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_STATE:
               case RANKEDBATTLES_ALIASES.STEP_RECEIVED_POSITIVE_STATE:
                  this.stepNormal.gotoAndStop(STEP_NORMAL_POSITIVE_LABEL);
                  break;
               case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_BONUS_STATE:
               case RANKEDBATTLES_ALIASES.STEP_JUST_RECEIVED_SHORT_BONUS_STATE:
               case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BLINK_BONUS_STATE:
               case RANKEDBATTLES_ALIASES.STEP_RECEIVED_BONUS_STATE:
                  this.stepNormal.gotoAndStop(STEP_NORMAL_BONUS_LABEL);
                  break;
               default:
                  this.stepNormal.gotoAndStop(STEP_NORMAL_NORMAL_LABEL);
            }
         }
      }
      
      private function trySetAlphaFrameScript() : void
      {
         if(this._setAlphaFrameLabel != Values.EMPTY_STR)
         {
            this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameByLabel(this._setAlphaFrameLabel),this.setStepNormalAlpha);
         }
      }
      
      private function addListeners() : void
      {
         addEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
      }
      
      private function removeListeners() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onArrowMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onArrowMouseRollOutHandler);
      }
      
      private function setStepNormalAlpha() : void
      {
         this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameByLabel(this._setAlphaFrameLabel),null);
         this.stepNormal.alpha = 1;
      }
      
      private function changeSteps() : void
      {
         var _loc1_:Number = this.stepNormal.alpha;
         var _loc2_:int = this.stepNormal.currentFrame;
         var _loc3_:Boolean = this.stepShine.visible;
         var _loc4_:int = this.stepShine.currentFrame;
         var _loc5_:Boolean = this.stepNormal.buttonMode;
         this.stepNormal.visible = false;
         this.stepShine.visible = false;
         gotoAndStop(this._stepSize);
         this.stepNormal.gotoAndPlay(_loc2_);
         this.stepShine.gotoAndPlay(_loc4_);
         this.stepNormal.visible = true;
         this.stepShine.visible = _loc3_;
         this.stepNormal.alpha = _loc1_;
         this.stepNormal.useHandCursor = this.stepNormal.buttonMode = _loc5_;
         this.stepShine.useHandCursor = this.stepShine.buttonMode = _loc5_;
         hitArea = this.hit;
         this.clearStepShineFrameHelper();
         this._stepShineFrameHelper = new FrameHelper(this.stepShine);
      }
      
      private function onStepReady() : void
      {
         if(this._stepEndShineLabel != null)
         {
            this.stepShine.stop();
            this.stepShine.addFrameScript(this._stepShineFrameHelper.getFrameBeforeLabel(this._stepEndShineLabel),null);
         }
         dispatchEvent(new StepEvent(StepEvent.STEP_READY));
      }
      
      private function clearStepShineFrameHelper() : void
      {
         if(this._stepShineFrameHelper)
         {
            this._stepShineFrameHelper.dispose();
            this._stepShineFrameHelper = null;
         }
      }
      
      override public function get width() : Number
      {
         if(this.stepNormal)
         {
            return this.stepNormal.x + this.stepNormal.width;
         }
         if(this.stepShine)
         {
            return this.stepShine.x + this.stepShine.width;
         }
         return super.width;
      }
      
      public function get componentSize() : String
      {
         return this._stepSize;
      }
      
      public function set componentSize(param1:String) : void
      {
         if(this._stepSize == param1)
         {
            return;
         }
         this._stepSize = param1;
         this.changeSteps();
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      public function set state(param1:String) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this.setupForNewState();
         }
      }
      
      private function onArrowMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onArrowMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_STEP,null);
      }
   }
}
