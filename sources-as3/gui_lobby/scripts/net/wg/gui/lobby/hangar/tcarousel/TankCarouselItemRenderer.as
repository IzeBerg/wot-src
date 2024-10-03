package net.wg.gui.lobby.hangar.tcarousel
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundManagerStatesLobby;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.carousels.controls.levelInfo.LevelInfoItem;
   import net.wg.gui.components.carousels.data.ProgressionPointsVO;
   import net.wg.gui.components.carousels.data.VehicleCarouselVO;
   import net.wg.gui.components.carousels.events.TankItemEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.scroller.IScrollerItemRenderer;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.gui.components.controls.scroller.data.ScrollerItemRendererSize;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.IClassFactory;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.gfx.MouseEventEx;
   
   public class TankCarouselItemRenderer extends SoundButtonEx implements IScrollerItemRenderer
   {
      
      public static const LABEL_CRYSTAL:String = "crystal";
      
      public static const LABEL_WOT_PLUS:String = "wotPlus";
      
      private static const RANKED_BONUS_NAME:String = "rankedBonus";
      
      private static const INFO_LEVEL_ITEM_NAME:String = "infoLevelContent";
      
      private static const PROGRESSION_POINTS_NAME:String = "progressionPoints";
      
      private static const CAROUSEL_RANKED_BONUS_LINKAGE:String = "CarouselRankedBonusUI";
      
      private static const LEVEL_INFO_ITEM_LINKAGE:String = "InfoLevelItemUI";
      
      private static const LINKAGE_CAROUSEL_PROGRESSION_POINTS:String = "CarouselProgressionPointsUI";
      
      private static const LINKAGE_EARLY_ACCESS_ICON:String = "EarlyAccessIconUI";
      
      private static const EARLY_ACCESS_ICON_OFFSET_X:int = -1;
      
      private static const EARLY_ACCESS_ICON_OFFSET_Y:int = 3;
      
      private static const PROGRESSION_POINTS_OFFSET:int = -8;
      
      private static const LEVEL_INFO_OFFSET:int = -10;
      
      private static const WARNING_PROGRESSION_POINTS:String = "BattlePass progressionPoints is empty! | _dataVO.isDisposed(), _dataVO.progressionPoints.isDisposed() |";
       
      
      public var content:BaseTankIcon = null;
      
      public var missionBadge:TankMissionBadge = null;
      
      public var border:Sprite = null;
      
      public var extraBorder:MovieClip = null;
      
      public var selectedMc:Sprite = null;
      
      public var hoverBg:Sprite = null;
      
      private var _index:uint = 0;
      
      private var _dataVO:VehicleCarouselVO = null;
      
      private var _toolTipMgr:ITooltipMgr = null;
      
      private var _isClickEnabled:Boolean = false;
      
      private var _isSpecialSlot:Boolean = false;
      
      private var _isViewPortEnabled:Boolean = true;
      
      private var _isInteractive:Boolean = false;
      
      private var _rowCount:int = 0;
      
      private var _rankedBonus:Sprite = null;
      
      private var _progressionPoints:CarouselProgressionPoints = null;
      
      private var _earlyAccessIcon:EarlyAccessIcon = null;
      
      private var _infoLevelContent:LevelInfoItem = null;
      
      private var _hasRankedBonus:Boolean = false;
      
      private var _hasProgression:Boolean = false;
      
      private var _hasLevelInfo:Boolean = false;
      
      private var _classFactory:IClassFactory;
      
      public function TankCarouselItemRenderer()
      {
         this._classFactory = App.utils.classFactory;
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
         this.selectedMc.mouseEnabled = false;
         this.selectedMc.mouseChildren = false;
         this.content.cacheAsBitmap = true;
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
         this._classFactory = null;
         this._dataVO = null;
         _owner = null;
         this._toolTipMgr = null;
         this.border = null;
         this.extraBorder = null;
         this.selectedMc = null;
         this.hoverBg = null;
         this.missionBadge.dispose();
         this.missionBadge = null;
         this.clearRankedBonus();
         this.clearProgressionPoints();
         this.clearInfoLevelContent();
         this.clearEarlyAccess();
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
            this._isSpecialSlot = this._dataVO.buySlot || this._dataVO.buyTank || this._dataVO.isRentPromotion;
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
            mouseEnabledOnDisabled = false;
         }
         this._hasRankedBonus = !!_loc1_ ? Boolean(this._dataVO.hasRankedBonus) : Boolean(false);
         this.updateRankedBonus();
         this._hasProgression = !!_loc1_ ? Boolean(this._dataVO.hasProgression) : Boolean(false);
         this.updateProgressionPoints();
         this.updateInteractiveState();
         this.updateEarlyAccess();
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
            this.missionBadge.setData(this._dataVO);
         }
      }
      
      protected function onShowTooltip() : void
      {
         var _loc1_:ActionPriceVO = null;
         if(this._dataVO.buyTank || this._dataVO.restoreTank)
         {
            this._toolTipMgr.showComplex(this._dataVO.tooltip);
         }
         else if(this._dataVO.buySlot)
         {
            _loc1_ = this._dataVO.getActionPriceVO();
            if(_loc1_)
            {
               this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.ACTION_SLOT_PRICE,null,_loc1_.newPrices,_loc1_.oldPrices);
            }
            else
            {
               this._toolTipMgr.showComplex(this._dataVO.tooltip);
            }
         }
         else if(StringUtils.isNotEmpty(this._dataVO.lockedTooltip))
         {
            this._toolTipMgr.showComplex(this._dataVO.lockedTooltip);
            if(this._isInteractive)
            {
               this.content.handleRollOver(this._dataVO);
            }
         }
         else if(this._dataVO.isWotPlusSlot && this._dataVO.intCD == Values.DEFAULT_INT)
         {
            this._toolTipMgr.showComplex(this._dataVO.tooltip);
         }
         else
         {
            if(this._dataVO.isWulfTooltip)
            {
               this._toolTipMgr.showWulfTooltip(this._dataVO.tooltip,this._dataVO.intCD);
            }
            else
            {
               this._toolTipMgr.showSpecial(this._dataVO.tooltip,null,this._dataVO.intCD);
            }
            if(this._isInteractive)
            {
               this.content.handleRollOver(this._dataVO);
               this.missionBadge.handleSlotRollOver();
            }
         }
      }
      
      protected function showContextMenu() : void
      {
         App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.VEHICLE,this,{"inventoryId":this._dataVO.id});
      }
      
      private function updateBorder() : void
      {
         this.extraBorder.visible = this._dataVO.isEarnCrystals && !this._dataVO.isCrystalsLimitReached || this._dataVO.isWotPlusSlot;
         this.border.visible = !this.extraBorder.visible;
         if(this.extraBorder.visible)
         {
            this.extraBorder.gotoAndStop(!!this._dataVO.isWotPlusSlot ? LABEL_WOT_PLUS : LABEL_CRYSTAL);
         }
      }
      
      private function updateEarlyAccess() : void
      {
         if(this._dataVO == null)
         {
            this.clearEarlyAccess();
            return;
         }
         var _loc1_:Boolean = this._dataVO.isEarlyAccess;
         if(_loc1_)
         {
            if(!this._earlyAccessIcon)
            {
               this._earlyAccessIcon = this._classFactory.getComponent(LINKAGE_EARLY_ACCESS_ICON,EarlyAccessIcon);
               addChild(this._earlyAccessIcon);
            }
            this._earlyAccessIcon.x = this.border.width + EARLY_ACCESS_ICON_OFFSET_X;
            this._earlyAccessIcon.y = EARLY_ACCESS_ICON_OFFSET_Y;
         }
         else
         {
            this.clearEarlyAccess();
         }
      }
      
      private function clearEarlyAccess() : void
      {
         if(this._earlyAccessIcon != null)
         {
            removeChild(this._earlyAccessIcon);
            this._earlyAccessIcon.dispose();
            this._earlyAccessIcon = null;
         }
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
         this._infoLevelContent = this._classFactory.getComponent(LEVEL_INFO_ITEM_LINKAGE,LevelInfoItem);
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
            this.missionBadge.visible = false;
         }
         else
         {
            this.clearInfoLevelContent();
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
         var _loc1_:ProgressionPointsVO = !!this._hasProgression ? this._dataVO.progressionPoints : null;
         if(_loc1_)
         {
            if(!this._progressionPoints)
            {
               this._progressionPoints = this._classFactory.getComponent(LINKAGE_CAROUSEL_PROGRESSION_POINTS,CarouselProgressionPoints);
               this._progressionPoints.name = PROGRESSION_POINTS_NAME;
               this._progressionPoints.x = this.border.width - this._progressionPoints.width >> 1;
               this._progressionPoints.y = PROGRESSION_POINTS_OFFSET;
               this._progressionPoints.visible = false;
               addChild(this._progressionPoints);
            }
            this._progressionPoints.setData(_loc1_,this._dataVO.intCD);
            this._progressionPoints.visible = this._progressionPoints.mouseEnabled = !this._hasRankedBonus;
            this.border.visible = !_loc1_.isSpecialVehicle && !this.extraBorder.visible;
         }
         else
         {
            if(this._hasProgression)
            {
               DebugUtils.LOG_WARNING(WARNING_PROGRESSION_POINTS,Boolean(this._dataVO) ? this._dataVO.isDisposed() : Errors.WASNT_FOUND,Boolean(this._dataVO.progressionPoints) ? this._dataVO.progressionPoints.isDisposed() : Errors.WASNT_FOUND);
            }
            this.clearProgressionPoints();
            this.border.visible = !this.extraBorder.visible;
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
         this._rankedBonus = this._classFactory.getComponent(CAROUSEL_RANKED_BONUS_LINKAGE,Sprite);
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
         this.content.enabled = this.content.buttonMode = this._isInteractive;
         this.content.mouseEnabled = true;
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
      
      protected function get isInteractive() : Boolean
      {
         return this._isInteractive;
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
                  dispatchEvent(new TankItemEvent(TankItemEvent.SELECT_TELECOM_VEHICLE,this._dataVO.intCD));
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
                  else if(!this._hasLevelInfo && this._dataVO.clickEnabled)
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
            else if(isUseRightBtn && _loc3_ == MouseEventEx.RIGHT_BUTTON && !this._dataVO.buySlot && !this._dataVO.buyTank && !this._dataVO.restoreTank && !this._dataVO.isRentPromotion)
            {
               this.showContextMenu();
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
         this.missionBadge.handleSlotRollOut();
         if(this._hasRankedBonus && this._hasProgression && !this._hasLevelInfo)
         {
            this._rankedBonus.visible = true;
            this._progressionPoints.visible = false;
         }
      }
      
      private function onSlotMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._dataVO)
         {
            return;
         }
         if(this._isInteractive && this._hasRankedBonus && this._hasProgression && !this._hasLevelInfo)
         {
            this._rankedBonus.visible = false;
            this._progressionPoints.visible = true;
         }
         this.onShowTooltip();
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
