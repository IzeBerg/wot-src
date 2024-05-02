package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.BuyBtnVO;
   import net.wg.gui.lobby.vehicleCustomization.data.styleInfo.StyleInfoVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CustomizationStyleInfoMeta extends BaseDAAPIComponent
   {
       
      
      public var onClose:Function;
      
      public var onApply:Function;
      
      public var onWidthUpdated:Function;
      
      private var _styleInfoVO:StyleInfoVO;
      
      private var _buyBtnVO:BuyBtnVO;
      
      public function CustomizationStyleInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._styleInfoVO)
         {
            this._styleInfoVO.dispose();
            this._styleInfoVO = null;
         }
         if(this._buyBtnVO)
         {
            this._buyBtnVO.dispose();
            this._buyBtnVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onApplyS() : void
      {
         App.utils.asserter.assertNotNull(this.onApply,"onApply" + Errors.CANT_NULL);
         this.onApply();
      }
      
      public function onWidthUpdatedS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.onWidthUpdated,"onWidthUpdated" + Errors.CANT_NULL);
         this.onWidthUpdated(param1,param2,param3);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:StyleInfoVO = this._styleInfoVO;
         this._styleInfoVO = new StyleInfoVO(param1);
         this.setData(this._styleInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_buttonUpdate(param1:Object) : void
      {
         var _loc2_:BuyBtnVO = this._buyBtnVO;
         this._buyBtnVO = new BuyBtnVO(param1);
         this.buttonUpdate(this._buyBtnVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:StyleInfoVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function buttonUpdate(param1:BuyBtnVO) : void
      {
         var _loc2_:String = "as_buttonUpdate" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
