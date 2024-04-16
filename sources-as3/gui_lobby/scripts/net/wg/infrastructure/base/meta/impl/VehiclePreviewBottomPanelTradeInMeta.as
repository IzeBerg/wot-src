package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPTradeInBuyingPanelVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewBottomPanelTradeInMeta extends BaseDAAPIComponent
   {
       
      
      public var onBuyClick:Function;
      
      private var _vPTradeInBuyingPanelVO:VPTradeInBuyingPanelVO;
      
      public function VehiclePreviewBottomPanelTradeInMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPTradeInBuyingPanelVO)
         {
            this._vPTradeInBuyingPanelVO.dispose();
            this._vPTradeInBuyingPanelVO = null;
         }
         super.onDispose();
      }
      
      public function onBuyClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBuyClick,"onBuyClick" + Errors.CANT_NULL);
         this.onBuyClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPTradeInBuyingPanelVO = this._vPTradeInBuyingPanelVO;
         this._vPTradeInBuyingPanelVO = new VPTradeInBuyingPanelVO(param1);
         this.setData(this._vPTradeInBuyingPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPTradeInBuyingPanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
