package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.vehiclePreview.data.VPBrowseTabVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehiclePreviewBrowseTabMeta extends BaseDAAPIComponent
   {
       
      
      public var setActiveState:Function;
      
      private var _vPBrowseTabVO:VPBrowseTabVO;
      
      public function VehiclePreviewBrowseTabMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._vPBrowseTabVO)
         {
            this._vPBrowseTabVO.dispose();
            this._vPBrowseTabVO = null;
         }
         super.onDispose();
      }
      
      public function setActiveStateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setActiveState,"setActiveState" + Errors.CANT_NULL);
         this.setActiveState(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:VPBrowseTabVO = this._vPBrowseTabVO;
         this._vPBrowseTabVO = new VPBrowseTabVO(param1);
         this.setData(this._vPBrowseTabVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:VPBrowseTabVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
