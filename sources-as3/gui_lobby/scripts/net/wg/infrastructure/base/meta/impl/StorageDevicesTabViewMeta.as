package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.storage.ItemsWithVehicleFilterTabView;
   import net.wg.gui.lobby.storage.data.StorageModulesFilterVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class StorageDevicesTabViewMeta extends ItemsWithVehicleFilterTabView
   {
       
      
      private var _storageModulesFilterVO:StorageModulesFilterVO;
      
      public function StorageDevicesTabViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._storageModulesFilterVO)
         {
            this._storageModulesFilterVO.dispose();
            this._storageModulesFilterVO = null;
         }
         super.onDispose();
      }
      
      public final function as_initModulesFilter(param1:Object) : void
      {
         var _loc2_:StorageModulesFilterVO = this._storageModulesFilterVO;
         this._storageModulesFilterVO = new StorageModulesFilterVO(param1);
         this.initModulesFilter(this._storageModulesFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function initModulesFilter(param1:StorageModulesFilterVO) : void
      {
         var _loc2_:String = "as_initModulesFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
