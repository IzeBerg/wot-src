package net.wg.gui.lobby.rankedBattles19.view.rewards.ranks
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.base.meta.IRankedBattlesRewardsRanksMeta;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class DivisionRewardsView extends UIComponentEx implements IDraggable, IStageSizeDependComponent
   {
      
      private static const CONTAINER_HEIGHT_ID_HIGH:String = "containerHigh";
      
      private static const CONTAINER_HEIGHT_ID_SHORT:String = "containerShort";
      
      private static const DIVISION_HEIGHT_ID_HIGH:String = "divisionHigh";
      
      private static const DIVISION_HEIGHT_ID_SHORT:String = "divisionShort";
      
      private static const SCROLL_STEP_FACTOR:Number = 10;
      
      private static const SCROLL_BAR_BOTTOM_OFFSET:Number = -7;
      
      private static const CONTAINER_TOP_PADDING_HIGH:Number = 16;
      
      private static const SCROLL_BAR_RIGHT_OFFSET:int = 70;
      
      private static const INV_REWARDS:String = "invalidateRewards";
      
      private static const INV_DIVISION_POS:String = "invalidateDivisionPosition";
      
      private static const INV_VIEW_PADDING:String = "invViewPadding";
       
      
      public var container:RewardsRanksContainer;
      
      public var scrollBar:ScrollBar = null;
      
      public var dragHitArea:Sprite = null;
      
      public var maskMc:Sprite = null;
      
      private var _rewards:Vector.<RewardsRankRendererVO> = null;
      
      private var _scrollPosition:Number = 0;
      
      private var _containerWidth:Number = 0;
      
      private var _selectedRendererPos:Number = -1;
      
      private var _contentShowAll:Boolean = true;
      
      private var _containerStartX:Number = 0;
      
      private var _containerGlobalLeftShift:Number = 0;
      
      private var _isDragging:Boolean = false;
      
      private var _dragOffset:Number = 0;
      
      private var _awardsListPlaced:Boolean = false;
      
      private var _renderersAreaSize:Rectangle = null;
      
      private var _renderersBottomOffset:int = 0;
      
      private var _rewardsIconSize:String = "";
      
      private var _rewardsCount:int = 0;
      
      private var _containerHeightID:String = "";
      
      private var _view:IRankedBattlesRewardsRanksMeta = null;
      
      private var _viewPadding:Padding;
      
      public function DivisionRewardsView()
      {
         this._viewPadding = new Padding();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         this.scrollBar.focusTarget = this;
         this.scrollBar.tabEnabled = false;
         this.scrollBar.isSmooth = true;
         this.container.addEventListener(Event.RESIZE,this.onContainerResizeHandler);
         this.container.owner = this;
         this.maskMc.visible = false;
         this.container.mask = this.maskMc;
         this._renderersAreaSize = new Rectangle();
         App.stageSizeMgr.register(this);
         if(App.cursor != null)
         {
            App.cursor.registerDragging(this,Cursors.MOVE);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_VIEW_PADDING))
         {
            this._containerGlobalLeftShift = Boolean(this._viewPadding) ? Number(this._viewPadding.left >> 1) : Number(Values.ZERO);
            invalidateSize();
         }
         if(this._rewards)
         {
            if(isInvalid(INV_REWARDS))
            {
               this.updateRewardsData();
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.updateComponentsPosition();
               this.drawScrollBar();
               this.updateScrollBar();
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         if(App.cursor != null)
         {
            App.cursor.unRegisterDragging(this);
         }
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this.container.removeEventListener(Event.RESIZE,this.onContainerResizeHandler);
         this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.dragHitArea = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.container.mask = null;
         this.container.dispose();
         this.container = null;
         this.maskMc = null;
         this._rewards = null;
         this._renderersAreaSize = null;
         this._viewPadding = null;
         this._view = null;
         super.onDispose();
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this.dragHitArea;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = (this._dragOffset - stage.mouseX) / SCROLL_STEP_FACTOR;
         this.scrollPosition = _loc3_;
      }
      
      public function onEndDrag() : void
      {
         this._isDragging = false;
      }
      
      public function onStartDrag() : void
      {
         if(this._isDragging == true || this.maxScroll < 0)
         {
            return;
         }
         this._isDragging = true;
         this._dragOffset = this._containerStartX + stage.mouseX - this.container.x;
      }
      
      public function setData(param1:Vector.<RewardsRankRendererVO>) : void
      {
         this._rewards = param1;
         invalidate(INV_REWARDS);
      }
      
      public function setSizePadding(param1:Padding) : void
      {
         if(this._viewPadding == param1)
         {
            return;
         }
         this._viewPadding = param1;
         invalidate(INV_VIEW_PADDING);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:String = CONTAINER_HEIGHT_ID_SHORT;
         if(param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            _loc3_ = CONTAINER_HEIGHT_ID_HIGH;
         }
         if(this._containerHeightID != _loc3_)
         {
            this._containerHeightID = _loc3_;
            invalidateSize();
         }
         var _loc4_:String = RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARD_SIZE_SMALL;
         if(param1 >= StageSizeBoundaries.WIDTH_2200 && param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            _loc4_ = RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARD_SIZE_BIG;
         }
         var _loc5_:int = RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARDS_COUNT_4;
         if(param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            _loc5_ = RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARDS_COUNT_7;
         }
         else if(param2 >= StageSizeBoundaries.HEIGHT_900)
         {
            _loc5_ = RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARDS_COUNT_5;
         }
         var _loc6_:int = RewardsRankRenderer.RENDERER_WIDTH_NARROW;
         if(param1 >= StageSizeBoundaries.WIDTH_2200)
         {
            _loc6_ = RewardsRankRenderer.RENDERER_WIDTH_WIDE;
         }
         else if(param1 >= StageSizeBoundaries.WIDTH_1920)
         {
            _loc6_ = RewardsRankRenderer.RENDERER_WIDTH_MIDDLE;
         }
         var _loc7_:Boolean = false;
         if(this._rewardsIconSize != _loc4_ || this._rewardsCount != _loc5_)
         {
            this._rewardsIconSize = _loc4_;
            this._rewardsCount = _loc5_;
            this.container.bonusSizeID = _loc4_;
            _loc7_ = true;
            dispatchEvent(new Event(Event.CHANGE));
         }
         this.container.setRendererWidth(_loc6_,!_loc7_);
      }
      
      private function updateRewardsData() : void
      {
         this.container.data = this._rewards;
         this._selectedRendererPos = this.container.getSelectedRendererXPos() + (this.container.width >> 1);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function updateComponentsPosition() : void
      {
         var _loc6_:Number = NaN;
         this._containerWidth = this.container.width;
         var _loc1_:Number = this.container.height;
         var _loc2_:Boolean = _width > this._containerWidth;
         var _loc3_:int = _width >> 1;
         var _loc4_:int = this._containerWidth >> 1;
         var _loc5_:int = this._containerHeightID == CONTAINER_HEIGHT_ID_SHORT ? int(Values.ZERO) : int(CONTAINER_TOP_PADDING_HIGH);
         if(_loc2_)
         {
            this._containerStartX = Math.max(_loc3_ - this._containerGlobalLeftShift,_loc4_);
         }
         else
         {
            this._containerStartX = _loc3_;
         }
         if(this.scrollBar.visible)
         {
            this._renderersBottomOffset = (this.scrollBar.height >> 1) - SCROLL_BAR_BOTTOM_OFFSET;
         }
         else
         {
            this._renderersBottomOffset = 0;
         }
         this._renderersAreaSize.y = _loc5_;
         this._renderersAreaSize.width = _width;
         this._renderersAreaSize.height = Math.min(_height - _loc5_ - this._renderersBottomOffset,_loc1_);
         this.container.y = this._renderersAreaSize.y;
         this.setDragAreaCmponentsSizes(this.dragHitArea);
         this.setDragAreaCmponentsSizes(this.maskMc);
         this.updateDragCmponents(_loc2_);
         if(_loc2_)
         {
            this.scrollPosition = Values.ZERO;
         }
         else if(this._selectedRendererPos != Values.DEFAULT_INT)
         {
            _loc6_ = this._selectedRendererPos / SCROLL_STEP_FACTOR - this.maxScroll;
            this.scrollPosition = _loc6_;
         }
         else if(this._contentShowAll)
         {
            this.scrollPosition = -this.maxScroll;
         }
         else
         {
            this.scrollPosition = this._scrollPosition;
         }
         this._contentShowAll = _loc2_;
      }
      
      private function setDragAreaCmponentsSizes(param1:DisplayObject) : void
      {
         param1.x = this._renderersAreaSize.x;
         param1.y = this._renderersAreaSize.y;
         param1.width = this._renderersAreaSize.width;
         param1.height = this._renderersAreaSize.height;
      }
      
      private function updateDragCmponents(param1:Boolean) : void
      {
         if(this._awardsListPlaced == !param1)
         {
            return;
         }
         this.dragHitArea.visible = !param1;
         this._awardsListPlaced = !param1;
      }
      
      private function drawScrollBar() : void
      {
         this.scrollBar.y = _height + SCROLL_BAR_BOTTOM_OFFSET;
         this.scrollBar.width = _width - this.scrollBar.x - SCROLL_BAR_RIGHT_OFFSET;
         this.scrollBar.validateNow();
      }
      
      private function updateScrollBar() : void
      {
         var _loc1_:Number = this.maxScroll;
         this.scrollBar.setScrollProperties(this.scrollPageSize,-_loc1_,_loc1_);
         this.scrollBar.position = this._scrollPosition;
         this.scrollBar.visible = _loc1_ > 0;
      }
      
      public function get rewardsIconSize() : String
      {
         return this._rewardsIconSize;
      }
      
      public function get rewardsCount() : int
      {
         return this._rewardsCount;
      }
      
      public function set view(param1:IRankedBattlesRewardsRanksMeta) : void
      {
         this._view = param1;
      }
      
      private function set scrollPosition(param1:Number) : void
      {
         var _loc2_:Number = this.maxScroll;
         if(_loc2_ > 0)
         {
            param1 = Math.max(-_loc2_,Math.min(_loc2_,param1));
         }
         else
         {
            param1 = 0;
         }
         this._scrollPosition = param1;
         this.container.x = Math.round(this._containerStartX - SCROLL_STEP_FACTOR * this._scrollPosition);
         this.updateScrollBar();
      }
      
      private function get scrollPageSize() : Number
      {
         return Math.ceil(_width / SCROLL_STEP_FACTOR);
      }
      
      private function get maxScroll() : Number
      {
         return (this._containerWidth - _width) / SCROLL_STEP_FACTOR / 2;
      }
      
      private function onContainerResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onScrollBarScrollHandler(param1:Event) : void
      {
         var _loc2_:Number = param1.target.position;
         if(isNaN(_loc2_))
         {
            return;
         }
         this.scrollPosition = _loc2_;
         App.contextMenuMgr.hide();
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         this.scrollPosition = this._scrollPosition - (param1.delta > 0 ? 1 : -1);
      }
   }
}
