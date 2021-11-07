package net.wg.gui.lobby.vehicleTradeWnds.sell.utils
{
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleSellDialogMoney implements IDisposable
   {
       
      
      private var _money:Vector.<VehicleSellDialogMoneyVO>;
      
      private var _moneyByType:Object;
      
      public function VehicleSellDialogMoney()
      {
         this._money = new Vector.<VehicleSellDialogMoneyVO>(0);
         this._moneyByType = {};
         super();
         this.addMoney(new VehicleSellDialogMoneyVO(CURRENCIES_CONSTANTS.CREDITS,CURRENCIES_CONSTANTS.CREDITS_COLOR));
         this.addMoney(new VehicleSellDialogMoneyVO(CURRENCIES_CONSTANTS.GOLD,CURRENCIES_CONSTANTS.GOLD_COLOR));
         this.addMoney(new VehicleSellDialogMoneyVO(CURRENCIES_CONSTANTS.CRYSTAL,CURRENCIES_CONSTANTS.CRYSTAL_COLOR));
      }
      
      public function dispose() : void
      {
         this._money.splice(0,this._money.length);
         this._money = null;
         this._moneyByType = null;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:VehicleSellDialogMoneyVO = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         for(_loc3_ in param1)
         {
            _loc2_ = this.getMoney(_loc3_);
            _loc2_.value = param1[_loc3_];
         }
         _loc4_ = this._money.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = this._money[_loc5_];
            if(!(_loc2_.type in param1))
            {
               _loc2_.value = 0;
            }
            _loc5_++;
         }
      }
      
      public function updateAccountMoney(param1:String, param2:int) : void
      {
         var _loc3_:VehicleSellDialogMoneyVO = this.getMoney(param1);
         _loc3_.accountValue = param2;
      }
      
      public function updateAccountMoneyDict(param1:Object) : void
      {
         var _loc2_:* = null;
         for(_loc2_ in param1)
         {
            this.updateAccountMoney(_loc2_,param1[_loc2_]);
         }
      }
      
      private function addMoney(param1:VehicleSellDialogMoneyVO) : void
      {
         if(this._moneyByType.hasOwnProperty(param1.type))
         {
            return;
         }
         this._money.push(param1);
         this._moneyByType[param1.type] = param1;
      }
      
      private function getMoney(param1:String) : VehicleSellDialogMoneyVO
      {
         if(this._moneyByType.hasOwnProperty(param1))
         {
            return this._moneyByType[param1];
         }
         var _loc2_:VehicleSellDialogMoneyVO = new VehicleSellDialogMoneyVO(param1,VehicleSellDialogUtils.EXTRA_CURRENCY_COLOR);
         this.addMoney(_loc2_);
         return _loc2_;
      }
      
      public function geResultMoney() : Vector.<VehicleSellDialogMoneyVO>
      {
         var _loc1_:Vector.<VehicleSellDialogMoneyVO> = new Vector.<VehicleSellDialogMoneyVO>(0);
         _loc1_.push(this._money[0]);
         var _loc2_:int = this._money.length;
         var _loc3_:int = 1;
         while(_loc3_ < _loc2_)
         {
            if(this._money[_loc3_].value != 0)
            {
               _loc1_.push(this._money[_loc3_]);
            }
            _loc3_++;
         }
         return _loc1_;
      }
   }
}
