package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.DemountKitInfoVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class DemountKitInfoMeta extends AbstractWindowView
   {
       
      
      public var onCancelClick:Function;
      
      private var _demountKitInfoVO:DemountKitInfoVO;
      
      public function DemountKitInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._demountKitInfoVO)
         {
            this._demountKitInfoVO.dispose();
            this._demountKitInfoVO = null;
         }
         super.onDispose();
      }
      
      public function onCancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
      
      public final function as_setDemountKitInfo(param1:Object) : void
      {
         var _loc2_:DemountKitInfoVO = this._demountKitInfoVO;
         this._demountKitInfoVO = new DemountKitInfoVO(param1);
         this.setDemountKitInfo(this._demountKitInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setDemountKitInfo(param1:DemountKitInfoVO) : void
      {
         var _loc2_:String = "as_setDemountKitInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
