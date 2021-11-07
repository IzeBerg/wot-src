package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.window.ExchangeFreeToTankmanInitVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ExchangeFreeToTankmanXpWindowMeta extends AbstractWindowView
   {
       
      
      public var apply:Function;
      
      public var onValueChanged:Function;
      
      public var calcValueRequest:Function;
      
      private var _exchangeFreeToTankmanInitVO:ExchangeFreeToTankmanInitVO;
      
      private var _actionPriceVO:ActionPriceVO;
      
      public function ExchangeFreeToTankmanXpWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._exchangeFreeToTankmanInitVO)
         {
            this._exchangeFreeToTankmanInitVO.dispose();
            this._exchangeFreeToTankmanInitVO = null;
         }
         if(this._actionPriceVO)
         {
            this._actionPriceVO.dispose();
            this._actionPriceVO = null;
         }
         super.onDispose();
      }
      
      public function applyS() : void
      {
         App.utils.asserter.assertNotNull(this.apply,"apply" + Errors.CANT_NULL);
         this.apply();
      }
      
      public function onValueChangedS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onValueChanged,"onValueChanged" + Errors.CANT_NULL);
         this.onValueChanged(param1);
      }
      
      public function calcValueRequestS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.calcValueRequest,"calcValueRequest" + Errors.CANT_NULL);
         this.calcValueRequest(param1);
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ExchangeFreeToTankmanInitVO = this._exchangeFreeToTankmanInitVO;
         this._exchangeFreeToTankmanInitVO = new ExchangeFreeToTankmanInitVO(param1);
         this.setInitData(this._exchangeFreeToTankmanInitVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCalcValueResponse(param1:Number, param2:Object) : void
      {
         var _loc3_:ActionPriceVO = this._actionPriceVO;
         this._actionPriceVO = Boolean(param2) ? new ActionPriceVO(param2) : null;
         this.setCalcValueResponse(param1,this._actionPriceVO);
         if(_loc3_)
         {
            _loc3_.dispose();
         }
      }
      
      protected function setInitData(param1:ExchangeFreeToTankmanInitVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCalcValueResponse(param1:Number, param2:ActionPriceVO) : void
      {
         var _loc3_:String = "as_setCalcValueResponse" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
