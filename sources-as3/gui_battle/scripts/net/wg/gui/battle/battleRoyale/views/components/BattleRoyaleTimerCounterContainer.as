package net.wg.gui.battle.battleRoyale.views.components
{
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLE_ROYAL_CONSTS;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class BattleRoyaleTimerCounterContainer extends BattleUIComponent
   {
      
      private static const INITIAL_STATE_FRAME_LABEL_PREFIX:String = "initial";
      
      private static const EXTRA_STATE_FRAME_LABEL_PREFIX:String = "extra";
      
      private static const MAX_STATE_FRAME_LABEL_PREFIX:String = "max";
      
      private static const SMALL_SIZE_FRAME_LABEL_POSTFIX:String = "Small";
      
      private static const NORMAL_SIZE_FRAME_LABEL_POSTFIX:String = "Normal";
       
      
      public var counterTF:TextField;
      
      private var _state:uint = 0;
      
      private var _isSmall:Boolean = false;
      
      private var _counterText:String;
      
      public function BattleRoyaleTimerCounterContainer()
      {
         this._counterText = String.prototype;
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(isInvalid(InvalidationType.SIZE) || isInvalid(InvalidationType.STATE))
         {
            switch(this._state)
            {
               case BATTLE_ROYAL_CONSTS.COUNTER_STATE_INITIAL:
                  _loc1_ = INITIAL_STATE_FRAME_LABEL_PREFIX;
                  break;
               case BATTLE_ROYAL_CONSTS.COUNTER_STATE_EXTRA:
                  _loc1_ = EXTRA_STATE_FRAME_LABEL_PREFIX;
                  break;
               case BATTLE_ROYAL_CONSTS.COUNTER_STATE_MAX:
                  _loc1_ = MAX_STATE_FRAME_LABEL_PREFIX;
                  break;
               default:
                  _loc1_ = EXTRA_STATE_FRAME_LABEL_PREFIX;
            }
            _loc1_ += !!this._isSmall ? SMALL_SIZE_FRAME_LABEL_POSTFIX : NORMAL_SIZE_FRAME_LABEL_POSTFIX;
            this.gotoAndStop(_loc1_);
            invalidateData();
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.counterTF.text = this._counterText;
         }
      }
      
      override protected function onDispose() : void
      {
         this.counterTF = null;
         super.onDispose();
      }
      
      public function setData(param1:String, param2:int = 0) : void
      {
         if(param1 != this._counterText)
         {
            this._counterText = param1;
            invalidateData();
         }
         if(param2 != this._state)
         {
            this._state = param2;
            invalidateState();
         }
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         if(param1 == this._isSmall)
         {
            return;
         }
         this._isSmall = param1;
         invalidateSize();
      }
   }
}
