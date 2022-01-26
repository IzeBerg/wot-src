package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.dialogs.SimpleDialog;
   import net.wg.gui.lobby.dialogs.data.TankmanOperationDialogVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class TankmanOperationDialogMeta extends SimpleDialog
   {
       
      
      private var _tankmanOperationDialogVO:TankmanOperationDialogVO;
      
      public function TankmanOperationDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._tankmanOperationDialogVO)
         {
            this._tankmanOperationDialogVO.dispose();
            this._tankmanOperationDialogVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:TankmanOperationDialogVO = this._tankmanOperationDialogVO;
         this._tankmanOperationDialogVO = new TankmanOperationDialogVO(param1);
         this.setData(this._tankmanOperationDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:TankmanOperationDialogVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
