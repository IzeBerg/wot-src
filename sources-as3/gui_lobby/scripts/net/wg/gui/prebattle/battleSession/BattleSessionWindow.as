package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Time;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.ListEventEx;
   import net.wg.gui.events.MessengerBarEvent;
   import net.wg.gui.interfaces.IButtonIconLoader;
   import net.wg.gui.lobby.messengerBar.WindowGeometryInBar;
   import net.wg.gui.prebattle.data.PlayerPrbInfoVO;
   import net.wg.gui.prebattle.meta.IBattleSessionWindowMeta;
   import net.wg.gui.prebattle.meta.impl.BattleSessionWindowMeta;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.gfx.MouseEventEx;
   
   public class BattleSessionWindow extends BattleSessionWindowMeta implements IBattleSessionWindowMeta
   {
      
      private static const NUMBERING_LINKAGE:String = "Numbering_UI";
      
      private static const MAX_PLAYERS_COUNT:int = 15;
      
      private static const FULL_NAME:String = "fullName";
      
      private static const TITLE_ICON:String = "team";
       
      
      public var upButtonClan:IButtonIconLoader;
      
      public var upButtonTournament:IButtonIconLoader;
      
      public var downButton:IButtonIconLoader;
      
      public var topBG:MovieClip;
      
      public var topHeaderBG:MovieClip;
      
      public var topStats:TopStats;
      
      public var playersStats:TopStats;
      
      public var listTitle:MovieClip;
      
      public var commentText:TextField;
      
      public var winsText:TextField;
      
      public var winsValue:TextField;
      
      public var mapText:TextField;
      
      public var mapValue:TextField;
      
      public var topInfo:TopInfo;
      
      public var memberStackList:ScrollingListEx;
      
      public var memberList:ScrollingListEx;
      
      public var leaveButton:SoundButtonEx;
      
      public var readyButton:SoundButtonEx;
      
      public var notReadyButton:SoundButtonEx;
      
      public var requirementInfo:RequirementInfo;
      
      public var requiredText:TextField;
      
      public var vehicleTypeText:TextField;
      
      public var vehicleLevelText:TextField;
      
      public var queueLabel:TextField;
      
      public var commentValue:TextAreaSimple;
      
      public var numberingContainer:MovieClip;
      
      public var txtEmptyMemberList:TextField;
      
      public var memberListBg:MovieClip;
      
      private var _isReady:Boolean = false;
      
      private var _firstLength:Number = 0;
      
      private var _numberingTFs:Vector.<MovieClip>;
      
      private var _isAssigned:Boolean = false;
      
      private var _canMoveToUnassigned:Boolean;
      
      private var _canMoveToAssignedS:Boolean;
      
      private var _scheduler:IScheduler;
      
      private var _classFactory:IClassFactory;
      
      public function BattleSessionWindow()
      {
         this._scheduler = App.utils.scheduler;
         this._classFactory = App.utils.classFactory;
         super();
         this._isReady = false;
         showWindowBgForm = false;
         canMinimize = true;
      }
      
      override public function as_enableLeaveBtn(param1:Boolean) : void
      {
         this.enableLeave(param1);
      }
      
      override public function as_enableReadyBtn(param1:Boolean) : void
      {
         this.readyButton.enabled = param1;
      }
      
      override public function as_refreshPermissions() : void
      {
         this._isReady = isPlayerReadyS();
         this.updateReadyButton();
         this.readyButton.enabled = isReadyBtnEnabledS();
         this.enableLeave(isLeaveBtnEnabledS());
         this.updateMoveControls();
      }
      
      override public function as_resetReadyButtonCoolDown() : void
      {
         this._scheduler.cancelTask(this.stopReadyButtonCoolDown);
      }
      
      override public function as_setCoolDownForReadyButton(param1:uint) : void
      {
         this._scheduler.cancelTask(this.stopReadyButtonCoolDown);
         this.notReadyButton.enabled = this.readyButton.enabled = false;
         this._scheduler.scheduleTask(this.stopReadyButtonCoolDown,param1 * Time.MILLISECOND_IN_SECOND);
      }
      
      override public function as_setPlayerState(param1:int, param2:Boolean, param3:Object) : void
      {
         var _loc4_:ScrollingListEx = !!param2 ? this.memberList : this.memberStackList;
         checkStatus(_loc4_,param3);
      }
      
      override public function as_toggleReadyBtn(param1:Boolean) : void
      {
         this._isReady = !param1;
         this.updateReadyButton();
      }
      
      override protected function setRosterList(param1:int, param2:Boolean, param3:DataProvider) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc4_:int = param3.length;
         this._firstLength = !!param2 ? Number(_loc4_) : Number(this._firstLength);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            param3[_loc5_].orderNumber = !!param2 ? _loc5_ + 1 : this._firstLength + _loc5_ + 1;
            _loc5_++;
         }
         if(param2)
         {
            disposeDataProvider(this.memberList.dataProvider);
            this.memberList.dataProvider = param3;
            this.readyButton.enabled = this.notReadyButton.enabled = isReadyBtnEnabledS();
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               if(param3[_loc6_].isCurrentPayer)
               {
                  this.memberList.selectedIndex = _loc6_;
                  this._isAssigned = true;
                  break;
               }
               _loc6_++;
            }
            if(!this._numberingTFs)
            {
               this.createNumbering();
            }
            _loc7_ = this.memberList.dataProvider.length;
            _loc5_ = 0;
            while(_loc5_ < MAX_PLAYERS_COUNT)
            {
               this._numberingTFs[_loc5_].visible = _loc5_ >= _loc7_;
               _loc5_++;
            }
         }
         else
         {
            disposeDataProvider(this.memberStackList.dataProvider);
            this.memberStackList.dataProvider = param3;
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               if(param3[_loc8_].isCurrentPayer)
               {
                  this.memberStackList.selectedIndex = _loc8_;
                  break;
               }
               _loc8_++;
            }
         }
         this.updateMoveControls();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(channelComponent,Aliases.CHANNEL_COMPONENT);
         this._isReady = isPlayerReadyS();
         this.updateReadyButton();
         this.readyButton.enabled = isReadyBtnEnabledS();
         this.enableLeave(isLeaveBtnEnabledS());
         window.setTitleIcon(TITLE_ICON);
         geometry = new WindowGeometryInBar(MessengerBarEvent.PIN_CAROUSEL_WINDOW,getClientIDS());
         setSize(width,this.leaveButton.y + this.leaveButton.height);
         this.txtEmptyMemberList.text = PREBATTLE.MEMBERLIST_EMPTY_LABEL;
         App.utils.commons.updateTextFieldSize(this.txtEmptyMemberList);
         this.txtEmptyMemberList.y = this.memberList.y + (this.memberList.height >> 1) - (this.txtEmptyMemberList.height >> 1);
         this.updateMoveControls();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.queueLabel.text = PREBATTLE.LABELS_COMPANY_QUEUE;
         this.upButtonClan.iconSource = this.upButtonTournament.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_SINGLE_RIGHT_ARROW_ICON;
         this.downButton.iconSource = RES_ICONS.MAPS_ICONS_MESSENGER_ICONS_SINGLE_LEFT_ARROW_ICON;
         this.readyButton.label = PREBATTLE.DIALOGS_BUTTONS_READY;
         this.notReadyButton.label = PREBATTLE.DIALOGS_BUTTONS_NOTREADY;
         this.setControlsLabels();
         this.memberList.addEventListener(ListEventEx.ITEM_CLICK,this.onMemberListItemClickHandler);
         this.memberList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onMemberListItemDoubleClickHandler);
         this.memberList.addEventListener(ListEvent.INDEX_CHANGE,this.onMemberListIndexChangeHandler);
         this.memberList.labelField = FULL_NAME;
         this.memberList.useRightButton = true;
         this.memberStackList.addEventListener(ListEventEx.ITEM_CLICK,this.onMemberListItemClickHandler);
         this.memberStackList.addEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onMemberListItemDoubleClickHandler);
         this.memberStackList.addEventListener(ListEvent.INDEX_CHANGE,this.onMemberStackListIndexChangeHandler);
         this.memberStackList.useRightButton = true;
         this.memberStackList.labelField = FULL_NAME;
         this.upButtonTournament.addEventListener(ButtonEvent.CLICK,this.onUpButtonClickHandler);
         this.upButtonClan.addEventListener(ButtonEvent.CLICK,this.onUpButtonClickHandler);
         this.downButton.addEventListener(ButtonEvent.CLICK,this.onDownButtonClickHandler);
         this.notReadyButton.addEventListener(ButtonEvent.CLICK,this.onReadyButtonClickHandler);
         this.readyButton.addEventListener(ButtonEvent.CLICK,this.onReadyButtonClickHandler);
         this.leaveButton.addEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
         this.commentValue.autoScroll = true;
         this.commentValue.selectable = true;
         this.commentValue.textField.selectable = true;
      }
      
      override protected function onDispose() : void
      {
         this._scheduler.cancelTask(this.stopReadyButtonCoolDown);
         this._scheduler = null;
         this._classFactory = null;
         while(this.numberingContainer.numChildren > 0)
         {
            this.numberingContainer.removeChildAt(0);
         }
         this.numberingContainer = null;
         if(this._numberingTFs)
         {
            this._numberingTFs.splice(0,this._numberingTFs.length);
            this._numberingTFs = null;
         }
         disposeDataProvider(this.memberList.dataProvider);
         disposeDataProvider(this.memberStackList.dataProvider);
         this.memberList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onMemberListItemDoubleClickHandler);
         this.memberList.removeEventListener(ListEventEx.ITEM_CLICK,this.onMemberListItemClickHandler);
         this.memberList.removeEventListener(ListEvent.INDEX_CHANGE,this.onMemberListIndexChangeHandler);
         this.memberStackList.removeEventListener(ListEventEx.ITEM_DOUBLE_CLICK,this.onMemberListItemDoubleClickHandler);
         this.memberStackList.removeEventListener(ListEventEx.ITEM_CLICK,this.onMemberListItemClickHandler);
         this.memberStackList.removeEventListener(ListEvent.INDEX_CHANGE,this.onMemberStackListIndexChangeHandler);
         this.upButtonTournament.removeEventListener(ButtonEvent.CLICK,this.onUpButtonClickHandler);
         this.upButtonTournament.dispose();
         this.upButtonTournament = null;
         this.upButtonClan.removeEventListener(ButtonEvent.CLICK,this.onUpButtonClickHandler);
         this.upButtonClan.dispose();
         this.upButtonClan = null;
         this.downButton.removeEventListener(ButtonEvent.CLICK,this.onDownButtonClickHandler);
         this.downButton.dispose();
         this.downButton = null;
         this.topStats.dispose();
         this.topStats = null;
         this.playersStats.dispose();
         this.playersStats = null;
         this.memberStackList.dispose();
         this.memberStackList = null;
         this.memberList.dispose();
         this.memberList = null;
         this.leaveButton.removeEventListener(ButtonEvent.CLICK,this.onLeaveButtonClickHandler);
         this.leaveButton.dispose();
         this.leaveButton = null;
         this.readyButton.removeEventListener(ButtonEvent.CLICK,this.onReadyButtonClickHandler);
         this.readyButton.dispose();
         this.readyButton = null;
         this.notReadyButton.removeEventListener(ButtonEvent.CLICK,this.onReadyButtonClickHandler);
         this.notReadyButton.dispose();
         this.notReadyButton = null;
         this.requirementInfo.dispose();
         this.requirementInfo = null;
         this.commentValue.dispose();
         this.commentValue = null;
         this.numberingContainer = null;
         this.queueLabel = null;
         this.vehicleLevelText = null;
         this.vehicleTypeText = null;
         this.requiredText = null;
         this.topInfo.dispose();
         this.topInfo = null;
         this.mapValue = null;
         this.mapText = null;
         this.winsValue = null;
         this.winsText = null;
         this.commentText = null;
         this.listTitle = null;
         this.topBG = null;
         this.topHeaderBG = null;
         this.txtEmptyMemberList = null;
         this.memberListBg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.topInfo.x = _width >> 1;
            this.requirementInfo.x = _width >> 1;
         }
      }
      
      override protected function setNationsLimits(param1:DataProvider) : void
      {
         if(param1.length)
         {
            this.requirementInfo.flagList.visible = true;
            this.requirementInfo.requiredNationText.visible = false;
            this.requirementInfo.flagList.dataProvider = param1;
         }
         else
         {
            this.requirementInfo.flagList.visible = false;
            this.requirementInfo.requiredNationText.visible = true;
            this.requirementInfo.flagList.dataProvider = param1;
            this.requirementInfo.requiredNationText.text = MENU.NATIONS_ALL;
         }
      }
      
      public function as_setClassesLimits(param1:Object, param2:Boolean) : void
      {
         var _loc4_:* = null;
         if(param2)
         {
            this.requirementInfo.requiredTypeText.visible = true;
            this.requirementInfo.icons.visible = false;
            this.requirementInfo.requiredTypeText.text = MENU.CLASSES_ANYTYPE;
         }
         else
         {
            this.requirementInfo.requiredTypeText.visible = false;
            this.requirementInfo.icons.visible = true;
         }
         var _loc3_:Object = this.requirementInfo.textFields;
         for(_loc4_ in param1)
         {
            if(_loc3_.hasOwnProperty(_loc4_))
            {
               _loc3_[_loc4_].text = param1[_loc4_];
            }
         }
      }
      
      public function as_setCommonLimits(param1:String, param2:Number) : void
      {
         this.topStats.valueTF.htmlText = param1;
      }
      
      public function as_setInfo(param1:Boolean, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String) : void
      {
         this.winsValue.text = param2;
         this.mapValue.text = param3;
         this.topInfo.firstTeamText.text = param4;
         this.topInfo.secondTeamText.text = param5;
         this.topInfo.winTeamsText.text = param6;
         window.title = param7;
         param1 = param1 && !this._isAssigned;
         this.commentValue.text = param8;
         this.upButtonTournament.visible = param1;
         this.upButtonClan.visible = !param1;
      }
      
      public function as_setWinnerIfDraw(param1:int) : void
      {
         this.topInfo.winnerIfDraw = param1;
      }
      
      public function as_setPlayersCountText(param1:String) : void
      {
         TextField(this.listTitle.membersTF).htmlText = param1;
      }
      
      public function as_setStartTime(param1:String) : void
      {
         this.topInfo.startTimeValue.text = param1;
         this.topInfo.invalidateLayout();
      }
      
      public function as_setTotalPlayersCount(param1:String) : void
      {
         this.playersStats.valueTF.htmlText = param1;
      }
      
      private function updateReadyButton() : void
      {
         this.notReadyButton.visible = this._isReady;
         this.readyButton.visible = !this._isReady;
      }
      
      private function enableLeave(param1:Boolean) : void
      {
         enabledCloseBtn = this.leaveButton.enabled = param1;
      }
      
      private function createNumbering() : void
      {
         var _loc1_:MovieClip = null;
         this._numberingTFs = new Vector.<MovieClip>();
         var _loc2_:int = 0;
         while(_loc2_ < MAX_PLAYERS_COUNT)
         {
            _loc1_ = this._classFactory.getComponent(NUMBERING_LINKAGE,MovieClip);
            _loc1_.textField.text = String(_loc2_ + 1);
            _loc1_.y += _loc1_.height * _loc2_;
            _loc1_.visible = false;
            this._numberingTFs[_loc2_] = _loc1_;
            this.numberingContainer.addChild(this._numberingTFs[_loc2_]);
            _loc2_++;
         }
      }
      
      private function stopReadyButtonCoolDown() : void
      {
         this.notReadyButton.enabled = this.readyButton.enabled = isReadyBtnEnabledS();
      }
      
      private function setControlsLabels() : void
      {
         this.topStats.titleTF.text = PREBATTLE.LABELS_STATS_LEVEL;
         this.playersStats.titleTF.text = PREBATTLE.LABELS_STATS_MAXPLAYERS;
         this.topInfo.startTimeText.text = PREBATTLE.TITLE_BATTLESESSION_HEADER_STARTTIME;
         this.commentText.text = PREBATTLE.TITLE_BATTLESESSION_COMMENT;
         this.mapText.text = PREBATTLE.TITLE_BATTLESESSION_ARENATYPE;
         this.winsText.text = PREBATTLE.TITLE_BATTLESESSION_BATTLESLIMIT;
         this.vehicleLevelText.text = PREBATTLE.STATS_BATTLESESSION_COMMONLEVEL;
         this.requiredText.text = PREBATTLE.STATS_BATTLESESSION_REQUIRED;
         this.vehicleTypeText.text = PREBATTLE.STATS_BATTLESESSION_VEHICLETYPE;
         this.leaveButton.label = PREBATTLE.BUTTONS_BATTLESESSION_LEAVE;
      }
      
      private function checkAndAssignMember(param1:PlayerPrbInfoVO) : void
      {
         if(canMoveToAssignedS())
         {
            requestToAssignMemberS(param1.accID);
         }
      }
      
      private function checkAndUnassignMember(param1:PlayerPrbInfoVO) : void
      {
         if(canMoveToUnassignedS())
         {
            requestToUnassignMemberS(param1.accID);
         }
      }
      
      private function updateMoveControls() : void
      {
         this._canMoveToUnassigned = canMoveToUnassignedS() && this.memberList.dataProvider.length > 0;
         this._canMoveToAssignedS = canMoveToAssignedS() && this.memberStackList.dataProvider.length > 0;
         this.downButton.enabled = this._canMoveToUnassigned && this.memberList.selectedIndex >= 0;
         this.upButtonClan.enabled = this.upButtonTournament.enabled = this._canMoveToAssignedS && this.memberStackList.selectedIndex >= 0;
         var _loc1_:Boolean = this.memberList.dataProvider.length == 0;
         this.memberListBg.visible = this.numberingContainer.visible = !_loc1_;
         this.txtEmptyMemberList.visible = _loc1_;
      }
      
      private function onMemberListItemClickHandler(param1:ListEventEx) : void
      {
         var _loc2_:PlayerPrbInfoVO = null;
         if(param1.buttonIdx == MouseEventEx.RIGHT_BUTTON)
         {
            _loc2_ = PlayerPrbInfoVO(param1.itemData);
            if(_loc2_.accID > -1)
            {
               App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.PREBATTLE_USER,this,_loc2_);
            }
            else
            {
               App.contextMenuMgr.hide();
            }
         }
      }
      
      private function onReadyButtonClickHandler(param1:ButtonEvent) : void
      {
         requestToReadyS(!this._isReady);
      }
      
      private function onLeaveButtonClickHandler(param1:ButtonEvent) : void
      {
         requestToLeaveS();
      }
      
      private function onUpButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:IDataProvider = this.memberStackList.dataProvider;
         var _loc3_:int = this.memberStackList.selectedIndex;
         if(_loc2_.length > 0 && _loc3_ > -1)
         {
            this.checkAndAssignMember(PlayerPrbInfoVO(_loc2_.requestItemAt(_loc3_)));
         }
      }
      
      private function onMemberListItemDoubleClickHandler(param1:ListEventEx) : void
      {
         if(param1.buttonIdx != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         if(param1.target == this.memberList)
         {
            this.checkAndUnassignMember(PlayerPrbInfoVO(param1.itemData));
         }
         else if(param1.target == this.memberStackList)
         {
            this.checkAndAssignMember(PlayerPrbInfoVO(param1.itemData));
         }
      }
      
      private function onDownButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:IDataProvider = this.memberList.dataProvider;
         var _loc3_:int = this.memberList.selectedIndex;
         if(_loc2_.length > 0)
         {
            if(_loc3_ > -1)
            {
               this.checkAndUnassignMember(PlayerPrbInfoVO(_loc2_.requestItemAt(_loc3_)));
            }
         }
      }
      
      private function onMemberListIndexChangeHandler(param1:ListEvent) : void
      {
         this.downButton.enabled = this._canMoveToUnassigned && param1.index >= 0;
      }
      
      private function onMemberStackListIndexChangeHandler(param1:ListEvent) : void
      {
         this.upButtonTournament.enabled = this.upButtonClan.enabled = this._canMoveToAssignedS && param1.index >= 0;
      }
   }
}
