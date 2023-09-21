package net.wg.gui.battle.views.battleMessenger
{
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerReceiverVO;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerSettingsVO;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerToxicVO;
   import net.wg.gui.battle.views.battleMessenger.actionPanel.BattleMessengerActionContainer;
   import net.wg.gui.battle.views.battleMessenger.interfaces.IBattleMessenger;
   import net.wg.infrastructure.base.meta.impl.BattleMessengerMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.utils.IScheduler;
   import scaleform.clik.events.InputEvent;
   import scaleform.gfx.MouseEventEx;
   import scaleform.gfx.TextFieldEx;
   
   public class BattleMessenger extends BattleMessengerMeta implements IBattleMessenger
   {
      
      public static const REMOVE_FOCUS:String = "removeFocus";
      
      private static const MESSAGES_CONTAINER:String = "_messagesContainer";
      
      public static const BOTTOM_SIDE_WIDTH:int = 230;
      
      private static const MESSAGE_FIELD_AVAILABLE_WIDTH:int = 218;
      
      private static const DEFAULT_RECEIVER_COLOR:int = 9868414;
      
      private static const EMPTY_STR:String = "";
      
      private static const BOTTOM_SIDE_Y_POSITION:uint = 48;
      
      private static const MAX_MESSAGES_HEIGHT_KOEF:Number = 0.7;
      
      private static const SHOW_NEXT_MSG_DURATION:uint = 200;
      
      private static const NAME_SWAP_AREA:String = "swapArea";
      
      private static const NAME_MESSAGER_CONTAINER:String = "messagesContainer";
      
      private static const NAME_USER_INTERACTION_CMP:String = "userInteractionCmp";
       
      
      public var receiverField:TextField = null;
      
      public var messageInputField:TextField = null;
      
      public var hintBackground:MovieClip = null;
      
      public var historyUpBtn:BattleButton = null;
      
      public var historyDownBtn:BattleButton = null;
      
      public var historyLastMessageBtn:BattleButton = null;
      
      public var tooltipSymbol:MovieClip = null;
      
      public var hit:MovieClip = null;
      
      public var itemBackground:MovieClip = null;
      
      public var backgroundLayer:Sprite = null;
      
      public var swapArea:Sprite;
      
      private var _swapAreaHit:Sprite;
      
      private var _appStage:Stage;
      
      private var _messagesContainer:Sprite;
      
      private var _receiverIdx:int = 0;
      
      private var _receivers:Vector.<BattleMessengerReceiverVO>;
      
      private var _tooltipStr:String = "";
      
      private var _isFocused:Boolean = true;
      
      private var _isActive:Boolean = false;
      
      private var _isHistoryEnabled:Boolean = false;
      
      private var _calculatedMaxVisibleMessages:int = -1;
      
      private var _defaultMaxVisibleMessages:int = -1;
      
      private var _redMessagesPool:BattleMessengerPool = null;
      
      private var _greenMessagesPool:BattleMessengerPool = null;
      
      private var _blackMessagesPool:BattleMessengerPool = null;
      
      private var _selfMessagesPool:BattleMessengerPool = null;
      
      private var _messages:Vector.<BattleMessage>;
      
      private var _topMessageIndex:int = 0;
      
      private var _bottomMessageIndex:int = 0;
      
      private var _isTopMessageVisible:Boolean = false;
      
      private var _isBottomMessageVisible:Boolean = false;
      
      private var _inactiveStateAlpha:Number = 0.5;
      
      private var _battleSmileyMap:BattleSmileyMap;
      
      private var _isChannelsInited:Boolean = false;
      
      private var _selectionBeginIndex:int = -1;
      
      private var _selectionEndIndex:int = -1;
      
      private var _selectedTargetOnMouseDown:Object = null;
      
      private var _isCtrlButtonPressed:Boolean = false;
      
      private var _isEnterButtonPressed:Boolean = false;
      
      private var _userInteractionCmp:BattleMessengerActionContainer = null;
      
      private var _isMessengerOver:Boolean = false;
      
      private var _isToxicEnabled:Boolean = false;
      
      private var _toxicPanelData:BattleMessengerToxicVO = null;
      
      private var _isSmallState:Boolean = false;
      
      private var _maxMessagesInHistory:int = -1;
      
      private var _isFullMessagesStack:Boolean = false;
      
      private var _nextMsgPosY:int = 0;
      
      private var _isTooltipShow:Boolean = false;
      
      private var _scheduler:IScheduler = null;
      
      private var _nextMsgKeyCode:int = 0;
      
      private var _wheelMessagesScroll:int = 0;
      
      private var _messagesAvailableWidth:int = 360;
      
      private var _poolsCreated:Boolean = false;
      
      public function BattleMessenger()
      {
         this.swapArea = new Sprite();
         this._appStage = App.stage;
         this._messagesContainer = new Sprite();
         this._receivers = new Vector.<BattleMessengerReceiverVO>();
         this._messages = new Vector.<BattleMessage>();
         this._battleSmileyMap = new BattleSmileyMap();
         super();
         this.swapArea.alpha = 0;
         this.swapArea.name = NAME_SWAP_AREA;
         addChild(this.swapArea);
         TextFieldEx.setNoTranslate(this.receiverField,true);
         TextFieldEx.setNoTranslate(this.messageInputField,true);
         this._messagesContainer.name = NAME_MESSAGER_CONTAINER;
         addChild(this._messagesContainer);
         this._messagesContainer.name = MESSAGES_CONTAINER;
         this._messagesContainer.mouseEnabled = false;
         this._scheduler = App.utils.scheduler;
      }
      
      private static function receiversSort(param1:BattleMessengerReceiverVO, param2:BattleMessengerReceiverVO) : int
      {
         return param1.orderIndex - param2.orderIndex;
      }
      
      private static function drawRect(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean = true) : void
      {
         var _loc7_:Graphics = param1.graphics;
         if(param6)
         {
            _loc7_.clear();
         }
         _loc7_.beginFill(0);
         _loc7_.drawRect(param2,param3,param4,param5);
         _loc7_.endFill();
      }
      
      private static function onMessageInputFieldInputHandler(param1:InputEvent) : void
      {
         param1.handled = true;
      }
      
      private static function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function setupList(param1:BattleMessengerSettingsVO) : void
      {
         this._maxMessagesInHistory = param1.maxLinesCount;
         this._defaultMaxVisibleMessages = this._calculatedMaxVisibleMessages = param1.numberOfMessagesInHistory;
         this._inactiveStateAlpha = param1.inactiveStateAlpha;
         if(!this._isCtrlButtonPressed && !this._isEnterButtonPressed)
         {
            this.setAlpha(this._inactiveStateAlpha);
         }
         this.messageInputField.maxChars = param1.maxMessageLength;
         this._tooltipStr = param1.toolTipStr;
         this._isHistoryEnabled = param1.isHistoryEnabled;
         var _loc2_:int = param1.lifeTime;
         var _loc3_:int = param1.alphaSpeed;
         var _loc4_:Number = param1.lastMessageAlpha;
         var _loc5_:Number = param1.recoveredLatestMessagesAlpha;
         var _loc6_:int = param1.recoveredMessagesLifeTime;
         this._redMessagesPool = new BattleMessengerPool(this._maxMessagesInHistory,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.RED_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._greenMessagesPool = new BattleMessengerPool(this._maxMessagesInHistory,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.GREEN_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._blackMessagesPool = new BattleMessengerPool(this._maxMessagesInHistory,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.BLACK_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._selfMessagesPool = new BattleMessengerPool(this._maxMessagesInHistory,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.SELF_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._poolsCreated = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.tooltipSymbol.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.tooltipSymbol.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
         this.receiverField.autoSize = TextFieldAutoSize.LEFT;
         this.historyUpBtn.addPressCallBack(this);
         this.historyDownBtn.addPressCallBack(this);
         this.historyLastMessageBtn.addPressCallBack(this);
         this.historyUpBtn.addClickCallBack(this);
         this.historyDownBtn.addClickCallBack(this);
         this.hideViewElements();
         this.hit.tabEnabled = false;
         this.receiverField.tabEnabled = false;
         tabEnabled = false;
         this.hit.buttonMode = true;
         this.switchSwapArea(false);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onMessengerRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onMessengerRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.hit.removeEventListener(MouseEvent.CLICK,this.onBattleMessengerMouseClickHandler);
         this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
         this.hintBackground.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.hintBackground.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
         this.messageInputField.removeEventListener(InputEvent.INPUT,onMessageInputFieldInputHandler);
         this.messageInputField.removeEventListener(KeyboardEvent.KEY_DOWN,this.onMessageInputFieldKeyDownHandler);
         this._appStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this._appStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         this.hit.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.hit.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
         this._appStage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
         this._appStage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         this._appStage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleMessage = null;
         if(this._userInteractionCmp)
         {
            this._toxicPanelData = null;
            this._userInteractionCmp.dispose();
            this._userInteractionCmp = null;
         }
         this.swapArea.hitArea = null;
         this._swapAreaHit = null;
         this.swapArea = null;
         this._battleSmileyMap.dispose();
         this._battleSmileyMap = null;
         for each(_loc1_ in this._messages)
         {
            this.removeMessageFromDisplayList(_loc1_);
         }
         this.backgroundLayer = null;
         this._messagesContainer = null;
         this._messages.fixed = false;
         this._messages.splice(0,this._messages.length);
         this._messages = null;
         this._receivers = null;
         this._selectedTargetOnMouseDown = null;
         this._redMessagesPool.dispose();
         this._redMessagesPool = null;
         this._greenMessagesPool.dispose();
         this._greenMessagesPool = null;
         this._blackMessagesPool.dispose();
         this._blackMessagesPool = null;
         this._selfMessagesPool.dispose();
         this._selfMessagesPool = null;
         this.itemBackground = null;
         this.receiverField = null;
         this.messageInputField = null;
         this.hintBackground = null;
         this.historyUpBtn.dispose();
         this.historyUpBtn = null;
         this.historyDownBtn.dispose();
         this.historyDownBtn = null;
         this.historyLastMessageBtn.dispose();
         this.historyLastMessageBtn = null;
         this.tooltipSymbol = null;
         this.hit = null;
         this._scheduler.cancelTask(this.selectMessageInputField);
         this._scheduler.cancelTask(this.scrollMessages);
         this.cancelNextMessageShow();
         this._scheduler = null;
         this._appStage = null;
         super.onDispose();
      }
      
      override protected function setReceiver(param1:BattleMessengerReceiverVO, param2:Boolean) : void
      {
         if(param2)
         {
            this.clearReceivers();
         }
         this._receivers.push(param1);
         this.updateReceivers();
      }
      
      override protected function setReceivers(param1:Vector.<BattleMessengerReceiverVO>) : void
      {
         this._receivers = param1;
         this.updateReceivers();
      }
      
      public function as_changeReceiver(param1:int) : void
      {
         this.receiverIdx = param1;
      }
      
      public function as_enableToSendMessage() : void
      {
         this._isChannelsInited = true;
      }
      
      public function as_enableToxicPanel() : void
      {
         this._toxicPanelData = new BattleMessengerToxicVO();
         this._userInteractionCmp = new BattleMessengerActionContainer();
         this._userInteractionCmp.name = NAME_USER_INTERACTION_CMP;
         this._userInteractionCmp.onClickButtonCallback = onToxicButtonClickedS;
         this._userInteractionCmp.onClosedCallback = onToxicPanelClosedS;
         this._userInteractionCmp.visible = false;
         this._isToxicEnabled = true;
         this._messagesContainer.addChild(this._userInteractionCmp);
      }
      
      public function as_enterPressed(param1:int) : void
      {
         var _loc2_:String = null;
         if(!this.visible)
         {
            return;
         }
         if(this._isCtrlButtonPressed)
         {
            return;
         }
         this.hideToxicPanel();
         if(this._isFocused)
         {
            this._isEnterButtonPressed = false;
            if(this._isChannelsInited)
            {
               _loc2_ = this.messageInputField.text;
               if(_loc2_.length > 0)
               {
                  if(sendMessageToChannelS(param1,_loc2_))
                  {
                     this.showLastIndexMessages();
                     this.hideViewElements();
                  }
               }
               else
               {
                  this.hideViewElements();
               }
               this.messageInputField.text = Values.EMPTY_STR;
            }
         }
         else
         {
            this._isEnterButtonPressed = true;
            this.receiverIdx = param1;
            this.showViewElements(true);
         }
         this.switchSwapArea(!this._isEnterButtonPressed);
      }
      
      public function as_restoreMessages(param1:String) : void
      {
         var _loc2_:BattleMessage = null;
         for each(_loc2_ in this._messages)
         {
            if(_loc2_.messageID == param1)
            {
               _loc2_.restoreMessage();
               this.syncToxicBackground(_loc2_);
            }
         }
         this.updateFullStack();
      }
      
      public function as_setActive(param1:Boolean) : void
      {
         var _loc2_:BattleMessage = null;
         this._isActive = param1;
         if(!this._isActive && !this._isFocused)
         {
            for each(_loc2_ in this._messages)
            {
               _loc2_.setState(BattleMessage.STATE_HIDDEN_MES);
            }
         }
      }
      
      public function as_setFocus() : void
      {
         this.showViewElements(true);
      }
      
      public function as_setUserPreferences(param1:String) : void
      {
         this._tooltipStr = param1;
      }
      
      public function as_showBlackMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,this._blackMessagesPool,param2);
      }
      
      public function as_showGreenMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,this._greenMessagesPool,param2);
      }
      
      public function as_showRedMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,this._redMessagesPool,param2);
      }
      
      public function as_showSelfMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,this._selfMessagesPool,param2);
      }
      
      public function as_toggleCtrlPressFlag(param1:Boolean) : void
      {
         if(this._isEnterButtonPressed)
         {
            return;
         }
         this.hideToxicPanel();
         this._isCtrlButtonPressed = param1;
         this.hintBackground.mouseEnabled = param1;
         if(param1)
         {
            this.showViewElements(false);
         }
         else
         {
            this.hideViewElements();
         }
         this.switchSwapArea(!this._isCtrlButtonPressed);
      }
      
      public function as_unSetFocus() : void
      {
         this._isCtrlButtonPressed = false;
         this._isEnterButtonPressed = false;
         this.hideViewElements();
         this.messageInputField.text = Values.EMPTY_STR;
      }
      
      public function as_updateMessages(param1:String, param2:String) : void
      {
         var _loc3_:BattleMessage = null;
         for each(_loc3_ in this._messages)
         {
            if(_loc3_.messageID == param1)
            {
               _loc3_.setBlockMessage(param2);
               this.syncToxicBackground(_loc3_);
            }
         }
         this.updateFullStack();
      }
      
      public function as_updateToxicPanel(param1:String, param2:Object) : void
      {
         this._toxicPanelData.reset();
         this._toxicPanelData.parseData(param2);
         this._userInteractionCmp.syncUpdater(param1,this._toxicPanelData);
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this.messageInputField;
      }
      
      public function onButtonClick(param1:Object) : void
      {
         switch(param1.name)
         {
            case this.historyUpBtn.name:
            case this.historyDownBtn.name:
               this.cancelNextMessageShow();
         }
      }
      
      public function onButtonPress(param1:Object) : void
      {
         switch(param1.name)
         {
            case this.historyUpBtn.name:
               this._nextMsgKeyCode = Keyboard.UP;
               this.showPrevVisibleMessages();
               break;
            case this.historyDownBtn.name:
               this._nextMsgKeyCode = Keyboard.DOWN;
               this.showNextVisibleMessages();
               break;
            case this.historyLastMessageBtn.name:
               this.showLastIndexMessages();
         }
         if(this._nextMsgKeyCode == Keyboard.UP || this._nextMsgKeyCode == Keyboard.DOWN)
         {
            this._scheduler.scheduleTask(this.showNextMessage,SHOW_NEXT_MSG_DURATION);
         }
      }
      
      public function setAvailableWidthForMessages(param1:int) : void
      {
         if(this._poolsCreated && param1 != this._messagesAvailableWidth)
         {
            this._messagesAvailableWidth = param1;
            this._redMessagesPool.setAvailableWidth(this._messagesAvailableWidth);
            this._greenMessagesPool.setAvailableWidth(this._messagesAvailableWidth);
            this._blackMessagesPool.setAvailableWidth(this._messagesAvailableWidth);
            this._selfMessagesPool.setAvailableWidth(this._messagesAvailableWidth);
            this.updateFullStack();
         }
      }
      
      public function updateSwapAreaHeight(param1:Number) : void
      {
         this.swapArea.graphics.clear();
         drawRect(this.swapArea,0,param1 - BOTTOM_SIDE_Y_POSITION,BOTTOM_SIDE_WIDTH,BOTTOM_SIDE_Y_POSITION);
         drawRect(this.swapArea,0,0,!!this._isSmallState ? Number(BOTTOM_SIDE_WIDTH) : Number(BattleMessage.DEFAULT_TEXT_WIDTH),param1 - BOTTOM_SIDE_Y_POSITION,false);
         this.swapArea.y = -param1 + BOTTOM_SIDE_Y_POSITION;
      }
      
      private function removeMessageFromDisplayList(param1:BattleMessage) : void
      {
         this.backgroundLayer.removeChild(param1.background);
         this._messagesContainer.removeChild(param1.messageField);
      }
      
      private function syncToxicBackground(param1:BattleMessage) : void
      {
         if(param1.isOpenedToxicPanel)
         {
            this._userInteractionCmp.syncBackground(param1.width);
         }
      }
      
      private function pushMessageWithToxicLogic(param1:BattleMessage) : void
      {
         param1.setState(BattleMessage.STATE_HIDDEN_MES,true);
         this.updateHistoryButtons();
      }
      
      private function switchSwapArea(param1:Boolean) : void
      {
         hitArea = !!param1 ? this.swapArea : null;
         this.swapArea.mouseEnabled = param1;
         if(!param1)
         {
            this.swapArea.hitArea = null;
         }
         else if(!this.swapArea.hitArea)
         {
            App.utils.commons.addEmptyHitArea(this.swapArea);
            this._swapAreaHit = this.swapArea.hitArea;
         }
         else
         {
            this.swapArea.hitArea = this._swapAreaHit;
         }
      }
      
      private function userInteraction(param1:Boolean, param2:Function, param3:String = "", param4:int = 0, param5:int = 0, param6:int = 0) : Boolean
      {
         var _loc7_:Object = null;
         if(!this._isToxicEnabled)
         {
            param2();
            return false;
         }
         if(param1)
         {
            _loc7_ = getToxicStatusS(param3);
            if(_loc7_ == null)
            {
               return false;
            }
            this._toxicPanelData.reset();
            this._toxicPanelData.parseData(_loc7_);
         }
         this._userInteractionCmp.drawTestGraphics(this._toxicPanelData,param1,param2,param4,param5,param6);
         return true;
      }
      
      private function showViewElements(param1:Boolean) : void
      {
         if(this._isFocused)
         {
            return;
         }
         this.updateFocus(param1);
         onMouseOutHandler(null);
         this.setPanelElementsVisibility(true);
         this.switchListenersViewElements(true);
         this.setAlpha(Values.DEFAULT_ALPHA);
         this.updateReceiverField();
         this.showLastIndexMessages();
         if(this._isChannelsInited)
         {
            App.utils.IME.setVisible(true);
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            this.messageInputField.setSelection(0,this.messageInputField.length);
         }
         if(this._isEnterButtonPressed)
         {
            focusReceivedS();
         }
      }
      
      private function updateFocus(param1:Boolean) : void
      {
         this._isFocused = param1;
         focusable = param1;
      }
      
      private function hideViewElements() : void
      {
         if(this._isCtrlButtonPressed)
         {
            return;
         }
         this.updateFocus(false);
         onMouseOutHandler(null);
         this.setPanelElementsVisibility(false);
         this.switchListenersViewElements(false);
         this.setAlpha(this._inactiveStateAlpha);
         this.disableInput();
         this.showLastIndexMessages();
         this.historyUpBtn.enabled = false;
         this.historyDownBtn.enabled = false;
         this.historyLastMessageBtn.enabled = false;
         App.utils.IME.setVisible(false);
         dispatchEvent(new Event(REMOVE_FOCUS));
         if(!this._isCtrlButtonPressed && !this._isEnterButtonPressed || this._isEnterButtonPressed)
         {
            focusLostS();
         }
      }
      
      private function switchListenersViewElements(param1:Boolean) : void
      {
         if(param1)
         {
            this.hit.removeEventListener(MouseEvent.CLICK,this.onBattleMessengerMouseClickHandler);
            this._appStage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
            this._appStage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            this._appStage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler);
            this.addEventListener(MouseEvent.ROLL_OVER,this.onMessengerRollOverHandler);
            this.addEventListener(MouseEvent.ROLL_OUT,this.onMessengerRollOutHandler);
         }
         else
         {
            this.hit.addEventListener(MouseEvent.CLICK,this.onBattleMessengerMouseClickHandler);
            this._appStage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
            this._appStage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            this._appStage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler);
            this._isMessengerOver = false;
            this.removeEventListener(MouseEvent.ROLL_OVER,this.onMessengerRollOverHandler);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.onMessengerRollOutHandler);
         }
      }
      
      private function updateReceivers() : void
      {
         this._receivers.sort(receiversSort);
         var _loc1_:int = this._receivers.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._receivers[_loc2_].isByDefault)
            {
               this._receiverIdx = _loc2_;
               break;
            }
            _loc2_++;
         }
         this.updateReceiverField();
      }
      
      private function setAlpha(param1:Number) : void
      {
         this.receiverField.alpha = param1;
         this.itemBackground.alpha = param1;
         this.messageInputField.alpha = param1;
      }
      
      private function pushMessage(param1:BattleMessage) : void
      {
         this._messages.push(param1);
         param1.x = 0;
         this.setNextMessagePosY(param1);
         this.backgroundLayer.addChild(param1.background);
         this._messagesContainer.addChild(param1.messageField);
         var _loc2_:uint = this._messages.length;
         if(this._maxMessagesInHistory > 0)
         {
            this._isFullMessagesStack = _loc2_ >= this._maxMessagesInHistory;
         }
         var _loc3_:Boolean = this._isToxicEnabled && this._isMessengerOver;
         if(_loc2_ > 1 && (_loc3_ || App.contextMenuMgr.isShown()))
         {
            this.checkBottomMessageVisible();
            this.pushMessageWithToxicLogic(param1);
         }
         else
         {
            if(this._isBottomMessageVisible)
            {
               ++this._bottomMessageIndex;
            }
            this.checkTopVisibleMes();
            this.checkBottomMessageVisible();
            this.pushMessageDefaultLogic(param1);
         }
         this.updateHistoryButtons();
      }
      
      private function checkTopVisibleMes() : void
      {
         this._isTopMessageVisible = this._topMessageIndex == 0;
         this.updateTopMesState();
      }
      
      private function updateAfterTopMesState() : void
      {
         if(this.userInteractsWithMessenger)
         {
            this._messages[this._topMessageIndex + 1].setState(BattleMessage.STATE_VISIBLE_WHEEL_MES,true);
         }
      }
      
      private function checkBottomMessageVisible() : void
      {
         this._isBottomMessageVisible = this._bottomMessageIndex == this._messages.length - 1;
      }
      
      private function pushMessageDefaultLogic(param1:BattleMessage) : void
      {
         var _loc2_:int = this._messages.length;
         var _loc3_:Boolean = !(this._isFocused || this._isActive) && !this._isCtrlButtonPressed;
         if(_loc2_ >= this._calculatedMaxVisibleMessages)
         {
            if(this._isBottomMessageVisible)
            {
               this.showLastIndexMessages();
               param1.show(_loc3_);
            }
            else
            {
               param1.setState(BattleMessage.STATE_HIDDEN_MES,true);
               this.updateHistoryButtons();
            }
         }
         else
         {
            param1.show(_loc3_);
            this._bottomMessageIndex = _loc2_ - 1;
            this.updateMessagesPosition();
            this.checkBigMessagesInSmallScreen(true);
         }
      }
      
      private function updateTopMesState() : void
      {
         var _loc1_:int = 0;
         if(this._isFocused || this._isActive || this._isCtrlButtonPressed)
         {
            _loc1_ = !!this._isTopMessageVisible ? int(BattleMessage.STATE_VISIBLE_WHEEL_MES) : int(BattleMessage.STATE_HIDEHALF_MES);
            this._messages[this._topMessageIndex].setState(_loc1_,true);
         }
      }
      
      private function setPanelElementsVisibility(param1:Boolean) : void
      {
         this.hintBackground.visible = param1;
         this.tooltipSymbol.visible = param1;
         this.historyUpBtn.visible = param1;
         this.historyDownBtn.visible = param1;
         this.historyLastMessageBtn.visible = param1;
      }
      
      private function showPrevVisibleMessages() : void
      {
         if(!this._isTopMessageVisible)
         {
            this.hideMessageByIndex(this._bottomMessageIndex);
            --this._bottomMessageIndex;
            --this._topMessageIndex;
            this._isTopMessageVisible = this._topMessageIndex == 0;
            this.showMessageByIndex(this._topMessageIndex);
            this.updateAfterTopMesState();
            this.checkBottomMessageVisible();
            this.updateHistoryButtons();
            this.updateMessagesPosition();
            this.checkBigMessagesInSmallScreen(false);
         }
      }
      
      private function updateMessagesPosition() : void
      {
         var _loc1_:BattleMessage = null;
         if(this._bottomMessageIndex < this._messages.length)
         {
            _loc1_ = this._messages[this._bottomMessageIndex];
            if(_loc1_)
            {
               this.backgroundLayer.y = this._messagesContainer.y = -(_loc1_.y + _loc1_.height);
            }
         }
      }
      
      private function showNextVisibleMessages() : void
      {
         if(!this._isBottomMessageVisible)
         {
            if(this._bottomMessageIndex - this._topMessageIndex + 1 >= this._calculatedMaxVisibleMessages)
            {
               this.hideMessageByIndex(this._topMessageIndex);
               ++this._topMessageIndex;
            }
            ++this._bottomMessageIndex;
            this.showMessageByIndex(this._bottomMessageIndex);
            this.checkBottomMessageVisible();
            this.checkTopVisibleMes();
            this.updateMessagesPosition();
            this.checkBigMessagesInSmallScreen(true);
            this.updateHistoryButtons();
         }
      }
      
      private function showMessageByIndex(param1:int) : void
      {
         var _loc2_:BattleMessage = this._messages[param1];
         var _loc3_:int = param1 == this._topMessageIndex && this._topMessageIndex != 0 ? int(BattleMessage.STATE_HIDEHALF_MES) : int(BattleMessage.STATE_VISIBLE_WHEEL_MES);
         _loc2_.setState(_loc3_,true);
         if(!this.userInteractsWithMessenger)
         {
            _loc2_.isWaitingAutoHide = true;
         }
      }
      
      private function hideMessageByIndex(param1:int) : void
      {
         this._messages[param1].setState(BattleMessage.STATE_HIDDEN_MES,true);
      }
      
      private function showLastIndexMessages() : void
      {
         var _loc1_:int = 0;
         var _loc4_:BattleMessage = null;
         if(!this._messages.length)
         {
            return;
         }
         var _loc2_:int = this._messages.length;
         var _loc3_:int = this._isFocused || this._isCtrlButtonPressed ? int(BattleMessage.STATE_VISIBLE_MES) : int(BattleMessage.STATE_RECOVERED_MES);
         this._bottomMessageIndex = _loc2_ - 1;
         this._calculatedMaxVisibleMessages = this._defaultMaxVisibleMessages;
         this._topMessageIndex = this._bottomMessageIndex - this._calculatedMaxVisibleMessages + 1;
         this._topMessageIndex = Math.max(this._topMessageIndex,0);
         this.checkTopVisibleMes();
         this.checkBottomMessageVisible();
         _loc1_ = 0;
         while(_loc1_ < this._topMessageIndex)
         {
            this.hideMessageByIndex(_loc1_);
            _loc1_++;
         }
         this.updateMessagesPosition();
         this.checkBigMessagesInSmallScreen(true);
         _loc1_ = this._bottomMessageIndex;
         while(_loc1_ >= this._topMessageIndex)
         {
            _loc4_ = this._messages[_loc1_];
            _loc4_.clearAnim();
            if((this._isFocused || this._isCtrlButtonPressed) && _loc1_ == this._topMessageIndex && !this._isTopMessageVisible)
            {
               _loc4_.setState(BattleMessage.STATE_HIDEHALF_MES);
            }
            else
            {
               _loc4_.setState(_loc3_,true);
            }
            _loc4_.isWaitingAutoHide = !this.userInteractsWithMessenger;
            _loc1_--;
         }
         this.updateHistoryButtons();
      }
      
      private function updateHistoryButtons() : void
      {
         if(this._isHistoryEnabled)
         {
            this.historyUpBtn.enabled = !this._isTopMessageVisible;
            this.historyDownBtn.enabled = this._bottomMessageIndex + 1 < this._messages.length;
            this.historyLastMessageBtn.enabled = !this._isBottomMessageVisible;
         }
      }
      
      private function updateReceiverField() : void
      {
         this.receiverField.htmlText = this.receiverLabel;
         var _loc1_:TextFormat = this.messageInputField.getTextFormat();
         _loc1_.color = this.receiverColor;
         this.messageInputField.setTextFormat(_loc1_);
         this.messageInputField.defaultTextFormat = _loc1_;
         if(this.isEnableReceiver && this._isFocused)
         {
            this.enableInput();
         }
         else
         {
            this.disableInput();
         }
         this.messageInputField.x = this.receiverField.x + this.receiverField.width;
         this.messageInputField.width = MESSAGE_FIELD_AVAILABLE_WIDTH - this.messageInputField.x;
      }
      
      private function enableInput() : void
      {
         if(this._isChannelsInited)
         {
            this.messageInputField.addEventListener(InputEvent.INPUT,onMessageInputFieldInputHandler);
            this.messageInputField.addEventListener(KeyboardEvent.KEY_DOWN,this.onMessageInputFieldKeyDownHandler);
            this.messageInputField.selectable = true;
            this.messageInputField.mouseEnabled = true;
            this.messageInputField.type = TextFieldType.INPUT;
            this._appStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
            this._appStage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         }
      }
      
      private function disableInput() : void
      {
         this.messageInputField.removeEventListener(InputEvent.INPUT,onMessageInputFieldInputHandler);
         this.messageInputField.removeEventListener(KeyboardEvent.KEY_DOWN,this.onMessageInputFieldKeyDownHandler);
         this.messageInputField.selectable = false;
         this.messageInputField.mouseEnabled = false;
         this.messageInputField.type = TextFieldType.DYNAMIC;
         if(this._isFocused)
         {
            this._appStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
            this._appStage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         }
         else
         {
            this._appStage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
            this._appStage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         }
      }
      
      private function showMessage(param1:String, param2:BattleMessengerPool, param3:String = "") : void
      {
         var _loc5_:BattleMessage = null;
         if(this._isFullMessagesStack)
         {
            _loc5_ = this._messages.shift();
            _loc5_.close();
            this.removeMessageFromDisplayList(_loc5_);
            _loc5_.dispose();
            this.updateFullStack();
         }
         var _loc4_:BattleMessage = param2.createItem(this.userInteraction);
         _loc4_.messageID = param3;
         _loc4_.setMessageData(param1);
         this.pushMessage(_loc4_);
      }
      
      private function updateFullStack() : void
      {
         var _loc1_:BattleMessage = null;
         this._nextMsgPosY = 0;
         for each(_loc1_ in this._messages)
         {
            this.setNextMessagePosY(_loc1_);
         }
         this.updateMessagesPosition();
      }
      
      private function setNextMessagePosY(param1:BattleMessage) : void
      {
         param1.y = this._nextMsgPosY;
         this._nextMsgPosY += param1.height;
      }
      
      private function clearReceivers() : void
      {
         var _loc1_:BattleMessengerReceiverVO = null;
         for each(_loc1_ in this._receivers)
         {
            _loc1_.dispose();
         }
         this._receivers.fixed = false;
         this._receivers.splice(0,this._receivers.length);
      }
      
      private function hideToxicPanel() : void
      {
         if(this._isToxicEnabled)
         {
            this._userInteractionCmp.hide();
         }
      }
      
      private function checkBigMessagesInSmallScreen(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this.hasExtraMessagesInFreeSpace())
         {
            _loc2_ = this.getCountExtraMesInSmallScreen(param1);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(param1)
               {
                  this.hideMessageByIndex(this._topMessageIndex + _loc3_);
               }
               else
               {
                  this.hideMessageByIndex(this._bottomMessageIndex - _loc3_);
               }
               _loc3_++;
            }
            if(param1)
            {
               this._topMessageIndex += _loc2_;
               this.updateAfterTopMesState();
               this.checkTopVisibleMes();
            }
            else
            {
               this._bottomMessageIndex -= _loc2_;
               this.checkBottomMessageVisible();
               this.updateMessagesPosition();
            }
            this._calculatedMaxVisibleMessages = this._bottomMessageIndex - this._topMessageIndex + 1;
            this.updateHistoryButtons();
         }
         else if(this._calculatedMaxVisibleMessages < this._defaultMaxVisibleMessages)
         {
            this.checkFreeSpaceForInvisibleMessages();
         }
      }
      
      private function hasExtraMessagesInFreeSpace() : Boolean
      {
         var _loc1_:int = 0;
         if(this._messages.length <= 1)
         {
            return false;
         }
         _loc1_ = y;
         var _loc2_:Number = this.calculateVisibleMessagesHeight() / _loc1_;
         return _loc2_ > MAX_MESSAGES_HEIGHT_KOEF;
      }
      
      private function getCountExtraMesInSmallScreen(param1:Boolean) : int
      {
         var _loc5_:int = 0;
         var _loc7_:Boolean = false;
         var _loc8_:BattleMessage = null;
         var _loc2_:int = y;
         var _loc3_:int = this._topMessageIndex;
         var _loc4_:int = this._bottomMessageIndex;
         var _loc6_:Number = 0;
         var _loc9_:int = 0;
         do
         {
            _loc8_ = this._messages[_loc4_];
            _loc5_ = _loc8_.y + _loc8_.height - this._messages[_loc3_].y;
            _loc6_ = _loc5_ / _loc2_;
            if(param1)
            {
               _loc3_++;
            }
            else
            {
               _loc4_--;
            }
            if(_loc6_ > MAX_MESSAGES_HEIGHT_KOEF)
            {
               _loc9_++;
               _loc7_ = true;
            }
         }
         while(_loc6_ > MAX_MESSAGES_HEIGHT_KOEF);
         
         return !!_loc7_ ? int(_loc9_) : int(0);
      }
      
      private function checkFreeSpaceForInvisibleMessages() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(this._topMessageIndex > 0)
         {
            _loc1_ = y;
            _loc2_ = this.calculateVisibleMessagesHeight();
            _loc3_ = _loc2_ / _loc1_;
            while(_loc3_ < MAX_MESSAGES_HEIGHT_KOEF && this._topMessageIndex > 0 && this._calculatedMaxVisibleMessages < this._defaultMaxVisibleMessages)
            {
               _loc2_ = -this._messagesContainer.y - this._messages[this._topMessageIndex - 1].y;
               _loc3_ = _loc2_ / _loc1_;
               this.updateHistoryButtons();
               if(_loc3_ < MAX_MESSAGES_HEIGHT_KOEF)
               {
                  --this._topMessageIndex;
                  ++this._calculatedMaxVisibleMessages;
                  this.showMessageByIndex(this._topMessageIndex);
                  this.checkAdditionalMsgAlpha(this._topMessageIndex);
                  this.updateAfterTopMesState();
               }
            }
            this.checkTopVisibleMes();
         }
      }
      
      private function checkAdditionalMsgAlpha(param1:int) : void
      {
         var _loc2_:BattleMessage = this._messages[param1];
         var _loc3_:BattleMessage = this._messages[param1 + 1];
         if(_loc3_.getState() == BattleMessage.STATE_FADE_OUT_MES)
         {
            _loc2_.alpha = _loc3_.alpha;
            _loc2_.setState(BattleMessage.STATE_FADE_OUT_MES,true);
         }
      }
      
      private function calculateVisibleMessagesHeight() : int
      {
         return -this._messagesContainer.y - this._messages[this._topMessageIndex].y;
      }
      
      private function showNextMessage() : void
      {
         if(this._nextMsgKeyCode == Keyboard.UP)
         {
            if(this._isTopMessageVisible)
            {
               this.cancelNextMessageShow();
            }
            else
            {
               this.showPrevVisibleMessages();
               this._scheduler.scheduleTask(this.showNextMessage,SHOW_NEXT_MSG_DURATION);
            }
         }
         else if(this._nextMsgKeyCode == Keyboard.DOWN)
         {
            if(this._isBottomMessageVisible)
            {
               this.cancelNextMessageShow();
            }
            else
            {
               this.showNextVisibleMessages();
               this._scheduler.scheduleTask(this.showNextMessage,SHOW_NEXT_MSG_DURATION);
            }
         }
      }
      
      private function cancelNextMessageShow() : void
      {
         this._nextMsgKeyCode = 0;
         this._scheduler.cancelTask(this.showNextMessage);
      }
      
      private function selectMessageInputField() : void
      {
         this.messageInputField.setSelection(this._selectionBeginIndex,this._selectionEndIndex);
         this._scheduler.cancelTask(this.selectMessageInputField);
         this._selectionBeginIndex = -1;
         this._selectionEndIndex = -1;
      }
      
      private function scrollMessages() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         this._scheduler.cancelTask(this.scrollMessages);
         if(this._wheelMessagesScroll == 0)
         {
            return;
         }
         var _loc1_:Boolean = this._wheelMessagesScroll > 0;
         var _loc2_:uint = this._messages.length;
         if(_loc1_)
         {
            _loc4_ = Math.min(_loc2_ - 1,this._bottomMessageIndex + this._wheelMessagesScroll);
            _loc5_ = _loc4_ - this._bottomMessageIndex;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               this.hideMessageByIndex(this._topMessageIndex + _loc3_);
               this.showMessageByIndex(this._bottomMessageIndex + _loc3_ + 1);
               _loc3_++;
            }
            this._bottomMessageIndex = _loc4_;
            this._topMessageIndex = Math.max(this._bottomMessageIndex - this._calculatedMaxVisibleMessages + 1,0);
         }
         else
         {
            _loc4_ = Math.max(this._topMessageIndex + this._wheelMessagesScroll,0);
            _loc5_ = _loc4_ - this._topMessageIndex;
            this._messages[this._topMessageIndex].setState(this._isFocused || this._isCtrlButtonPressed ? int(BattleMessage.STATE_VISIBLE_MES) : int(BattleMessage.STATE_RECOVERED_MES),true);
            _loc3_ = 0;
            while(_loc3_ > _loc5_)
            {
               this.hideMessageByIndex(this._bottomMessageIndex + _loc3_);
               this.showMessageByIndex(this._topMessageIndex + _loc3_ - 1);
               _loc3_--;
            }
            this._topMessageIndex = _loc4_;
            this._bottomMessageIndex = Math.min(_loc2_ - 1,this._topMessageIndex + this._calculatedMaxVisibleMessages - 1);
         }
         this.checkTopVisibleMes();
         if(!_loc1_)
         {
            this.updateAfterTopMesState();
         }
         this.checkBottomMessageVisible();
         this.updateMessagesPosition();
         this.checkBigMessagesInSmallScreen(_loc1_);
         this.updateHistoryButtons();
         this.hideToxicPanel();
         this._wheelMessagesScroll = 0;
      }
      
      override public function set y(param1:Number) : void
      {
         var _loc2_:BattleMessage = null;
         super.y = param1;
         if(this._bottomMessageIndex < this._messages.length)
         {
            _loc2_ = this._messages[this._bottomMessageIndex];
            if(_loc2_.getState() != BattleMessage.STATE_HIDDEN_MES)
            {
               this.checkBigMessagesInSmallScreen(true);
            }
            this.updateMessagesPosition();
         }
      }
      
      public function set isSmallState(param1:Boolean) : void
      {
         this._isSmallState = param1;
      }
      
      public function get isEnterButtonPressed() : Boolean
      {
         return this._isEnterButtonPressed;
      }
      
      private function get userInteractsWithMessenger() : Boolean
      {
         return this._isFocused || this._isActive || this._isCtrlButtonPressed;
      }
      
      private function set receiverIdx(param1:int) : void
      {
         if(this._receiverIdx == param1 || param1 >= this._receivers.length)
         {
            return;
         }
         this._receiverIdx = param1;
         this.updateReceiverField();
      }
      
      private function get receiverColor() : int
      {
         return this._receivers.length > 0 ? int(this._receivers[this._receiverIdx].inputColor) : int(DEFAULT_RECEIVER_COLOR);
      }
      
      private function get receiverLabel() : String
      {
         return this._receivers.length > 0 ? this._receivers[this._receiverIdx].labelStr : EMPTY_STR;
      }
      
      private function get isEnableReceiver() : Boolean
      {
         return this._receivers.length > 0 ? Boolean(this._receivers[this._receiverIdx].isEnabled) : Boolean(false);
      }
      
      private function onBattleMessengerRollOverHandler(param1:MouseEvent) : void
      {
         this.switchSwapArea(false);
      }
      
      private function onBattleMessengerRollOutHandler(param1:MouseEvent) : void
      {
         if(this._isTooltipShow)
         {
            this._isTooltipShow = false;
         }
         else
         {
            this.switchSwapArea(true);
         }
      }
      
      private function onMessengerRollOutHandler(param1:MouseEvent) : void
      {
         this._isMessengerOver = false;
      }
      
      private function onMessengerRollOverHandler(param1:MouseEvent) : void
      {
         this._isMessengerOver = true;
      }
      
      private function onStageMouseWheelHandler(param1:MouseEvent = null) : void
      {
         if(param1 && this._messages.length > 0 && this._isMessengerOver)
         {
            if(param1.delta > 0 && !this.historyUpBtn.enabled || param1.delta < 0 && !this.historyDownBtn.enabled)
            {
               return;
            }
            if(param1.target != this._appStage && !App.contextMenuMgr.isShown())
            {
               this._scheduler.cancelTask(this.scrollMessages);
               this._wheelMessagesScroll += param1.delta > 0 ? -1 : 1;
               this._scheduler.scheduleOnNextFrame(this.scrollMessages);
               return;
            }
         }
         if(this._isEnterButtonPressed)
         {
            this.hideViewElements();
            this._isEnterButtonPressed = false;
         }
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._tooltipStr);
         this._isTooltipShow = true;
      }
      
      private function onMessageInputFieldKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = param1.keyCode;
         if(_loc2_ == Keyboard.UP || _loc2_ == Keyboard.DOWN || _loc2_ == Keyboard.PAGE_DOWN)
         {
            if(this._selectionBeginIndex == -1)
            {
               this._scheduler.scheduleOnNextFrame(this.selectMessageInputField);
            }
            this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
            this._selectionEndIndex = this.messageInputField.selectionEndIndex;
         }
      }
      
      private function onKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(this._messages.length == 0)
         {
            return;
         }
         var _loc2_:int = param1.keyCode;
         if(_loc2_ == Keyboard.UP || _loc2_ == Keyboard.DOWN)
         {
            this._nextMsgKeyCode = _loc2_;
            this._scheduler.scheduleTask(this.showNextMessage,SHOW_NEXT_MSG_DURATION);
         }
         if(_loc2_ == Keyboard.UP)
         {
            if(!this._isTopMessageVisible)
            {
               this.hideToxicPanel();
               this.showPrevVisibleMessages();
            }
            dispatchEvent(new Event(REMOVE_FOCUS));
         }
         else if(_loc2_ == Keyboard.DOWN)
         {
            if(!this._isBottomMessageVisible)
            {
               this.hideToxicPanel();
               this.showNextVisibleMessages();
            }
            dispatchEvent(new Event(REMOVE_FOCUS));
         }
         else if(_loc2_ == Keyboard.PAGE_DOWN)
         {
            if(!this._isBottomMessageVisible)
            {
               this.hideToxicPanel();
               this.showLastIndexMessages();
            }
            dispatchEvent(new Event(REMOVE_FOCUS));
         }
      }
      
      private function onKeyUpHandler(param1:KeyboardEvent) : void
      {
         if(this._messages.length == 0)
         {
            return;
         }
         var _loc2_:int = param1.keyCode;
         if(this._nextMsgKeyCode == Keyboard.UP || this._nextMsgKeyCode == Keyboard.DOWN)
         {
            this.cancelNextMessageShow();
         }
         if(_loc2_ == Keyboard.UP || _loc2_ == Keyboard.DOWN || _loc2_ == Keyboard.PAGE_DOWN)
         {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
         }
      }
      
      private function onBattleMessengerMouseClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx && MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            this.showViewElements(true);
         }
      }
      
      private function onStageMouseDownHandler(param1:MouseEvent) : void
      {
         this._selectedTargetOnMouseDown = param1.target;
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(param1 is MouseEventEx)
         {
            _loc2_ = param1.stageX / stage.scaleX;
            _loc3_ = param1.stageY / stage.scaleY;
            _loc4_ = MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON;
            if(_loc4_ && this.hit.hitTestPoint(_loc2_,_loc3_,false) && this._isCtrlButtonPressed)
            {
               this.as_toggleCtrlPressFlag(false);
               this.as_enterPressed(this._receiverIdx);
            }
            if(param1.target == this._appStage || !this.hitTestPoint(_loc2_,_loc3_,false) && !App.utils.IME.getContainer().hitTestPoint(_loc2_,_loc3_,false))
            {
               if(!this._isCtrlButtonPressed)
               {
                  this.hideViewElements();
                  this._isEnterButtonPressed = false;
               }
            }
            else if(_loc4_ && this._selectedTargetOnMouseDown != this.messageInputField)
            {
               this.messageInputField.setSelection(0,this.messageInputField.length);
               dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            }
         }
         this._selectedTargetOnMouseDown = null;
      }
   }
}
