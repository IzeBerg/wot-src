package net.wg.data.VO
{
   import net.wg.infrastructure.interfaces.IWalletStatusVO;
   
   public class WalletStatusVO implements IWalletStatusVO
   {
      
      private static const FIELD_GOLD:String = "gold";
      
      private static const FIELD_FREE_EXP:String = "freeXP";
      
      private static const FIELD_CREDITS:String = "credits";
      
      private static const FIELD_CRYSTAL:String = "crystal";
       
      
      private var _goldStatus:uint;
      
      private var _freeXpStatus:uint;
      
      private var _creditsStatus:uint;
      
      private var _crystalStatus:uint;
      
      public function WalletStatusVO()
      {
         super();
      }
      
      public final function dispose() : void
      {
      }
      
      public function get goldStatus() : uint
      {
         return this._goldStatus;
      }
      
      public function get freeXpStatus() : uint
      {
         return this._freeXpStatus;
      }
      
      public function get creditsStatus() : uint
      {
         return this._creditsStatus;
      }
      
      public function get crystalStatus() : uint
      {
         return this._crystalStatus;
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null)
         {
            if(param1.hasOwnProperty(FIELD_GOLD))
            {
               this._goldStatus = param1.gold;
            }
            if(param1.hasOwnProperty(FIELD_FREE_EXP))
            {
               this._freeXpStatus = param1.freeXP;
            }
            if(param1.hasOwnProperty(FIELD_CREDITS))
            {
               this._creditsStatus = param1.credits;
            }
            if(param1.hasOwnProperty(FIELD_CRYSTAL))
            {
               this._crystalStatus = param1.crystal;
            }
         }
         else
         {
            this._goldStatus = 1;
            this._freeXpStatus = 1;
            this._creditsStatus = 1;
            this._crystalStatus = 1;
         }
      }
   }
}
