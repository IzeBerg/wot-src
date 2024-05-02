package net.wg.gui.lobby.fortifications.cmp.battleRoom
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.ExtendedUserVO;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.controls.ButtonIconTextTransparent;
   import net.wg.gui.events.FiltersEvent;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.fortifications.data.battleRoom.SortieSlotVO;
   import net.wg.gui.lobby.fortifications.events.ClanBattleSlotEvent;
   import net.wg.gui.rally.controls.RallyLockableSlotRenderer;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.ButtonEvent;
   
   public class SortieSlot extends RallyLockableSlotRenderer implements IPopOverCaller
   {
      
      public static const MAIN_LOCK_FILTER:uint = 1 << 0;
      
      public static const ONDRAG_LOCK_FILTER:uint = 1 << 1;
      
      private static const DEF_BTN_ALPHA:Number = 0.5;
      
      private static const HOVER_BTN_ALPHA:Number = 1;
      
      private static const FILTERS_HOR_GAP:int = 9;
      
      private static const ALERT_ICON_PADDING:int = 3;
       
      
      public var hoverArea:MovieClip = null;
      
      public var candidateRating:TextField = null;
      
      public var vehBrokenIcon:Sprite = null;
      
      public var unfrozeVehicleBtn:ButtonIconTextTransparent = null;
      
      public var typeFilters:SlotButtonFilters = null;
      
      public var btnConfigure:IButtonIconLoader = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _popoverCaller:PopoverCallerWrapper = null;
      
      private var _rollEventLockers:uint = 0;
      
      private var _isMouseOver:Boolean = false;
      
      private var _isEnableRollEventListeners:Boolean = false;
      
      private var _sortieData:SortieSlotVO;
      
      private var _gunnerIcon:MovieClip;
      
      public function SortieSlot()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override public function setStatus(param1:int) : String
      {
         var _loc2_:String = IndicationOfStatus.STATUS_NORMAL;
         if(param1 < STATUSES.length && param1)
         {
            _loc2_ = STATUSES[param1];
         }
         statusIndicator.status = _loc2_;
         return _loc2_;
      }
      
      override public function updateComponents() : void
      {
         super.updateComponents();
         var _loc1_:Boolean = !this._sortieData.isCommanderState;
         var _loc2_:Boolean = _loc1_ || this._sortieData.player || !this._sortieData.isFiltersEnabled || !this._sortieData.isMatchingEnabled;
         this.lockFilterOverListener(MAIN_LOCK_FILTER,_loc2_);
         var _loc3_:Boolean = index == 0;
         if(_loc3_ || _loc1_)
         {
            removeBtn.visible = !_loc3_ && _loc1_ && this._sortieData.isRemoveAvailable && slotData.player;
            this.typeFilters.visible = this.btnConfigure.visible = false;
            return;
         }
         var _loc4_:int = Boolean(this._sortieData.vehicles) ? int(this._sortieData.vehicles.length) : int(0);
         if(_loc4_ > 0)
         {
            vehicleBtn.vehicleCount = _loc4_;
            vehicleBtn.visible = true;
         }
         this.typeFilters.resetFilters(this._sortieData.filterState);
         this.typeFilters.visible = !slotData.player && (this.hasSelectedFilters || this._isMouseOver && vehicleBtn.vehicleCount < 0);
         if(this.typeFilters.visible)
         {
            this.updateFiltersAlpha();
         }
         this.btnConfigure.visible = this._sortieData.isMatchingEnabled && !slotData.player;
         this.btnConfigure.enabled = this._sortieData.isFiltersEnabled;
         removeBtn.visible = this.hasFilters || slotData.player;
         this.vehBrokenIcon.visible = false;
         this.unfrozeVehicleBtn.visible = false;
         this.unfrozeVehicleBtn.enabled = this._sortieData.unfrozeVehiclesBtnEnabled;
         if(this._sortieData.canUnfrozeVehicles)
         {
            this.unfrozeVehicleBtn.visible = true;
         }
         else
         {
            this.vehBrokenIcon.visible = this._sortieData.hasFrozenVehicle;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.typeFilters.layout = new HorizontalGroupLayout(FILTERS_HOR_GAP,false);
         this.typeFilters.buttonLinkage = Linkages.BUTTON_BLACK;
         this.unfrozeVehicleBtn.visible = false;
         this.vehBrokenIcon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.enableRollEventListeners(false);
         this.vehBrokenIcon.removeEventListener(MouseEvent.ROLL_OVER,this.onVehBrokenIconRollOver);
         this.vehBrokenIcon.removeEventListener(MouseEvent.ROLL_OUT,this.onVehBrokenIconRollOut);
         this.vehBrokenIcon = null;
         this.unfrozeVehicleBtn.removeEventListener(ButtonEvent.CLICK,this.onUnfrozeVehicleBtnClick);
         this.unfrozeVehicleBtn.removeEventListener(MouseEvent.ROLL_OVER,this.onUnfrozeVehicleBtnRollOver);
         this.unfrozeVehicleBtn.removeEventListener(MouseEvent.ROLL_OUT,this.onUnfrozeVehicleBtnRollOut);
         this.unfrozeVehicleBtn.dispose();
         this.unfrozeVehicleBtn = null;
         this.candidateRating = null;
         removeTooltipSubscriber(this._gunnerIcon);
         this._gunnerIcon = null;
         removeTooltipSubscriber(this.btnConfigure);
         this.btnConfigure.removeEventListener(ButtonEvent.CLICK,this.onBtnConfigureClickHandler);
         this.btnConfigure.dispose();
         this.btnConfigure = null;
         this.typeFilters.removeEventListener(FiltersEvent.FILTERS_CHANGED,this.onTypeFiltersChangedHandler);
         this.typeFilters.dispose();
         this.typeFilters = null;
         this._popoverCaller.dispose();
         this._popoverCaller = null;
         this.hoverArea = null;
         this._sortieData = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hoverArea.buttonMode = true;
         takePlaceFirstTimeBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
         if(takePlaceBtn)
         {
            takePlaceBtn.label = FORTIFICATIONS.SORTIE_SLOT_TAKEPLACE;
         }
         this._popoverCaller = new PopoverCallerWrapper(DisplayObject(this.btnConfigure));
         this.btnConfigure.addEventListener(ButtonEvent.CLICK,this.onBtnConfigureClickHandler);
         this.btnConfigure.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_GEAR;
         this.btnConfigure.mouseEnabledOnDisabled = true;
         this.typeFilters.addEventListener(FiltersEvent.FILTERS_CHANGED,this.onTypeFiltersChangedHandler);
         addTooltipSubscriber(this.btnConfigure);
         this.btnConfigure.alpha = DEF_BTN_ALPHA;
         this.typeFilters.visible = this.btnConfigure.visible = false;
         this.unfrozeVehicleBtn.mouseEnabledOnDisabled = true;
         this.unfrozeVehicleBtn.addEventListener(ButtonEvent.CLICK,this.onUnfrozeVehicleBtnClick);
         this.unfrozeVehicleBtn.addEventListener(MouseEvent.ROLL_OVER,this.onUnfrozeVehicleBtnRollOver);
         this.unfrozeVehicleBtn.addEventListener(MouseEvent.ROLL_OUT,this.onUnfrozeVehicleBtnRollOut);
         this.vehBrokenIcon.addEventListener(MouseEvent.ROLL_OVER,this.onVehBrokenIconRollOver);
         this.vehBrokenIcon.addEventListener(MouseEvent.ROLL_OUT,this.onVehBrokenIconRollOut);
         vehicleBtn.alertIconPadding = ALERT_ICON_PADDING;
      }
      
      public function getHitArea() : DisplayObject
      {
         return vehicleBtn as DisplayObject;
      }
      
      public function getPopoverCaller() : IPopOverCaller
      {
         return this._popoverCaller;
      }
      
      public function getTargetButton() : DisplayObject
      {
         return vehicleBtn as DisplayObject;
      }
      
      public function lockFilterOverListener(param1:uint, param2:Boolean) : void
      {
         if(param2)
         {
            this._rollEventLockers |= param1;
         }
         else
         {
            this._rollEventLockers &= ~param1;
         }
      }
      
      public function setFiltersData(param1:ButtonFiltersVO) : void
      {
         this.typeFilters.setData(param1);
      }
      
      private function updateFiltersAlpha() : void
      {
         var _loc1_:Button = null;
         var _loc2_:int = this.typeFilters.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this.typeFilters.getButtonAt(_loc3_);
            if(this._isMouseOver || _loc1_.selected)
            {
               _loc1_.alpha = HOVER_BTN_ALPHA;
            }
            else
            {
               _loc1_.alpha = DEF_BTN_ALPHA;
            }
            _loc3_++;
         }
      }
      
      private function enableRollEventListeners(param1:Boolean) : void
      {
         if(this._isEnableRollEventListeners == param1)
         {
            return;
         }
         this._isEnableRollEventListeners = param1;
         if(param1)
         {
            if(!hasEventListener(MouseEvent.ROLL_OVER))
            {
               addEventListener(MouseEvent.ROLL_OVER,this.onSortieRollOverHandler);
            }
            if(!hasEventListener(MouseEvent.ROLL_OUT))
            {
               addEventListener(MouseEvent.ROLL_OUT,this.onSortieRollOutHandler);
            }
         }
         else
         {
            if(hasEventListener(MouseEvent.ROLL_OVER))
            {
               removeEventListener(MouseEvent.ROLL_OVER,this.onSortieRollOverHandler);
            }
            if(hasEventListener(MouseEvent.ROLL_OUT))
            {
               removeEventListener(MouseEvent.ROLL_OUT,this.onSortieRollOutHandler);
            }
         }
      }
      
      override public function set slotData(param1:IRallySlotVO) : void
      {
         this._sortieData = SortieSlotVO(param1);
         super.slotData = param1;
      }
      
      override public function set index(param1:int) : void
      {
         super.index = param1;
         this.enableRollEventListeners(param1 > 0);
      }
      
      public function get takePlaceFirstTimeBtnTyped() : ButtonIconTextTransparent
      {
         return ButtonIconTextTransparent(takePlaceFirstTimeBtn);
      }
      
      public function set takePlaceFirstTimeBtnTyped(param1:ButtonIconTextTransparent) : void
      {
         takePlaceFirstTimeBtn = param1;
      }
      
      public function get gunnerIcon() : MovieClip
      {
         return this._gunnerIcon;
      }
      
      public function set gunnerIcon(param1:MovieClip) : void
      {
         if(param1 == this._gunnerIcon)
         {
            return;
         }
         this._gunnerIcon = param1;
         param1.visible = false;
         addTooltipSubscriber(param1);
      }
      
      public function get hasFilters() : Boolean
      {
         return this.hasSelectedVehicles || this.hasSelectedFilters;
      }
      
      public function get hasSelectedFilters() : Boolean
      {
         return this.typeFilters.filtersValue > 0;
      }
      
      public function get hasSelectedVehicles() : Boolean
      {
         return vehicleBtn.vehicleCount > 0;
      }
      
      override protected function onContextMenuAreaClick(param1:MouseEvent) : void
      {
         var _loc2_:ExtendedUserVO = Boolean(slotData) ? ExtendedUserVO(slotData.player) : null;
         if(_loc2_ && !UserTags.isCurrentPlayer(_loc2_.tags))
         {
            App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.STRONGHOLD_USER,this,_loc2_);
         }
      }
      
      override protected function onRemoveClick(param1:ButtonEvent) : void
      {
         if(this.hasSelectedFilters || this.hasSelectedVehicles)
         {
            dispatchEvent(new ClanBattleSlotEvent(ClanBattleSlotEvent.RESET_FILTERS,0,true));
         }
         else
         {
            super.onRemoveClick(param1);
         }
      }
      
      private function onBtnConfigureClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new ClanBattleSlotEvent(ClanBattleSlotEvent.CHOOSE_VEHICLE,0,true));
      }
      
      private function onTypeFiltersChangedHandler(param1:FiltersEvent) : void
      {
         dispatchEvent(new ClanBattleSlotEvent(ClanBattleSlotEvent.FILTERS_CHANGED,param1.filtersValue,true));
      }
      
      private function onSortieRollOverHandler(param1:MouseEvent) : void
      {
         if(this._rollEventLockers > 0)
         {
            return;
         }
         this._isMouseOver = true;
         this.typeFilters.visible = vehicleBtn.vehicleCount < 0;
         if(this.typeFilters.visible)
         {
            this.updateFiltersAlpha();
         }
         this.btnConfigure.alpha = HOVER_BTN_ALPHA;
      }
      
      private function onSortieRollOutHandler(param1:MouseEvent) : void
      {
         this._isMouseOver = false;
         if(this._sortieData && this._sortieData.isCommanderState && !this._sortieData.player && !this._sortieData.isLocked)
         {
            this.typeFilters.visible = this.hasSelectedFilters;
            if(this.typeFilters.visible)
            {
               this.updateFiltersAlpha();
            }
            this.btnConfigure.alpha = DEF_BTN_ALPHA;
         }
      }
      
      private function onUnfrozeVehicleBtnClick(param1:ButtonEvent) : void
      {
         dispatchEvent(new RallyViewsEvent(RallyViewsEvent.VEH_UNFREEZE_REQUEST,index));
      }
      
      private function onUnfrozeVehicleBtnRollOver(param1:MouseEvent) : void
      {
         if(this.unfrozeVehicleBtn.enabled)
         {
            this._tooltipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_UNFROZEVEHICLEBTN);
         }
         else
         {
            this._tooltipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_UNFROZEVEHICLEBTN_DISABLED);
         }
      }
      
      private function onUnfrozeVehicleBtnRollOut(param1:MouseEvent) : void
      {
         hideTooltip();
      }
      
      private function onVehBrokenIconRollOver(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_VEHBROKENICON);
      }
      
      private function onVehBrokenIconRollOut(param1:MouseEvent) : void
      {
         hideTooltip();
      }
   }
}

import flash.display.DisplayObject;
import net.wg.infrastructure.interfaces.IPopOverCaller;
import net.wg.infrastructure.interfaces.entity.IDisposable;

class PopoverCallerWrapper implements IPopOverCaller, IDisposable
{
    
   
   private var _target:DisplayObject;
   
   private var _disposed:Boolean = false;
   
   function PopoverCallerWrapper(param1:DisplayObject)
   {
      super();
      this._target = param1;
   }
   
   public function dispose() : void
   {
      this._disposed = true;
      this._target = null;
   }
   
   public function getHitArea() : DisplayObject
   {
      return this._target;
   }
   
   public function getTargetButton() : DisplayObject
   {
      return this._target;
   }
   
   public function isDisposed() : Boolean
   {
      return this._disposed;
   }
}
