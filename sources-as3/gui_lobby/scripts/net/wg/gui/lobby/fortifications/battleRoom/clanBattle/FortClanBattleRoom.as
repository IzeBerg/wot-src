package net.wg.gui.lobby.fortifications.battleRoom.clanBattle
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.FITTING_TYPES;
   import net.wg.data.constants.generated.FORTIFICATION_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.controls.ButtonIconLoader;
   import net.wg.gui.components.controls.InfoIcon;
   import net.wg.gui.components.controls.NormalSortingBtnVO;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.minimap.MinimapGrid;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.gui.lobby.components.data.ButtonFiltersVO;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.fortifications.battleRoom.SortieChatSection;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSlot;
   import net.wg.gui.lobby.fortifications.cmp.drctn.impl.ConnectedDirects;
   import net.wg.gui.lobby.fortifications.data.battleRoom.SortieSlotVO;
   import net.wg.gui.lobby.fortifications.data.battleRoom.SortieVO;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.ClanBattleTimerVO;
   import net.wg.gui.lobby.fortifications.data.battleRoom.clanBattle.FortClanBattleRoomVO;
   import net.wg.gui.lobby.fortifications.data.popover.FortVehicleSelectPopoverData;
   import net.wg.gui.lobby.fortifications.events.ClanBattleSlotEvent;
   import net.wg.gui.lobby.fortifications.events.ClanBattleTimerEvent;
   import net.wg.gui.lobby.fortifications.interfaces.IClanBattleTimer;
   import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverParams;
   import net.wg.gui.lobby.reservesPanel.components.ReserveSlot;
   import net.wg.gui.messenger.ChannelComponent;
   import net.wg.gui.rally.controls.RallyInvalidationType;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.events.RallyViewsEvent;
   import net.wg.gui.rally.interfaces.IChatSectionWithDescription;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.vo.ActionButtonVO;
   import net.wg.infrastructure.base.meta.IFortClanBattleRoomMeta;
   import net.wg.infrastructure.base.meta.impl.FortClanBattleRoomMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.IPopoverManager;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.gfx.MouseEventEx;
   
   public class FortClanBattleRoom extends FortClanBattleRoomMeta implements IFortClanBattleRoomMeta
   {
      
      private static const CHANGE_UNIT_STATE:int = 24;
      
      private static const SET_PLAYER_STATE:int = 6;
      
      private static const SEPARATOR_BACK_Y:int = 68;
      
      private static const CHAT_HEADER_Y:int = 84;
      
      private static const CHAT_CHANNEL_COMPONENT_Y:int = 118;
      
      private static const CHAT_MESSAGE_AREA_HEIGHT:int = 443;
      
      private static const CHAT_MESSAGE_INPUT_Y:int = 468;
      
      private static const SEPARATOR_BATTLE_BACK_Y:int = 356;
      
      private static const CHAT_BATTLE_HEADER_Y:int = 377;
      
      private static const CHAT_BATTLE_CHANNEL_COMPONENT_Y:int = 406;
      
      private static const CHAT_BATTLE_MESSAGE_AREA_HEIGHT:int = 155;
      
      private static const CHAT_BATTLE_MESSAGE_INPUT_Y:int = 180;
      
      private static const ROOM_STATUS_INFO_COMMANDER_Y:int = 587;
      
      private static const ROOM_STATUS_INFO_Y:int = 605;
      
      private static const SEPARATOR_CANINVITE_Y:int = 139;
      
      private static const SEPARATOR_Y:int = 102;
      
      private static const WAITING_LIST_BUTTON_BAR_CANINVITE_Y:int = 170;
      
      private static const WAITING_LIST_BUTTON_BAR_Y:int = 134;
      
      private static const WAITING_LIST_SECTION_CANINVITE_Y:int = 106;
      
      private static const WAITING_LIST_SECTION_Y:int = 69;
      
      private static const CANDIDATES_HEADER_CANINVITE_Y:int = 6;
      
      private static const CANDIDATES_HEADER_Y:int = 43;
      
      private static const CONFIGURE_BUTTON_MARGIN:int = 5;
      
      private static const NATION_INDEX:String = "nationIndex";
      
      private static const ASCENDING:String = "ascending";
      
      private static const NUMERIC:String = "numeric";
       
      
      public var mineClanName:TextField = null;
      
      public var enemyClanName:TextField = null;
      
      public var mineReadyStatus:IndicationOfStatus = null;
      
      public var enemyReadyStatus:IndicationOfStatus = null;
      
      public var timer:IClanBattleTimer = null;
      
      public var headerDescr:TextField = null;
      
      public var teamHeader:TextField = null;
      
      public var waitForBattleHeader:TextField = null;
      
      public var waitForDirections:MovieClip = null;
      
      public var connectedDirections:ConnectedDirects = null;
      
      public var roomStatusInfo:TextField = null;
      
      public var lblMapHeader:TextField = null;
      
      public var btnRoomStatus:SoundButtonEx = null;
      
      public var btnConfigure:ButtonIconLoader = null;
      
      public var divisionInfo:InfoIcon = null;
      
      public var minimapGrid:MinimapGrid = null;
      
      public var minimap:MinimapPresentation = null;
      
      public var timerBack:MovieClip = null;
      
      public var separatorBack1:Sprite = null;
      
      public var separatorBack2:Sprite = null;
      
      public var waitingListButtonBar:SortableHeaderButtonBar = null;
      
      public var teamButtonBar:SortableHeaderButtonBar = null;
      
      public var reserve1:ReserveSlot = null;
      
      public var reserve2:ReserveSlot = null;
      
      public var reserve3:ReserveSlot = null;
      
      private var _model:FortClanBattleRoomVO = null;
      
      private var _isCommander:Boolean = false;
      
      private var _canInvite:Boolean = false;
      
      private var _configureButtonData:ActionButtonVO = null;
      
      private var _reserveSlots:Vector.<ReserveSlot> = null;
      
      private var _roomStatusDescription:String = "";
      
      private var _currentDirection:String = "";
      
      private var _popoverMgr:IPopoverManager = null;
      
      public function FortClanBattleRoom()
      {
         super();
         this._reserveSlots = new <ReserveSlot>[this.reserve1,this.reserve2,this.reserve3];
         alpha = 0;
      }
      
      override protected function onChooseVehicleRequest(param1:RallyViewsEvent) : void
      {
         var _loc2_:IRallySimpleSlotRenderer = IRallySimpleSlotRenderer(param1.target);
         var _loc3_:FortVehicleSelectPopoverData = new FortVehicleSelectPopoverData();
         _loc3_.isMultiSelect = false;
         _loc3_.showMainBtn = true;
         _loc3_.levelsRange = this._model.levelsRange;
         if(_loc2_.slotData.selectedVehicle)
         {
            _loc3_.selectedVehicles = [_loc2_.slotData.selectedVehicle.intCD];
         }
         App.popoverMgr.show(IPopOverCaller(param1.target),FORTIFICATION_ALIASES.FORT_VEHICLE_SELECT_POPOVER_ALIAS,_loc3_);
      }
      
      override protected function setFiltersData(param1:ButtonFiltersVO) : void
      {
         FortClanBattleTeamSection(teamSection).setFiltersData(param1);
      }
      
      override protected function setBattleRoomData(param1:FortClanBattleRoomVO) : void
      {
         this._model = param1;
         this.headerDescr.htmlText = param1.headerDescr;
         this.teamHeader.htmlText = param1.teamHeader;
         this.lblMapHeader.text = param1.mapName;
         if(param1.isBattleTimerVisible)
         {
            this.timer.visible = this.mineReadyStatus.visible = this.enemyReadyStatus.visible = this.enemyClanName.visible = this.mineClanName.visible = true;
            this.mineClanName.htmlText = param1.mineClanName;
            this.enemyClanName.htmlText = param1.enemyClanName;
            this.waitForBattleHeader.visible = false;
         }
         else
         {
            this.timer.visible = this.mineReadyStatus.visible = this.enemyReadyStatus.visible = this.enemyClanName.visible = this.mineClanName.visible = false;
            this.waitForBattleHeader.visible = true;
            this.waitForBattleHeader.htmlText = param1.waitForBattleDescr;
            this.mineReadyStatus.status = IndicationOfStatus.STATUS_NORMAL;
            this.enemyReadyStatus.status = IndicationOfStatus.STATUS_NORMAL;
         }
         this.timerBack.gotoAndStop(!!param1.isBattleTimerVisible ? 1 : 2);
         titleLbl.visible = !param1.isBattleType;
         descrLbl.visible = !param1.isBattleType;
         this.lblMapHeader.visible = param1.isBattleType;
         this.minimapGrid.visible = param1.isBattleType;
         this.minimapGrid.back.visible = this.minimapGrid.dices.visible = !param1.isMapEnabled;
         this.minimap.visible = param1.isBattleType;
         this.reserve3.visible = param1.isBattleType;
         if(!param1.isBattleType)
         {
            this.waitForDirections.visible = false;
            this.connectedDirections.visible = false;
         }
         this.separatorBack2.y = !!param1.isBattleType ? Number(SEPARATOR_BATTLE_BACK_Y) : Number(SEPARATOR_BACK_Y);
         SortieChatSection(chatSection).lblChatHeader.y = !!param1.isBattleType ? Number(CHAT_BATTLE_HEADER_Y) : Number(CHAT_HEADER_Y);
         var _loc2_:ChannelComponent = getChannelComponent();
         _loc2_.y = !!param1.isBattleType ? Number(CHAT_BATTLE_CHANNEL_COMPONENT_Y) : Number(CHAT_CHANNEL_COMPONENT_Y);
         _loc2_.messageInput.y = !!param1.isBattleType ? Number(CHAT_BATTLE_MESSAGE_INPUT_Y) : Number(CHAT_MESSAGE_INPUT_Y);
         _loc2_.messageArea.height = !!param1.isBattleType ? Number(CHAT_BATTLE_MESSAGE_AREA_HEIGHT) : Number(CHAT_MESSAGE_AREA_HEIGHT);
         this.layoutConfigureInfo();
         alpha = 1;
      }
      
      override protected function setTimerDelta(param1:ClanBattleTimerVO) : void
      {
         this.timer.setData(param1);
      }
      
      override protected function updateTitle() : void
      {
         titleLbl.text = FORTIFICATIONS.STRONGHOLDTITLE_SORTIE;
      }
      
      override protected function configUI() : void
      {
         var _loc1_:ReserveSlot = null;
         var _loc2_:TextField = null;
         var _loc3_:MovieClip = null;
         super.configUI();
         this._popoverMgr = App.popoverMgr;
         this.initWaitingListButtonBar();
         this.waitingListButtonBar.mouseEnabled = false;
         this.waitingListButtonBar.mouseChildren = false;
         this.teamButtonBar.mouseEnabled = false;
         this.teamButtonBar.mouseChildren = false;
         descrLbl.text = FORTIFICATIONS.SORTIE_ROOM_DESCRIPTION;
         descrLbl.mouseEnabled = false;
         backBtn.tooltip = TOOLTIPS.FORTIFICATION_SORTIE_BATTLEROOM_LEAVEBTN;
         this.headerDescr.autoSize = TextFieldAutoSize.LEFT;
         this.timer.addEventListener(ClanBattleTimerEvent.ALERT_TICK,this.onTimerAlertTickHandler);
         if(this.btnRoomStatus)
         {
            this.btnRoomStatus.addEventListener(ButtonEvent.CLICK,this.onRoomStatusClickHandler);
            this.btnRoomStatus.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.btnRoomStatus.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         }
         this.btnConfigure.addEventListener(ButtonEvent.CLICK,this.onBtnConfigureClickHandler);
         this.btnConfigure.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.btnConfigure.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.btnConfigure.iconSource = RES_ICONS.MAPS_ICONS_LIBRARY_GEAR;
         this.btnConfigure.mouseEnabledOnDisabled = true;
         this.divisionInfo.addEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.divisionInfo.addEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         for each(_loc1_ in this._reserveSlots)
         {
            _loc1_.slotIndex = this._reserveSlots.indexOf(_loc1_);
            _loc1_.type = FITTING_TYPES.RESERVES_SLOTS[_loc1_.slotIndex];
            _loc1_.addEventListener(ButtonEvent.CLICK,this.onReserveSlotClickHandler);
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.onReserveSlotMouseDownHandler);
            _loc1_.addEventListener(MouseEvent.MOUSE_WHEEL,this.onReserveSlotMouseWheelHandler);
            _loc1_.enabled = false;
            _loc1_.levelMC.visible = false;
         }
         teamSection.entireSelectArea = true;
         _loc2_ = this.waitForDirections.waitInfo;
         _loc3_ = this.waitForDirections.waitIcon;
         _loc2_.text = WAITING.LOADINGDATA;
         _loc3_.x = this.waitForDirections.width - _loc3_.width + _loc2_.textWidth >> 1;
         _loc2_.x = _loc3_.x + _loc3_.width;
         this.waitForDirections.visible = false;
         this.connectedDirections.visible = false;
         addEventListener(ClanBattleSlotEvent.FILTERS_CHANGED,this.onSlotFiltersChangedHandler);
         addEventListener(ClanBattleSlotEvent.RESET_FILTERS,this.onSlotResetFiltersHandler);
         addEventListener(ClanBattleSlotEvent.CHOOSE_VEHICLE,this.onChooseVehicleHandler);
      }
      
      private function onChooseVehicleHandler(param1:ClanBattleSlotEvent) : void
      {
         var _loc2_:SortieSlot = param1.slot;
         var _loc3_:FortVehicleSelectPopoverData = new FortVehicleSelectPopoverData();
         _loc3_.slotIndex = _loc2_.index;
         _loc3_.levelsRange = this._model.levelsRange;
         _loc3_.selectedVehicles = SortieSlotVO(_loc2_.slotData).vehicles;
         this._popoverMgr.show(_loc2_.getPopoverCaller(),FORTIFICATION_ALIASES.FORT_VEHICLE_SELECT_POPOVER_ALIAS,_loc3_);
      }
      
      private function onSlotFiltersChangedHandler(param1:ClanBattleSlotEvent) : void
      {
         onFiltersChangeS(param1.slot.index,param1.filtersValue);
      }
      
      private function onSlotResetFiltersHandler(param1:ClanBattleSlotEvent) : void
      {
         resetFiltersS(param1.slot.index);
      }
      
      override protected function draw() : void
      {
         super.draw();
         this._isCommander = Boolean(rallyData) ? Boolean(rallyData.isCommander) : Boolean(false);
         this._canInvite = Boolean(rallyData) ? Boolean(rallyData.canInvite) : Boolean(false);
         this.btnConfigure.visible = this.btnRoomStatus.visible = this._isCommander;
         if(isInvalid(RallyInvalidationType.CONFIGURE_BUTTON_DATA))
         {
            if(this._configureButtonData)
            {
               this.btnConfigure.enabled = this._configureButtonData.isEnabled;
               this.btnConfigure.invalidateState();
               this.btnRoomStatus.enabled = this._configureButtonData.isRoomStatusEnabled;
               this.btnRoomStatus.invalidateState();
            }
         }
         if(teamSection.actionButtonData != null && isInvalid(RallyInvalidationType.ACTION_BUTTON_DATA))
         {
            tabChildren = focusable = !teamSection.actionButtonData.isReady;
         }
         this.layoutConfigureInfo();
      }
      
      public function enableCloseButton(param1:Boolean) : void
      {
         if(this.btnRoomStatus)
         {
            this.btnRoomStatus.enabled = param1;
         }
      }
      
      public function as_setOpened(param1:String, param2:String, param3:String) : void
      {
         this.btnRoomStatus.label = param1;
         this.roomStatusInfo.htmlText = param2;
         this._roomStatusDescription = param3;
      }
      
      public function headerDataProvider(param1:SortableHeaderButtonBar, param2:IDataProvider) : void
      {
         param1.dataProvider = param2;
      }
      
      private function onControlRollOutHandler(param1:MouseEvent) : void
      {
         onControlRollOut();
      }
      
      private function onControlRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = Values.EMPTY_STR;
         var _loc3_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.btnRoomStatus:
               _loc2_ = TOOLTIPS.FORTIFICATION_UNIT_ACCESS_HEADER;
               _loc3_ = this._roomStatusDescription;
               this.showTooltip(_loc2_,_loc3_);
               break;
            case this.btnConfigure:
               _loc2_ = !!this.btnConfigure.enabled ? TOOLTIPS.FORTIFICATION_HEADER_SETTINGSBTN_HEADER : TOOLTIPS.FORTIFICATION_HEADER_SETTINGSBTN_DISABLED_HEADER;
               _loc3_ = !!this.btnConfigure.enabled ? TOOLTIPS.FORTIFICATION_HEADER_SETTINGSBTN_BODY : TOOLTIPS.FORTIFICATION_HEADER_SETTINGSBTN_DISABLED_BODY;
               this.showTooltip(_loc2_,_loc3_);
               break;
            case this.divisionInfo:
               App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SORTIE_DIVISION,null);
         }
      }
      
      private function onRoomStatusClickHandler(param1:ButtonEvent) : void
      {
         toggleRoomStatus();
      }
      
      private function onBtnConfigureClickHandler(param1:ButtonEvent) : void
      {
         openConfigureWindowS();
      }
      
      private function showTooltip(param1:String, param2:String) : void
      {
         var _loc3_:String = App.toolTipMgr.getNewFormatter().addHeader(param1,true).addBody(param2,true).make();
         if(_loc3_.length > 0)
         {
            App.toolTipMgr.showComplex(_loc3_);
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         backBtn.label = FORTIFICATIONS.SORTIE_ROOM_LEAVEBTN;
         registerFlashComponentS(this.minimapGrid,Aliases.LOBBY_MINIMAP_GRID);
         registerFlashComponentS(this.minimap,Aliases.LOBBY_MINIMAP);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:ReserveSlot = null;
         App.utils.scheduler.cancelTask(this.coolDownControls);
         this.timer.removeEventListener(ClanBattleTimerEvent.ALERT_TICK,this.onTimerAlertTickHandler);
         this.timer = null;
         this.headerDescr = null;
         this.teamHeader = null;
         this.waitForBattleHeader = null;
         this.waitForDirections = null;
         this._model = null;
         this._popoverMgr = null;
         this.mineReadyStatus.dispose();
         this.mineReadyStatus = null;
         this.enemyReadyStatus.dispose();
         this.enemyReadyStatus = null;
         this.mineClanName = null;
         this.enemyClanName = null;
         this.connectedDirections.dispose();
         this.connectedDirections = null;
         this.roomStatusInfo = null;
         this.lblMapHeader = null;
         this.minimapGrid = null;
         this.minimap = null;
         this.timerBack = null;
         this.separatorBack1 = null;
         this.separatorBack2 = null;
         for each(_loc1_ in this._reserveSlots)
         {
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onReserveSlotClickHandler);
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onReserveSlotMouseDownHandler);
            _loc1_.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onReserveSlotMouseWheelHandler);
            _loc1_ = null;
         }
         this._reserveSlots.splice(0,this._reserveSlots.length);
         this._reserveSlots = null;
         this.reserve1.dispose();
         this.reserve1 = null;
         this.reserve2.dispose();
         this.reserve2 = null;
         this.reserve3.dispose();
         this.reserve3 = null;
         if(this.btnConfigure)
         {
            this.btnConfigure.removeEventListener(ButtonEvent.CLICK,this.onBtnConfigureClickHandler);
            this.btnConfigure.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.btnConfigure.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            this.btnConfigure.dispose();
            this.btnConfigure = null;
         }
         this._configureButtonData = null;
         this.divisionInfo.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
         this.divisionInfo.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
         this.divisionInfo.dispose();
         this.divisionInfo = null;
         if(this.btnRoomStatus)
         {
            this.btnRoomStatus.removeEventListener(ButtonEvent.CLICK,this.onRoomStatusClickHandler);
            this.btnRoomStatus.removeEventListener(MouseEvent.ROLL_OVER,this.onControlRollOverHandler);
            this.btnRoomStatus.removeEventListener(MouseEvent.ROLL_OUT,this.onControlRollOutHandler);
            this.btnRoomStatus.dispose();
            this.btnRoomStatus = null;
         }
         if(this.waitingListButtonBar)
         {
            this.waitingListButtonBar.dispose();
            this.waitingListButtonBar = null;
         }
         if(this.teamButtonBar)
         {
            this.teamButtonBar.dispose();
            this.teamButtonBar = null;
         }
         removeEventListener(ClanBattleSlotEvent.FILTERS_CHANGED,this.onSlotFiltersChangedHandler);
         removeEventListener(ClanBattleSlotEvent.RESET_FILTERS,this.onSlotResetFiltersHandler);
         removeEventListener(ClanBattleSlotEvent.CHOOSE_VEHICLE,this.onChooseVehicleHandler);
         super.onDispose();
      }
      
      public function as_setDirection(param1:String, param2:Boolean) : void
      {
         if(this._currentDirection != param1)
         {
            this._currentDirection = param1;
            this.connectedDirections.setDirection(param1,param2);
         }
      }
      
      override protected function setTableHeader(param1:Vector.<NormalSortingBtnVO>) : void
      {
         var _loc2_:DataProvider = new DataProvider(App.utils.data.vectorToArray(param1));
         this.headerDataProvider(this.teamButtonBar,_loc2_);
      }
      
      override protected function setReservesEnabled(param1:Array) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._reserveSlots[_loc3_].enabled = param1[_loc3_];
            _loc3_++;
         }
      }
      
      override protected function setReservesData(param1:Vector.<DeviceSlotVO>) : void
      {
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._reserveSlots[_loc3_].update(param1[_loc3_]);
            _loc3_++;
         }
      }
      
      protected function showFittingPopover(param1:ReserveSlot) : void
      {
         var _loc2_:Object = new FittingSelectPopoverParams(param1.type,param1.slotIndex);
         App.popoverMgr.show(param1,FORTIFICATION_ALIASES.FORT_RESERVE_SELECT_POPOVER_ALIAS,_loc2_);
      }
      
      private function onReserveSlotClickHandler(param1:ButtonEvent) : void
      {
         if(param1.buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            this.showFittingPopover(ReserveSlot(param1.currentTarget));
         }
      }
      
      private function onReserveSlotMouseDownHandler(param1:MouseEvent) : void
      {
         App.popoverMgr.hide();
      }
      
      private function onReserveSlotMouseWheelHandler(param1:MouseEvent) : void
      {
         App.popoverMgr.hide();
      }
      
      override protected function getRallyViewAlias() : String
      {
         return FORTIFICATION_ALIASES.FORT_CLAN_BATTLE_ROOM_VIEW_UI;
      }
      
      override protected function getTitleStr() : String
      {
         return FORTIFICATIONS.SORTIE_ROOM_TITLE;
      }
      
      override protected function getIRallyVOForRally(param1:Object) : IRallyVO
      {
         return new SortieVO(param1);
      }
      
      override protected function coolDownControls(param1:Boolean, param2:int) : void
      {
         if(param2 == CHANGE_UNIT_STATE)
         {
            IChatSectionWithDescription(chatSection).enableEditCommitButton(param1);
            this.enableCloseButton(param1);
         }
         else if(param2 == SET_PLAYER_STATE)
         {
            teamSection.enableFightButton(param1);
         }
         super.coolDownControls(param1,param2);
      }
      
      public function as_updateReadyStatus(param1:Boolean, param2:Boolean) : void
      {
         this.mineReadyStatus.status = this.getIndicatorStatus(param1);
         this.enemyReadyStatus.status = this.getIndicatorStatus(param2);
      }
      
      public function as_updateReadyDirections(param1:Boolean) : void
      {
         this.waitForDirections.visible = !param1;
         this.connectedDirections.visible = param1;
      }
      
      override protected function setConfigureButtonState(param1:ActionButtonVO) : void
      {
         this._configureButtonData = param1;
         invalidate(RallyInvalidationType.CONFIGURE_BUTTON_DATA);
      }
      
      public function as_updateTeamHeaderText(param1:String) : void
      {
         FortClanBattleTeamSection(teamSection).updateTeamHeaderText(param1);
      }
      
      private function getIndicatorStatus(param1:Boolean) : String
      {
         return !!param1 ? IndicationOfStatus.STATUS_READY : IndicationOfStatus.STATUS_NORMAL;
      }
      
      private function onTimerAlertTickHandler(param1:ClanBattleTimerEvent) : void
      {
         onTimerAlertS();
      }
      
      private function layoutConfigureInfo() : void
      {
         if(this._isCommander)
         {
            this.headerDescr.x = this.btnConfigure.x + this.btnConfigure.width + CONFIGURE_BUTTON_MARGIN;
            this.roomStatusInfo.y = ROOM_STATUS_INFO_COMMANDER_Y;
         }
         else
         {
            this.headerDescr.x = this.btnConfigure.x;
            this.roomStatusInfo.y = ROOM_STATUS_INFO_Y;
         }
         this.divisionInfo.x = this.headerDescr.x + this.headerDescr.width;
         var _loc1_:Boolean = this._isCommander || this._canInvite;
         this.separatorBack1.y = !!_loc1_ ? Number(SEPARATOR_CANINVITE_Y) : Number(SEPARATOR_Y);
         this.waitingListButtonBar.y = !!_loc1_ ? Number(WAITING_LIST_BUTTON_BAR_CANINVITE_Y) : Number(WAITING_LIST_BUTTON_BAR_Y);
         waitingListSection.y = !!_loc1_ ? Number(WAITING_LIST_SECTION_CANINVITE_Y) : Number(WAITING_LIST_SECTION_Y);
         waitingListSection.lblCandidatesHeader.y = !!_loc1_ ? Number(CANDIDATES_HEADER_CANINVITE_Y) : Number(CANDIDATES_HEADER_Y);
      }
      
      private function initWaitingListButtonBar() : void
      {
         var _loc1_:NormalSortingBtnVO = new NormalSortingBtnVO({
            "id":NATION_INDEX,
            "buttonWidth":165,
            "buttonHeight":40,
            "sortOrder":0,
            "toolTip":PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NATION,
            "defaultSortDirection":ASCENDING,
            "label":PREBATTLE.LABELS_PLAYER,
            "inverted":false,
            "sortType":NUMERIC,
            "showSeparator":true,
            "textAlign":TextFieldAutoSize.LEFT
         });
         var _loc2_:NormalSortingBtnVO = new NormalSortingBtnVO({
            "id":NATION_INDEX,
            "buttonWidth":90,
            "buttonHeight":40,
            "sortOrder":0,
            "toolTip":PROFILE.SECTION_TECHNIQUE_SORT_TOOLTIP_NATION,
            "defaultSortDirection":ASCENDING,
            "label":FORTIFICATIONS.STRONGHOLDTABLE_RATING,
            "inverted":false,
            "sortType":NUMERIC,
            "showSeparator":false
         });
         var _loc3_:IDataProvider = new DataProvider([_loc1_,_loc2_]);
         this.headerDataProvider(this.waitingListButtonBar,_loc3_);
      }
   }
}
