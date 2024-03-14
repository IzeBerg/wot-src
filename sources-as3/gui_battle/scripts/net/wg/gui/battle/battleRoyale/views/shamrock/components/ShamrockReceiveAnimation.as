package net.wg.gui.battle.battleRoyale.views.shamrock.components
{
   import flash.display.FrameLabel;
   import net.wg.gui.battle.battleRoyale.views.shamrock.events.ShamrockAnimationEvent;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class ShamrockReceiveAnimation extends BattleUIComponent
   {
      
      private static const FRAME_ADD_FROM_TEAMMATE:String = "addFromTeammate";
      
      private static const FRAME_ADD:String = "add";
      
      private static const FRAME_EMPTY:String = "empty";
      
      private static const FRAME_ANIM_PRE_COMPLETE:String = "animPreComplete";
      
      private static const FRAME_ANIM_COMPLETE:String = "animComplete";
      
      private static const PLUS:String = "+";
       
      
      public var valueTFWrapper:TextFieldWrapper = null;
      
      private var _newTotal:int = 0;
      
      private var _fromTeammate:Boolean = false;
      
      private var _preCompletedScriptFrame:int = 0;
      
      private var _completedScriptFrame:int = 0;
      
      private var _isRunning:Boolean = false;
      
      public function ShamrockReceiveAnimation()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.clear();
         addFrameScript(this._preCompletedScriptFrame,null);
         addFrameScript(this._completedScriptFrame,null);
         this.valueTFWrapper.dispose();
         this.valueTFWrapper = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc3_:FrameLabel = null;
         super.configUI();
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FRAME_ANIM_PRE_COMPLETE)
            {
               this._preCompletedScriptFrame = _loc3_.frame;
               addFrameScript(this._preCompletedScriptFrame,this.onAnimationPreComplete);
            }
            else if(_loc3_.name == FRAME_ANIM_COMPLETE)
            {
               this._completedScriptFrame = _loc3_.frame;
               addFrameScript(this._completedScriptFrame,this.onAnimationComplete);
            }
            _loc4_++;
         }
         this.clear();
      }
      
      public function clear() : void
      {
         gotoAndStop(FRAME_EMPTY);
         this._isRunning = false;
      }
      
      public function setValue(param1:int, param2:int, param3:Boolean) : void
      {
         this._isRunning = true;
         this.valueTFWrapper.setText(PLUS + param1);
         this._newTotal = param2;
         this._fromTeammate = param3;
         gotoAndPlay(!!param3 ? FRAME_ADD_FROM_TEAMMATE : FRAME_ADD);
      }
      
      private function onAnimationPreComplete() : void
      {
         dispatchEvent(new ShamrockAnimationEvent(ShamrockAnimationEvent.VALUE_ADDED,0,this._newTotal,this._fromTeammate));
      }
      
      private function onAnimationComplete() : void
      {
         this._isRunning = false;
         dispatchEvent(new ShamrockAnimationEvent(ShamrockAnimationEvent.COMPLETED));
      }
      
      public function get isRunning() : Boolean
      {
         return this._isRunning;
      }
   }
}
