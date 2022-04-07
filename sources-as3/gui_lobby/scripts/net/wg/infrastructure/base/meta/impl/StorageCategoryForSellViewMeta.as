package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.storage.categories.BaseCategoryView;
   import net.wg.gui.lobby.storage.categories.forsell.StorageCategoryForSellVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class StorageCategoryForSellViewMeta extends BaseCategoryView
   {
       
      
      public var navigateToStore:Function;
      
      public var selectItem:Function;
      
      public var selectAll:Function;
      
      public var sellItem:Function;
      
      public var sellAll:Function;
      
      private var _storageCategoryForSellVO:StorageCategoryForSellVO;
      
      public function StorageCategoryForSellViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._storageCategoryForSellVO)
         {
            this._storageCategoryForSellVO.dispose();
            this._storageCategoryForSellVO = null;
         }
         super.onDispose();
      }
      
      public function navigateToStoreS() : void
      {
         App.utils.asserter.assertNotNull(this.navigateToStore,"navigateToStore" + Errors.CANT_NULL);
         this.navigateToStore();
      }
      
      public function selectItemS(param1:Number, param2:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.selectItem,"selectItem" + Errors.CANT_NULL);
         this.selectItem(param1,param2);
      }
      
      public function selectAllS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.selectAll,"selectAll" + Errors.CANT_NULL);
         this.selectAll(param1);
      }
      
      public function sellItemS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.sellItem,"sellItem" + Errors.CANT_NULL);
         this.sellItem(param1);
      }
      
      public function sellAllS() : void
      {
         App.utils.asserter.assertNotNull(this.sellAll,"sellAll" + Errors.CANT_NULL);
         this.sellAll();
      }
      
      public final function as_init(param1:Object) : void
      {
         var _loc2_:StorageCategoryForSellVO = this._storageCategoryForSellVO;
         this._storageCategoryForSellVO = new StorageCategoryForSellVO(param1);
         this.init(this._storageCategoryForSellVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function init(param1:StorageCategoryForSellVO) : void
      {
         var _loc2_:String = "as_init" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
