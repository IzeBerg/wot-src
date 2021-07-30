package net.wg.gui.battle.views.gameMessagesPanel
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.GAME_MESSAGES_CONSTS;
   import net.wg.gui.battle.views.gameMessagesPanel.components.EndGameMessage;
   import net.wg.gui.battle.views.gameMessagesPanel.components.MessageContainerBase;
   import net.wg.gui.battle.views.gameMessagesPanel.data.GameMessageVO;
   import net.wg.gui.battle.views.gameMessagesPanel.events.GameMessagesPanelEvent;
   import net.wg.infrastructure.base.meta.IGameMessagesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.GameMessagesPanelMeta;
   import net.wg.utils.IScheduler;
   
   public class GameMessagesPanel extends GameMessagesPanelMeta implements IGameMessagesPanelMeta
   {
      
      private static const INTRO:String = "intro";
      
      private static const OUTRO:String = "outro";
      
      private static const DELAYED_REMOVAL_TIME:int = 2000;
       
      
      public var messagesContainer:MovieClip = null;
      
      protected var msgLinkageTypeDict:Dictionary = null;
      
      protected var msgClassTypeDict:Dictionary = null;
      
      private var _messagesStack:Vector.<GameMessageVO> = null;
      
      private var _activeMessages:Vector.<MessageContainerBase> = null;
      
      private var _scheduler:IScheduler;
      
      private var _isPlayingMessages:Boolean = false;
      
      private var _enablePlaying:Boolean = true;
      
      public function GameMessagesPanel()
      {
         this._scheduler = App.utils.scheduler;
         super();
         this._messagesStack = new Vector.<GameMessageVO>(0);
         this._activeMessages = new Vector.<MessageContainerBase>(0);
         this.initMappingDict();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(GameMessagesPanelEvent.MESSAGES_POST_INTRO_PLAYING,this.onMessagesPlayingHandler);
         addEventListener(GameMessagesPanelEvent.MESSAGES_OUTRO_PLAYING,this.onMessagesPlayingHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(GameMessagesPanelEvent.MESSAGES_POST_INTRO_PLAYING,this.onMessagesPlayingHandler);
         removeEventListener(GameMessagesPanelEvent.MESSAGES_OUTRO_PLAYING,this.onMessagesPlayingHandler);
         this._scheduler.cancelTask(this.onOutroTaskComplete);
         this._scheduler.cancelTask(this.onMessageTaskComplete);
         this._scheduler.cancelTask(this.removeMessageFromContainer);
         this._scheduler = null;
         this.removeActiveMessages();
         this._activeMessages = null;
         this.messagesContainer = null;
         this.removeStackMessages();
         this._messagesStack = null;
         App.utils.data.cleanupDynamicObject(this.msgLinkageTypeDict);
         this.msgLinkageTypeDict = null;
         App.utils.data.cleanupDynamicObject(this.msgClassTypeDict);
         this.msgClassTypeDict = null;
         super.onDispose();
      }
      
      override protected function addMessage(param1:GameMessageVO) : void
      {
         var _loc2_:GameMessageVO = new GameMessageVO(param1.toHash());
         if(!this._isPlayingMessages && this._enablePlaying)
         {
            this._messagesStack.push(_loc2_);
            this.playFromStack();
            this._enablePlaying = _loc2_.priority != GAME_MESSAGES_CONSTS.GAME_MESSAGE_PRIORITY_END_GAME;
         }
         else if(this._enablePlaying)
         {
            if(_loc2_.priority == GAME_MESSAGES_CONSTS.GAME_MESSAGE_PRIORITY_END_GAME)
            {
               this._messagesStack.splice(0,this._messagesStack.length);
               this._messagesStack.push(_loc2_);
               this.playNextFromStack();
               this._enablePlaying = false;
            }
            else if(_loc2_.priority == GAME_MESSAGES_CONSTS.GAME_MESSAGE_PRIORITY_HIGH)
            {
               this._messagesStack.unshift(_loc2_);
               this.playNextFromStack();
            }
            else
            {
               this._messagesStack.push(_loc2_);
            }
         }
      }
      
      public function as_clearMessages() : void
      {
         this._enablePlaying = true;
         this._isPlayingMessages = false;
         this._scheduler.cancelTask(this.onOutroTaskComplete);
         this._scheduler.cancelTask(this.onMessageTaskComplete);
         this._scheduler.cancelTask(this.removeMessageFromContainer);
         this.removeActiveMessages();
         this.removeStackMessages();
      }
      
      protected function initMappingDict() : void
      {
         this.msgLinkageTypeDict = new Dictionary();
         this.msgLinkageTypeDict[GAME_MESSAGES_CONSTS.WIN] = Linkages.WIN_UI_LINKAGE;
         this.msgLinkageTypeDict[GAME_MESSAGES_CONSTS.DEFEAT] = Linkages.DEFEAT_UI_LINKAGE;
         this.msgLinkageTypeDict[GAME_MESSAGES_CONSTS.DRAW] = Linkages.DRAW_UI_LINKAGE;
         this.msgClassTypeDict = new Dictionary();
         this.msgClassTypeDict[GAME_MESSAGES_CONSTS.WIN] = EndGameMessage;
         this.msgClassTypeDict[GAME_MESSAGES_CONSTS.DEFEAT] = EndGameMessage;
         this.msgClassTypeDict[GAME_MESSAGES_CONSTS.DRAW] = EndGameMessage;
      }
      
      protected function layoutMessage(param1:MessageContainerBase) : void
      {
      }
      
      private function removeStackMessages() : void
      {
         var _loc1_:GameMessageVO = null;
         for each(_loc1_ in this._messagesStack)
         {
            _loc1_.dispose();
         }
         this._messagesStack.splice(0,this._messagesStack.length);
      }
      
      private function removeActiveMessages() : void
      {
         var _loc1_:MessageContainerBase = null;
         for each(_loc1_ in this._activeMessages)
         {
            _loc1_.stop();
            this.messagesContainer.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._activeMessages.splice(0,this._activeMessages.length);
      }
      
      private function onMessageTaskComplete() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:MessageContainerBase = this._activeMessages[0];
         if(_loc1_)
         {
            if(this._messagesStack.length > 0)
            {
               this.playNextFromStack();
            }
            else
            {
               if(this._activeMessages.length > 1)
               {
                  _loc2_ = this._activeMessages.length;
                  _loc3_ = 0;
                  while(_loc3_ < _loc2_)
                  {
                     this._activeMessages[_loc3_].stop();
                     this._activeMessages[_loc3_].dispose();
                     _loc3_++;
                  }
               }
               this._activeMessages.splice(0,this._activeMessages.length);
               onMessageHidingS(_loc1_.getType(),_loc1_.getID());
               _loc1_.gotoAndPlay(OUTRO);
               this._scheduler.scheduleTask(this.onOutroTaskComplete,DELAYED_REMOVAL_TIME,_loc1_);
               this._isPlayingMessages = false;
            }
         }
      }
      
      private function onOutroTaskComplete(param1:MessageContainerBase) : void
      {
         this.messagesContainer.removeChild(param1);
         var _loc2_:String = param1.getType();
         dispatchEvent(new GameMessagesPanelEvent(GameMessagesPanelEvent.MESSAGES_ENDED_PLAYING,_loc2_));
         onMessageEndedS(_loc2_,param1.getID());
         param1.stop();
         param1.dispose();
         param1 = null;
         if(this._activeMessages.length == 0)
         {
            dispatchEvent(new GameMessagesPanelEvent(GameMessagesPanelEvent.ALL_MESSAGES_ENDED_PLAYING,Values.EMPTY_STR));
         }
      }
      
      private function removeMessageFromContainer(param1:MessageContainerBase) : void
      {
         this.messagesContainer.removeChild(param1);
      }
      
      private function playFromStack() : void
      {
         var _loc2_:MessageContainerBase = null;
         var _loc1_:GameMessageVO = this._messagesStack.pop();
         if(_loc1_)
         {
            _loc2_ = App.utils.classFactory.getComponent(this.msgLinkageTypeDict[_loc1_.messageType],this.msgClassTypeDict[_loc1_.messageType]);
            _loc2_.setData(_loc1_);
            this.layoutMessage(_loc2_);
            this.messagesContainer.addChild(_loc2_);
            dispatchEvent(new GameMessagesPanelEvent(GameMessagesPanelEvent.MESSAGES_STARTED_PLAYING,_loc1_.messageType));
            this._activeMessages.push(_loc2_);
            onMessageStartedS(_loc1_.messageType,_loc2_.getModificator(),_loc2_.getID());
            _loc2_.gotoAndPlay(INTRO);
            if(!this._isPlayingMessages)
            {
               this._isPlayingMessages = true;
            }
            this._scheduler.scheduleTask(this.onMessageTaskComplete,_loc1_.duration);
         }
      }
      
      private function playNextFromStack() : void
      {
         var _loc1_:MessageContainerBase = null;
         if(this._isPlayingMessages && this._activeMessages.length > 0)
         {
            _loc1_ = this._activeMessages.pop();
            onMessageHidingS(_loc1_.getType(),_loc1_.getID());
            _loc1_.gotoAndPlay(OUTRO);
            this._scheduler.scheduleTask(this.onOutroTaskComplete,DELAYED_REMOVAL_TIME,_loc1_);
         }
         this.playFromStack();
      }
      
      private function onMessagesPlayingHandler(param1:GameMessagesPanelEvent) : void
      {
         onMessagePhaseStartedS(param1.messageType,param1.messageModificator,param1.messageId);
      }
   }
}
