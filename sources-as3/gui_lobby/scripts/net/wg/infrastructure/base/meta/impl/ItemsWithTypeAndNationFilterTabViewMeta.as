package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.storage.ItemsWithTypeFilterTabView;
   import net.wg.gui.lobby.storage.data.StorageNationFilterVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ItemsWithTypeAndNationFilterTabViewMeta extends ItemsWithTypeFilterTabView
   {
       
      
      public var selectNation:Function;
      
      private var _storageNationFilterVO:StorageNationFilterVO;
      
      public function ItemsWithTypeAndNationFilterTabViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._storageNationFilterVO)
         {
            this._storageNationFilterVO.dispose();
            this._storageNationFilterVO = null;
         }
         super.onDispose();
      }
      
      public function selectNationS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.selectNation,"selectNation" + Errors.CANT_NULL);
         this.selectNation(param1);
      }
      
      public final function as_initNationFilter(param1:Object) : void
      {
         var _loc2_:StorageNationFilterVO = this._storageNationFilterVO;
         this._storageNationFilterVO = new StorageNationFilterVO(param1);
         this.initNationFilter(this._storageNationFilterVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function initNationFilter(param1:StorageNationFilterVO) : void
      {
         var _loc2_:String = "as_initNationFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
