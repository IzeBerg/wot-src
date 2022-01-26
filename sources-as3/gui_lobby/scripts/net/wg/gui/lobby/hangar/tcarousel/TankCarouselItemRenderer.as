package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.carousels.controls.levelInfo.LevelInfoItem;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.common.Counter;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.infrastructure.uilogger.new_year.LogTankSlot;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.MouseEventEx;
   
   public class TankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer
   {
      
      private static const RANKED_BONUS_NAME:String = "rankedBonus";
      
      private static const INFO_LEVEL_ITEM_NAME:String = "infoLevelContent";
      
      private static const PROGRESSION_POINTS:String = "progressionPoints";
      
      private static const CAROUSEL_RANKED_BONUS_LINKAGE:String = "CarouselRankedBonusUI";
      
      private static const LEVEL_INFO_ITEM_LINKAGE:String = "InfoLevelItemUI";
      
      private static const LINKAGE_CAROUSEL_PROGRESSION_POINTS:String = "CarouselProgressionPointsUI";
      
      private static const PROGRESSION_POINTS_OFFSET:int = -8;
      
      private static const LEVEL_INFO_OFFSET:int = -10;
      
      private static const NY_VEH_COUNTER_PROPS:CounterProps = new CounterProps(CounterProps.DEFAULT_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,true,Linkages.COUNTER_UI,CounterProps.DEFAULT_TF_PADDING,false,Counter.EMPTY_STATE);
      
      private static const NY_VEHICLE_BONUS_NAME:String = "nyVehicleBonus";
      
      private static const NY_BONUS_OFFSET_X:int = -2;
      
      public static const LABEL_CRYSTAL:String = "crystal";
      
      public static const LABEL_WOT_PLUS:String = "wotPlus";
       
      
      public var content:BaseTankIcon = null;
      
      public var border:Sprite = null;
      
      public var extraBorder:MovieClip = null;
      
      public var nyBorder:Sprite = null;
      
      public var selectedMc:Sprite = null;
      
      public var hoverBg:Sprite = null;
      
      public var nySelect:MovieClip = null;
      
      private var _index:uint = 0;
      
      private var _dataVO:VehicleCarouselVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _isClickEnabled:Boolean = false;
      
      private var _isSpecialSlot:Boolean = false;
      
      private var _isViewPortEnabled:Boolean = true;
      
      private var _isInteractive:Boolean = false;
      
      private var _rowCount:int = 0;
      
      private var _rankedBonus:Sprite = null;
      
      private var _nyBonus:NYVehicleBonus = null;
      
      private var _progressionPoints:CarouselProgressionPoints = null;
      
      private var _infoLevelContent:LevelInfoItem = null;
      
      private var _hasRankedBonus:Boolean = false;
      
      private var _hasProgression:Boolean = false;
      
      private var _hasLevelInfo:Boolean = false;
      
      private var _logger:LogTankSlot;
      
      public function TankCarouselItemRenderer()
      {
         this._logger = new LogTankSlot();
         super();
         preventAutosizing = true;
         constraintsDisabled = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         mouseEnabled = false;
         this.border.mouseEnabled = false;
         this.border.mouseChildren = false;
         this.extraBorder.mouseEnabled = false;
         this.extraBorder.mouseChildren = false;
         this.nyBorder.mouseChildren = this.nyBorder.mouseEnabled = false;
         this.selectedMc.mouseEnabled = false;
         this.selectedMc.mouseChildren = false;
         this.nySelect.mouseEnabled = false;
         this.nySelect.mouseChildren = false;
         this.content.cacheAsBitmap = true;
         this.content.buttonMode = true;
         this.content.mouseChildren = false;
         soundType = SoundTypes.CAROUSEL_BTN;
         soundId = SoundManagerStatesLobby.CAROUSEL_CELL_BTN;
         this.addListeners();
      }
      
      override protected function onDispose() : void
      {
         this.removeListeners();
         this.content.dispose();
         this.content = null;
         this._logger.dispose();
         this._logger = null;
         this.nySelect = null;
         this._dataVO = null;
         _owner = null;
         this._toolTipMgr = null;
         this.nyBorder = null;
         this.border = null;
         this.extraBorder = null;
         this.selectedMc = null;
         this.hoverBg = null;
         this.clearRankedBonus();
         this.clearProgressionPoints();
         this.clearInfoLevelContent();
         this.clearNyBonus();
         super.onDispose();
      }
      
      public function measureSize(param1:Point = null) : Point
      {
         return null;
      }
      
      protected function updateData() : void
      {
         var _loc1_:Boolean = this._dataVO != null;
         if(_loc1_)
         {
            alpha = this._dataVO.alpha;
            isUseRightBtn = this._dataVO.isUseRightBtn;
            this._isClickEnabled = this._dataVO.clickEnabled;
            this._isSpecialSlot = this._dataVO.buySlot || this._dataVO.buyTank || this._dataVO.isRentPromotion || this._dataVO.nySlot;
            this.updateBorder();
            mouseEnabledOnDisabled = true;
         }
         else
         {
            alpha = Values.DEFAULT_ALPHA;
            isUseRightBtn = false;
            this._isClickEnabled = false;
            this._isSpecialSlot = false;
            this.extraBorder.visible = false;
            this.nyBorder.visible = false;
            mouseEnabledOnDisabled = false;
         }
         this._hasRankedBonus = !!_loc1_ ? Boolean(this._dataVO.hasRankedBonus) : Boolean(false);
         this.updateRankedBonus();
         this.updateNyBonus(!!_loc1_ ? Boolean(this._dataVO.hasNyBonus) : Boolean(false));
         this._hasProgression = !!_loc1_ ? Boolean(this._dataVO.hasProgression) : Boolean(false);
         this.updateProgressionPoints();
         this.updateInteractiveState();
         this._hasLevelInfo = false;
         if(_loc1_ && this._dataVO.hasExtendedInfo)
         {
            this._hasLevelInfo = true;
            this._isSpecialSlot = this._isSpecialSlot || this._dataVO.levelInfo.isCollapsible;
         }
         this.updateInfoLevelContent();
         if(!_loc1_ || this._hasLevelInfo || this._dataVO.isNull)
         {
            this.hoverBg.visible = false;
         }
         if(!this._hasLevelInfo)
         {
            this.content.setData(this._dataVO);
         }
         if(_loc1_ && this._dataVO.showBubble)
         {
            App.utils.counterManager.setCounter(this.border,CounterManager.COUNTER_EMPTY,null,NY_VEH_COUNTER_PROPS);
         }
         else
         {
            App.utils.counterManager.removeCounter(this.border);
         }
         this.nySelect.visible = !!_loc1_ ? this._dataVO.hasNyBonus || this._dataVO.nySlot : Boolean(false);
         this.selectedMc.visible = !this.nySelect.visible && _loc1_;
         this.border.visible = !this.nySelect.visible;
      }
      
      private function updateBorder() : void
      {
         var _loc1_:Boolean = this._dataVO.hasNyBonus;
         this.extraBorder.visible = !_loc1_ && (this._dataVO.isEarnCrystals && !this._dataVO.isCrystalsLimitReached || this._dataVO.isWotPlusSlot);
         this.border.visible = !this.extraBorder.visible && !_loc1_;
         this.nyBorder.visible = !this.extraBorder.visible && _loc1_;
         this.selectedMc.visible = !_loc1_;
         if(this.extraBorder.visible)
         {
            this.extraBorder.gotoAndStop(!!this._dataVO.isWotPlusSlot ? LABEL_WOT_PLUS : LABEL_CRYSTAL);
         }
         this.border.visible = !this.extraBorder.visible && !_loc1_;
         this.nyBorder.visible = !this.extraBorder.visible && _loc1_;
      }
      
      private function clearInfoLevelContent() : void
      {
         if(this._infoLevelContent != null)
         {
            this._infoLevelContent.removeEventListener(ListRendererEvent.CHANGE_SIZE,this.onInfoLevelChangeSizeHandler);
            this._infoLevelContent.dispose();
            removeChild(this._infoLevelContent);
            this._infoLevelContent = null;
         }
      }
      
      private function addInfoLevelContent() : void
      {
         this._infoLevelContent = App.utils.classFactory.getComponent(LEVEL_INFO_ITEM_LINKAGE,LevelInfoItem);
         this._infoLevelContent.name = INFO_LEVEL_ITEM_NAME;
         this._infoLevelContent.addEventListener(ListRendererEvent.CHANGE_SIZE,this.onInfoLevelChangeSizeHandler);
         this._infoLevelContent.y = this.levelInfoOffset;
         addChildAt(this._infoLevelContent,getChildIndex(this.content));
      }
      
      private function updateInfoLevelContent() : void
      {
         if(this._hasLevelInfo)
         {
            if(!this._infoLevelContent)
            {
               this.addInfoLevelContent();
            }
            this._infoLevelContent.setData(this._dataVO.levelInfo);
            this._infoLevelContent.small = this.adaptiveSize == ScrollerItemRendererSize.SMALL_SIZE;
            this._infoLevelContent.doubled = this._rowCount > 1;
            this._infoLevelContent.visible = true;
            this.content.visible = false;
            this.border.visible = false;
            this.extraBorder.visible = false;
         }
         else
         {
            this.clearInfoLevelContent();
         }
      }
      
      private function updateNyBonus(param1:Boolean) : void
      {
         if(param1)
         {
            if(!this._nyBonus)
            {
               this._nyBonus = App.utils.classFactory.getComponent(Linkages.NY_VEHICLE_BONUS_UI,NYVehicleBonus);
               this._nyBonus.name = NY_VEHICLE_BONUS_NAME;
               this._nyBonus.x = (width - this._nyBonus.width >> 1) + NY_BONUS_OFFSET_X;
               this._nyBonus.y = -(this._nyBonus.height >> 1);
               this._nyBonus.updateBonus(this._dataVO.nyBonusValue,this._dataVO.nyBonusIcon);
               this._nyBonus.mouseChildren = this._nyBonus.mouseEnabled = false;
               addChild(this._nyBonus);
            }
            else
            {
               this._nyBonus.updateBonus(this._dataVO.nyBonusValue,this._dataVO.nyBonusIcon);
            }
            this._nyBonus.visible = true;
         }
         else
         {
            this.clearNyBonus();
         }
      }
      
      private function clearNyBonus() : void
      {
         if(this._nyBonus != null)
         {
            removeChild(this._nyBonus);
            this._nyBonus.dispose();
            this._nyBonus = null;
         }
      }
      
      private function clearProgressionPoints() : void
      {
         if(this._progressionPoints)
         {
            this._progressionPoints.dispose();
            removeChild(this._progressionPoints);
            this._progressionPoints = null;
         }
      }
      
      private function updateProgressionPoints() : void
      {
         if(this._hasProgression)
         {
            if(!this._progressionPoints)
            {
               this._progressionPoints = App.utils.classFactory.getComponent(LINKAGE_CAROUSEL_PROGRESSION_POINTS,CarouselProgressionPoints);
               this._progressionPoints.setData(this._dataVO.progressionPoints,this._dataVO.intCD);
               this._progressionPoints.name = PROGRESSION_POINTS;
               this._progressionPoints.x = this.border.width - this._progressionPoints.width >> 1;
               this._progressionPoints.y = PROGRESSION_POINTS_OFFSET;
               addChild(this._progressionPoints);
            }
            this._progressionPoints.visible = this._progressionPoints.mouseEnabled = !this._hasRankedBonus;
            this.border.visible = !this._dataVO.progressionPoints.isSpecialVehicle && !this.extraBorder.visible && !this.nyBorder.visible;
         }
         else
         {
            this.clearProgressionPoints();
            this.border.visible = !this.extraBorder.visible && !this.nyBorder.visible;
         }
      }
      
      private function clearRankedBonus() : void
      {
         if(this._rankedBonus)
         {
            removeChild(this._rankedBonus);
            this._rankedBonus = null;
         }
      }
      
      private function updateRankedBonus() : void
      {
         if(this._hasRankedBonus)
         {
            if(!this._rankedBonus)
            {
               this.addRankedBonus();
            }
            this._rankedBonus.visible = true;
         }
         else
         {
            this.clearRankedBonus();
         }
      }
      
      private function addRankedBonus() : void
      {
         this._rankedBonus = App.utils.classFactory.getComponent(CAROUSEL_RANKED_BONUS_LINKAGE,Sprite);
         this._rankedBonus.mouseChildren = this._rankedBonus.mouseEnabled = false;
         this._rankedBonus.name = RANKED_BONUS_NAME;
         this._rankedBonus.x = width >> 1;
         addChild(this._rankedBonus);
      }
      
      private function addListeners() : void
      {
         this.content.addEventListener(MouseEvent.ROLL_OVER,this.onSlotMouseRollOverHandler);
         this.content.addEventListener(MouseEvent.ROLL_OUT,this.onSlotMouseRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      private function removeListeners() : void
      {
         this.content.removeEventListener(MouseEvent.ROLL_OVER,this.onSlotMouseRollOverHandler);
         this.content.removeEventListener(MouseEvent.ROLL_OUT,this.onSlotMouseRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onSlotMouseClickHandler);
      }
      
      private function updateInteractiveState() : void
      {
         this._isInteractive = this._isViewPortEnabled && this._isClickEnabled || this._isSpecialSlot;
         this.enabled = this._isInteractive;
         this.content.enabled = this._isInteractive;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 != enabled)
         {
            super.enabled = param1;
            mouseChildren = param1;
            mouseEnabled = false;
         }
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return this._dataVO;
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._dataVO != null)
         {
            this._dataVO.removeEventListener(Event.CHANGE,this.onDataVOChangeHandler);
            this._dataVO = null;
         }
         if(param1 != null)
         {
            this._dataVO = VehicleCarouselVO(param1);
            this._dataVO.addEventListener(Event.CHANGE,this.onDataVOChangeHandler);
         }
         this.updateData();
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function set tooltipDecorator(param1:ITooltipMgr) : void
      {
         this._toolTipMgr = param1;
      }
      
      public function set isViewPortEnabled(param1:Boolean) : void
      {
         if(this._isViewPortEnabled == param1)
         {
            return;
         }
         this._isViewPortEnabled = param1;
         this.updateInteractiveState();
      }
      
      public function get adaptiveSize() : String
      {
         return ScrollerItemRendererSize.NORMAL_SIZE;
      }
      
      public function get rowsCount() : int
      {
         return this._rowCount;
      }
      
      public function set rowsCount(param1:int) : void
      {
         this._rowCount = param1;
         if(this._infoLevelContent)
         {
            this._infoLevelContent.doubled = this._rowCount > 1;
         }
      }
      
      protected function get levelInfoOffset() : int
      {
         return LEVEL_INFO_OFFSET;
      }
      
      protected function get dataVO() : VehicleCarouselVO
      {
         return this._dataVO;
      }
      
      private function onSlotMouseClickHandler(param1:Event) : void
      {
         var _loc2_:MouseEventEx = null;
         var _loc3_:uint = 0;
         var _loc4_:String = null;
         if(!this._isInteractive)
         {
            return;
         }
         if(this._dataVO != null)
         {
            _loc2_ = param1 as MouseEventEx;
            _loc3_ = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
            if(!selected && _loc3_ == MouseEventEx.LEFT_BUTTON)
            {
               if(this._dataVO.isRentPromotion)
               {
                  dispatchEvent(new TankItemEvent(TankItemEvent.SELECT_RENT_PROMOTION_SLOT,this._dataVO.intCD));
               }
               else if(this._dataVO.isWotPlusSlot && this._dataVO.intCD < 0)
               {
                  dispatchEvent(new TankItemEvent(TankItemEvent.SELECT_WOT_PLUS_VEHICLE,this._dataVO.intCD));
               }
               else
               {
                  if(this._dataVO.buySlot)
                  {
                     _loc4_ = TankItemEvent.SELECT_BUY_SLOT;
                  }
                  else if(this._dataVO.buyTank)
                  {
                     _loc4_ = TankItemEvent.SELECT_BUY_TANK;
                  }
                  else if(this._dataVO.restoreTank)
                  {
                     _loc4_ = TankItemEvent.SELECT_RESTORE_TANK;
                  }
                  else if(this._dataVO.nySlot)
                  {
                     this._logger.slotClick();
                     _loc4_ = TankItemEvent.SELECT_NEW_YEAR_SLOT;
                  }
                  else if(this._dataVO.clickEnabled && !this._hasLevelInfo)
                  {
                     _loc4_ = TankItemEvent.SELECT_ITEM;
                     dispatchEvent(new ListRendererEvent(ListRendererEvent.SELECT));
                  }
                  if(_loc4_ != null)
                  {
                     dispatchEvent(new TankItemEvent(_loc4_,this._index,true,true));
                  }
               }
            }
            else if(_loc3_ == MouseEventEx.RIGHT_BUTTON && isUseRightBtn && !this._dataVO.buySlot && !this._dataVO.buyTank && !this._dataVO.restoreTank && !this._dataVO.isRentPromotion && !this._dataVO.nySlot)
            {
               App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.VEHICLE,this,{"inventoryId":this._dataVO.id});
            }
         }
         this._toolTipMgr.hide();
      }
      
      private function onSlotMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         if(!this._isInteractive || !this._dataVO)
         {
            return;
         }
         this.content.handleRollOut(this._dataVO);
         if(this._hasRankedBonus && this._hasProgression && !this._hasLevelInfo)
         {
            this._rankedBonus.visible = true;
            this._progressionPoints.visible = false;
         }
      }
      
      private function onSlotMouseRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ActionPriceVO = null;
         if(!this._isInteractive || !this._dataVO)
         {
            return;
         }
         if(this._hasRankedBonus && this._hasProgression && !this._hasLevelInfo)
         {
            this._rankedBonus.visible = false;
            this._progressionPoints.visible = true;
         }
         if(this._dataVO.buyTank || this._dataVO.restoreTank)
         {
            this._toolTipMgr.showComplex(this._dataVO.tooltip);
         }
         else if(this._dataVO.buySlot)
         {
            _loc2_ = this._dataVO.getActionPriceVO();
            if(_loc2_)
            {
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_SLOT_PRICE,null,_loc2_.newPrices,_loc2_.oldPrices);
            }
            else
            {
               this._toolTipMgr.showComplex(this._dataVO.tooltip);
            }
         }
         else if(StringUtils.isNotEmpty(this._dataVO.lockedTooltip))
         {
            this._toolTipMgr.showComplex(this._dataVO.lockedTooltip);
         }
         else if(this._dataVO.isWotPlusSlot && this._dataVO.intCD == Values.DEFAULT_INT)
         {
            this._toolTipMgr.showComplex(this._dataVO.tooltip);
         }
         else if(this._dataVO.nySlot)
         {
            this._toolTipMgr.showComplex(this._dataVO.tooltip);
            this.content.handleRollOver(this._dataVO);
         }
         else
         {
            this._toolTipMgr.showSpecial(this._dataVO.tooltip,null,this._dataVO.intCD);
            this.content.handleRollOver(this._dataVO);
         }
      }
      
      private function onDataVOChangeHandler(param1:Event) : void
      {
         this.updateData();
      }
      
      private function onInfoLevelChangeSizeHandler(param1:ListRendererEvent) : void
      {
         dispatchEvent(param1);
      }
   }
}
