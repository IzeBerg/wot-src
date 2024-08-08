package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.VO.TrainingRoomInfoVO;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.data.VO.TrainingRoomTeamBaseVO;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.TextAreaSimple;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.TextFieldShort;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.gui.components.minimap.MinimapPresentation;
   import net.wg.gui.events.ArenaVoipSettingsEvent;
   import net.wg.infrastructure.base.meta.ITrainingRoomBaseMeta;
   import net.wg.infrastructure.base.meta.impl.TrainingRoomBaseMeta;
   import net.wg.infrastructure.events.DropEvent;
   import net.wg.infrastructure.events.VoiceChatEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IVoiceChatManager;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.CoreList;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class TrainingRoomBase extends TrainingRoomBaseMeta implements ITrainingRoomBaseMeta
   {
      
      private static const SUB_VIEW_MARGIN:int = 120;
      
      private static const BACK_SLASH:String = "/";
      
      private static const OWNER_BAGE_Y_OFFSET:int = -1;
       
      
      public var team1Label:TextField;
      
      public var team2Label:TextField;
      
      public var otherLabel:TextField;
      
      public var titleField:TextField;
      
      public var typeField:TextField;
      
      public var comment:TextAreaSimple;
      
      public var map:TextField;
      
      public var arenaVOIPLabel:TextField;
      
      public var ownerLabel:TextField;
      
      public var timeoutLabel:TextField;
      
      public var maxPlayersLabel:TextField;
      
      public var closeButton:SoundButtonEx;
      
      public var settingsButton:SoundButtonEx;
      
      public var startButton:SoundButtonEx;
      
      public var inviteButton:SoundButtonEx;
      
      public var minimap:MinimapPresentation;
      
      public var owner:UserNameField;
      
      public var timeout:TextFieldShort;
      
      public var maxPlayers:TextFieldShort;
      
      public var description:TextAreaSimple;
      
      public var battleIcon:BattleTypeIcon;
      
      public var other:DropTileList;
      
      public var arenaVoipSettings:ArenaVoipSettings;
      
      public var observerButton:ObserverButtonComponent;
      
      private var _team1LabelText:String = "";
      
      private var _team2LabelText:String = "";
      
      private var _otherLabelText:String = "";
      
      private var _slots:Vector.<InteractiveObject> = null;
      
      private var _maxPlayersCount:Number = 0;
      
      private var _curPlayersCount:Number = 0;
      
      private var _dragDropListDelegateCtrl:IDisposable = null;
      
      private var _myWidth:Number = 0;
      
      private var _voiceChatMgr:IVoiceChatManager;
      
      private var _swapBtns:Vector.<UIComponent> = null;
      
      private var _ownerBadgeVisible:Boolean = false;
      
      private var _ownerY:int = -1;
      
      private var _ownerBadgeY:int = -1;
      
      public function TrainingRoomBase()
      {
         this._voiceChatMgr = App.voiceChatMgr;
         super();
         _deferredDispose = true;
         this._slots = this.getSlots();
         this._swapBtns = this.getSwapBtns();
         this._ownerY = this.owner.y;
         this._ownerBadgeY = this._ownerY + OWNER_BAGE_Y_OFFSET;
      }
      
      protected static function checkStatus(param1:CoreList, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:int, param8:BadgeVisualVO) : void
      {
         var _loc10_:TrainingRoomRendererVO = null;
         var _loc9_:IDataProvider = param1.dataProvider;
         for each(_loc10_ in _loc9_)
         {
            if(_loc10_.dbID == param2)
            {
               _loc10_.stateString = param3;
               _loc10_.icon = param4;
               _loc10_.vShortName = param5;
               _loc10_.vLevel = param6;
               _loc10_.igrType = param7;
               _loc10_.badgeVisualVO = param8;
               param1.invalidateData();
               break;
            }
         }
      }
      
      protected static function checkUserTags(param1:CoreList, param2:Number, param3:Array) : void
      {
         var _loc5_:TrainingRoomRendererVO = null;
         var _loc4_:IDataProvider = param1.dataProvider;
         for each(_loc5_ in _loc4_)
         {
            if(_loc5_.dbID == param2)
            {
               _loc5_.tags = param3;
               param1.invalidateData();
               break;
            }
         }
      }
      
      private static function startDisableCoolDown(param1:Function, param2:Number) : void
      {
         var _loc3_:IScheduler = App.utils.scheduler;
         _loc3_.cancelTask(param1);
         _loc3_.scheduleTask(param1,param2 * 1000);
      }
      
      override public final function setViewSize(param1:Number, param2:Number) : void
      {
         this._myWidth = param1;
         invalidateSize();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.setViewSize(param1,param2);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.updateStage(App.appWidth,App.appHeight);
         this.addListeners();
         this.description.autoScroll = false;
         this.comment.autoScroll = false;
         this.ownerLabel.text = MENU.TRAINING_INFO_OWNER;
         this.timeoutLabel.text = MENU.TRAINING_INFO_TIMEOUT_LABEL;
         this.maxPlayersLabel.text = MENU.TRAINING_INFO_MAXPLAYERS;
         this.timeout.buttonMode = false;
         this.timeout.autoSize = this.maxPlayers.autoSize = TextFieldAutoSize.LEFT;
         this.maxPlayers.buttonMode = false;
         this.startButton.mouseEnabledOnDisabled = true;
         this.observerButton.addEventListener(ObserverButtonComponent.SELECTED,this.onObserverButtonSelectedHandler,false,0,true);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeListeners();
         var _loc1_:IScheduler = App.utils.scheduler;
         _loc1_.cancelTask(this.finishDisable_swapButton_CoolDownHandler);
         _loc1_.cancelTask(this.finishDisable_settingsButton_CoolDownHandler);
         _loc1_.cancelTask(this.finishDisable_observerButton_CoolDownHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.clearDragController();
         this.disposeComponents();
         this.comment.dispose();
         this.comment = null;
         this.other.dispose();
         this.other = null;
         if(this._slots)
         {
            this._slots.splice(0,this._slots.length);
            this._slots = null;
         }
         if(this._swapBtns)
         {
            this._swapBtns.splice(0,this._swapBtns.length);
            this._swapBtns = null;
         }
         this._voiceChatMgr = null;
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.onPopulate();
         if(canAssignToTeamS(1) || canAssignToTeamS(2) || canChangePlayerTeamS())
         {
            this.createDragController();
         }
         else
         {
            this.clearDragController();
         }
         registerFlashComponentS(this.minimap,Aliases.LOBBY_MINIMAP);
         this.setTeamsInfo();
         _loc1_ = this._voiceChatMgr.getYY();
         _loc2_ = this._voiceChatMgr.isVOIPEnabledS();
         this.arenaVoipSettings.visible = _loc2_ || _loc1_;
         this.arenaVOIPLabel.text = _loc2_ || _loc1_ ? MENU.TRAINING_INFO_VOICECHAT : Values.EMPTY_STR;
      }
      
      override protected function setOther(param1:TrainingRoomTeamBaseVO) : void
      {
         this._otherLabelText = param1.teamLabel;
         this.countPlayers();
         invalidateData();
      }
      
      override protected function setTeam1(param1:TrainingRoomTeamBaseVO) : void
      {
         this._team1LabelText = param1.teamLabel;
         this.countPlayers();
         invalidateData();
      }
      
      override protected function setTeam2(param1:TrainingRoomTeamBaseVO) : void
      {
         this._team2LabelText = param1.teamLabel;
         this.countPlayers();
         invalidateData();
      }
      
      override protected function setPlayerTagsInOther(param1:Number, param2:Array) : void
      {
         checkUserTags(this.other,param1,param2.slice(0));
      }
      
      override protected function setPlayerTagsInTeam1(param1:Number, param2:Array) : void
      {
         this.doSetPlayerTagsInTeam1(param1,param2.slice(0));
      }
      
      override protected function setPlayerTagsInTeam2(param1:Number, param2:Array) : void
      {
         this.doSetPlayerTagsInTeam2(param1,param2.slice(0));
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            x = this._myWidth - _originalWidth >> 1;
            y = -SUB_VIEW_MARGIN;
         }
         if(isInvalid(InvalidationType.STATE))
         {
            this.inviteButton.visible = canSendInviteS();
            this.settingsButton.visible = canChangeSettingS();
            this.startButton.visible = canStartBattleS();
            if(!canDestroyRoomS())
            {
               this.closeButton.label = MENU.TRAINING_INFO_EXITBUTTON;
            }
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.team1Label.htmlText = this._team1LabelText;
            this.team2Label.htmlText = this._team2LabelText;
            this.otherLabel.htmlText = this._otherLabelText;
         }
      }
      
      override protected function setInfo(param1:TrainingRoomInfoVO) : void
      {
         this.doUpdateComment(param1.comment);
         this.timeout.label = param1.roundLenString;
         this._maxPlayersCount = param1.maxPlayersCount;
         this.maxPlayers.label = this._curPlayersCount + BACK_SLASH + this._maxPlayersCount;
         this.map.htmlText = param1.arenaName;
         this.titleField.htmlText = param1.title;
         this.typeField.htmlText = param1.arenaSubType;
         var _loc2_:int = param1.badge;
         var _loc3_:Boolean = Boolean(_loc2_);
         if(_loc3_ != this._ownerBadgeVisible)
         {
            this.owner.y = !!_loc3_ ? Number(this._ownerBadgeY) : Number(this._ownerY);
            this._ownerBadgeVisible = _loc3_;
         }
         this.owner.userVO = new UserVO(null);
         var _loc4_:UserVO = this.owner.userVO;
         _loc4_.accID = -1;
         _loc4_.dbID = -1;
         _loc4_.fullName = param1.creatorFullName;
         _loc4_.userName = param1.creator;
         _loc4_.clanAbbrev = param1.creatorClan;
         _loc4_.region = param1.creatorRegion;
         _loc4_.igrType = param1.creatorIgrType;
         _loc4_.badgeVisualVO = param1.badgeVisualVO;
         this.minimap.setMapS(param1.arenaTypeID);
         this.description.position = 0;
         this.description.htmlText = param1.description;
         this.battleIcon.type = param1.battleTypeIco;
         this.arenaVoipSettings.setUseArenaVoip(param1.arenaVoipChannels);
         this.arenaVoipSettings.setCanChangeArenaVOIP(param1.canChangeArenaVOIP);
         invalidate(InvalidationType.STATE);
         this.observerButton.visible = param1.isObserverModeEnabled;
      }
      
      override protected function setPlayerStateInOther(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         checkStatus(this.other,param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function setPlayerStateInTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         this.doCheckStatusTeam1(param1,param2,param3,param4,param5,param6,param7);
      }
      
      override protected function setPlayerStateInTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
         this.doCheckStatusTeam2(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function as_disableControls(param1:Boolean) : void
      {
         this.disableControls(param1);
      }
      
      public function as_enabledCloseButton(param1:Boolean) : void
      {
         this.closeButton.enabled = param1;
      }
      
      public function as_setArenaVoipChannels(param1:Number) : void
      {
         this.arenaVoipSettings.setUseArenaVoip(param1);
      }
      
      public function as_setObserver(param1:Boolean) : void
      {
         this.observerButton.selected = param1;
      }
      
      public function as_setStartButtonState(param1:Boolean, param2:String) : void
      {
         this.startButton.enabled = param1;
         this.startButton.tooltip = param2;
      }
      
      public function as_startCoolDownObserver(param1:Number) : void
      {
         this.observerButton.enabled = false;
         startDisableCoolDown(this.finishDisable_observerButton_CoolDownHandler,param1);
      }
      
      public function as_startCoolDownSetting(param1:Number) : void
      {
         this.settingsButton.enabled = false;
         startDisableCoolDown(this.finishDisable_settingsButton_CoolDownHandler,param1);
      }
      
      public function as_startCoolDownSwapButton(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._swapBtns)
         {
            _loc2_ = this._swapBtns.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._swapBtns[_loc3_].enabled = false;
               _loc3_++;
            }
         }
         startDisableCoolDown(this.finishDisable_swapButton_CoolDownHandler,param1);
      }
      
      public function as_startCoolDownVoiceChat(param1:Number) : void
      {
         this.arenaVoipSettings.startCoolDownUseCommonVoiceChat(param1);
      }
      
      public function as_updateComment(param1:String) : void
      {
         this.doUpdateComment(param1);
      }
      
      public function as_updateMap(param1:Number, param2:Number, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:Boolean) : void
      {
         this.minimap.setMapS(param1);
         this._maxPlayersCount = param2;
         this.maxPlayers.label = this._curPlayersCount + BACK_SLASH + this._maxPlayersCount;
         this.map.htmlText = param3;
         this.titleField.htmlText = param4;
         this.typeField.htmlText = param5;
         this.description.position = Values.ZERO;
         this.description.htmlText = param6;
         this.battleIcon.type = param7;
         this.observerButton.visible = param9;
      }
      
      public function as_updateTimeout(param1:String) : void
      {
         this.timeout.label = param1;
      }
      
      protected function getSwapBtns() : Vector.<UIComponent>
      {
         return null;
      }
      
      protected function getSlots() : Vector.<InteractiveObject>
      {
         return Vector.<InteractiveObject>([this.other]);
      }
      
      protected function addListeners() : void
      {
         var _loc1_:CoreList = null;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onHandleEscape,true);
         this.settingsButton.addEventListener(ButtonEvent.CLICK,this.onSettingsButtonClickHandler);
         this.startButton.addEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.inviteButton.addEventListener(ButtonEvent.CLICK,this.onInviteButtonClickHandler);
         for each(_loc1_ in this._slots)
         {
            _loc1_.addEventListener(DropEvent.END_DROP,this.onEndDropHandler);
         }
         this.arenaVoipSettings.addEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT,this.onArenaVoipSettingsSelectUseCommonVoiceChatHandler);
         this._voiceChatMgr.addEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatMgrStartSpeakingHandler);
         this._voiceChatMgr.addEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatMgrStopSpeakingHandler);
      }
      
      protected function doDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject) : void
      {
         this.countPlayers();
      }
      
      protected final function isSlotDroppable(param1:uint, param2:uint) : Boolean
      {
         var _loc3_:uint = getPlayerTeamS(param1);
         return _loc3_ == param2 || param2 == 0 && canAssignToTeamS(_loc3_) || param2 != 0 && canChangePlayerTeamS();
      }
      
      protected function setTeamsInfo() : void
      {
      }
      
      protected function doCheckStatusTeam1(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
      }
      
      protected function doCheckStatusTeam2(param1:Number, param2:String, param3:String, param4:String, param5:String, param6:int, param7:BadgeVisualVO) : void
      {
      }
      
      protected function doSetPlayerTagsInTeam1(param1:Number, param2:Array) : void
      {
      }
      
      protected function doSetPlayerTagsInTeam2(param1:Number, param2:Array) : void
      {
      }
      
      protected function removeListeners() : void
      {
         var _loc1_:CoreList = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onHandleEscape);
         this.observerButton.removeEventListener(ObserverButtonComponent.SELECTED,this.onObserverButtonSelectedHandler);
         for each(_loc1_ in this._slots)
         {
            _loc1_.removeEventListener(DropEvent.END_DROP,this.onEndDropHandler);
         }
         this.settingsButton.removeEventListener(ButtonEvent.CLICK,this.onSettingsButtonClickHandler);
         this.startButton.removeEventListener(ButtonEvent.CLICK,this.onStartButtonClickHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.inviteButton.removeEventListener(ButtonEvent.CLICK,this.onInviteButtonClickHandler);
         this.arenaVoipSettings.removeEventListener(ArenaVoipSettingsEvent.SELECT_USE_COMMON_VOICE_CHAT,this.onArenaVoipSettingsSelectUseCommonVoiceChatHandler);
         this._voiceChatMgr.removeEventListener(VoiceChatEvent.START_SPEAKING,this.onVoiceChatMgrStartSpeakingHandler);
         this._voiceChatMgr.removeEventListener(VoiceChatEvent.STOP_SPEAKING,this.onVoiceChatMgrStopSpeakingHandler);
      }
      
      protected function disableControls(param1:Boolean) : void
      {
         this.closeButton.enabled = !param1;
         this.settingsButton.enabled = !param1;
         this.startButton.enabled = !param1;
         this.inviteButton.enabled = !param1;
         this.arenaVoipSettings.enabled = !param1;
         this.observerButton.enabled = !param1;
         if(param1)
         {
            this.clearDragController();
         }
         else if(!this._dragDropListDelegateCtrl && (canAssignToTeamS(1) || canAssignToTeamS(2) || canChangePlayerTeamS()))
         {
            this.createDragController();
         }
      }
      
      protected function getDragElementLinkage() : String
      {
         return Linkages.TRAINING_DRAG_ELEMENT_UI;
      }
      
      private function doUpdateComment(param1:String) : void
      {
         this.comment.position = Values.ZERO;
         this.comment.text = param1;
         this.comment.validateNow();
         invalidateLayout();
      }
      
      private function clearDragController() : void
      {
         if(this._dragDropListDelegateCtrl)
         {
            this._dragDropListDelegateCtrl.dispose();
            this._dragDropListDelegateCtrl = null;
         }
      }
      
      private function finishDisable_settingsButton_CoolDownHandler() : void
      {
         this.settingsButton.enabled = true;
      }
      
      private function finishDisable_swapButton_CoolDownHandler() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this._swapBtns)
         {
            _loc1_ = this._swapBtns.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._swapBtns[_loc2_].enabled = true;
               _loc2_++;
            }
         }
      }
      
      private function finishDisable_observerButton_CoolDownHandler() : void
      {
         this.observerButton.enabled = true;
      }
      
      private function disposeComponents() : void
      {
         this.team1Label = null;
         this.team2Label = null;
         this.otherLabel = null;
         this.titleField = null;
         this.typeField = null;
         this.map = null;
         this.arenaVOIPLabel = null;
         this.ownerLabel = null;
         this.timeoutLabel = null;
         this.maxPlayersLabel = null;
         this.observerButton.dispose();
         this.observerButton = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.settingsButton.dispose();
         this.settingsButton = null;
         this.startButton.dispose();
         this.startButton = null;
         this.inviteButton.dispose();
         this.inviteButton = null;
         this.owner.dispose();
         this.owner = null;
         this.timeout.dispose();
         this.timeout = null;
         this.maxPlayers.dispose();
         this.maxPlayers = null;
         this.description.dispose();
         this.description = null;
         this.battleIcon.dispose();
         this.battleIcon = null;
         this.arenaVoipSettings.dispose();
         this.arenaVoipSettings = null;
         this.minimap = null;
      }
      
      private function setSpeaking(param1:Boolean, param2:Number) : void
      {
         var _loc3_:CoreList = null;
         var _loc4_:IDataProvider = null;
         var _loc5_:TrainingRoomRendererVO = null;
         for each(_loc3_ in this._slots)
         {
            _loc4_ = _loc3_.dataProvider;
            for each(_loc5_ in _loc4_)
            {
               if(_loc5_.dbID == param2)
               {
                  _loc5_.isPlayerSpeaking = param1;
                  _loc3_.invalidateData();
               }
            }
         }
      }
      
      private function createDragController() : void
      {
         var _loc1_:Class = App.utils.classFactory.getClass(Linkages.TRAINING_DRAG_DELEGATE);
         assertNull(this._dragDropListDelegateCtrl,Errors.CANT_NULL);
         var _loc2_:String = this.getDragElementLinkage();
         this._dragDropListDelegateCtrl = new TrainingDragController(this._slots,_loc1_,_loc2_,this.isSlotDroppable);
      }
      
      private function countPlayers() : void
      {
         var _loc1_:CoreList = null;
         this._curPlayersCount = 0;
         for each(_loc1_ in this._slots)
         {
            this._curPlayersCount += _loc1_.dataProvider.length;
         }
         this.maxPlayers.label = this._curPlayersCount + BACK_SLASH + this._maxPlayersCount;
         App.toolTipMgr.hide();
         App.contextMenuMgr.hide();
      }
      
      protected final function get slots() : Vector.<InteractiveObject>
      {
         return this._slots;
      }
      
      private function onHandleEscape(param1:InputEvent) : void
      {
         onEscapeS();
      }
      
      private function onObserverButtonSelectedHandler(param1:Event) : void
      {
         selectObserverS(this.observerButton.selected);
      }
      
      private function onVoiceChatMgrStartSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this.setSpeaking(true,param1.getAccountDBID());
      }
      
      private function onVoiceChatMgrStopSpeakingHandler(param1:VoiceChatEvent) : void
      {
         this.setSpeaking(false,param1.getAccountDBID());
      }
      
      private function onArenaVoipSettingsSelectUseCommonVoiceChatHandler(param1:ArenaVoipSettingsEvent) : void
      {
         selectCommonVoiceChatS(param1.index);
      }
      
      private function onSettingsButtonClickHandler(param1:ButtonEvent) : void
      {
         showTrainingSettingsS();
      }
      
      private function onStartButtonClickHandler(param1:ButtonEvent) : void
      {
         startTrainingS();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         closeTrainingRoomS();
      }
      
      private function onInviteButtonClickHandler(param1:ButtonEvent) : void
      {
         showPrebattleInvitationsFormS();
      }
      
      private function onEndDropHandler(param1:DropEvent) : void
      {
         this.doDrop(param1.sender,param1.receiver,param1.draggedItem);
      }
   }
}
