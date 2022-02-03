package net.wg.gui.battle.views.messages
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.gui.battle.views.messages.VO.PoolSettingsVO;
   import net.wg.infrastructure.base.meta.IBattleMessageListMeta;
   import net.wg.infrastructure.base.meta.impl.BattleMessageListMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import org.idmedia.as3commons.lang.Exception;
   
   public class MessageListDAAPI extends BattleMessageListMeta implements IBattleMessageListMeta, IDAAPIModule
   {
      
      private static const POOL_COLOR_ERROR:String = "Can\'t find pool for color: ";
       
      
      protected var isShowUniqueOnly:Boolean;
      
      protected var maxMessages:uint = 3;
      
      private var _isDAAPIInited:Boolean = false;
      
      private var _yellowMessagesPool:FadedMessagesPool;
      
      private var _redMessagesPool:FadedMessagesPool;
      
      private var _purpleMessagesPool:FadedMessagesPool;
      
      private var _greenMessagesPool:FadedMessagesPool;
      
      private var _goldMessagesPool:FadedMessagesPool;
      
      private var _selfMessagesPool:FadedMessagesPool;
      
      public function MessageListDAAPI(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
         super.onDispose();
         if(this._yellowMessagesPool != null)
         {
            this._yellowMessagesPool.dispose();
         }
         if(this._redMessagesPool != null)
         {
            this._redMessagesPool.dispose();
         }
         if(this._purpleMessagesPool != null)
         {
            this._purpleMessagesPool.dispose();
         }
         if(this._greenMessagesPool != null)
         {
            this._greenMessagesPool.dispose();
         }
         if(this._goldMessagesPool != null)
         {
            this._goldMessagesPool.dispose();
         }
         if(this._selfMessagesPool != null)
         {
            this._selfMessagesPool.dispose();
         }
         this._yellowMessagesPool = null;
         this._redMessagesPool = null;
         this._purpleMessagesPool = null;
         this._greenMessagesPool = null;
         this._goldMessagesPool = null;
         this._selfMessagesPool = null;
      }
      
      override protected function setupList(param1:FadingMessageListSettingsVO) : void
      {
         var _loc2_:String = null;
         var _loc4_:PoolSettingsVO = null;
         var _loc5_:FadedMessagesPool = null;
         setup(param1);
         this.maxMessages = param1.maxLinesCount;
         this.isShowUniqueOnly = param1.showUniqueOnly;
         var _loc3_:Vector.<PoolSettingsVO> = param1.poolSettings;
         var _loc6_:int = 0;
         var _loc7_:* = _loc3_;
         while(true)
         {
            for each(_loc4_ in _loc7_)
            {
               _loc2_ = _loc4_.colorType;
               _loc5_ = new FadedMessagesPool(param1,_loc4_.renderer);
               switch(_loc2_)
               {
                  case BATTLE_MESSAGES_CONSTS.COLOR_YELLOW:
                     this._yellowMessagesPool = _loc5_;
                     break;
                  case BATTLE_MESSAGES_CONSTS.COLOR_RED:
                     this._redMessagesPool = _loc5_;
                     break;
                  case BATTLE_MESSAGES_CONSTS.COLOR_PURPLE:
                     this._purpleMessagesPool = _loc5_;
                     break;
                  case BATTLE_MESSAGES_CONSTS.COLOR_GREEN:
                     this._greenMessagesPool = _loc5_;
                     break;
                  case BATTLE_MESSAGES_CONSTS.COLOR_GOLD:
                     this._goldMessagesPool = _loc5_;
                     break;
                  case BATTLE_MESSAGES_CONSTS.COLOR_SELF:
                     this._selfMessagesPool = _loc5_;
                     break;
               }
            }
            return;
         }
         throw new Exception(POOL_COLOR_ERROR + _loc2_);
      }
      
      override protected function onMessageClose(param1:IMessage) : void
      {
         super.onMessageClose(param1);
         param1.deleteFromPool();
      }
      
      public function as_clear() : void
      {
         clearMessages();
      }
      
      public final function as_dispose() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
         dispose();
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
      }
      
      public function as_isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      public final function as_populate() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
         this.onPopulate();
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
      }
      
      public function as_refresh() : void
      {
         if(isOnStage())
         {
            onRefreshCompleteS();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
         }
      }
      
      public function as_showGoldMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,param2,this._goldMessagesPool);
      }
      
      public function as_showGreenMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,param2,this._greenMessagesPool);
      }
      
      public function as_showPurpleMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,param2,this._purpleMessagesPool);
      }
      
      public function as_showRedMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,param2,this._redMessagesPool);
      }
      
      public function as_showSelfMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,param2,this._selfMessagesPool);
      }
      
      public function as_showYellowMessage(param1:String, param2:String) : void
      {
         this.showMessage(param1,param2,this._yellowMessagesPool);
      }
      
      protected function onPopulate() : void
      {
         this._isDAAPIInited = true;
      }
      
      protected function showMessage(param1:String, param2:String, param3:FadedMessagesPool) : void
      {
         if(this.isShowUniqueOnly && isNowShowed(param1))
         {
            return;
         }
         if(length >= this.maxMessages)
         {
            closeOldestMessage();
         }
         var _loc4_:FadedTextMessage = param3.createItem();
         _loc4_.setData(param1,param2);
         pushMessage(_loc4_);
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      private function onAddedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler);
         onRefreshCompleteS();
      }
   }
}
