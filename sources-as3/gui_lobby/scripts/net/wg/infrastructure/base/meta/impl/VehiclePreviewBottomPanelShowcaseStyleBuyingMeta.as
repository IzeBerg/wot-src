package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPShowcaseStyleBuyingVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewBottomPanelShowcaseStyleBuyingMeta extends BaseDAAPIComponent
   {
       
      
      public var onBuyClick:Function;
      
      private var _vPShowcaseStyleBuyingVO:VPShowcaseStyleBuyingVO;
      
      public function VehiclePreviewBottomPanelShowcaseStyleBuyingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPShowcaseStyleBuyingVO)
         {
            this._vPShowcaseStyleBuyingVO.dispose();
            this._vPShowcaseStyleBuyingVO = null;
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
         var _loc2_:VPShowcaseStyleBuyingVO = this._vPShowcaseStyleBuyingVO;
         this._vPShowcaseStyleBuyingVO = new VPShowcaseStyleBuyingVO(param1);
         this.setData(this._vPShowcaseStyleBuyingVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPShowcaseStyleBuyingVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
