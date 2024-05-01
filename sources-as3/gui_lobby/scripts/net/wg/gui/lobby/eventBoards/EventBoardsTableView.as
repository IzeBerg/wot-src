package net.wg.gui.lobby.eventBoards
{
   import fl.motion.easing.Linear;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.common.waiting.WaitingComponent;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.eventBoards.components.AwardGroups;
   import net.wg.gui.lobby.eventBoards.components.AwardStripeRenderer;
   import net.wg.gui.lobby.eventBoards.components.MaintenanceComponent;
   import net.wg.gui.lobby.eventBoards.components.Pagination;
   import net.wg.gui.lobby.eventBoards.components.TableViewHeader;
   import net.wg.gui.lobby.eventBoards.components.TableViewStatus;
   import net.wg.gui.lobby.eventBoards.components.TableViewTableHeader;
   import net.wg.gui.lobby.eventBoards.components.view.EventBoardTableContent;
   import net.wg.gui.lobby.eventBoards.data.AwardStripeRendererVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableRendererContainerVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewHeaderVO;
   import net.wg.gui.lobby.eventBoards.data.EventBoardsTableViewStatusVO;
   import net.wg.gui.lobby.eventBoards.events.AwardsRendererEvent;
   import net.wg.gui.lobby.eventBoards.events.PlayerRendererEvent;
   import net.wg.infrastructure.base.meta.IEventBoardsTableViewMeta;
   import net.wg.infrastructure.base.meta.impl.EventBoardsTableViewMeta;
   import net.wg.infrastructure.interfaces.IPopOverCaller;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InputValue;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.clik.ui.InputDetails;
   
   public class EventBoardsTableView extends EventBoardsTableViewMeta implements IEventBoardsTableViewMeta, IPopOverCaller
   {
      
      private static const TOP_PANEL_Y:int = 84;
      
      private static const TABLE_HEADER_Y:int = 138;
      
      private static const TOP_PANEL_HEIGHT:int = 216;
      
      private static const UNAVAILABLE_HEIGHT:int = 219;
      
      private static const AWARDS_ONTOP_PANEL_HEIGHT:int = 136;
      
      private static const AWARDS_HEIGHT:int = 80;
      
      private static const FADE_IN_DURATION:Number = 150;
      
      private static const PANE_WIDTH:int = 920;
      
      private static const PANE_WIDTH_WITH_SCROLLBAR:int = 933;
      
      private static const PANE_HEIGHT:int = 400;
      
      private static const MY_PLACE_OFFSET_X:int = 10;
      
      private static const MY_PLACE_OFFSET_Y:int = 50;
      
      private static const SCROLLBAR_OFFSET_X:int = 20;
      
      private static const SCROLLBAR_MARGIN:int = 8;
      
      private static const PADDING_TOP:int = 94;
      
      private static const STATUS_OFFSET:int = 15;
      
      private static const INV_HEADER_DATA:String = "InvHeaderData";
      
      private static const INV_AWARD:String = "InvAward";
      
      private static const INV_AWARD_POSITION:String = "InvAwardPosition";
      
      private static const INV_TABLE_HEADER_DATA:String = "InvTableHeaderData";
      
      private static const INV_STATUS_DATA:String = "InvStatusData";
      
      private static const INV_BACKGROUND_POSITION:String = "InvBackgroundPosition";
      
      private static const INV_SCROLL_POSITION:String = "InvScrollPosition";
      
      private static const INV_MY_PLACE:String = "InvMyPlace";
      
      private static const PARTICIPATE_CLICK:String = "participateClick";
      
      private static const STATUS_CHANGE_HEIGHT:String = "statusChangeHeight";
      
      private static const AWARD_GROUPS_CHANGE_SIZE:String = "awardGroupsChangeSize";
       
      
      public var header:TableViewHeader;
      
      public var status:TableViewStatus;
      
      public var btnClose:ISoundButtonEx;
      
      public var btnMyPlace:ISoundButtonEx;
      
      public var selectRatingBtn:ISoundButtonEx;
      
      public var bg:Sprite;
      
      public var bgLoader:UILoaderAlt;
      
      public var awardGroups:AwardGroups = null;
      
      public var awards:AwardStripeRenderer = null;
      
      public var awardsOther:AwardStripeRenderer = null;
      
      public var tableHeader:TableViewTableHeader = null;
      
      public var scrollPane:ResizableScrollPane = null;
      
      public var waitingCmp:WaitingComponent = null;
      
      public var maintenanceCmp:MaintenanceComponent = null;
      
      public var awardsMask:MovieClip = null;
      
      public var tableTopShadow:MovieClip = null;
      
      public var emptyDataTF:TextField = null;
      
      private var _pagination:Pagination = null;
      
      private var _bgFadeTween:Tween;
      
      private var _viewOpacity:Number = 0.0;
      
      private var _headerData:EventBoardsTableViewHeaderVO;
      
      private var _statusData:EventBoardsTableViewStatusVO;
      
      private var _tableData:EventBoardTableRendererContainerVO;
      
      private var _awardsData:EventBoardTableRendererContainerVO;
      
      private var _tableHeaderData:EventBoardTableHeaderVO;
      
      private var _popoverAlias:String = "";
      
      private var _freeSpace:Number = 400;
      
      private var _content:EventBoardTableContent = null;
      
      private var _firstAwardVO:AwardStripeRendererVO = null;
      
      private var _secondAwardVO:AwardStripeRendererVO = null;
      
      private var _firstAwardPosition:Number = 0;
      
      private var _secondAwardPosition:Number = 0;
      
      private var _currentOffset:Number = 0;
      
      private var _availableOffset:Number = 0;
      
      private var _scrollIndex:int = 0;
      
      private var _isCentered:Boolean = false;
      
      private var _selectedIndex:int = -1;
      
      private var _myPlaceTooltip:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _isNextAwardShown:Boolean = false;
      
      private var _myPlaceVisible:Boolean = false;
      
      public function EventBoardsTableView()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._freeSpace = !!this.status.visible ? Number(param2 - y - this.status.getHeight() - UNAVAILABLE_HEIGHT) : Number(param2 - y - UNAVAILABLE_HEIGHT);
         setSize(param1,param2);
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this);
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         var _loc2_:InputDetails = param1.details;
         if(_loc2_.code == Keyboard.ESCAPE && _loc2_.value == InputValue.KEY_DOWN)
         {
            param1.handled = true;
            closeViewS();
         }
      }
      
      private function set viewOpacity(param1:Number) : void
      {
         this._viewOpacity = param1;
         if(_baseDisposed)
         {
            return;
         }
         if(this.btnMyPlace)
         {
            this.btnMyPlace.alpha = this._viewOpacity;
         }
         if(this.selectRatingBtn)
         {
            this.selectRatingBtn.alpha = this._viewOpacity;
         }
         if(this.bgLoader)
         {
            this.bgLoader.alpha = this._viewOpacity;
         }
         if(this.scrollPane)
         {
            this.scrollPane.alpha = this._viewOpacity;
         }
         if(this.btnClose)
         {
            this.btnClose.alpha = this._viewOpacity;
         }
         if(this.awardGroups)
         {
            this.awardGroups.alpha = this._viewOpacity;
         }
         if(this.status)
         {
            this.status.alpha = this._viewOpacity;
         }
         if(this.header)
         {
            this.header.alpha = this._viewOpacity;
         }
         if(this.tableHeader)
         {
            this.tableHeader.alpha = this._viewOpacity;
         }
         if(this.awards)
         {
            this.awards.alpha = this._viewOpacity;
         }
         if(this.awardsOther)
         {
            this.awardsOther.alpha = this._viewOpacity;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.tableTopShadow.visible = false;
         this.tableTopShadow.mouseChildren = false;
         this.tableTopShadow.mouseEnabled = false;
         this.bg.alpha = 0;
         this._bgFadeTween = new Tween(FADE_IN_DURATION,this.bg,{"alpha":1},{
            "paused":false,
            "ease":Linear.easeOut
         });
         this.btnClose.label = EVENT_BOARDS.EXCEL_BTNCLOSE;
         this.btnClose.addEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.bgLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.bgLoader.autoSize = false;
         this.btnMyPlace.addEventListener(ButtonEvent.CLICK,this.onBtnMyPlaceClickHandler);
         this.btnMyPlace.addEventListener(MouseEvent.ROLL_OVER,this.onMyPlaceRollOverHandler);
         this.btnMyPlace.addEventListener(MouseEvent.ROLL_OUT,this.onMyPlaceRollOutHandler);
         this._content = EventBoardTableContent(this.scrollPane.target);
         this._content.addEventListener(Event.RESIZE,this.onContentResizeHandler);
         this._content.addEventListener(AwardsRendererEvent.AWARD_POSITION_CHANGE,this.onAwardPositionChangedHandler);
         this._content.addEventListener(PlayerRendererEvent.PLAYER_CLICK,this.onPlayerClickHandler);
         this.scrollPane.scrollBarShiftHorizontal = SCROLLBAR_OFFSET_X;
         this.scrollPane.scrollBarMargin = SCROLLBAR_MARGIN;
         this.selectRatingBtn.addEventListener(ButtonEvent.CLICK,this.showSelectRatingPopover);
         this.selectRatingBtn.addEventListener(MouseEvent.MOUSE_OVER,this.onSelectRatingOver);
         this.selectRatingBtn.addEventListener(MouseEvent.MOUSE_OUT,this.onSelectRatingOut);
         this.selectRatingBtn.usePreventUpdateTextScale = true;
         addEventListener(PARTICIPATE_CLICK,this.onBtnParticipateClickHandler);
         addEventListener(STATUS_CHANGE_HEIGHT,this.onStatusChangeHeight);
         addEventListener(AWARD_GROUPS_CHANGE_SIZE,this.onAwardGroupsChangeSize);
         this.viewOpacity = 0;
      }
      
      private function onContentResizeHandler(param1:Event) : void
      {
         this.scrollPane.invalidateSize();
         invalidate(INV_SCROLL_POSITION);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
            this.viewOpacity = 1;
         }
         if(isInvalid(INV_BACKGROUND_POSITION))
         {
            this.bgLoader.x = Math.round((App.appWidth - this.bgLoader.width) * 0.5 - this.x);
            this.bgLoader.y = 0;
         }
         if(this._headerData && isInvalid(INV_HEADER_DATA))
         {
            this.header.update(this._headerData);
         }
         if(this._tableHeaderData && isInvalid(INV_TABLE_HEADER_DATA))
         {
            this.tableHeader.update(this._tableHeaderData);
         }
         if(this._statusData && isInvalid(INV_STATUS_DATA))
         {
            this.status.update(this._statusData);
         }
         if(this._tableData && isInvalid(InvalidationType.DATA))
         {
            this._content = EventBoardTableContent(this.scrollPane.target);
            this._content.setData(this._tableData);
            this.setTableVisible(true);
            this.setAwardsDefaultPosition();
            invalidate(INV_SCROLL_POSITION);
         }
         if(this._tableData && isInvalid(INV_MY_PLACE))
         {
            this.updateMyPlacePosition();
            this._content.setMyPlace(this._selectedIndex);
            this._content.validateNow();
         }
         if(isInvalid(INV_SCROLL_POSITION))
         {
            if(this._scrollIndex == 0 || this._scrollIndex == 1)
            {
               this._firstAwardPosition = 0;
               this.scrollPane.scrollPosition = 0;
               this._isNextAwardShown = false;
            }
            if(this._content && this._scrollIndex > 1)
            {
               this._content.validateNow();
               this._availableOffset = Math.max(this.scrollPane.getContentHeight() - this.scrollPane.height,0);
               this._currentOffset = this._content.getRendererPosition(this._scrollIndex);
               if(this._isCentered)
               {
                  _loc1_ = (this.scrollPane.height - AWARDS_HEIGHT) * 0.5;
                  if(this._currentOffset < _loc1_)
                  {
                     this.scrollPane.scrollPosition = 0;
                  }
                  else
                  {
                     this._currentOffset -= _loc1_;
                     this.changeScrollPosition(this._availableOffset,this._currentOffset);
                  }
               }
               else
               {
                  this.changeScrollPosition(this._availableOffset,this._currentOffset);
               }
            }
         }
         if(this._firstAwardVO && isInvalid(INV_AWARD))
         {
            this.tableTopShadow.visible = false;
            this.awards.setData(this._firstAwardVO);
            if(this._secondAwardVO)
            {
               this.awardsOther.setData(this._secondAwardVO);
            }
         }
         if(this._firstAwardVO && isInvalid(INV_AWARD_POSITION))
         {
            this.tableTopShadow.visible = false;
            if(this._secondAwardVO)
            {
               if(this._firstAwardPosition <= 0 && this._secondAwardPosition >= AWARDS_HEIGHT)
               {
                  this.setAwardsDefaultPosition();
                  if(this._secondAwardPosition < this.scrollPane.height)
                  {
                     this.highlightNextAward();
                  }
               }
               else if(this._secondAwardPosition > 0 && this._secondAwardPosition < AWARDS_HEIGHT)
               {
                  this.awards.visible = true;
                  this.awardsOther.visible = true;
                  this.tableTopShadow.visible = true;
                  this.awards.y = AWARDS_ONTOP_PANEL_HEIGHT + this._secondAwardPosition;
                  this.awards.showShadow(true);
                  this.awardsOther.y = this.awards.y + AWARDS_HEIGHT;
                  this.highlightNextAward();
               }
               else if(this._secondAwardPosition <= 0)
               {
                  this.awardsOther.visible = true;
                  this.awards.visible = false;
                  this.awardsOther.y = TOP_PANEL_HEIGHT;
                  this.awards.y = AWARDS_ONTOP_PANEL_HEIGHT;
                  this.highlightNextAward();
               }
            }
            else
            {
               this.setAwardsDefaultPosition();
            }
         }
      }
      
      override protected function setHeaderData(param1:EventBoardsTableViewHeaderVO) : void
      {
         this._headerData = param1;
         this._popoverAlias = this._headerData.popoverAlias;
         invalidate(INV_HEADER_DATA);
      }
      
      override protected function setStatusData(param1:EventBoardsTableViewStatusVO) : void
      {
         this._statusData = param1;
         invalidate(INV_STATUS_DATA);
      }
      
      override protected function setTableData(param1:EventBoardTableRendererContainerVO) : void
      {
         this._tableData = param1;
         this._scrollIndex = 0;
         invalidateData();
      }
      
      override protected function setAwardsStripes(param1:EventBoardTableRendererContainerVO) : void
      {
         this._awardsData = param1;
         this._firstAwardVO = Boolean(this._awardsData.tableDP[0]) ? AwardStripeRendererVO(this._awardsData.tableDP[0]) : null;
         this._secondAwardVO = Boolean(this._awardsData.tableDP[1]) ? AwardStripeRendererVO(this._awardsData.tableDP[1]) : null;
         invalidate(INV_AWARD);
      }
      
      override protected function setTableHeaderData(param1:EventBoardTableHeaderVO) : void
      {
         this._tableHeaderData = param1;
         invalidate(INV_TABLE_HEADER_DATA);
      }
      
      public function as_setBackground(param1:String) : void
      {
         this.bgLoader.source = param1;
      }
      
      public function as_setScrollPos(param1:int, param2:Boolean) : void
      {
         if(this.scrollPane.scrollPosition != param1)
         {
            this._scrollIndex = param1;
            this._isCentered = param2;
            invalidate(INV_SCROLL_POSITION);
         }
      }
      
      public function as_setMyPlaceVisible(param1:Boolean) : void
      {
         this._myPlaceVisible = param1;
         invalidate(INV_MY_PLACE);
      }
      
      public function as_setMyPlace(param1:int) : void
      {
         this._selectedIndex = param1;
         invalidate(INV_MY_PLACE);
      }
      
      public function as_setMyPlaceTooltip(param1:String) : void
      {
         this._myPlaceTooltip = param1;
      }
      
      public function as_setStatusVisible(param1:Boolean) : void
      {
         if(this.status.visible != param1)
         {
            this.status.visible = param1;
            invalidateSize();
         }
      }
      
      public function as_setWaiting(param1:Boolean, param2:String) : void
      {
         this.waitingCmp.visible = param1;
         this.waitingCmp.setAnimationStatus(!param1);
         this.waitingCmp.setMessage(param2);
      }
      
      public function as_setMaintenance(param1:Boolean, param2:String, param3:String, param4:String) : void
      {
         this.maintenanceCmp.visible = param1;
         this.maintenanceCmp.setMessage(param2,param3);
         this.maintenanceCmp.setLabel(param4);
         this.viewOpacity = !!param1 ? Number(0) : Number(1);
      }
      
      public function as_setEmptyData(param1:String) : void
      {
         this.setTableVisible(false);
         this.emptyDataTF.text = param1;
         this.tableTopShadow.visible = true;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.awardGroups,Aliases.LOBBY_EVENT_BOARDS_AWARDGROUPS);
         registerFlashComponentS(this.maintenanceCmp,Aliases.LOBBY_EVENT_BOARDS_MAINTENANCE);
         this._content = EventBoardTableContent(this.scrollPane.target);
         this._pagination = this._content.pagination;
         registerFlashComponentS(this._pagination,Aliases.LOBBY_EVENT_BOARDS_PAGINATION);
         this.waitingCmp.setSize(App.appWidth,App.appHeight);
         this.waitingCmp.visible = false;
         this.waitingCmp.setAnimationStatus(true);
         this.maintenanceCmp.setSize(App.appWidth,App.appHeight);
         this.maintenanceCmp.visible = false;
         this.awardGroups.visible = false;
         this.status.visible = false;
         this.btnMyPlace.visible = false;
         this._pagination.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this._content.removeEventListener(AwardsRendererEvent.AWARD_POSITION_CHANGE,this.onAwardPositionChangedHandler);
         this._content.removeEventListener(PlayerRendererEvent.PLAYER_CLICK,this.onPlayerClickHandler);
         this._content.removeEventListener(Event.RESIZE,this.onContentResizeHandler);
         this._content.dispose();
         this._content = null;
         this.bgLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.bgLoader.dispose();
         this.bgLoader = null;
         this.header.dispose();
         this.header = null;
         this.tableHeader.dispose();
         this.tableHeader = null;
         this.status.dispose();
         this.status = null;
         this._tableData = null;
         this._awardsData = null;
         this._headerData = null;
         this._tableHeaderData = null;
         this._statusData = null;
         this.awards.dispose();
         this.awards = null;
         this.awardsOther.dispose();
         this.awardsOther = null;
         this.awardsMask = null;
         if(this._firstAwardVO)
         {
            this._firstAwardVO.dispose();
            this._firstAwardVO = null;
         }
         if(this._secondAwardVO)
         {
            this._secondAwardVO.dispose();
            this._secondAwardVO = null;
         }
         this.scrollPane.target = null;
         this.scrollPane.dispose();
         this.scrollPane = null;
         this.btnClose.removeEventListener(ButtonEvent.CLICK,this.onBtnCloseClickHandler);
         this.btnClose.dispose();
         this.btnClose = null;
         this.selectRatingBtn.removeEventListener(ButtonEvent.CLICK,this.showSelectRatingPopover);
         this.selectRatingBtn.removeEventListener(MouseEvent.MOUSE_OVER,this.onSelectRatingOver);
         this.selectRatingBtn.removeEventListener(MouseEvent.MOUSE_OUT,this.onSelectRatingOut);
         this.selectRatingBtn.dispose();
         this.selectRatingBtn = null;
         this.btnMyPlace.removeEventListener(ButtonEvent.CLICK,this.onBtnMyPlaceClickHandler);
         this.btnMyPlace.removeEventListener(MouseEvent.ROLL_OVER,this.onMyPlaceRollOverHandler);
         this.btnMyPlace.removeEventListener(MouseEvent.ROLL_OUT,this.onMyPlaceRollOutHandler);
         this.btnMyPlace.dispose();
         this.btnMyPlace = null;
         this.bg = null;
         this.waitingCmp.dispose();
         this.waitingCmp = null;
         this.maintenanceCmp = null;
         this._bgFadeTween.dispose();
         this._bgFadeTween = null;
         this.awardGroups = null;
         this.emptyDataTF = null;
         this._pagination = null;
         this.tableTopShadow = null;
         removeEventListener(PARTICIPATE_CLICK,this.onBtnParticipateClickHandler);
         removeEventListener(STATUS_CHANGE_HEIGHT,this.onStatusChangeHeight);
         removeEventListener(AWARD_GROUPS_CHANGE_SIZE,this.onAwardGroupsChangeSize);
         this._myPlaceTooltip = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      private function updateMyPlacePosition() : void
      {
         this.btnMyPlace.visible = this._myPlaceVisible;
         if(this._myPlaceVisible)
         {
            this.btnMyPlace.x = this.awardGroups.x + MY_PLACE_OFFSET_X;
            this.btnMyPlace.y = this.awardGroups.y + this.awardGroups.getSize() + MY_PLACE_OFFSET_Y;
         }
      }
      
      private function updateLayout() : void
      {
         var _loc1_:int = App.appWidth;
         var _loc2_:int = App.appHeight;
         this.waitingCmp.setSize(_loc1_,_loc2_);
         this.maintenanceCmp.setSize(_loc1_,_loc2_);
         this.bg.width = _loc1_;
         this.bg.height = _loc2_;
         this.header.x = _loc1_ >> 1;
         this.header.y = TOP_PANEL_Y;
         this._freeSpace = !!this.status.visible ? Number(height - y - this.status.getHeight() - UNAVAILABLE_HEIGHT) : Number(height - y - UNAVAILABLE_HEIGHT);
         this.scrollPane.setSize(PANE_WIDTH,this._freeSpace);
         this.awardGroups.x = (_loc1_ - this.scrollPane.width - this.awardGroups.width >> 1) - MY_PLACE_OFFSET_X;
         this.tableTopShadow.x = this.awardsMask.x = this.awardsOther.x = this.awards.x = this.scrollPane.x = this.awardGroups.x + this.awardGroups.width;
         this.tableHeader.x = this.scrollPane.x;
         this.tableHeader.y = TABLE_HEADER_Y;
         this.tableTopShadow.y = this.awardsMask.y = this.awards.y = this.awardGroups.y = this.scrollPane.y = TOP_PANEL_HEIGHT;
         this.btnClose.x = this.awardGroups.x;
         this.btnClose.y = TOP_PANEL_Y;
         this.awardsOther.y = TOP_PANEL_HEIGHT + AWARDS_HEIGHT;
         this.selectRatingBtn.x = this.scrollPane.x + PANE_WIDTH_WITH_SCROLLBAR - this.selectRatingBtn.width;
         this.selectRatingBtn.y = TOP_PANEL_Y;
         this.selectRatingBtn.label = EVENT_BOARDS.TABLE_SELECTRATINGBTN;
         this.awardGroups.updateLayout();
         this.updateMyPlacePosition();
         if(this.status.visible)
         {
            this.status.x = (_loc1_ - this.status.width >> 1) + STATUS_OFFSET;
            this.status.y = _loc2_ - PADDING_TOP - this.status.getHeight();
         }
         this.emptyDataTF.x = this.scrollPane.x + (PANE_WIDTH - this.emptyDataTF.width) * 0.5;
         this.emptyDataTF.y = TOP_PANEL_HEIGHT + this._freeSpace * 0.5;
         invalidate(INV_BACKGROUND_POSITION);
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         if(_baseDisposed)
         {
            return;
         }
         invalidate(INV_BACKGROUND_POSITION);
      }
      
      private function onBtnCloseClickHandler(param1:ButtonEvent) : void
      {
         closeViewS();
      }
      
      private function onBtnMyPlaceClickHandler(param1:ButtonEvent) : void
      {
         setMyPlaceS();
      }
      
      private function onBtnParticipateClickHandler(param1:Event) : void
      {
         participateStatusClickS();
      }
      
      private function onStatusChangeHeight(param1:Event) : void
      {
         if(this.status.visible)
         {
            this.status.y = App.appHeight - PADDING_TOP - this.status.getHeight();
            this._freeSpace = height - y - this.status.getHeight() - UNAVAILABLE_HEIGHT;
            this.scrollPane.setSize(PANE_WIDTH,this._freeSpace);
         }
      }
      
      private function onAwardGroupsChangeSize(param1:Event) : void
      {
         this.updateMyPlacePosition();
      }
      
      private function showSelectRatingPopover() : void
      {
         var _loc1_:Object = null;
         if(this._popoverAlias != Values.EMPTY_STR)
         {
            _loc1_ = {};
            _loc1_.caller = "excel";
            _loc1_.eventID = null;
            App.popoverMgr.show(this,this._popoverAlias,_loc1_);
         }
      }
      
      public function getTargetButton() : DisplayObject
      {
         return DisplayObject(this.selectRatingBtn);
      }
      
      public function getHitArea() : DisplayObject
      {
         return DisplayObject(this.selectRatingBtn);
      }
      
      private function onAwardPositionChangedHandler(param1:AwardsRendererEvent) : void
      {
         var _loc2_:int = 0;
         if(this._secondAwardVO)
         {
            _loc2_ = param1.awardVO.id;
            switch(_loc2_)
            {
               case this._firstAwardVO.id:
                  this._firstAwardPosition = param1.position;
                  break;
               case this._secondAwardVO.id:
                  this._secondAwardPosition = param1.position;
            }
            invalidate(INV_AWARD_POSITION);
         }
      }
      
      private function onPlayerClickHandler(param1:PlayerRendererEvent) : void
      {
         playerClickS(param1.id);
      }
      
      private function setAwardsDefaultPosition() : void
      {
         this.awards.y = TOP_PANEL_HEIGHT;
         this.awardsOther.y = TOP_PANEL_HEIGHT + AWARDS_HEIGHT;
         this.awards.showShadow(false);
         this.awards.visible = true;
         this.awardsOther.visible = false;
         this._firstAwardPosition = 0;
         this._isNextAwardShown = false;
         showNextAwardS(this._isNextAwardShown);
      }
      
      private function onMyPlaceRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(this._myPlaceTooltip);
      }
      
      private function onMyPlaceRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function setTableVisible(param1:Boolean) : void
      {
         this.scrollPane.visible = param1;
         this.awardGroups.visible = param1;
         this.awards.visible = param1;
         this.awardsOther.visible = param1;
         this._pagination.visible = param1;
         this.emptyDataTF.visible = !param1;
      }
      
      private function onSelectRatingOver(param1:MouseEvent) : void
      {
         this._toolTipMgr.showComplex(TOOLTIPS.ELEN_EXCEL_SELECTRATINGBTN_TOOLTIP);
      }
      
      private function onSelectRatingOut(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function highlightNextAward() : void
      {
         if(!this._isNextAwardShown)
         {
            this._isNextAwardShown = true;
            showNextAwardS(this._isNextAwardShown);
         }
      }
      
      private function changeScrollPosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = Math.round(param1 >= param2 ? Number(param2) : Number(param1));
         this.scrollPane.scrollPosition = Math.ceil(_loc3_ / this.scrollPane.scrollStepFactor);
         this.scrollPane.validateNow();
         this._content.validateNow();
      }
   }
}
