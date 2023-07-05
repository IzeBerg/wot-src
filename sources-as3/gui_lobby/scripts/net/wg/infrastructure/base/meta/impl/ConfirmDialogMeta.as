package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.ConfirmDialogVO;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ConfirmDialogMeta extends AbstractWindowView
   {
       
      
      public var submit:Function;
      
      private var _confirmDialogVO:ConfirmDialogVO;
      
      public function ConfirmDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._confirmDialogVO)
         {
            this._confirmDialogVO.dispose();
            this._confirmDialogVO = null;
         }
         super.onDispose();
      }
      
      public function submitS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1);
      }
      
      public final function as_setSettings(param1:Object) : void
      {
         var _loc2_:ConfirmDialogVO = this._confirmDialogVO;
         this._confirmDialogVO = new ConfirmDialogVO(param1);
         this.setSettings(this._confirmDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setSettings(param1:ConfirmDialogVO) : void
      {
         var _loc2_:String = "as_setSettings" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
