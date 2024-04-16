package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.SortableTable;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.components.VehicleSelectorFilter;
   import net.wg.gui.lobby.components.data.VehicleSelectorFilterVO;
   import net.wg.gui.lobby.components.events.VehicleSelectorFilterEvent;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsVehiclesOverlayVO;
   import net.wg.gui.lobby.eventBoards.events.FilterRendererEvent;
   import net.wg.infrastructure.base.meta.IEventBoardsVehiclesOverlayMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsVehiclesOverlayMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class EventBoardsDetailsVehiclesView extends EventBoardsVehiclesOverlayMeta implements IEventBoardsVehiclesOverlayMeta
   {
      
      private static const TOGGLE_TILE_WIDTH:uint = 45;
      
      private static const TOGGLE_TILE_HEIGHT:uint = 22;
      
      private static const TOGGLE_TILE_GAP:uint = 5;
      
      private static const TABLE_TOP_POSITION:uint = 88;
      
      private static const BG_WIDTH:int = 750;
      
      private static const BG_HEIGHT:int = 415;
      
      private static const INV_BACKGROUND:String = "InvBackground";
      
      private static const INV_FILTERS:String = "InvFilters";
       
      
      public var titleTf:TextField = null;
      
      public var separatorTop:ISeparatorAsset = null;
      
      public var separatorBottom:Sprite = null;
      
      public var listType:SimpleTileList = null;
      
      public var filtersView:VehicleSelectorFilter;
      
      public var table:SortableTable = null;
      
      public var bgLoader:UILoaderAlt;
      
      private var _headerData:EventBoardTableFilterVO = null;
      
      private var _filtersData:VehicleSelectorFilterVO = null;
      
      private var _vehiclesData:EventBoardsVehiclesOverlayVO = null;
      
      private var _selectedIndex:int = -1;
      
      private var _selectedId:int = -1;
      
      public function EventBoardsDetailsVehiclesView()
      {
         super();
      }
      
      override protected function setHeader(param1:EventBoardTableFilterVO) : void
      {
         this._headerData = param1;
         invalidateData();
      }
      
      override protected function setFilters(param1:VehicleSelectorFilterVO) : void
      {
         this._filtersData = param1;
         invalidate(INV_FILTERS);
      }
      
      override protected function setVehicles(param1:EventBoardsVehiclesOverlayVO) : void
      {
         this._vehiclesData = param1;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._headerData && isInvalid(InvalidationType.DATA))
         {
            this.listType.visible = true;
            this.filtersView.visible = false;
            this.listType.dataProvider = this._headerData.filters;
         }
         if(this._filtersData && isInvalid(INV_FILTERS))
         {
            this.filtersView.setData(this._filtersData);
            this.filtersView.visible = true;
            this.listType.visible = false;
            this.filtersView.compatibleOnlyCheckBox.visible = false;
            this.filtersView.validateNow();
         }
         if(this._vehiclesData && isInvalid(InvalidationType.DATA))
         {
            this.table.listDP = this._vehiclesData.vehicles;
            this.table.scrollPosition = 0;
            this.bgLoader.source = this._vehiclesData.bgPath;
            this.titleTf.htmlText = this._vehiclesData.title;
         }
         if(isInvalid(INV_BACKGROUND))
         {
            this.bgLoader.width = BG_WIDTH;
            this.bgLoader.height = BG_HEIGHT;
            this.bgLoader.x = 0;
            this.bgLoader.y = TABLE_TOP_POSITION;
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         super.onBeforeDispose();
         this.listType.removeEventListener(FilterRendererEvent.ITEM_CLICK,this.onListTypeItemClickHandler);
         this.filtersView.removeEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         this.bgLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
      }
      
      override protected function onDispose() : void
      {
         this.bgLoader.dispose();
         this.bgLoader = null;
         this.titleTf = null;
         this.separatorTop.dispose();
         this.separatorTop = null;
         this.filtersView.dispose();
         this.filtersView = null;
         this.listType.dispose();
         this.listType = null;
         this._vehiclesData = null;
         this._headerData = null;
         this._filtersData = null;
         this.table.dispose();
         this.table = null;
         this.separatorBottom = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.filtersView.visible = false;
         this.filtersView.mode = VehicleSelectorFilter.MODE_USER_VEHICLES;
         this.listType.visible = false;
         this.separatorTop.setType(SeparatorConstants.MEDIUM_TYPE);
         this.separatorTop.mouseEnabled = false;
         this.separatorBottom.mouseEnabled = false;
         this.listType.tileWidth = TOGGLE_TILE_WIDTH;
         this.listType.tileHeight = TOGGLE_TILE_HEIGHT;
         this.listType.horizontalGap = TOGGLE_TILE_GAP;
         this.listType.directionMode = DirectionMode.HORIZONTAL;
         this.listType.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         var _loc1_:IClassFactory = App.utils.classFactory;
         this.listType.itemRenderer = _loc1_.getClass(Linkages.LEVEL_TYPE_FLAG_RENDERER_UI);
         this.listType.addEventListener(FilterRendererEvent.ITEM_CLICK,this.onListTypeItemClickHandler);
         this.filtersView.addEventListener(VehicleSelectorFilterEvent.CHANGE,this.onFiltersViewChangeHandler);
         this.bgLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.bgLoader.autoSize = false;
         this.table.headerHeight = 0;
         this.table.isSortable = false;
         this.table.isListSelectable = false;
         this.table.y = TABLE_TOP_POSITION;
         this.table.scrollbarPadding = {
            "top":8,
            "bottom":8,
            "left":0,
            "right":-150
         };
      }
      
      private function onListTypeItemClickHandler(param1:FilterRendererEvent) : void
      {
         this._selectedIndex = param1.index;
         this._selectedId = param1.id;
         this.clearSelection();
         if(this._selectedIndex != Values.DEFAULT_INT)
         {
            changeFilterS(this._selectedId);
         }
         param1.stopPropagation();
      }
      
      private function clearSelection() : void
      {
         var _loc1_:int = this.listType.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.listType.getRendererAt(_loc2_).selected = false;
            _loc2_++;
         }
         if(this._selectedIndex != Values.DEFAULT_INT)
         {
            this.listType.getRendererAt(this._selectedIndex).selected = true;
         }
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         invalidate(INV_BACKGROUND);
      }
      
      private function onFiltersViewChangeHandler(param1:VehicleSelectorFilterEvent) : void
      {
         applyFiltersS(param1.nation,param1.vehicleType,param1.level,param1.isMain,false);
      }
   }
}
