package net.wg.gui.lobby.storage.categories.blueprints
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import net.wg.data.VO.FilterDAAPIDataProvider;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.lobby.storage.categories.cards.BlueprintCardVO;
   import net.wg.gui.lobby.storage.categories.cards.CardEvent;
   import net.wg.gui.lobby.storage.data.BlueprintsFragmentVO;
   import net.wg.infrastructure.base.meta.IStorageCategoryBlueprintsViewMeta;
   import net.wg.infrastructure.base.meta.impl.StorageCategoryBlueprintsViewMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class StorageCategoryBlueprintsView extends StorageCategoryBlueprintsViewMeta implements IStorageCategoryBlueprintsViewMeta, IStageSizeDependComponent
   {
      
      private static const CAROUSEL_TOP_OFFSET:int = 20;
      
      private static const CAROUSEL_BOTTOM_OFFSET:int = 30;
      
      private static const NO_ITEM_VIEW_X_OFFSET:int = 4;
      
      private static const NO_ITEM_VIEW_Y_OFFSET:int = -40;
      
      private static const CAROUSEL_Y_OFFSET_BIG:int = 30;
      
      private static const CAROUSEL_Y_OFFSET_SMALL:int = 0;
       
      
      public var title:TextField;
      
      public var barTitle:TextField;
      
      public var filtersBlock:BlueprintsFilterBlock = null;
      
      public var noItemsView:BlueprintsNoItemsView;
      
      public var intelligenceFragments:BlueprintFragmentRenderer;
      
      public var fragmentsSeparator:MovieClip;
      
      public var fragmentsBar:BlueprintFragmentsBar;
      
      private var _carouselOffsetY:int = 0;
      
      private var _initialYPositions:Dictionary;
      
      public function StorageCategoryBlueprintsView()
      {
         this._initialYPositions = new Dictionary();
         super();
      }
      
      override public function as_scrollToItem(param1:int) : void
      {
         var _loc4_:BlueprintCardVO = null;
         var _loc2_:IDataProvider = carousel.dataProvider;
         var _loc3_:int = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.requestItemAt(_loc5_) as BlueprintCardVO;
            if(_loc4_ && _loc4_.id == param1)
            {
               carousel.goToItem(_loc5_,false,true);
               break;
            }
            _loc5_++;
         }
      }
      
      override public function as_showDummyScreen(param1:Boolean) : void
      {
         super.as_showDummyScreen(param1);
         this.filtersBlock.visible = !param1;
      }
      
      override protected function hasNoFilterWarningView() : Boolean
      {
         return true;
      }
      
      override protected function updateNationalFragments(param1:DataProvider) : void
      {
         this.fragmentsBar.dataProvider = param1;
         invalidateSize();
      }
      
      override protected function updateIntelligenceData(param1:BlueprintsFragmentVO) : void
      {
         this.intelligenceFragments.update(param1);
         invalidateSize();
      }
      
      override protected function getNewCardDP() : IDataProvider
      {
         return new FilterDAAPIDataProvider(BlueprintCardVO);
      }
      
      override protected function onDispose() : void
      {
         this.title = null;
         this.barTitle = null;
         this.fragmentsBar.dispose();
         this.fragmentsBar = null;
         carousel.removeEventListener(CardEvent.SELL,this.onCardSellHandler);
         this.filtersBlock.removeEventListener(FiltersEvent.SEARCH_VALUE_CHANGED,this.onFiltersBlockSearchValueChangedHandler);
         this.filtersBlock.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersBlockFiltersChangedHandler);
         this.filtersBlock.removeEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
         this.filtersBlock.dispose();
         this.filtersBlock = null;
         this.noItemsView.dispose();
         this.noItemsView = null;
         this.intelligenceFragments.dispose();
         this.intelligenceFragments = null;
         this.fragmentsSeparator = null;
         App.utils.data.cleanupDynamicObject(this._initialYPositions);
         this._initialYPositions = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.stageSizeMgr.register(this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.text = STORAGE.BLUEPRINTS_TITLE;
         this.title.mouseWheelEnabled = this.title.mouseEnabled = false;
         this.barTitle.text = STORAGE.BLUEPRINTS_NATIONBAR_TITLE;
         this.barTitle.autoSize = TextFieldAutoSize.LEFT;
         carousel.scrollList.itemRendererClassReference = Linkages.BLUEPRINTS_CARD_RENDERER;
         carousel.scrollList.paddingTop = CAROUSEL_TOP_OFFSET;
         carousel.scrollList.paddingBottom = CAROUSEL_BOTTOM_OFFSET;
         carousel.addEventListener(CardEvent.SELL,this.onCardSellHandler);
         this.filtersBlock.addEventListener(FiltersEvent.SEARCH_VALUE_CHANGED,this.onFiltersBlockSearchValueChangedHandler);
         this.filtersBlock.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onFiltersBlockFiltersChangedHandler);
         this.filtersBlock.addEventListener(FiltersEvent.RESET_ALL_FILTERS,this.onFiltersBlockResetAllFiltersHandler);
         this.saveInitialYPositionForGroup(carousel,scrollBar,this.filtersBlock);
      }
      
      override protected function draw() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         if(_loc1_)
         {
            this.setupPositionYOffsetForGroup(this._carouselOffsetY,carousel,scrollBar,this.filtersBlock);
         }
         super.draw();
         if(_loc1_)
         {
            this.filtersBlock.x = carousel.x;
            this.filtersBlock.width = carousel.width;
            this.title.x = this.barTitle.x = carousel.x;
            if(this.fragmentsBar.dataProvider != null)
            {
               _loc3_ = this.intelligenceFragments.width;
               _loc4_ = this.fragmentsBar.dataProvider.length;
               _loc5_ = (_loc4_ + 1) * _loc3_ + this.fragmentsSeparator.width;
               _loc6_ = _loc4_ + 1;
               _loc7_ = (carousel.width - _loc5_) / _loc6_;
               this.intelligenceFragments.x = carousel.x;
               this.fragmentsSeparator.x = this.intelligenceFragments.x + _loc3_ + _loc7_;
               this.fragmentsBar.x = this.fragmentsSeparator.x + this.fragmentsSeparator.width + _loc7_;
               this.fragmentsBar.width = carousel.width - _loc3_ - this.fragmentsSeparator.width - 2 * _loc7_;
            }
            this.noItemsView.validateNow();
            this.noItemsView.x = Math.max(carousel.x,(width - this.noItemsView.actualWidth >> 1) + NO_ITEM_VIEW_X_OFFSET);
            _loc2_ = this.fragmentsBar.y + this.fragmentsBar.height;
            this.noItemsView.y = _loc2_ + (height - _loc2_ - this.noItemsView.actualHeight >> 1) + NO_ITEM_VIEW_Y_OFFSET;
         }
      }
      
      override protected function onDummyEvent(param1:String) : void
      {
         resetFilterS();
      }
      
      public function as_updateCounter(param1:Boolean, param2:String, param3:Boolean) : void
      {
         this.filtersBlock.updateCounter(param1,param2,param3);
      }
      
      public function as_updateSearch(param1:String, param2:String, param3:String, param4:int) : void
      {
         this.filtersBlock.updateSearch(param1,param2,param3,param4);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         invalidateSize();
         this._carouselOffsetY = param1 < StageSizeBoundaries.WIDTH_1600 ? int(CAROUSEL_Y_OFFSET_SMALL) : int(CAROUSEL_Y_OFFSET_BIG);
      }
      
      private function saveInitialYPositionForGroup(... rest) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in rest)
         {
            this._initialYPositions[_loc2_] = _loc2_.y;
         }
      }
      
      private function setupPositionYOffsetForGroup(param1:int, ... rest) : void
      {
         var _loc3_:DisplayObject = null;
         for each(_loc3_ in rest)
         {
            _loc3_.y = this._initialYPositions[_loc3_] + param1;
         }
      }
      
      override public function get noItemsComponent() : UIComponent
      {
         return this.noItemsView;
      }
      
      private function onFiltersBlockSearchValueChangedHandler(param1:FiltersEvent) : void
      {
         changeSearchNameVehicleS(param1.searchValue);
      }
      
      private function onFiltersBlockResetAllFiltersHandler(param1:FiltersEvent) : void
      {
         resetFilterS();
      }
      
      private function onCardSellHandler(param1:CardEvent) : void
      {
         navigateToBlueprintScreenS(param1.data.id);
      }
      
      private function onFiltersBlockFiltersChangedHandler(param1:FiltersEvent) : void
      {
         selectConvertibleS(Boolean(param1.filtersValue));
      }
      
      public function as_updateCanConvert(param1:Boolean) : void
      {
         this.filtersBlock.updateCanConvert(param1);
      }
   }
}
