package net.wg.gui.battle.views.battleMessenger
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
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
      
      private static const MESSAGE_FIELD_AVAILABLE_WIDTH:int = 218;
      
      private static const DEFAULT_RECEIVER_COLOR:int = 9868414;
      
      private static const EMPTY_STR:String = "";
      
      private static const HOVER_SIZE:Number = 10;
      
      private static const BOTTOM_SIDE_Y_POSITION:Number = 48;
      
      private static const BOTTOM_SIDE_WIDTH:Number = 230;
       
      
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
      
      public var hoverMC:Sprite;
      
      public var swapArea:Sprite = null;
      
      private var _receiverIdx:int = 0;
      
      private var _receivers:Vector.<BattleMessengerReceiverVO>;
      
      private var _tooltipStr:String = "";
      
      private var _isFocused:Boolean = true;
      
      private var _isActive:Boolean = false;
      
      private var _isHistoryEnabled:Boolean = false;
      
      private var _maxMessages:int = -1;
      
      private var _maxVisibleMessages:int = -1;
      
      private var _redMessagesPool:BattleMessengerPool = null;
      
      private var _greenMessagesPool:BattleMessengerPool = null;
      
      private var _blackMessagesPool:BattleMessengerPool = null;
      
      private var _selfMessagesPool:BattleMessengerPool = null;
      
      private var _messages:Vector.<BattleMessage>;
      
      private var _topMessageIndex:int = 0;
      
      private var _bottomMessageIndex:int = 0;
      
      private var _isTopMessageVisible:Boolean = false;
      
      private var _isBottomMessageVisible:Boolean = false;
      
      private var _isFullVisibleMessagesInHistoryStack:Boolean = false;
      
      private var _isFullMessagesStack:Boolean = false;
      
      private var _inactiveStateAlpha:Number = 0.5;
      
      private var _scheduler:IScheduler;
      
      private var _isUnlimitedMessageStack:Boolean = false;
      
      private var _battleSmileyMap:BattleSmileyMap;
      
      private var _isChannelsInited:Boolean = false;
      
      private var _selectionBeginIndex:int = 0;
      
      private var _selectionEndIndex:int = 0;
      
      private var _selectedTargetOnMouseDown:Object = null;
      
      private var _isCtrlButtonPressed:Boolean = false;
      
      private var _isEnterButtonPressed:Boolean = false;
      
      private var _userInteractionCmp:BattleMessengerActionContainer = null;
      
      private var _isToxicOver:Boolean = false;
      
      private var _isToxicEnabled:Boolean = false;
      
      private var _toxicPanelData:BattleMessengerToxicVO = null;
      
      private var _defaultWidth:int = -1;
      
      private var _availableWidth:int;
      
      private var _hoverWidth:int = 0;
      
      private var _hoverHeight:int = 0;
      
      private var _hoverYPosition:int = 0;
      
      private var _hoverState:int = 0;
      
      private var _isSmallState:Boolean = false;
      
      public function BattleMessenger()
      {
         this.hoverMC = new Sprite();
         this._receivers = new Vector.<BattleMessengerReceiverVO>();
         this._messages = new Vector.<BattleMessage>();
         this._scheduler = App.utils.scheduler;
         this._battleSmileyMap = new BattleSmileyMap();
         this._availableWidth = BattleMessage.DEFAULT_TEXT_WIDTH;
         super();
         this._defaultWidth = this.hit.width;
         this.drawRect(this.hoverMC,0,0,HOVER_SIZE,HOVER_SIZE);
         this.hoverMC.x = 0;
         this.hoverMC.alpha = 0;
         this.swapArea = new Sprite();
         this.swapArea.alpha = 0;
         addChild(this.swapArea);
         this.addChildAt(this.hoverMC,this.getChildIndex(this.backgroundLayer) - 1);
         addEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         hitArea = this.swapArea;
         mouseChildren = false;
         TextFieldEx.setNoTranslate(this.receiverField,true);
         TextFieldEx.setNoTranslate(this.messageInputField,true);
         this.tooltipSymbol.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.tooltipSymbol.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      private static function receiversSort(param1:BattleMessengerReceiverVO, param2:BattleMessengerReceiverVO) : int
      {
         return param1.orderIndex - param2.orderIndex;
      }
      
      override protected function setupList(param1:BattleMessengerSettingsVO) : void
      {
         this._maxMessages = param1.maxLinesCount;
         this._isUnlimitedMessageStack = this._maxMessages == -1;
         this._maxVisibleMessages = param1.numberOfMessagesInHistory;
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
         this._redMessagesPool = new BattleMessengerPool(this._maxMessages,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.RED_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._greenMessagesPool = new BattleMessengerPool(this._maxMessages,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.GREEN_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._blackMessagesPool = new BattleMessengerPool(this._maxMessages,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.BLACK_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
         this._selfMessagesPool = new BattleMessengerPool(this._maxMessages,_loc2_,_loc3_,_loc4_,_loc5_,_loc6_,BATTLE_MESSAGES_CONSTS.SELF_MESSAGE_RENDERER,this._battleSmileyMap,this.userInteraction);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.receiverField.autoSize = TextFieldAutoSize.LEFT;
         this.historyUpBtn.addClickCallBack(this);
         this.historyDownBtn.addClickCallBack(this);
         this.historyLastMessageBtn.addClickCallBack(this);
         this.hideViewElements();
         this.hit.tabEnabled = false;
         this.receiverField.tabEnabled = false;
         tabEnabled = false;
         this.hit.buttonMode = true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleMessage = null;
         this._scheduler.cancelTask(this.updateMesYPositions);
         this._scheduler = null;
         if(this._userInteractionCmp)
         {
            this._toxicPanelData = null;
            this.removeEventListener(MouseEvent.ROLL_OVER,this.onMessengerRollOverHandler);
            this.removeEventListener(MouseEvent.ROLL_OUT,this.onMessengerRollOutHandler);
            this._userInteractionCmp.dispose();
            this._userInteractionCmp = null;
         }
         removeEventListener(MouseEvent.ROLL_OUT,this.onBattleMessengerRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onBattleMessengerRollOverHandler);
         this.swapArea = null;
         this._battleSmileyMap.dispose();
         this._battleSmileyMap = null;
         this.hit.removeEventListener(MouseEvent.CLICK,this.onBattleMessengerMouseClickHandler);
         this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.tooltipSymbol.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.hintBackground.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.hintBackground.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.messageInputField.removeEventListener(KeyboardEvent.KEY_DOWN,this.onMessageInputFieldKeyDownHandler);
         this.messageInputField.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         this.messageInputField.removeEventListener(InputEvent.INPUT,this.onMessageInputFieldInputHandler);
         App.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         this.hit.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         this.hit.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler);
         for each(_loc1_ in this._messages)
         {
            this.backgroundLayer.removeChild(_loc1_.background);
            removeChild(_loc1_.messageField);
         }
         this.backgroundLayer = null;
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
         this.hoverMC = null;
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
         this._userInteractionCmp.onClickButtonCallback = onToxicButtonClickedS;
         this._userInteractionCmp.onClosedCallback = onToxicPanelClosedS;
         this._userInteractionCmp.visible = false;
         this._isToxicEnabled = true;
         this.addChild(this._userInteractionCmp);
      }
      
      public function as_enterPressed(param1:int) : void
      {
         var _loc2_:String = null;
         if(this._isCtrlButtonPressed)
         {
            return;
         }
         this.hideToxicPanel();
         if(this._isFocused)
         {
            this._isEnterButtonPressed = false;
            _loc2_ = this.messageInputField.text;
            if(this._isChannelsInited)
            {
               if(_loc2_.length > 0)
               {
                  if(sendMessageToChannelS(param1,_loc2_))
                  {
                     this.hideViewElements();
                     this.showLastIndexMessages();
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
               if(_loc2_.isOpenedToxicPanel)
               {
                  this._userInteractionCmp.syncBackground(_loc2_.background.width);
               }
            }
         }
      }
      
      public function as_setActive(param1:Boolean) : void
      {
         var _loc2_:BattleMessage = null;
         this._isActive = param1;
         if(!this._isActive && !this._isFocused)
         {
            for each(_loc2_ in this._messages)
            {
               _loc2_.setState(BattleMessage.HIDDEN_MES);
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
               if(_loc3_.isOpenedToxicPanel)
               {
                  this._userInteractionCmp.syncBackground(_loc3_.background.width);
               }
            }
         }
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
               this.showPrevVisibleMessages();
               break;
            case this.historyDownBtn.name:
               this.showNextVisibleMessages();
               break;
            case this.historyLastMessageBtn.name:
               this.showLastIndexMessages();
         }
      }
      
      public function setAvailableWidthForMessages(param1:int) : void
      {
         var _loc2_:BattleMessage = null;
         this._availableWidth = param1;
         for each(_loc2_ in this._messages)
         {
            _loc2_.setAvailableWidth(param1);
         }
         this._scheduler.cancelTask(this.updateMesYPositions);
         this._scheduler.scheduleOnNextFrame(this.updateMesYPositions);
      }
      
      public function updateSwapAreaHeight(param1:Number) : void
      {
         this.swapArea.graphics.clear();
         this.drawRect(this.swapArea,0,param1 - BOTTOM_SIDE_Y_POSITION,BOTTOM_SIDE_WIDTH,BOTTOM_SIDE_Y_POSITION);
         this.drawRect(this.swapArea,0,0,!!this._isSmallState ? Number(BOTTOM_SIDE_WIDTH) : Number(BattleMessage.DEFAULT_TEXT_WIDTH),param1 - BOTTOM_SIDE_Y_POSITION);
         this.swapArea.y = -param1 + BOTTOM_SIDE_Y_POSITION;
      }
      
      private function switchSwapArea(param1:Boolean) : void
      {
         if(param1)
         {
            hitArea = this.swapArea;
         }
         else
         {
            hitArea = null;
         }
         this.swapArea.mouseEnabled = param1;
         mouseChildren = !param1;
      }
      
      private function drawRect(param1:Sprite, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         param1.graphics.beginFill(0);
         param1.graphics.drawRect(param2,param3,param4,param5);
         param1.graphics.endFill();
      }
      
      private function fillBG() : void
      {
         if(this._hoverState == BattleMessage.VISIBLE_MES)
         {
            this.hoverMC.visible = true;
            this.hoverMC.y = this._hoverYPosition - this._hoverHeight;
            this.hoverMC.width = this._hoverWidth;
            this.hoverMC.height = this._hoverHeight;
         }
         else
         {
            this.hoverMC.visible = false;
         }
      }
      
      private function userInteraction(param1:Boolean, param2:Function, param3:String = "", param4:int = 0, param5:int = 0, param6:int = 0) : Boolean
      {
         if(!this._isToxicEnabled)
         {
            param2();
            return false;
         }
         var _loc7_:Object = null;
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
         this.onMouseOutHandler(null);
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
         if(this._isCtrlButtonPressed)
         {
            this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
            this._selectionEndIndex = this.messageInputField.selectionEndIndex;
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
         this.onMouseOutHandler(null);
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
            App.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler);
            if(this._isToxicEnabled)
            {
               this.addEventListener(MouseEvent.ROLL_OVER,this.onMessengerRollOverHandler);
               this.addEventListener(MouseEvent.ROLL_OUT,this.onMessengerRollOutHandler);
            }
         }
         else
         {
            this.hit.addEventListener(MouseEvent.CLICK,this.onBattleMessengerMouseClickHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStageMouseDownHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler);
            App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onStageMouseWheelHandler);
            if(this._isToxicEnabled)
            {
               this._isToxicOver = false;
               this.removeEventListener(MouseEvent.ROLL_OVER,this.onMessengerRollOverHandler);
               this.removeEventListener(MouseEvent.ROLL_OUT,this.onMessengerRollOutHandler);
            }
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
      
      private function isToxicOver() : Boolean
      {
         return this._isToxicEnabled && this._isToxicOver;
      }
      
      private function pushMessage(param1:BattleMessage) : void
      {
         this._messages.push(param1);
         this.backgroundLayer.addChild(param1.background);
         addChildAt(param1.messageField,getChildIndex(this.backgroundLayer) + 1);
         param1.x = 0;
         param1.y = -param1.height;
         if(this.isToxicOver() || App.contextMenuMgr.isShown())
         {
            this.pushMessageWithToxicLogic(param1);
         }
         else
         {
            this.pushMessageDefaultLogic(param1);
         }
      }
      
      private function pushMessageWithToxicLogic(param1:BattleMessage) : void
      {
         var _loc2_:Boolean = this._isFullVisibleMessagesInHistoryStack && this._isFocused;
         if(!_loc2_ && this._messages.length == this._maxVisibleMessages)
         {
            this._isFullVisibleMessagesInHistoryStack = true;
         }
         this.updateHistoryButtons();
         param1.setState(BattleMessage.HIDDEN_MES);
      }
      
      private function pushMessageDefaultLogic(param1:BattleMessage) : void
      {
         if(this._isFullVisibleMessagesInHistoryStack && this._isFocused)
         {
            if(this._isBottomMessageVisible)
            {
               if(this._isFullMessagesStack)
               {
                  --this._topMessageIndex;
                  --this._bottomMessageIndex;
               }
               this.showNextVisibleMessages();
               param1.show(!this._isFocused && !this._isCtrlButtonPressed);
            }
            else if(this._isTopMessageVisible)
            {
               if(this._isFullMessagesStack)
               {
                  this.moveUpMessages();
                  this._messages[this._bottomMessageIndex - 1].setState(BattleMessage.VISIBLE_MES);
               }
               param1.setState(BattleMessage.HIDDEN_MES);
            }
            else
            {
               if(this._isFullMessagesStack)
               {
                  --this._topMessageIndex;
                  --this._bottomMessageIndex;
                  this.updateHistoryButtons();
               }
               if(this._isTopMessageVisible)
               {
                  this._messages[this._topMessageIndex].setState(BattleMessage.VISIBLE_MES);
               }
               param1.setState(BattleMessage.HIDDEN_MES);
            }
            if(!this._isUnlimitedMessageStack && !this._isFullMessagesStack && this._messages.length == this._maxMessages)
            {
               this._isFullMessagesStack = true;
            }
         }
         else
         {
            if(!this._isFullMessagesStack)
            {
               ++this._bottomMessageIndex;
            }
            this.moveUpMessages();
            if(this._messages.length == this._maxVisibleMessages)
            {
               this._isFullVisibleMessagesInHistoryStack = true;
               this.updateHistoryButtons();
            }
            if(!this._isUnlimitedMessageStack && !this._isFullMessagesStack && this._messages.length == this._maxMessages)
            {
               this._isFullMessagesStack = true;
            }
            param1.show(!(this._isFocused || this._isActive) && !this._isCtrlButtonPressed);
            if(this._messages.length > this._maxVisibleMessages)
            {
               this.showLastIndexMessages();
            }
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
      
      private function updateMesYPositions() : void
      {
         var _loc1_:int = this._bottomMessageIndex - 1;
         var _loc2_:int = 0;
         while(_loc1_ >= this._topMessageIndex)
         {
            _loc2_ -= this._messages[_loc1_].height;
            this._messages[_loc1_].y = _loc2_;
            _loc1_--;
         }
      }
      
      private function moveDownMessages() : void
      {
         var _loc1_:int = this._messages[this._bottomMessageIndex].height;
         var _loc2_:int = this._topMessageIndex + 1;
         while(_loc2_ < this._bottomMessageIndex)
         {
            this._messages[_loc2_].y += _loc1_;
            _loc2_++;
         }
      }
      
      private function showPrevVisibleMessages() : void
      {
         --this._topMessageIndex;
         --this._bottomMessageIndex;
         this.updateHistoryButtons();
         var _loc1_:BattleMessage = this._messages[this._topMessageIndex];
         _loc1_.setState(!!this._isTopMessageVisible ? int(BattleMessage.VISIBLE_WHEEL_MES) : int(BattleMessage.HIDEHALF_MES));
         this.showMessageByIndex(this._topMessageIndex + 1,false,true);
         this.moveDownMessages();
         _loc1_.y = this._messages[this._topMessageIndex + 1].y - _loc1_.height;
         this.hideMessageByIndex(this._bottomMessageIndex);
         this._hoverHeight = -_loc1_.y;
         this._hoverYPosition = this.backgroundLayer.y;
         this.fillBG();
      }
      
      private function moveUpMessages() : void
      {
         var _loc1_:int = this._bottomMessageIndex - 1;
         var _loc2_:int = this._messages[_loc1_].height;
         var _loc3_:int = this._topMessageIndex;
         while(_loc3_ < _loc1_)
         {
            this._messages[_loc3_].y -= _loc2_;
            _loc3_++;
         }
      }
      
      private function showNextVisibleMessages() : void
      {
         var _loc1_:Boolean = this._maxVisibleMessages - this._bottomMessageIndex <= 0;
         if(this._isFullVisibleMessagesInHistoryStack && _loc1_)
         {
            ++this._topMessageIndex;
            this.hideMessageByIndex(this._topMessageIndex - 1,true);
            this._messages[this._topMessageIndex].setState(!!this._isTopMessageVisible ? int(BattleMessage.VISIBLE_WHEEL_MES) : int(BattleMessage.HIDEHALF_MES));
         }
         ++this._bottomMessageIndex;
         this.updateHistoryButtons();
         this.moveUpMessages();
         this.showMessageByIndex(this._bottomMessageIndex - 1,true,true);
         this._hoverYPosition = this.backgroundLayer.y;
         this.fillBG();
      }
      
      private function showMessageByIndex(param1:int, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:BattleMessage = this._messages[param1];
         _loc4_.setState(BattleMessage.VISIBLE_WHEEL_MES);
         if(param2)
         {
            this._hoverHeight += _loc4_.height;
         }
         if(param3)
         {
            this._hoverWidth = Math.max(this._hoverWidth,_loc4_.width);
         }
      }
      
      private function hideMessageByIndex(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:BattleMessage = this._messages[param1];
         _loc3_.setState(BattleMessage.HIDDEN_MES);
         if(param2)
         {
            this._hoverHeight -= _loc3_.height;
         }
      }
      
      private function showLastIndexMessages() : void
      {
         var _loc3_:int = 0;
         var _loc7_:BattleMessage = null;
         var _loc1_:int = this._defaultWidth;
         var _loc2_:int = 0;
         var _loc4_:Boolean = !(this._isFocused || this._isActive || this._isCtrlButtonPressed);
         var _loc5_:int = this._messages.length;
         var _loc6_:int = this._isFocused || this._isCtrlButtonPressed ? int(BattleMessage.VISIBLE_MES) : int(BattleMessage.RECOVERED_MES);
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            this._messages[_loc3_].setState(BattleMessage.HIDDEN_MES);
            _loc3_++;
         }
         this._bottomMessageIndex = _loc5_;
         if(this._isFullVisibleMessagesInHistoryStack)
         {
            this._topMessageIndex = this._bottomMessageIndex - this._maxVisibleMessages;
         }
         this.updateHistoryButtons();
         _loc3_ = this._bottomMessageIndex - 1;
         while(_loc3_ >= this._topMessageIndex)
         {
            _loc7_ = this._messages[_loc3_];
            _loc2_ -= _loc7_.height;
            _loc7_.y = _loc2_;
            _loc7_.clear();
            _loc7_.setState(_loc6_);
            _loc7_.hidingState = _loc4_;
            _loc1_ = Math.max(_loc1_,_loc7_.width);
            _loc3_--;
         }
         this._hoverWidth = _loc1_;
         this._hoverHeight = -_loc2_;
         this._hoverYPosition = this.backgroundLayer.y;
         this._hoverState = _loc6_;
         this.fillBG();
         if(!this._isTopMessageVisible && this._isFocused)
         {
            this._messages[this._topMessageIndex].setState(BattleMessage.HIDEHALF_MES);
         }
      }
      
      private function updateHistoryButtons() : void
      {
         this._isTopMessageVisible = this._topMessageIndex == 0;
         if(this._bottomMessageIndex > this._messages.length)
         {
            this._bottomMessageIndex = this._messages.length;
         }
         this._isBottomMessageVisible = this._bottomMessageIndex == this._messages.length;
         if(this._isHistoryEnabled)
         {
            this.historyUpBtn.enabled = !this._isTopMessageVisible;
            this.historyDownBtn.enabled = this._bottomMessageIndex < this._messages.length;
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
            this.messageInputField.addEventListener(KeyboardEvent.KEY_DOWN,this.onMessageInputFieldKeyDownHandler);
            this.messageInputField.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
            this.messageInputField.addEventListener(InputEvent.INPUT,this.onMessageInputFieldInputHandler);
            App.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
            this.messageInputField.selectable = true;
            this.messageInputField.mouseEnabled = true;
            this.messageInputField.type = TextFieldType.INPUT;
         }
      }
      
      private function disableInput() : void
      {
         this.messageInputField.removeEventListener(KeyboardEvent.KEY_DOWN,this.onMessageInputFieldKeyDownHandler);
         this.messageInputField.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         this.messageInputField.removeEventListener(InputEvent.INPUT,this.onMessageInputFieldInputHandler);
         App.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUpHandler);
         this.messageInputField.selectable = false;
         this.messageInputField.mouseEnabled = false;
         this.messageInputField.type = TextFieldType.DYNAMIC;
      }
      
      private function showMessage(param1:String, param2:BattleMessengerPool, param3:String = "") : void
      {
         var _loc5_:BattleMessage = null;
         if(this._isFullMessagesStack)
         {
            _loc5_ = this._messages.shift();
            _loc5_.close();
            this.backgroundLayer.removeChild(_loc5_.background);
            removeChild(_loc5_.messageField);
         }
         var _loc4_:BattleMessage = param2.createItem(this.userInteraction);
         _loc4_.messageID = param3;
         _loc4_.setAvailableWidth(this._availableWidth);
         _loc4_.setMessageData(param1);
         this.pushMessage(_loc4_);
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
      
      public function set isSmallState(param1:Boolean) : void
      {
         this._isSmallState = param1;
      }
      
      public function get isEnterButtonPressed() : Boolean
      {
         return this._isEnterButtonPressed;
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
         this.switchSwapArea(true);
      }
      
      private function onMessengerRollOutHandler(param1:MouseEvent) : void
      {
         this._isToxicOver = false;
      }
      
      private function onMessengerRollOverHandler(param1:MouseEvent) : void
      {
         this._isToxicOver = true;
      }
      
      private function onStageMouseWheelHandler(param1:MouseEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1)
         {
            _loc2_ = param1.stageX / stage.scaleX;
            _loc3_ = param1.stageY / stage.scaleY;
            if(param1.target != App.stage && this.hitTestPoint(_loc2_,_loc3_,false) && !App.contextMenuMgr.isShown())
            {
               this.onBackgroundLayerWheelHandler(param1);
               return;
            }
         }
         if(this._isEnterButtonPressed)
         {
            this.hideViewElements();
            this._isEnterButtonPressed = false;
         }
      }
      
      private function onBackgroundLayerWheelHandler(param1:MouseEvent) : void
      {
         if(param1.delta > 0)
         {
            if(this.historyUpBtn.enabled)
            {
               this.showPrevVisibleMessages();
               this.hideToxicPanel();
            }
         }
         else if(this.historyDownBtn.enabled)
         {
            this.showNextVisibleMessages();
            this.hideToxicPanel();
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(this._tooltipStr);
      }
      
      private function onMessageInputFieldKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = param1.keyCode;
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
         else
         {
            this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
            this._selectionEndIndex = this.messageInputField.selectionEndIndex;
         }
      }
      
      private function onMessageInputFieldInputHandler(param1:InputEvent) : void
      {
         param1.handled = true;
      }
      
      private function onKeyUpHandler(param1:KeyboardEvent) : void
      {
         var _loc2_:int = param1.keyCode;
         if(_loc2_ == Keyboard.UP || _loc2_ == Keyboard.DOWN || _loc2_ == Keyboard.PAGE_DOWN)
         {
            dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
            this.messageInputField.setSelection(this._selectionBeginIndex,this._selectionEndIndex);
         }
         else
         {
            this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
            this._selectionEndIndex = this.messageInputField.selectionEndIndex;
         }
      }
      
      private function onBattleMessengerMouseClickHandler(param1:MouseEvent) : void
      {
         if(param1 is MouseEventEx)
         {
            if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
            {
               this.showViewElements(true);
               this._selectionBeginIndex = this.messageInputField.selectionBeginIndex;
               this._selectionEndIndex = this.messageInputField.selectionEndIndex;
            }
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
            if(param1.target == App.stage || !this.hitTestPoint(_loc2_,_loc3_,false) && !App.utils.IME.getContainer().hitTestPoint(_loc2_,_loc3_,false))
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
