package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.EVENTBOARDS_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.cyberSport.controls.interfaces.IVehicleButton;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsAwardsOverlayVO;
   import net.wg.gui.lobby.eventBoards.events.FilterRendererEvent;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.meta.IEventBoardsAwardsOverlayMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsAwardsOverlayMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class EventBoardsDetailsAwardsView extends EventBoardsAwardsOverlayMeta implements IEventBoardsAwardsOverlayMeta, IPopOverCaller
   {
      
      private static const TOGGLE_TILE_WIDTH:uint = 45;
      
      private static const TOGGLE_TILE_HEIGHT:uint = 22;
      
      private static const TOGGLE_TILE_GAP:uint = 5;
      
      private static const TABLE_TOP_POSITION:uint = 88;
      
      private static const BG_WIDTH:int = 750;
      
      private static const BG_HEIGHT:int = 415;
      
      private static const INV_BACKGROUND:String = "InvBackground";
      
      private static const INV_HEADER:String = "InvHeader";
      
      private static const INV_VEHICLE:String = "InvVehicle";
       
      
      public var titleTf:TextField = null;
      
      public var separatorTop:ISeparatorAsset = null;
      
      public var separatorBottom:Sprite = null;
      
      public var listType:SimpleTileList = null;
      
      public var vehicleBtn:IVehicleButton = null;
      
      public var awardsTable:EventBoardsDetailsAwardsTableContent = null;
      
      public var bgLoader:UILoaderAlt;
      
      private var _headerData:EventBoardTableFilterVO = null;
      
      private var _vehicleData:VehicleVO = null;
      
      private var _awardsData:EventBoardsAwardsOverlayVO = null;
      
      private var _selectedIndex:int = -1;
      
      private var _selectedId:int = -1;
      
      private var _eventId:String = "";
      
      public function EventBoardsDetailsAwardsView()
      {
         super();
      }
      
      public function getTargetButton() : DisplayObject
      {
         return DisplayObject(this.vehicleBtn);
      }
      
      public function getHitArea() : DisplayObject
      {
         return DisplayObject(this.vehicleBtn);
      }
      
      override protected function setHeader(param1:EventBoardTableFilterVO) : void
      {
         this._headerData = param1;
         invalidate(INV_HEADER);
      }
      
      override protected function setVehicle(param1:VehicleVO) : void
      {
         this._vehicleData = param1;
         invalidate(INV_VEHICLE);
      }
      
      override protected function setData(param1:EventBoardsAwardsOverlayVO) : void
      {
         this._awardsData = param1;
         this._eventId = param1.eventID;
         invalidateData();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._headerData && isInvalid(INV_HEADER))
         {
            this.listType.visible = true;
            this.vehicleBtn.visible = false;
            this.listType.dataProvider = this._headerData.filters;
         }
         if(this._vehicleData && isInvalid(INV_VEHICLE))
         {
            this.listType.visible = false;
            this.vehicleBtn.visible = true;
            this.vehicleBtn.setVehicle(this._vehicleData);
         }
         if(this._awardsData && isInvalid(InvalidationType.DATA))
         {
            this.awardsTable.setData(this._awardsData.awardsTableVO);
            this.titleTf.htmlText = this._awardsData.title;
            this.bgLoader.source = this._awardsData.bgPath;
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
         this.bgLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onVehicleButtonRollOverHandler);
         this.vehicleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onVehicleButtonRollOutHandler);
         this.vehicleBtn.removeEventListener(ButtonEvent.CLICK,this.onVehicleButtonClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.bgLoader.dispose();
         this.bgLoader = null;
         this.titleTf = null;
         this.separatorTop.dispose();
         this.separatorTop = null;
         this.listType.dispose();
         this.listType = null;
         this.vehicleBtn.dispose();
         this.vehicleBtn = null;
         this.awardsTable.dispose();
         this.awardsTable = null;
         this._awardsData = null;
         this._vehicleData = null;
         this._headerData = null;
         this.separatorBottom = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.separatorTop.setType(SeparatorConstants.MEDIUM_TYPE);
         this.listType.tileWidth = TOGGLE_TILE_WIDTH;
         this.listType.tileHeight = TOGGLE_TILE_HEIGHT;
         this.listType.horizontalGap = TOGGLE_TILE_GAP;
         this.listType.directionMode = DirectionMode.HORIZONTAL;
         this.listType.renderersAlign = SimpleTileList.RENDERERS_ALIGN_CENTER;
         var _loc1_:IClassFactory = App.utils.classFactory;
         this.listType.itemRenderer = _loc1_.getClass(Linkages.LEVEL_TYPE_FLAG_RENDERER_UI);
         this.listType.addEventListener(FilterRendererEvent.ITEM_CLICK,this.onListTypeItemClickHandler);
         this.bgLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.bgLoader.autoSize = false;
         this.separatorTop.mouseEnabled = false;
         this.separatorBottom.mouseEnabled = false;
         this.awardsTable.y = TABLE_TOP_POSITION;
         this.vehicleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onVehicleButtonRollOverHandler);
         this.vehicleBtn.addEventListener(MouseEvent.ROLL_OUT,this.onVehicleButtonRollOutHandler);
         this.vehicleBtn.addEventListener(ButtonEvent.CLICK,this.onVehicleButtonClickHandler);
         this.listType.visible = false;
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
      
      private function onVehicleButtonRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CYBER_SPORT_SELECTED_VEHICLE,null,this._vehicleData.intCD);
      }
      
      private function onVehicleButtonRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onVehicleButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.caller = "awards";
         _loc2_.eventID = this._eventId;
         App.popoverMgr.show(this,EVENTBOARDS_ALIASES.RESULT_FILTER_POPOVER_VEHICLES_ALIAS,_loc2_);
      }
   }
}
