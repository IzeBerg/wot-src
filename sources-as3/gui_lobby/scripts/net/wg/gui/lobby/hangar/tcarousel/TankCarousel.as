package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.VO.TankCarouselFilterSelectedVO;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.carousels.filters.TankCarouselFilters;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
   import net.wg.infrastructure.base.meta.impl.TankCarouselMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class TankCarousel extends TankCarouselMeta implements ITankCarousel
   {
      
      private static const HELP_ID_SEPARATOR:String = "_";
      
      private static const FILTERS_WIDTH:Number = 58;
      
      private static const ARROW_WIDTH:Number = 24;
      
      private static const ELASTICITY:Number = 0.25;
      
      private static const MASK_SIDE_OFFSET:int = -10;
      
      private static const MASK_TOP_OFFSET_DEFAULT:int = -12;
      
      private static const MASK_BOTTOM_OFFSET_DEFAULT:int = 0;
      
      private static const MASK_TOP_OFFSET_EPIC_BIG:int = -10;
      
      private static const MASK_TOP_OFFSET_EPIC_SMALL:int = -20;
      
      private static const MASK_BOTTOM_OFFSET_EPIC_BIG:int = -8;
      
      private static const MASK_BOTTOM_OFFSET_EPIC_SMALL:int = -17;
      
      private static const THROW_ACCELERATION_RATE:int = 4;
      
      private static const OFFSET_FILTERS:int = 20;
      
      private static const OFFSET_ARROW:int = 14;
      
      private static const OFFSET_CAROUSEL:int = 10;
      
      private static const THRESHOLD:int = 809;
      
      private static const GO_TO_OFFSET:Number = 0.5;
      
      private static const INV_ROW_COUNT:String = "invRowCount";
      
      private static const HIT_AREA_NAME:String = "emptyHitArea";
      
      private static const INVALID_SCROLL_POS:String = "InvalidScrollPos";
      
      private static const OPTIMIZE_OFFSET:int = 10;
       
      
      public var vehicleFilters:TankCarouselFilters = null;
      
      public var background:MovieClip = null;
      
      private var _carouselHelpLayoutId:String = null;
      
      private var _filtersHelpLayoutId:String = null;
      
      private var _stageHeight:Number = 0;
      
      private var _rowCount:int = 1;
      
      private var _helper:ITankCarouselHelper = null;
      
      private var _smallDoubleCarouselEnable:Boolean = false;
      
      private var _listVisibleHeight:int = -1;
      
      private var _itemIndexToScroll:int = -1;
      
      private var _rightMargin:int = 0;
      
      public function TankCarousel()
      {
         super();
      }
      
      override public function as_populate() : void
      {
         super.as_populate();
         App.graphicsOptimizationMgr.register(this);
      }
      
      override protected function updateLayout(param1:int, param2:int = 0) : void
      {
         var _loc3_:Number = param2 + OFFSET_ARROW;
         var _loc4_:int = FILTERS_WIDTH + OFFSET_FILTERS;
         if(this.vehicleFilters.visible)
         {
            _loc3_ += _loc4_;
         }
         var _loc5_:Number = param1 - _loc3_ - OFFSET_ARROW - this._rightMargin >> 0;
         this.background.width = param1 >> 0;
         var _loc6_:int = _loc5_ + leftArrowOffset - rightArrowOffset >> 0;
         super.updateLayout(_loc5_,(_loc5_ - _loc6_ >> 1) + _loc3_ >> 0);
         leftArrow.x = !!this.vehicleFilters.visible ? Number(param2 + _loc4_ + OFFSET_ARROW) : Number(OFFSET_ARROW);
         startFadeMask.x = scrollList.x = leftArrow.x + ARROW_WIDTH + OFFSET_CAROUSEL;
         endFadeMask.x = rightArrow.x - rightArrow.width - endFadeMask.width >> 0;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         endFadeMask.mouseEnabled = false;
         startFadeMask.mouseEnabled = false;
         roundCountRenderer = false;
         var _loc1_:ScrollConfig = new ScrollConfig();
         _loc1_.elasticity = ELASTICITY;
         _loc1_.throwAccelerationRate = THROW_ACCELERATION_RATE;
         scrollList.scrollConfig = _loc1_;
         scrollList.useTimer = true;
         scrollList.hasHorizontalElasticEdges = true;
         scrollList.snapScrollPositionToItemRendererSize = false;
         scrollList.snapToPages = true;
         scrollList.cropContent = true;
         scrollList.maskOffsetLeft = scrollList.maskOffsetRight = MASK_SIDE_OFFSET;
         scrollList.maskOffsetTop = MASK_TOP_OFFSET_DEFAULT;
         scrollList.goToOffset = GO_TO_OFFSET;
         this._helper = this.getNewHelper();
         this.updateScrollListSettings();
         leftArrow.mouseEnabledOnDisabled = rightArrow.mouseEnabledOnDisabled = true;
         addEventListener(TankItemEvent.SELECT_BUY_SLOT,this.onSelectBuySlotHandler);
         addEventListener(TankItemEvent.SELECT_BUY_TANK,this.onSelectBuyTankHandler);
         addEventListener(TankItemEvent.SELECT_RESTORE_TANK,this.onSelectRestoreTankHandler);
         addEventListener(TankItemEvent.SELECT_RENT_PROMOTION_SLOT,this.onSelectRentPromotionSlotHandler);
         addEventListener(TankItemEvent.SELECT_WOT_PLUS_VEHICLE,this.onSelectWotPlusVehicleHandler);
         this.vehicleFilters.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
         this.vehicleFilters.addEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
         this.background.mouseEnabled = false;
         this.background.mouseChildren = false;
         var _loc2_:Sprite = new Sprite();
         _loc2_.name = HIT_AREA_NAME;
         addChild(_loc2_);
         this.background.hitArea = _loc2_;
         mouseEnabled = false;
         App.utils.helpLayout.registerComponent(this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc2_:Boolean = isInvalid(INV_ROW_COUNT);
         if(_loc1_)
         {
            this._helper = this.getNewHelper();
         }
         if(_loc2_)
         {
            scrollList.rowCount = this._rowCount;
            goToSelectedItem();
            invalidate(InvalidationType.SETTINGS);
         }
         if(_loc1_ || _loc2_)
         {
            this.checkMaskOffsets();
         }
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.updateScrollListSettings();
         }
         if(isInvalid(INVALID_SCROLL_POS))
         {
            if(this._itemIndexToScroll != Values.DEFAULT_INT)
            {
               scrollList.validateNow();
               scrollList.goToItem(this._itemIndexToScroll,true,true);
            }
            this._itemIndexToScroll = Values.DEFAULT_INT;
         }
         super.draw();
         if(_loc1_)
         {
            if(scrollList.pageWidth == 0)
            {
               scrollList.validateNow();
            }
            this.updateLayout(width);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function updateSelectedIndex() : void
      {
         super.updateSelectedIndex();
         goToSelectedItem();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(TankItemEvent.SELECT_BUY_SLOT,this.onSelectBuySlotHandler);
         removeEventListener(TankItemEvent.SELECT_BUY_TANK,this.onSelectBuyTankHandler);
         removeEventListener(TankItemEvent.SELECT_RESTORE_TANK,this.onSelectRestoreTankHandler);
         removeEventListener(TankItemEvent.SELECT_RENT_PROMOTION_SLOT,this.onSelectRentPromotionSlotHandler);
         removeEventListener(TankItemEvent.SELECT_WOT_PLUS_VEHICLE,this.onSelectWotPlusVehicleHandler);
         App.contextMenuMgr.hide();
         this.vehicleFilters.removeEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
         this.vehicleFilters.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
         this.vehicleFilters.dispose();
         this.vehicleFilters = null;
         this.background = null;
         this._helper = null;
         super.onDispose();
      }
      
      override protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
      {
         this.vehicleFilters.visible = param1.isVisible;
         this.vehicleFilters.initData(param1);
      }
      
      override protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO) : void
      {
         this.vehicleFilters.setSelectedData(param1);
      }
      
      public function as_rowCount(param1:int) : void
      {
         if(this._rowCount != param1)
         {
            this._rowCount = param1;
            invalidate(InvalidationType.SIZE,INV_ROW_COUNT);
         }
      }
      
      public function as_scrollToSlot(param1:int) : void
      {
         this._itemIndexToScroll = param1;
         invalidate(INVALID_SCROLL_POS);
      }
      
      public function as_setSmallDoubleCarousel(param1:Boolean) : void
      {
         this._smallDoubleCarouselEnable = param1;
         invalidateSize();
      }
      
      public function as_useExtendedCarousel(param1:Boolean) : void
      {
         scrollList.useExtendedViewPort = param1;
         this.checkMaskOffsets();
      }
      
      public function getAliasS() : String
      {
         return getCarouselAliasS();
      }
      
      public function getBottom() : Number
      {
         return this.background.height + this.background.y;
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
         if(StringUtils.isEmpty(this._carouselHelpLayoutId))
         {
            this._carouselHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
         }
         var _loc2_:HelpLayoutVO = new HelpLayoutVO();
         _loc2_.x = leftArrow.x;
         _loc2_.y = scrollList.y;
         _loc2_.width = rightArrow.x - leftArrow.x;
         _loc2_.height = scrollList.height;
         _loc2_.extensibilityDirection = Directions.RIGHT;
         _loc2_.message = LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL;
         _loc2_.id = name + HELP_ID_SEPARATOR + Math.random();
         _loc2_.scope = this;
         _loc1_.push(_loc2_);
         if(StringUtils.isEmpty(this._filtersHelpLayoutId))
         {
            this._filtersHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
         }
         var _loc3_:HelpLayoutVO = new HelpLayoutVO();
         _loc3_.x = this.vehicleFilters.x;
         _loc3_.y = this.vehicleFilters.y;
         _loc3_.width = this.vehicleFilters.width;
         _loc3_.height = this.vehicleFilters.height;
         _loc3_.extensibilityDirection = Directions.RIGHT;
         _loc3_.message = LOBBY_HELP.HANGAR_VEHFILTERS;
         _loc3_.id = this._filtersHelpLayoutId;
         _loc3_.scope = this;
         _loc1_.push(_loc3_);
         return _loc1_;
      }
      
      public function getRectangles() : Vector.<Rectangle>
      {
         if(!visible || !stage || !parent.visible)
         {
            return null;
         }
         var _loc1_:int = getBounds(App.stage).y - this.background.y + OPTIMIZE_OFFSET;
         return new <Rectangle>[new Rectangle(x,_loc1_,App.appWidth,App.appHeight - _loc1_)];
      }
      
      public function setRightMargin(param1:int) : void
      {
         this._rightMargin = param1;
         invalidateSize();
      }
      
      public function updateCarouselPosition(param1:Number) : void
      {
         if(y != param1)
         {
            y = param1;
            dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_GRAPHICS_RECTANGLES_UPDATE));
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         width = param1;
         this._stageHeight = param2;
         invalidate(InvalidationType.SIZE);
      }
      
      protected function getNewHelper() : ITankCarouselHelper
      {
         var _loc1_:ITankCarouselHelper = this._helper;
         var _loc2_:Boolean = this._rowCount > 1;
         if(_loc2_ && (this._stageHeight < THRESHOLD || this._smallDoubleCarouselEnable))
         {
            if(!(_loc1_ is SmallTankCarouselHelper))
            {
               _loc1_ = this.createSmallHelper();
               invalidate(InvalidationType.SETTINGS);
            }
         }
         else if(!(_loc1_ is TankCarouselHelper))
         {
            _loc1_ = this.createNormalHelper();
            invalidate(InvalidationType.SETTINGS);
         }
         return _loc1_;
      }
      
      protected function createSmallHelper() : ITankCarouselHelper
      {
         return new SmallTankCarouselHelper();
      }
      
      protected function createNormalHelper() : ITankCarouselHelper
      {
         return new TankCarouselHelper();
      }
      
      private function checkMaskOffsets() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(scrollList.useExtendedViewPort)
         {
            _loc3_ = this._rowCount > 1;
            _loc4_ = _loc3_ && (this._stageHeight < THRESHOLD || this._smallDoubleCarouselEnable);
            _loc1_ = !!_loc4_ ? int(MASK_TOP_OFFSET_EPIC_SMALL) : int(MASK_TOP_OFFSET_EPIC_BIG);
            _loc2_ = !!_loc4_ ? int(MASK_BOTTOM_OFFSET_EPIC_SMALL) : int(MASK_BOTTOM_OFFSET_EPIC_BIG);
         }
         else
         {
            _loc1_ = MASK_TOP_OFFSET_DEFAULT;
            _loc2_ = MASK_BOTTOM_OFFSET_DEFAULT;
         }
         if(scrollList.maskOffsetTop != _loc1_ || scrollList.maskOffsetBottom != _loc2_)
         {
            scrollList.maskOffsetTop = _loc1_;
            scrollList.maskOffsetBottom = _loc2_;
         }
      }
      
      private function updateScrollListSettings() : void
      {
         var _loc1_:int = this._helper.verticalGap;
         var _loc2_:int = this._helper.horizontalGap;
         var _loc3_:int = this._helper.rendererHeight;
         var _loc4_:int = this._helper.rendererWidth;
         scrollList.itemRendererClassReference = this._helper.linkRenderer;
         horizontalGap = _loc2_;
         verticalGap = _loc1_;
         rendererWidth = _loc4_;
         rendererHeight = _loc3_;
         pageWidth = _loc4_ + _loc2_;
         scrollList.height = (_loc1_ + _loc3_) * this._rowCount - _loc1_;
         this._listVisibleHeight = (_loc1_ + this._helper.rendererVisibleHeight) * this._rowCount - _loc1_ + this._helper.rendererHeightDiff * Math.max(0,this._rowCount - 1);
         var _loc5_:int = this._helper.padding.top;
         scrollList.y = _loc5_;
         this.background.height = -this.background.y + this._listVisibleHeight + _loc5_ + this._helper.padding.bottom;
         leftArrow.height = rightArrow.height = this._listVisibleHeight;
         startFadeMask.height = endFadeMask.height = this._listVisibleHeight + _loc5_;
         startFadeMask.y = endFadeMask.y = 0;
         leftArrow.y = _loc5_;
         rightArrow.y = _loc5_ + this._listVisibleHeight;
         this.vehicleFilters.height = this._listVisibleHeight;
      }
      
      public function get rowCount() : int
      {
         return this._rowCount;
      }
      
      public function get smallDoubleCarouselEnable() : Boolean
      {
         return this._rowCount > 1 && (this._stageHeight < THRESHOLD || this._smallDoubleCarouselEnable);
      }
      
      public function get helper() : ITankCarouselHelper
      {
         return this._helper;
      }
      
      private function onSelectWotPlusVehicleHandler(param1:TankItemEvent) : void
      {
         selectWotPlusVehicleS(param1.itemId);
      }
      
      private function onSelectRestoreTankHandler(param1:TankItemEvent) : void
      {
         restoreTankS();
      }
      
      private function onSelectBuyTankHandler(param1:TankItemEvent) : void
      {
         buyTankS();
      }
      
      private function onSelectBuySlotHandler(param1:TankItemEvent) : void
      {
         buySlotS();
      }
      
      private function onSelectRentPromotionSlotHandler(param1:TankItemEvent) : void
      {
         buyRentPromotionS(param1.itemId);
      }
      
      private function onVehicleFiltersItemClickHandler(param1:RendererEvent) : void
      {
         setFilterS(param1.index);
      }
      
      private function onVehicleFiltersResizeHandler(param1:Event) : void
      {
         this.vehicleFilters.y = scrollList.y + (this._listVisibleHeight - this.vehicleFilters.height >> 1);
         updateHotFiltersS();
      }
   }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class TankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(10);
   
   private static const RENDER_HEIGHT:int = 102;
   
   private static const RENDERER_VISIBLE_HEIGHT:int = 102;
   
   private static const RENDERER_HEIGHT_DIFF:int = RENDER_HEIGHT - RENDERER_VISIBLE_HEIGHT;
    
   
   function TankCarouselHelper()
   {
      super();
   }
   
   public function get linkRenderer() : String
   {
      return "TankCarouselItemRendererUI";
   }
   
   public function get rendererWidth() : int
   {
      return 162;
   }
   
   public function get rendererHeight() : int
   {
      return RENDER_HEIGHT;
   }
   
   public function get horizontalGap() : int
   {
      return 10;
   }
   
   public function get verticalGap() : int
   {
      return 10;
   }
   
   public function get padding() : Padding
   {
      return PADDING;
   }
   
   public function get rendererVisibleHeight() : int
   {
      return RENDERER_VISIBLE_HEIGHT;
   }
   
   public function get rendererHeightDiff() : int
   {
      return RENDERER_HEIGHT_DIFF;
   }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class SmallTankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(19,20);
   
   private static const RENDER_HEIGHT:int = 37;
   
   private static const RENDERER_VISIBLE_HEIGHT:int = 37;
   
   private static const RENDERER_HEIGHT_DIFF:int = RENDER_HEIGHT - RENDERER_VISIBLE_HEIGHT;
    
   
   function SmallTankCarouselHelper()
   {
      super();
   }
   
   public function get linkRenderer() : String
   {
      return "SmallTankCarouselItemRendererUI";
   }
   
   public function get rendererWidth() : int
   {
      return 162;
   }
   
   public function get rendererHeight() : int
   {
      return RENDER_HEIGHT;
   }
   
   public function get horizontalGap() : int
   {
      return 10;
   }
   
   public function get verticalGap() : int
   {
      return 10;
   }
   
   public function get padding() : Padding
   {
      return PADDING;
   }
   
   public function get rendererVisibleHeight() : int
   {
      return RENDERER_VISIBLE_HEIGHT;
   }
   
   public function get rendererHeightDiff() : int
   {
      return RENDERER_HEIGHT_DIFF;
   }
}
