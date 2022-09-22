package net.wg.gui.lobby.storage.categories.storage
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.storage.data.StorageNationFilterVO;
   import net.wg.infrastructure.base.meta.impl.ItemsWithTypeAndNationFilterTabViewMeta;
   
   public class ItemsWithTypeAndNationFilterTabView extends ItemsWithTypeAndNationFilterTabViewMeta
   {
      
      private static const NO_BOOKS_FRAME_NAME:String = "crewBooks";
       
      
      private var _currentFiltersBlock:StorageTypeAndNationFilterBlock;
      
      public function ItemsWithTypeAndNationFilterTabView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._currentFiltersBlock = filtersBlock as StorageTypeAndNationFilterBlock;
         App.utils.asserter.assertNotNull(this._currentFiltersBlock,"_currentFiltersBlock " + Errors.CANT_NULL);
         this._currentFiltersBlock.addEventListener(FiltersEvent.NATION_FILTER_CHANGED,this.onNationIndexChangeHandler);
      }
      
      override protected function initNoItemsView() : void
      {
         noItemsView.noItemsMc.gotoAndStop(NO_BOOKS_FRAME_NAME);
         noItemsView.setTexts(STORAGE.CREWBOOKS_NOITEMS_INFO);
      }
      
      override protected function disposeNoItemsView() : void
      {
      }
      
      override protected function onDispose() : void
      {
         this._currentFiltersBlock.removeEventListener(FiltersEvent.NATION_FILTER_CHANGED,this.onNationIndexChangeHandler);
         this._currentFiltersBlock = null;
         super.onDispose();
      }
      
      override protected function initNationFilter(param1:StorageNationFilterVO) : void
      {
         this._currentFiltersBlock.initNationFilter(param1);
      }
      
      private function onNationIndexChangeHandler(param1:FiltersEvent) : void
      {
         selectNationS(param1.filtersValue);
      }
   }
}
