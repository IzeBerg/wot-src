package net.wg.gui.lobby.eventBoards.components.view
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SimpleTileList;
   import net.wg.gui.components.popovers.PopOver;
   import net.wg.gui.components.popovers.PopOverConst;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableFilterVO;
   import net.wg.gui.lobby.eventBoards.events.FilterRendererEvent;
   import net.wg.infrastructure.base.meta.IEventBoardsResultFilterPopoverViewMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsResultFilterPopoverViewMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class EventBoardsResultFilterPopoverView extends EventBoardsResultFilterPopoverViewMeta implements IEventBoardsResultFilterPopoverViewMeta
   {
      
      private static const TOGGLE_TILE_WIDTH:uint = 180;
      
      private static const TOGGLE_TILE_HEIGHT:uint = 43;
      
      private static const TILE_BOTTOM_PADDING:uint = 5;
      
      private static const SEPARATOR_TOP_PADDING:uint = 23;
      
      private static const SEPARATOR_BOTTOM_PADDING:uint = 47;
      
      private static const LAYOUT_POPOVER:String = "layoutPopover";
       
      
      public var listType:SimpleTileList = null;
      
      public var infoTF:TextField = null;
      
      public var ratingButton:ISoundButtonEx = null;
      
      public var cancelBtn:ISoundButtonEx = null;
      
      public var separatorBottom:Sprite = null;
      
      private var _initData:EventBoardTableFilterVO = null;
      
      private var _selectedItem:int = -1;
      
      private var _selectedId:int = -1;
      
      private var _ratingButtonTooltip:String = "";
      
      public function EventBoardsResultFilterPopoverView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:IClassFactory = App.utils.classFactory;
         this.listType.itemRenderer = _loc1_.getClass(Linkages.LEVEL_TYPE_FLAG_TEXT_RENDERER_UI);
         this.listType.tileWidth = TOGGLE_TILE_WIDTH;
         this.listType.tileHeight = TOGGLE_TILE_HEIGHT;
         this.infoTF.htmlText = EVENT_BOARDS.POPOVER_TITLE;
         this.ratingButton.label = EVENT_BOARDS.POPOVER_BUTTONS_RATING;
         this.cancelBtn.label = EVENT_BOARDS.POPOVER_BUTTONS_CANCEL;
         this.listType.addEventListener(FilterRendererEvent.ITEM_CLICK,this.onListItemClickHandler);
         this.listType.addEventListener(Event.RESIZE,this.onListResizeHandler);
         this.ratingButton.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.ratingButton.addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.ratingButton.addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.cancelBtn.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         var _loc2_:DisplayObject = App.popoverMgr.popoverCaller as DisplayObject;
         _loc2_.addEventListener(Event.RESIZE,this.onCallerResizeHandler);
      }
      
      override protected function initLayout() : void
      {
         popoverLayout.preferredLayout = this.getPreferredLayout();
         PopOver(wrapper).isCloseBtnVisible = true;
         super.initLayout();
      }
      
      override protected function onDispose() : void
      {
         this.listType.removeEventListener(FilterRendererEvent.ITEM_CLICK,this.onListItemClickHandler);
         this.listType.removeEventListener(Event.RESIZE,this.onListResizeHandler);
         this.listType.dispose();
         this.listType = null;
         this.ratingButton.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.ratingButton.removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         this.ratingButton.removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         this.ratingButton.dispose();
         this.ratingButton = null;
         this.cancelBtn.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.cancelBtn.dispose();
         this.cancelBtn = null;
         this.separatorBottom = null;
         this.infoTF = null;
         this._initData = null;
         var _loc1_:DisplayObject = App.popoverMgr.popoverCaller as DisplayObject;
         if(_loc1_)
         {
            _loc1_.removeEventListener(Event.RESIZE,this.onCallerResizeHandler);
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._initData && isInvalid(InvalidationType.DATA))
         {
            this.listType.dataProvider = this._initData.filters;
            this._selectedItem = this._initData.selected;
            this._ratingButtonTooltip = this._initData.tooltip;
         }
         if(isInvalid(LAYOUT_POPOVER))
         {
            updateCallerGlobalPosition();
            popoverLayout.invokeLayout();
            this.separatorBottom.y = this.listType.y + this.listType.height + TILE_BOTTOM_PADDING;
            this.cancelBtn.y = this.ratingButton.y = this.separatorBottom.y + SEPARATOR_TOP_PADDING;
            this.height = this.cancelBtn.y + SEPARATOR_BOTTOM_PADDING;
         }
      }
      
      protected function getPreferredLayout() : int
      {
         return PopOverConst.ARROW_RIGHT;
      }
      
      override protected function setInitData(param1:EventBoardTableFilterVO) : void
      {
         App.utils.asserter.assertNull(this._initData,"Reinitialization EventBoardsFilterPopover");
         this._initData = param1;
         invalidateData();
      }
      
      private function onCallerResizeHandler(param1:Event) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         invalidate(LAYOUT_POPOVER);
      }
      
      private function onListItemClickHandler(param1:FilterRendererEvent) : void
      {
         this._selectedItem = param1.index;
         this._selectedId = param1.id;
         this.clearSelection();
         param1.stopPropagation();
      }
      
      private function onListResizeHandler(param1:Event) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         invalidate(LAYOUT_POPOVER);
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         if(param1.target == this.ratingButton && this._selectedItem != Values.DEFAULT_INT)
         {
            changeFilterS(this._selectedId);
         }
         onWindowCloseS();
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
         if(this._selectedItem != Values.DEFAULT_INT)
         {
            this.listType.getRendererAt(this._selectedItem).selected = true;
         }
      }
      
      private function onButtonRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._ratingButtonTooltip);
      }
      
      private function onButtonRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
