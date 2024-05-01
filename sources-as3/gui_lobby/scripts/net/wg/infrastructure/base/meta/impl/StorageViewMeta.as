package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.data.StorageVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class StorageViewMeta extends AbstractScreen
   {
       
      
      public var navigateToHangar:Function;
      
      public var onClose:Function;
      
      private var _storageVO:StorageVO;
      
      public function StorageViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._storageVO)
         {
            this._storageVO.dispose();
            this._storageVO = null;
         }
         super.onDispose();
      }
      
      public function navigateToHangarS() : void
      {
         App.utils.asserter.assertNotNull(this.navigateToHangar,"navigateToHangar" + Errors.CANT_NULL);
         this.navigateToHangar();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:StorageVO = this._storageVO;
         this._storageVO = new StorageVO(param1);
         this.setData(this._storageVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:StorageVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
