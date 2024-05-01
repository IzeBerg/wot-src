package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.lobby.techtree.data.BlueprintBalanceVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class BlueprintBalance extends FadeComponent
   {
       
      
      public var balance:BalanceContainer = null;
      
      private var _balanceVO:BlueprintBalanceVO = null;
      
      public function BlueprintBalance()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(enabled && isInvalid(InvalidationType.DATA,InvalidationType.STATE))
         {
            this.balance.setBalance(this._balanceVO);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.balance != null)
         {
            this.balance.dispose();
            this.balance = null;
         }
         this._balanceVO = null;
         super.onDispose();
      }
      
      public function setData(param1:BlueprintBalanceVO) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._balanceVO = param1;
         invalidateData();
      }
   }
}
