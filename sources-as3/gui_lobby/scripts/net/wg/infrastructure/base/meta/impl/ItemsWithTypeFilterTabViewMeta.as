package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.storage.categories.BaseCategoryView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ItemsWithTypeFilterTabViewMeta extends BaseCategoryView
   {
       
      
      public var sellItem:Function;
      
      public var resetFilter:Function;
      
      public var onFiltersChange:Function;
      
      public var navigateToStore:Function;
      
      public var upgradeItem:Function;
      
      private var _buttonFiltersVO:ButtonFiltersVO;
      
      public function ItemsWithTypeFilterTabViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._buttonFiltersVO)
         {
            this._buttonFiltersVO.dispose();
            this._buttonFiltersVO = null;
         }
         super.onDispose();
      }
      
      public function sellItemS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.sellItem,"sellItem" + Errors.CANT_NULL);
         this.sellItem(param1);
      }
      
      public function resetFilterS() : void
      {
         App.utils.asserter.assertNotNull(this.resetFilter,"resetFilter" + Errors.CANT_NULL);
         this.resetFilter();
      }
      
      public function onFiltersChangeS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onFiltersChange,"onFiltersChange" + Errors.CANT_NULL);
         this.onFiltersChange(param1);
      }
      
      public function navigateToStoreS() : void
      {
         App.utils.asserter.assertNotNull(this.navigateToStore,"navigateToStore" + Errors.CANT_NULL);
         this.navigateToStore();
      }
      
      public function upgradeItemS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.upgradeItem,"upgradeItem" + Errors.CANT_NULL);
         this.upgradeItem(param1);
      }
      
      public final function as_initTypeFilter(param1:Object) : void
      {
         var _loc2_:ButtonFiltersVO = this._buttonFiltersVO;
         this._buttonFiltersVO = new ButtonFiltersVO(param1);
         this.initTypeFilter(this._buttonFiltersVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function initTypeFilter(param1:ButtonFiltersVO) : void
      {
         var _loc2_:String = "as_initTypeFilter" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
