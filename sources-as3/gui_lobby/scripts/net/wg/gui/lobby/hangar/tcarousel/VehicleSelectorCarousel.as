package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.Aliases;
   import net.wg.data.VO.TankCarouselFilterInitVO;
   import net.wg.data.constants.Directions;
   import net.wg.gui.components.controls.ButtonIconNormal;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.gui.components.controls.scroller.data.ScrollConfig;
   import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
   import net.wg.infrastructure.base.meta.impl.VehicleSelectorCarouselMeta;
   import net.wg.infrastructure.interfaces.IDisplayObject;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleSelectorCarousel extends VehicleSelectorCarouselMeta implements IPopOverCaller, IHelpLayoutComponent
   {
      
      private static const HELP_ID_SEPARATOR:String = "_";
      
      private static const ELASTICITY:Number = 0.25;
      
      private static const MASK_OFFSET:int = -10;
      
      private static const THROW_ACCELERATION_RATE:int = 4;
      
      private static const GO_TO_OFFSET:Number = 0.5;
      
      private static const INVALID_INIT:String = "invalidInit";
      
      private static const SCROLL_LIST_TOP:int = 88;
      
      private static const SCROLL_LIST_WIDTH:int = 690;
      
      private static const SCROLL_LIST_HEIGHT:int = 366;
      
      private static const SCROLL_LIST_LEFT:int = 32;
      
      private static const COLUMN_COUNT:int = 4;
      
      private static const ROW_COUNT:int = 3;
      
      private static const IN_HANGAR_FILTER_ID:int = 0;
       
      
      public var filterButton:ButtonIconNormal = null;
      
      public var inHangarCheckBox:CheckBox = null;
      
      public var vehiclesListScrollBar:ScrollBar = null;
      
      private var _carouselHelpLayoutId:String = null;
      
      private var _filtersHelpLayoutId:String = null;
      
      private var _helper:ITankCarouselHelper = null;
      
      private var _filterButtonData:TankCarouselFilterInitVO = null;
      
      private var _hotFilters:SimpleRendererVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function VehicleSelectorCarousel()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         startFadeMask.mouseEnabled = false;
         roundCountRenderer = false;
         var _loc1_:ScrollConfig = new ScrollConfig();
         _loc1_.elasticity = ELASTICITY;
         _loc1_.throwAccelerationRate = THROW_ACCELERATION_RATE;
         this._helper = new TankCarouselHelper();
         scrollList.scrollConfig = _loc1_;
         scrollList.mouseWheelDirection = DirectionMode.VERTICAL;
         scrollList.useTimer = true;
         scrollList.hasVerticalElasticEdges = true;
         scrollList.snapScrollPositionToItemRendererSize = false;
         scrollList.snapToPages = true;
         scrollList.cropContent = true;
         scrollList.maskOffsetLeft = scrollList.maskOffsetRight = MASK_OFFSET;
         scrollList.goToOffset = GO_TO_OFFSET;
         scrollList.setScrollbar(this.vehiclesListScrollBar);
         scrollList.columnCount = COLUMN_COUNT;
         scrollList.rowCount = ROW_COUNT;
         scrollList.y = SCROLL_LIST_TOP;
         scrollList.height = SCROLL_LIST_HEIGHT;
         goToSelectedItem();
         this.updateScrollListSettings();
         filterCounter.hasCounter = false;
         filterCounter.hasButton = false;
         this.filterButton.addEventListener(ButtonEvent.CLICK,this.onParamsFilterClickHandler);
         this.inHangarCheckBox.visible = this.filterButton.visible = false;
         this.inHangarCheckBox.enableDynamicFrameUpdating();
         this.subscribeInHangarFilter();
         mouseEnabled = false;
         App.utils.helpLayout.registerComponent(this);
      }
      
      override protected function initCarouselFilter(param1:TankCarouselFilterInitVO) : void
      {
         this._filterButtonData = param1;
         invalidate(INVALID_INIT);
      }
      
      override protected function draw() : void
      {
         if(this._filterButtonData != null && isInvalid(INVALID_INIT))
         {
            if(this._filterButtonData.isVisible)
            {
               this.filterButton.iconSource = this._filterButtonData.mainBtn.value;
               this.filterButton.tooltip = this._filterButtonData.mainBtn.tooltip;
               this._hotFilters = SimpleRendererVO(this._filterButtonData.hotFilters.requestItemAt(IN_HANGAR_FILTER_ID));
               this.inHangarCheckBox.label = this._hotFilters.value;
               this.inHangarCheckBox.selected = this._hotFilters.selected;
            }
            this.inHangarCheckBox.visible = this.filterButton.visible = this._filterButtonData.isVisible;
         }
         if(isInvalid(InvalidationType.SETTINGS))
         {
            this.updateScrollListSettings();
         }
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            updateLayout(SCROLL_LIST_WIDTH,SCROLL_LIST_LEFT);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function onDispose() : void
      {
         this.filterButton.removeEventListener(ButtonEvent.CLICK,this.onParamsFilterClickHandler);
         this.unsubscribeInHangarFilter();
         App.contextMenuMgr.hide();
         this.filterButton.dispose();
         this.filterButton = null;
         this.inHangarCheckBox.dispose();
         this.inHangarCheckBox = null;
         this.vehiclesListScrollBar.dispose();
         this.vehiclesListScrollBar = null;
         this._filterButtonData = null;
         this._hotFilters = null;
         this._helper = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function getHitArea() : DisplayObject
      {
         return this.filterButton;
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         var _loc1_:Vector.<HelpLayoutVO> = new Vector.<HelpLayoutVO>();
         if(StringUtils.isEmpty(this._carouselHelpLayoutId))
         {
            this._carouselHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
         }
         _loc1_.push(this.getHelpLayoutVO(scrollList,LOBBY_HELP.HANGAR_VEHICLE_CAROUSEL,name + HELP_ID_SEPARATOR + Math.random()));
         if(StringUtils.isEmpty(this._filtersHelpLayoutId))
         {
            this._filtersHelpLayoutId = name + HELP_ID_SEPARATOR + Math.random();
         }
         _loc1_.push(this.getHelpLayoutVO(this.filterButton,LOBBY_HELP.HANGAR_VEHFILTERS,this._filtersHelpLayoutId));
         return _loc1_;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return this.filterButton;
      }
      
      private function getHelpLayoutVO(param1:IDisplayObject, param2:String, param3:String) : HelpLayoutVO
      {
         var _loc4_:HelpLayoutVO = new HelpLayoutVO();
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.width = param1.width;
         _loc4_.height = param1.height;
         _loc4_.extensibilityDirection = Directions.RIGHT;
         _loc4_.message = param2;
         _loc4_.id = param3;
         _loc4_.scope = this;
         return _loc4_;
      }
      
      private function subscribeInHangarFilter() : void
      {
         this.inHangarCheckBox.addEventListener(Event.SELECT,this.onInHangarCheckBoxSelectHandler);
         this.inHangarCheckBox.addEventListener(MouseEvent.ROLL_OVER,this.onInHangarCheckBoxRollOverHandler);
         this.inHangarCheckBox.addEventListener(MouseEvent.ROLL_OUT,this.onInHangarCheckBoxRollOutHandler);
         this.inHangarCheckBox.addEventListener(MouseEvent.CLICK,this.onInHangarCheckBoxClickHandler);
      }
      
      private function unsubscribeInHangarFilter() : void
      {
         this.inHangarCheckBox.removeEventListener(Event.SELECT,this.onInHangarCheckBoxSelectHandler);
         this.inHangarCheckBox.removeEventListener(MouseEvent.ROLL_OVER,this.onInHangarCheckBoxRollOverHandler);
         this.inHangarCheckBox.removeEventListener(MouseEvent.ROLL_OUT,this.onInHangarCheckBoxRollOutHandler);
         this.inHangarCheckBox.removeEventListener(MouseEvent.CLICK,this.onInHangarCheckBoxClickHandler);
      }
      
      private function updateScrollListSettings() : void
      {
         scrollList.itemRendererClassReference = this._helper.linkRenderer;
         scrollList.paddingTop = verticalGap;
         scrollList.paddingBottom = verticalGap;
         horizontalGap = this._helper.horizontalGap;
         verticalGap = this._helper.verticalGap;
         rendererWidth = this._helper.rendererWidth;
         rendererHeight = this._helper.rendererHeight;
         pageHeight = this._helper.rendererHeight + this._helper.verticalGap;
      }
      
      public function get helper() : ITankCarouselHelper
      {
         return this._helper;
      }
      
      private function onInHangarCheckBoxSelectHandler(param1:Event) : void
      {
         setFilterS(IN_HANGAR_FILTER_ID,this.inHangarCheckBox.selected);
      }
      
      private function onInHangarCheckBoxRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._hotFilters.tooltip,null);
      }
      
      private function onInHangarCheckBoxRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onInHangarCheckBoxClickHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onParamsFilterClickHandler(param1:ButtonEvent) : void
      {
         App.popoverMgr.show(this,Aliases.VEHICLES_FILTER_POPOVER);
      }
   }
}

import net.wg.gui.lobby.hangar.tcarousel.helper.ITankCarouselHelper;
import scaleform.clik.utils.Padding;

class TankCarouselHelper implements ITankCarouselHelper
{
   
   private static const PADDING:Padding = new Padding(10,10,10,10);
   
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
      return 13;
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
