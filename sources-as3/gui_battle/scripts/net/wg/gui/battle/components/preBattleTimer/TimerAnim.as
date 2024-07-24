package net.wg.gui.battle.components.preBattleTimer
{
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class TimerAnim extends BattleUIComponent
   {
      
      private static const TIME_DIFF_BORDER_TO_RESET:int = 3;
      
      private static const SECONDS_IN_MINUTE:int = 60;
      
      private static const DECADE:int = 10;
      
      private static const DIGIT_WIDTH:int = 60;
      
      private static const CHAIN_GAP:int = 7;
      
      private static const CHAINS_COUNT:int = 2;
       
      
      public var secondDecade0:DigitAnim = null;
      
      public var secondDecade1:DigitAnim = null;
      
      public var secondDecade2:DigitAnim = null;
      
      public var secondDecade3:DigitAnim = null;
      
      public var secondDecade4:DigitAnim = null;
      
      public var secondDecade5:DigitAnim = null;
      
      public var secondDecade6:DigitAnim = null;
      
      public var secondDecade7:DigitAnim = null;
      
      public var secondDecade8:DigitAnim = null;
      
      public var secondDecade9:DigitAnim = null;
      
      public var secondUnit0:DigitAnim = null;
      
      public var secondUnit1:DigitAnim = null;
      
      public var secondUnit2:DigitAnim = null;
      
      public var secondUnit3:DigitAnim = null;
      
      public var secondUnit4:DigitAnim = null;
      
      public var secondUnit5:DigitAnim = null;
      
      public var secondUnit6:DigitAnim = null;
      
      public var secondUnit7:DigitAnim = null;
      
      public var secondUnit8:DigitAnim = null;
      
      public var secondUnit9:DigitAnim = null;
      
      private var _lastTimeSet:int = 0;
      
      private var _allowAnim:Boolean = false;
      
      private var _chains:Vector.<DigitsChain> = null;
      
      private var _chainsVisibility:Vector.<Boolean> = null;
      
      private var _digits:Vector.<int> = null;
      
      private const DIGIT_WIDTH_WITH_GAP:int = 67.0;
      
      public function TimerAnim()
      {
         super();
         this._digits = new Vector.<int>(CHAINS_COUNT,true);
         this._digits[0] = 0;
         this._digits[1] = 0;
         this._chainsVisibility = new Vector.<Boolean>(CHAINS_COUNT,true);
         this._chainsVisibility[0] = true;
         this._chainsVisibility[1] = true;
         this._chains = this.createDigitChains();
      }
      
      protected function createDigitChains() : Vector.<DigitsChain>
      {
         var _loc1_:Vector.<DigitsChain> = new Vector.<DigitsChain>(CHAINS_COUNT,true);
         _loc1_[0] = new DigitsChain(new <DigitAnim>[this.secondUnit0,this.secondUnit1,this.secondUnit2,this.secondUnit3,this.secondUnit4,this.secondUnit5,this.secondUnit6,this.secondUnit7,this.secondUnit8,this.secondUnit9]);
         _loc1_[1] = new DigitsChain(new <DigitAnim>[this.secondDecade0,this.secondDecade1,this.secondDecade2,this.secondDecade3,this.secondDecade4,this.secondDecade5,this.secondDecade6,this.secondDecade7,this.secondDecade8,this.secondDecade9]);
         return _loc1_;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < CHAINS_COUNT)
         {
            this._chains[_loc1_].dispose();
            this._chains[_loc1_] = null;
            _loc1_++;
         }
         this._chainsVisibility = null;
         this._chains = null;
         this._digits = null;
         this.secondDecade0.dispose();
         this.secondDecade0 = null;
         this.secondDecade1.dispose();
         this.secondDecade1 = null;
         this.secondDecade2.dispose();
         this.secondDecade2 = null;
         this.secondDecade3.dispose();
         this.secondDecade3 = null;
         this.secondDecade4.dispose();
         this.secondDecade4 = null;
         this.secondDecade5.dispose();
         this.secondDecade5 = null;
         this.secondDecade6.dispose();
         this.secondDecade6 = null;
         this.secondDecade7.dispose();
         this.secondDecade7 = null;
         this.secondDecade8.dispose();
         this.secondDecade8 = null;
         this.secondDecade9.dispose();
         this.secondDecade9 = null;
         this.secondUnit0.dispose();
         this.secondUnit0 = null;
         this.secondUnit1.dispose();
         this.secondUnit1 = null;
         this.secondUnit2.dispose();
         this.secondUnit2 = null;
         this.secondUnit3.dispose();
         this.secondUnit3 = null;
         this.secondUnit4.dispose();
         this.secondUnit4 = null;
         this.secondUnit5.dispose();
         this.secondUnit5 = null;
         this.secondUnit6.dispose();
         this.secondUnit6 = null;
         this.secondUnit7.dispose();
         this.secondUnit7 = null;
         this.secondUnit8.dispose();
         this.secondUnit8 = null;
         this.secondUnit9.dispose();
         this.secondUnit9 = null;
         super.onDispose();
      }
      
      public function ownerVisibleChange(param1:Boolean) : void
      {
         this._allowAnim = param1 && this.visible;
         if(this._allowAnim)
         {
            this.setTime(this._lastTimeSet,true);
         }
      }
      
      public function setTime(param1:int, param2:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         if(Math.abs(this._lastTimeSet - param1) > TIME_DIFF_BORDER_TO_RESET)
         {
            _loc3_ = 0;
            while(_loc3_ < CHAINS_COUNT)
            {
               this._chains[_loc3_].rest();
               _loc3_++;
            }
         }
         if(this._allowAnim)
         {
            _loc4_ = param1 % SECONDS_IN_MINUTE;
            this._digits[0] = _loc4_ % DECADE;
            this._digits[1] = (_loc4_ - this._digits[0]) / DECADE;
            _loc5_ = Values.ZERO;
            _loc3_ = 0;
            while(_loc3_ < CHAINS_COUNT)
            {
               this._chainsVisibility[_loc3_] = _loc4_ >= Math.pow(DECADE,_loc3_);
               if(this._chainsVisibility[_loc3_])
               {
                  _loc5_ += this.DIGIT_WIDTH_WITH_GAP;
               }
               _loc3_++;
            }
            _loc5_ -= CHAIN_GAP;
            _loc6_ = -(_loc5_ >> 1);
            _loc3_ = CHAINS_COUNT - 1;
            while(_loc3_ >= 0)
            {
               if(this._chainsVisibility[_loc3_])
               {
                  this._chains[_loc3_].showDigit(this._digits[_loc3_],_loc6_,param2);
                  _loc6_ += this.DIGIT_WIDTH_WITH_GAP;
               }
               else
               {
                  this._chains[_loc3_].hideDigit(param2);
               }
               _loc3_--;
            }
         }
         this._lastTimeSet = param1;
      }
   }
}
