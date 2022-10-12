package net.wg.gui.battle.views.battleMessenger.actionPanel
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
   import net.wg.gui.battle.components.buttons.BattleStateButton;
   import net.wg.gui.battle.components.buttons.btnConfig.BattleStateBtnSettings;
   import net.wg.gui.battle.components.buttons.interfaces.IClickButtonHandler;
   import net.wg.gui.battle.random.views.stats.components.playersPanel.VO.PlayersPanelContextMenuSentData;
   import net.wg.gui.battle.views.battleMessenger.VO.BattleMessengerToxicVO;
   import net.wg.gui.battle.views.battleMessenger.VO.ButtonToxicStatusVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IAtlasManager;
   import scaleform.clik.utils.Padding;
   
   public class BattleMessengerActionContainer extends Sprite implements IDisposable, IClickButtonHandler
   {
      
      private static const BG_PADDING_BY_Y:int = 5;
      
      private static const BLACK_LIST_BTN_X_POS:int = 1;
      
      private static const BLACK_LIST_BTN_Y_POS:int = 2;
      
      private static const BG_SHAPE_TOP_PADDING:int = -2;
      
      private static const BTN_STATE_NAME:String = "_blackListBtn";
       
      
      public var onClickButtonCallback:Function = null;
      
      public var onClosedCallback:Function = null;
      
      private var _bg:Sprite = null;
      
      private var _messageID:String = "";
      
      private var _callbackFunction:Function = null;
      
      private var _atlasManager:IAtlasManager;
      
      private var _blackListButton:BattleStateButton = null;
      
      private var _muteBtnImageMap:Dictionary;
      
      private var _blackListState:Number = -1;
      
      private var _vehicleID:Number = -1;
      
      private var _isShowContainer:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function BattleMessengerActionContainer()
      {
         this._atlasManager = App.atlasMgr;
         this._muteBtnImageMap = new Dictionary();
         super();
         this.addEventListener(MouseEvent.ROLL_OUT,this.onActionContainerRollOutHandler);
         this._bg = new Sprite();
         this._bg.graphics.beginFill(16711680);
         this._bg.graphics.drawRect(0,0,10,10);
         this._bg.graphics.endFill();
         this._bg.addEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this._bg.visible = false;
         this._bg.alpha = 0;
         this.addChild(this._bg);
         this.visible = false;
         this._muteBtnImageMap[BATTLE_MESSAGES_CONSTS.ADD_IN_BLACKLIST] = {
            "defaultState":[new BattleStateBtnSettings(BATTLEATLAS.BUTTON_TOXIC_CHAT_OFF_NORMAL)],
            "hoverState":[new BattleStateBtnSettings(BATTLEATLAS.BUTTON_TOXIC_CHAT_OFF_HOVER)],
            "disableState":[new BattleStateBtnSettings(BATTLEATLAS.BUTTON_TOXIC_CHAT_OFF_DISABLEL)]
         };
         this._muteBtnImageMap[BATTLE_MESSAGES_CONSTS.REMOVE_FROM_BLACKLIST] = {
            "defaultState":[new BattleStateBtnSettings(BATTLEATLAS.BUTTON_TOXIC_CHAT_ON_NORMAL)],
            "hoverState":[new BattleStateBtnSettings(BATTLEATLAS.BUTTON_TOXIC_CHAT_ON_HOVER)],
            "disableState":[new BattleStateBtnSettings(BATTLEATLAS.BUTTON_TOXIC_CHAT_ON_DISABLEL)]
         };
         this.buttonsConfig();
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.onClickButtonCallback = null;
         this.onClosedCallback = null;
         this._callbackFunction = null;
         this._bg.removeEventListener(MouseEvent.CLICK,this.onBgClickHandler);
         this._bg = null;
         this._atlasManager = null;
         this._blackListButton.dispose();
         this._blackListButton = null;
         this._muteBtnImageMap = null;
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onActionContainerRollOutHandler);
      }
      
      public function drawTestGraphics(param1:BattleMessengerToxicVO, param2:Boolean, param3:Function, param4:int, param5:int, param6:int) : void
      {
         if(this._isShowContainer)
         {
            this.hideElement();
         }
         this._isShowContainer = true;
         this._callbackFunction = param3;
         if(!param2)
         {
            this.hideElement();
            return;
         }
         if(!visible)
         {
            visible = true;
         }
         this.y = param4;
         if(!this._bg.visible)
         {
            this._bg.visible = true;
         }
         this._bg.x = 0;
         this._bg.y = BG_SHAPE_TOP_PADDING;
         this._bg.width = param5;
         this._bg.height = param6 + BG_PADDING_BY_Y;
         this._blackListButton.x = BLACK_LIST_BTN_X_POS;
         this._blackListButton.y = BLACK_LIST_BTN_Y_POS;
         this._messageID = param1.messageID;
         this._vehicleID = param1.vehicleID;
         this.updateStates(param1);
      }
      
      public function hide() : void
      {
         if(visible)
         {
            this.hideElement();
         }
      }
      
      public function onButtonClick(param1:Object) : void
      {
         var _loc2_:Number = -1;
         if(param1 == this._blackListButton)
         {
            _loc2_ = this._blackListState;
         }
         if(this.onClickButtonCallback != null)
         {
            this.onClickButtonCallback(this._messageID,_loc2_);
         }
      }
      
      public function syncBackground(param1:Number) : void
      {
         if(this._bg.width == param1)
         {
            return;
         }
         this._bg.width = param1;
      }
      
      public function syncUpdater(param1:String, param2:BattleMessengerToxicVO) : void
      {
         if(this._messageID != param1)
         {
            return;
         }
         this.updateStates(param2);
      }
      
      private function updateCenterPositionByHeight() : void
      {
         this._blackListButton.y = (this._bg.height - this._blackListButton.actualHeight >> 1) + BG_SHAPE_TOP_PADDING;
      }
      
      private function updateStates(param1:BattleMessengerToxicVO) : void
      {
         this._blackListState = this.updateBlackListButton(param1.blackList,this._blackListButton,this._muteBtnImageMap);
         this.updateCenterPositionByHeight();
      }
      
      private function updateBlackListButton(param1:ButtonToxicStatusVO, param2:BattleStateButton, param3:Dictionary) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:String = null;
         _loc4_ = param1.status;
         _loc5_ = param1.enabled;
         if(this._blackListState == _loc4_ && param2.enabled == _loc5_)
         {
            return this._blackListState;
         }
         _loc6_ = param1.tooltip;
         var _loc7_:Object = param3[_loc4_];
         param2.clearAllStates();
         param2.state = InteractiveStates.UP;
         param2.tooltipStr = _loc6_;
         param2.setUpOutState(_loc7_.defaultState);
         param2.setOverState(_loc7_.hoverState);
         param2.setDisableState(_loc7_.disableState);
         param2.isAllowedToShowToolTipOnDisabledState = true;
         var _loc8_:Padding = new Padding(2,2,2,1);
         param2.setHitArea(_loc8_);
         param2.enabled = _loc5_;
         return _loc4_;
      }
      
      private function buttonsConfig() : void
      {
         this._blackListButton = new BattleStateButton();
         this._blackListButton.name = BTN_STATE_NAME;
         this.setAtlasProperties(this._blackListButton);
         this._blackListButton.addClickCallBack(this);
         this._blackListButton.x = BLACK_LIST_BTN_X_POS;
      }
      
      private function setAtlasProperties(param1:BattleStateButton) : void
      {
         param1.atlasName = ATLAS_CONSTANTS.BATTLE_ATLAS;
         param1.atlasMgr = this._atlasManager;
         this.addChild(param1);
      }
      
      private function hideElement() : void
      {
         if(this._callbackFunction != null)
         {
            this.visible = false;
            this.onClosedCallback(this._messageID);
            this._vehicleID = -1;
            this._messageID = Values.EMPTY_STR;
            this._callbackFunction();
            this._isShowContainer = false;
         }
      }
      
      private function onBgClickHandler(param1:MouseEvent) : void
      {
         if(this._vehicleID != -1 && App.utils.commons.isRightButton(param1))
         {
            App.contextMenuMgr.show(BATTLE_CONTEXT_MENU_HANDLER_TYPE.PLAYERS_PANEL,this._bg,new PlayersPanelContextMenuSentData(this._vehicleID));
         }
      }
      
      private function onActionContainerRollOutHandler(param1:MouseEvent) : void
      {
         this.hideElement();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
