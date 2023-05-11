package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.data.GoodieInfoVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class GoodieInfoMeta extends AbstractWindowView
   {
       
      
      public var onCancelClick:Function;
      
      private var _goodieInfoVO:GoodieInfoVO;
      
      public function GoodieInfoMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._goodieInfoVO)
         {
            this._goodieInfoVO.dispose();
            this._goodieInfoVO = null;
         }
         super.onDispose();
      }
      
      public function onCancelClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancelClick,"onCancelClick" + Errors.CANT_NULL);
         this.onCancelClick();
      }
      
      public final function as_setInfo(param1:Object) : void
      {
         var _loc2_:GoodieInfoVO = this._goodieInfoVO;
         this._goodieInfoVO = new GoodieInfoVO(param1);
         this.setInfo(this._goodieInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setInfo(param1:GoodieInfoVO) : void
      {
         var _loc2_:String = "as_setInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
