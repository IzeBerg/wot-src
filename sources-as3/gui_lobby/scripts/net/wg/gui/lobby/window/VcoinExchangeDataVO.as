package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VcoinExchangeDataVO extends DAAPIDataClass
   {
       
      
      private var _minTransactVal:uint;
      
      private var _maxTransactVal:uint;
      
      private var _countStep:uint;
      
      public function VcoinExchangeDataVO(param1:Object)
      {
         super(param1);
      }
      
      public function set minTransactVal(param1:uint) : void
      {
         this._minTransactVal = param1;
      }
      
      public function set maxTransactVal(param1:uint) : void
      {
         this._maxTransactVal = param1;
      }
      
      public function set countStep(param1:uint) : void
      {
         this._countStep = param1;
      }
      
      public function get minTransactVal() : uint
      {
         return this._minTransactVal;
      }
      
      public function get maxTransactVal() : uint
      {
         return this._maxTransactVal;
      }
      
      public function get countStep() : uint
      {
         return this._countStep;
      }
   }
}
