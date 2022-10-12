package net.wg.gui.battle.comp7.views.battleTankCarousel
{
   import fl.motion.easing.Circular;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.VO.TankCarouselFilterSelectedVO;
   import net.wg.gui.components.common.AlphaPropertyWrapper;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.infrastructure.base.meta.IComp7BattleTankCarouselMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7BattleTankCarouselMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.utils.Padding;
   
   public class BattleTankCarousel extends Comp7BattleTankCarouselMeta implements IComp7BattleTankCarouselMeta
   {
      
      private static const FILTERS_WIDTH:Number = 58;
      
      private static const ELASTICITY:Number = 0.25;
      
      private static const MASK_OFFSET:int = 0;
      
      private static const THROW_ACCELERATION_RATE:int = 4;
      
      private static const OFFSET_ARROW:int = 3;
      
      private static const GO_TO_OFFSET:Number = 0.5;
      
      private static const GO_TO_DURATION:uint = 1;
      
      private static const MASK_TOP_OFFSET_DEFAULT:int = -12;
      
      private static const MASK_BOTTOM_OFFSET_DEFAULT:int = 0;
      
      private static const INV_ROW_COUNT:String = "invRowCount";
      
      private static const TWO_ROWS:int = 2;
      
      private static const INV_ATTENTION:String = "invAttention";
      
      private static const NO_VEHICLE_MSG_ID:String = "#comp7:battleCarousel/noFilteredVehiclesMessage";
      
      private static const HIDE_TWEEN_DURATION:int = 300;
      
      private static const HIDE_OFFSET:int = 15;
       
      
      public var vehicleFilters:BattleTankCarouselFilters = null;
      
      public var background:MovieClip = null;
      
      public var bgGlow:MovieClip = null;
      
      public var attentionTF:TextField = null;
      
      private var _helper:ITankCarouselHelper = null;
      
      private var _rowCountOverride:int = -1;
      
      private var _isAttention:Boolean = false;
      
      private var _tween:Tween = null;
      
      private var _isVisible:Boolean = false;
      
      private var _isHidden:Boolean = false;
      
      private var _alphaWrapper:AlphaPropertyWrapper = null;
      
      private var _startY:int;
      
      public function BattleTankCarousel()
      {
         super();
      }
      
      override public function as_hideCounter() : void
      {
         super.as_hideCounter();
         this._isAttention = false;
         invalidate(INV_ATTENTION);
      }
      
      override public function as_showCounter(param1:String, param2:Boolean) : void
      {
         super.as_showCounter(param1,param2);
         if(param2 != this._isAttention)
         {
            this._isAttention = param2;
            invalidate(INV_ATTENTION);
         }
      }
      
      override public function isCompVisible() : Boolean
      {
         return this._isVisible && !this._isHidden;
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         if(this._isHidden || param1 == this._isVisible)
         {
            return;
         }
         this._isVisible = param1;
         if(this._isVisible)
         {
            y = this._startY;
            this.clearTween();
            this.updateVisibility();
         }
         else
         {
            this.animateHide(this.onHideAnimationComplete);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateVisibility();
         this._alphaWrapper = new AlphaPropertyWrapper(this);
         App.utils.commons.addEmptyHitArea(this.bgGlow);
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
         scrollList.maskOffsetLeft = scrollList.maskOffsetRight = MASK_OFFSET;
         scrollList.goToOffset = GO_TO_OFFSET;
         scrollList.goToDuration = GO_TO_DURATION;
         scrollList.maskOffsetTop = MASK_TOP_OFFSET_DEFAULT;
         scrollList.maskOffsetBottom = MASK_BOTTOM_OFFSET_DEFAULT;
         scrollList.showRendererOnlyIfDataExists = true;
         this.getNewHelper();
         leftArrow.mouseEnabledOnDisabled = rightArrow.mouseEnabledOnDisabled = true;
         this.vehicleFilters.addEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
         this.vehicleFilters.addEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
         this.background.mouseEnabled = false;
         this.background.mouseChildren = false;
         mouseEnabled = false;
         this.attentionTF.visible = false;
         this.attentionTF.text = NO_VEHICLE_MSG_ID;
         App.utils.commons.updateTextFieldSize(this.attentionTF,false,true);
         this.updateAttentionPos();
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this._alphaWrapper.dispose();
         this._alphaWrapper = null;
         App.contextMenuMgr.hide();
         this.vehicleFilters.removeEventListener(Event.RESIZE,this.onVehicleFiltersResizeHandler);
         this.vehicleFilters.removeEventListener(RendererEvent.ITEM_CLICK,this.onVehicleFiltersItemClickHandler);
         this.vehicleFilters.dispose();
         this.vehicleFilters = null;
         this.attentionTF = null;
         this.background = null;
         this.bgGlow = null;
         this._helper = null;
         super.onDispose();
      }
      
      override protected function setCarouselFilter(param1:TankCarouselFilterSelectedVO) : void
      {
         this.vehicleFilters.setSelectedData(param1);
      }
      
      override protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
      {
         this.vehicleFilters.visible = param1.isVisible;
         this.vehicleFilters.initData(param1);
      }
      
      override protected function updateLayout(param1:int, param2:int = 0) : void
      {
         var _loc3_:int = 0;
         _loc3_ = param2 + FILTERS_WIDTH + OFFSET_ARROW;
         var _loc4_:int = param1 - _loc3_ - OFFSET_ARROW;
         this.background.width = param1 >> 0;
         this.bgGlow.x = this.background.width - this.bgGlow.width >> 1;
         var _loc5_:int = _loc4_ + leftArrowOffset - rightArrowOffset;
         super.updateLayout(_loc4_,(_loc4_ - _loc5_ >> 1) + _loc3_ >> 0);
         startFadeMask.x = scrollList.x + startFadeMask.width | 0;
         endFadeMask.x = rightArrow.x - rightArrow.width - endFadeMask.width >> 0;
         this.updateAttentionPos();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = isInvalid(InvalidationType.SIZE);
         var _loc2_:Boolean = isInvalid(INV_ROW_COUNT);
         if(_loc1_ || _loc2_)
         {
            this.getNewHelper();
         }
         if(_loc2_)
         {
            goToSelectedItem();
            invalidate(InvalidationType.SETTINGS);
         }
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.updateScrollListSettings();
         }
         super.draw();
         if(_loc1_)
         {
            this._startY = y;
            if(scrollList.pageWidth == 0)
            {
               scrollList.validateNow();
            }
            this.updateLayout(width);
            goToSelectedItem();
         }
         if(isInvalid(INV_ATTENTION))
         {
            this.attentionTF.visible = this._isAttention;
            scrollList.visible = endFadeMask.visible = startFadeMask.visible = leftArrow.visible = rightArrow.visible = !this._isAttention;
         }
      }
      
      override protected function updateSelectedIndex() : void
      {
         super.updateSelectedIndex();
         goToSelectedItem();
      }
      
      public function as_hide(param1:Boolean) : void
      {
         this._isHidden = true;
         if(param1)
         {
            this.animateHide(this.onHideCompleted);
         }
         else
         {
            this.onHideCompleted();
         }
      }
      
      public function as_rowCount(param1:int) : void
      {
         param1 = Math.max(1,Math.min(param1,TWO_ROWS));
         if(this._rowCountOverride != param1)
         {
            this._rowCountOverride = param1;
            invalidate(InvalidationType.SIZE,INV_ROW_COUNT);
         }
      }
      
      public function getBottom() : Number
      {
         if(isDisposed())
         {
            return 0;
         }
         return this.background.height + this.background.y;
      }
      
      public function setInteractive(param1:Boolean) : void
      {
         mouseChildren = tabEnabled = tabChildren = param1;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         if(isDisposed() || param1 == width)
         {
            return;
         }
         width = param1;
         invalidateSize();
      }
      
      private function animateHide(param1:Function) : void
      {
         var _loc2_:Boolean = this._tween && this._tween.paused;
         var _loc3_:Boolean = _loc2_ || !this._tween;
         if(_loc2_)
         {
            this.clearTween();
         }
         if(_loc3_)
         {
            this._startY = y;
            this._tween = new Tween(HIDE_TWEEN_DURATION,this._alphaWrapper,{
               "alpha":0,
               "y":this._startY + HIDE_OFFSET
            },{
               "ease":Circular.easeOut,
               "onComplete":param1
            });
         }
      }
      
      private function onHideAnimationComplete(param1:Tween = null) : void
      {
         this.clearTween();
         this._isVisible = false;
         this.updateVisibility();
      }
      
      private function updateVisibility() : void
      {
         this.visible = this._isVisible;
         alpha = !!this._isVisible ? Number(1) : Number(0);
      }
      
      private function clearTween() : void
      {
         if(this._tween)
         {
            this._tween.dispose();
            this._tween = null;
         }
      }
      
      private function onHideCompleted(param1:Tween = null) : void
      {
         this.onHideAnimationComplete();
         if(!isDisposed())
         {
            onViewIsHiddenS();
         }
      }
      
      private function updateAttentionPos() : void
      {
         this.attentionTF.x = scrollList.x + (scrollList.width - this.attentionTF.width >> 1) | 0;
      }
      
      private function getNewHelper() : void
      {
         var _loc1_:Boolean = false;
         if(this._rowCountOverride > 0)
         {
            _loc1_ = this._rowCountOverride == TWO_ROWS;
         }
         else
         {
            _loc1_ = App.appWidth <= StageSizeBoundaries.WIDTH_1366;
         }
         if(_loc1_ && !(this._helper is SmallTankCarouselHelper))
         {
            this._helper = new SmallTankCarouselHelper();
            this.notificateHelperChanged();
         }
         else if(!_loc1_ && !(this._helper is TankCarouselHelper))
         {
            this._helper = new TankCarouselHelper();
            this.notificateHelperChanged();
         }
      }
      
      private function notificateHelperChanged() : void
      {
         invalidate(InvalidationType.SETTINGS);
      }
      
      private function updateScrollListSettings() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Padding = null;
         _loc1_ = this._helper.rowCount;
         var _loc2_:int = this._helper.horizontalGap;
         _loc3_ = this._helper.verticalGap;
         var _loc4_:int = this._helper.rendererWidth;
         _loc5_ = this._helper.rendererHeight;
         _loc6_ = this._helper.padding;
         this.vehicleFilters.setRowCount(_loc1_);
         scrollList.rowCount = _loc1_;
         scrollList.itemRendererClassReference = this._helper.linkRenderer;
         horizontalGap = _loc2_;
         verticalGap = _loc3_;
         rendererWidth = _loc4_;
         rendererHeight = _loc5_;
         pageWidth = _loc4_ + _loc2_;
         var _loc7_:int = (_loc3_ + _loc5_) * _loc1_ - _loc3_;
         var _loc8_:int = _loc6_.top;
         this.background.height = -this.background.y + _loc7_ + _loc8_ + _loc6_.bottom;
         scrollList.height = startFadeMask.height = endFadeMask.height = leftArrow.height = rightArrow.height = this.vehicleFilters.height = _loc7_;
         scrollList.y = leftArrow.y = startFadeMask.y = endFadeMask.y = _loc8_;
         rightArrow.y = scrollList.y + rightArrow.height;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(visible == param1 || isDisposed())
         {
            return;
         }
         if(this.vehicleFilters)
         {
            this.vehicleFilters.visible = param1;
         }
         super.visible = param1;
      }
      
      private function onVehicleFiltersItemClickHandler(param1:RendererEvent) : void
      {
         setFilterS(param1.index);
      }
      
      private function onVehicleFiltersResizeHandler(param1:Event) : void
      {
         this.vehicleFilters.y = scrollList.y + (scrollList.height - this.vehicleFilters.height >> 1);
      }
   }
}

import scaleform.clik.utils.Padding;

class TankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(10);
   
   private static const RENDERER_WIDTH:int = 160;
   
   private static const RENDERER_HEIGHT:int = 100;
   
   private static const GAP:int = 10;
   
   private static const RENDERER_VISIBLE_HEIGHT:int = 100;
   
   private static const RENDERER_HEIGHT_DIFF:int = RENDERER_HEIGHT - RENDERER_VISIBLE_HEIGHT;
   
   private static const RENDERER_NAME:String = "Comp7BattleTankCarouselItemRendererUI";
   
   private static const ROW_COUNT:uint = 1;
    
   
   function TankCarouselHelper()
   {
      super();
   }
   
   public function get linkRenderer() : String
   {
      return RENDERER_NAME;
   }
   
   public function get rendererWidth() : int
   {
      return RENDERER_WIDTH;
   }
   
   public function get rendererHeight() : int
   {
      return RENDERER_HEIGHT;
   }
   
   public function get horizontalGap() : int
   {
      return GAP;
   }
   
   public function get verticalGap() : int
   {
      return GAP;
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
   
   public function get rowCount() : uint
   {
      return ROW_COUNT;
   }
}

import scaleform.clik.utils.Padding;

class SmallTankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(20);
   
   private static const RENDERER_WIDTH:int = 160;
   
   private static const RENDERER_HEIGHT:int = 35;
   
   private static const GAP:int = 10;
   
   private static const RENDERER_VISIBLE_HEIGHT:int = 35;
   
   private static const RENDERER_HEIGHT_DIFF:int = RENDERER_HEIGHT - RENDERER_VISIBLE_HEIGHT;
   
   private static const ROW_COUNT:uint = 2;
   
   private static const RENDERER_NAME:String = "Comp7SmallBattleTankCarouselItemRendererUI";
    
   
   function SmallTankCarouselHelper()
   {
      super();
   }
   
   public function get linkRenderer() : String
   {
      return RENDERER_NAME;
   }
   
   public function get rendererWidth() : int
   {
      return RENDERER_WIDTH;
   }
   
   public function get rendererHeight() : int
   {
      return RENDERER_HEIGHT;
   }
   
   public function get horizontalGap() : int
   {
      return GAP;
   }
   
   public function get verticalGap() : int
   {
      return GAP;
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
   
   public function get rowCount() : uint
   {
      return ROW_COUNT;
   }
}

import scaleform.clik.utils.Padding;

interface ITankCarouselHelper
{
    
   
   function get linkRenderer() : String;
   
   function get rendererWidth() : int;
   
   function get rendererHeight() : int;
   
   function get horizontalGap() : int;
   
   function get verticalGap() : int;
   
   function get padding() : Padding;
   
   function get rendererVisibleHeight() : int;
   
   function get rendererHeightDiff() : int;
   
   function get rowCount() : uint;
}
