package net.wg.gui.battle.components.preBattleTimer
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DigitsChain implements IDisposable
   {
       
      
      private var _chain:Vector.<DigitAnim> = null;
      
      private var _chainLen:int = 0;
      
      private var _isAnimInProgress:Boolean = false;
      
      private var _isAnimInit:Boolean = false;
      
      private var _activeDigit:int = -1;
      
      private var _nextDigit:int = -1;
      
      private var _nextDigitToX:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function DigitsChain(param1:Vector.<DigitAnim>)
      {
         super();
         this.init(param1);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._disposed = true;
         var _loc1_:int = 0;
         while(_loc1_ < this._chainLen)
         {
            this._chain[_loc1_].removeEventListener(PreBattleTimerEvent.HIDDEN,this.onDigitsHiddenHandler);
            this._chain[_loc1_].removeEventListener(PreBattleTimerEvent.SHOWN,this.onDigitsShownHandler);
            this._chain[_loc1_].removeEventListener(PreBattleTimerEvent.ALLOW_TO_SHOW_NEXT_DIGIT,this.onDigitsAllowToShowNextDigitHandler);
            _loc1_++;
         }
         this._chain.splice(0,this._chainLen);
         this._chain = null;
      }
      
      protected function onDispose() : void
      {
      }
      
      public function hideDigit(param1:Boolean) : void
      {
         if(this._activeDigit != Values.DEFAULT_INT)
         {
            this._nextDigit = Values.DEFAULT_INT;
            if(param1)
            {
               this._chain[this._activeDigit].hideImmediately();
            }
            else
            {
               this._chain[this._activeDigit].hide();
            }
            this._activeDigit = Values.DEFAULT_INT;
         }
      }
      
      public function rest() : void
      {
         this._isAnimInit = false;
         this._isAnimInProgress = false;
         this._nextDigit = Values.DEFAULT_INT;
         if(this._activeDigit > Values.DEFAULT_INT)
         {
            this._chain[this._activeDigit].hideImmediately();
         }
         this._activeDigit = Values.DEFAULT_INT;
      }
      
      public function showDigit(param1:int, param2:int, param3:Boolean) : void
      {
         param3 = param3 || this._activeDigit == Values.DEFAULT_INT;
         if(this._nextDigit == param1)
         {
            return;
         }
         if(!this._isAnimInit || param3)
         {
            this._isAnimInit = true;
            if(this._activeDigit != param1 && this._activeDigit != Values.DEFAULT_INT)
            {
               this._chain[this._activeDigit].hideImmediately();
            }
            this._activeDigit = param1;
            this._nextDigit = param1;
            this._chain[param1].x = param2;
            this._chain[param1].showImmediately();
         }
         else
         {
            this._nextDigit = param1;
            this._nextDigitToX = param2;
            if(!this._isAnimInProgress)
            {
               this._isAnimInProgress = true;
               this._chain[this._activeDigit].hide();
            }
         }
      }
      
      private function init(param1:Vector.<DigitAnim>) : void
      {
         this._chain = param1;
         this._chainLen = param1.length;
         var _loc2_:int = 0;
         while(_loc2_ < this._chainLen)
         {
            this._chain[_loc2_].digit = _loc2_;
            this._chain[_loc2_].addEventListener(PreBattleTimerEvent.HIDDEN,this.onDigitsHiddenHandler);
            this._chain[_loc2_].addEventListener(PreBattleTimerEvent.SHOWN,this.onDigitsShownHandler);
            this._chain[_loc2_].addEventListener(PreBattleTimerEvent.ALLOW_TO_SHOW_NEXT_DIGIT,this.onDigitsAllowToShowNextDigitHandler);
            _loc2_++;
         }
      }
      
      private function onDigitsShownHandler(param1:PreBattleTimerEvent) : void
      {
         this.applyDigitsShownCallback(param1.digitID);
         if(this._nextDigit == param1.digitID)
         {
            this._chain[this._activeDigit].hold();
            this._isAnimInProgress = false;
         }
      }
      
      private function onDigitsAllowToShowNextDigitHandler(param1:PreBattleTimerEvent) : void
      {
         if(this._nextDigit != param1.digitID && this._nextDigit > Values.DEFAULT_INT)
         {
            this._activeDigit = this._nextDigit;
            this._chain[this._activeDigit].x = this._nextDigitToX;
            this._chain[this._activeDigit].show();
         }
      }
      
      private function onDigitsHiddenHandler(param1:PreBattleTimerEvent) : void
      {
         this.applyDigitsHiddenCallback(param1.digitID);
         if(this._nextDigit == Values.DEFAULT_INT)
         {
            this._isAnimInProgress = false;
            this._isAnimInit = false;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function applyDigitsShownCallback(param1:int) : void
      {
      }
      
      protected function applyDigitsHiddenCallback(param1:int) : void
      {
      }
   }
}
