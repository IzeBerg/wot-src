package net.wg.gui.battle.battleRoyale.views.shamrock.components.results
{
   import flash.display.FrameLabel;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.battleRoyale.views.shamrock.events.ShamrockAnimationEvent;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class WinnerShamrockAnimation extends BattleUIComponent
   {
      
      private static const FRAME_ANIM_SHOW_TOTAL:String = "showTotal";
      
      private static const FRAME_ANIM_TOTAL_SHOWN:String = "totalShown";
      
      private static const FRAME_ANIM_SHOW_X3:String = "showX3";
      
      private static const FRAME_ANIM_COLLECTED_X3:String = "collectedX3";
      
      private static const FRAME_ANIM_FINISHED_X3:String = "finishedX3";
      
      private static const FRAME_ANIM_SHOW_BONUS:String = "showBonus";
      
      private static const FRAME_ANIM_COLLECTED_BONUS:String = "collectedBonus";
      
      private static const BONUS_LABEL_PREFIX:String = "+";
      
      private static const MIN_FACTOR:int = 1;
      
      private static const START_ANIM_DELAY:int = 1500;
       
      
      public var shamrocksLabel:AbstractShamrockLabel = null;
      
      public var bonusLabel:AbstractShamrockLabel = null;
      
      private var _collectedX3ScriptFrame:int = 0;
      
      private var _finishedX3ScriptFrame:int = 0;
      
      private var _collectedBonusScriptFrame:int = 0;
      
      private var _totalShownScriptFrame:int = 0;
      
      private var _initial:int = 0;
      
      private var _factor:int = 0;
      
      private var _placeBonus:int = 0;
      
      private var _timer:int = -1;
      
      public function WinnerShamrockAnimation()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         var _loc3_:FrameLabel = null;
         super.configUI();
         stop();
         this.bonusLabel.setPrefix(BONUS_LABEL_PREFIX);
         var _loc1_:Array = currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FRAME_ANIM_TOTAL_SHOWN)
            {
               this._totalShownScriptFrame = _loc3_.frame;
               addFrameScript(this._totalShownScriptFrame,this.onAnimationTotalShown);
            }
            else if(_loc3_.name == FRAME_ANIM_COLLECTED_X3)
            {
               this._collectedX3ScriptFrame = _loc3_.frame;
               addFrameScript(this._collectedX3ScriptFrame,this.onAnimationCollectedX3);
            }
            else if(_loc3_.name == FRAME_ANIM_FINISHED_X3)
            {
               this._finishedX3ScriptFrame = _loc3_.frame;
               addFrameScript(this._finishedX3ScriptFrame,this.onAnimationFinishedX3);
            }
            else if(_loc3_.name == FRAME_ANIM_COLLECTED_BONUS)
            {
               this._collectedBonusScriptFrame = _loc3_.frame;
               addFrameScript(this._collectedBonusScriptFrame,this.onAnimationCollectedBonus);
            }
            _loc4_++;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._timer != Values.DEFAULT_INT)
         {
            clearTimeout(this._timer);
         }
         addFrameScript(this._collectedX3ScriptFrame,null);
         addFrameScript(this._finishedX3ScriptFrame,null);
         addFrameScript(this._collectedBonusScriptFrame,null);
         addFrameScript(this._totalShownScriptFrame,null);
         this.shamrocksLabel.dispose();
         this.shamrocksLabel = null;
         this.bonusLabel.dispose();
         this.bonusLabel = null;
         super.onDispose();
      }
      
      public function setValues(param1:int, param2:int, param3:int) : void
      {
         this.shamrocksLabel.seMaxValue(param1 * param2 + param3);
         this.shamrocksLabel.setValue(param1);
         this._initial = param1;
         this._factor = param2;
         this._placeBonus = param3;
         if(this._timer != Values.DEFAULT_INT)
         {
            clearTimeout(this._timer);
         }
         this._timer = setTimeout(gotoAndPlay,START_ANIM_DELAY,FRAME_ANIM_SHOW_TOTAL);
      }
      
      private function onAnimationTotalShown() : void
      {
         if(this._factor > MIN_FACTOR)
         {
            gotoAndPlay(FRAME_ANIM_SHOW_X3);
         }
         else
         {
            this.onAnimationFinishedX3();
         }
      }
      
      private function onAnimationCollectedX3() : void
      {
         var _loc1_:int = 0;
         _loc1_ = this._initial * this._factor;
         var _loc2_:int = _loc1_ - this._initial;
         this.shamrocksLabel.setValue(_loc1_,true);
         dispatchEvent(new ShamrockAnimationEvent(ShamrockAnimationEvent.COLLECT_X3,_loc2_,_loc1_,false,true));
      }
      
      private function onAnimationFinishedX3() : void
      {
         if(this._placeBonus > Values.ZERO)
         {
            this.bonusLabel.seMaxValue(this._placeBonus);
            this.bonusLabel.setValue(this._placeBonus);
            gotoAndPlay(FRAME_ANIM_SHOW_BONUS);
         }
         else
         {
            stop();
         }
      }
      
      private function onAnimationCollectedBonus() : void
      {
         this.shamrocksLabel.setValue(this._initial * this._factor + this._placeBonus,true);
      }
   }
}
