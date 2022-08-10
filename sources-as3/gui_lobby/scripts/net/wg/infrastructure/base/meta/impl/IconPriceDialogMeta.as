package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.dialogs.IconDialog;
   import net.wg.gui.lobby.dialogs.data.IconPriceDialogVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class IconPriceDialogMeta extends IconDialog
   {
       
      
      private var _iconPriceDialogVO:IconPriceDialogVO;
      
      public function IconPriceDialogMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._iconPriceDialogVO)
         {
            this._iconPriceDialogVO.dispose();
            this._iconPriceDialogVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setMessagePrice(param1:Object) : void
      {
         var _loc2_:IconPriceDialogVO = this._iconPriceDialogVO;
         this._iconPriceDialogVO = new IconPriceDialogVO(param1);
         this.setMessagePrice(this._iconPriceDialogVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setMessagePrice(param1:IconPriceDialogVO) : void
      {
         var _loc2_:String = "as_setMessagePrice" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
