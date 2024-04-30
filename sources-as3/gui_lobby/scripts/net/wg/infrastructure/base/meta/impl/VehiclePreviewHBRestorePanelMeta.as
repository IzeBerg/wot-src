package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPHBRestorePanelVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewHBRestorePanelMeta extends BaseDAAPIComponent
   {
       
      
      public var onBuyClick:Function;
      
      private var _vPHBRestorePanelVO:VPHBRestorePanelVO;
      
      public function VehiclePreviewHBRestorePanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPHBRestorePanelVO)
         {
            this._vPHBRestorePanelVO.dispose();
            this._vPHBRestorePanelVO = null;
         }
         super.onDispose();
      }
      
      public function onBuyClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onBuyClick,"onBuyClick" + Errors.CANT_NULL);
         this.onBuyClick();
      }
      
      public final function as_setBuyData(param1:Object) : void
      {
         var _loc2_:VPHBRestorePanelVO = this._vPHBRestorePanelVO;
         this._vPHBRestorePanelVO = new VPHBRestorePanelVO(param1);
         this.setBuyData(this._vPHBRestorePanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setBuyData(param1:VPHBRestorePanelVO) : void
      {
         var _loc2_:String = "as_setBuyData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
