package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.ConfirmExchangeDialogVO;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ConfirmExchangeDialogMeta extends AbstractWindowView
   {
       
      
      public var exchange:Function;
      
      public var onSelectedAmountChanged:Function;
      
      public var openDiscountInfoPage:Function;
      
      private var _confirmExchangeDialogVO:ConfirmExchangeDialogVO;
      
      public function ConfirmExchangeDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._confirmExchangeDialogVO)
         {
            this._confirmExchangeDialogVO.dispose();
            this._confirmExchangeDialogVO = null;
         }
         super.onDispose();
      }
      
      public function exchangeS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.exchange,"exchange" + Errors.CANT_NULL);
         this.exchange(param1);
      }
      
      public function onSelectedAmountChangedS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectedAmountChanged,"onSelectedAmountChanged" + Errors.CANT_NULL);
         this.onSelectedAmountChanged(param1,param2);
      }
      
      public function openDiscountInfoPageS() : void
      {
         App.utils.asserter.assertNotNull(this.openDiscountInfoPage,"openDiscountInfoPage" + Errors.CANT_NULL);
         this.openDiscountInfoPage();
      }
      
      public final function as_update(param1:Object) : void
      {
         var _loc2_:ConfirmExchangeDialogVO = this._confirmExchangeDialogVO;
         this._confirmExchangeDialogVO = new ConfirmExchangeDialogVO(param1);
         this.update(this._confirmExchangeDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function update(param1:ConfirmExchangeDialogVO) : void
      {
         var _loc2_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
