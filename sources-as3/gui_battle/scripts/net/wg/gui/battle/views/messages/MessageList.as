package net.wg.gui.battle.views.messages
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.generated.BATTLE_MESSAGES_CONSTS;
   import net.wg.gui.battle.views.messages.VO.MessageListSettingsVO;
   import net.wg.gui.battle.views.messages.events.MessageEvent;
   import net.wg.gui.battle.views.messages.interfaces.IMessageList;
   
   public class MessageList extends EventDispatcher implements IMessageList
   {
      
      private static const DEF_MESSAGE_GAP:Number = 5;
       
      
      protected var messages:Vector.<IMessage>;
      
      protected var direction:String = "up";
      
      protected var messageGap:Number = 5.0;
      
      private var _x:Number;
      
      private var _y:Number;
      
      private var _disposed:Boolean = false;
      
      private var _container:DisplayObjectContainer;
      
      private var _visible:Boolean = true;
      
      public function MessageList(param1:DisplayObjectContainer = null)
      {
         super();
         this.container = param1;
         this.messages = new Vector.<IMessage>();
      }
      
      public function clearMessages() : void
      {
         var _loc1_:IMessage = null;
         for each(_loc1_ in this.messages)
         {
            this.clearMessage(_loc1_);
            _loc1_.close();
         }
         this.messages.splice(0,this.messages.length);
      }
      
      public function closeOldestMessage() : void
      {
         if(this.messages.length > 0)
         {
            this.messages[0].close();
         }
      }
      
      public final function dispose() : void
      {
         if(this._disposed && App.instance)
         {
            App.utils.asserter.assert(false,"(" + getQualifiedClassName(this) + ") already disposed!");
         }
         this.onDispose();
         this._disposed = true;
      }
      
      public function isNowShowed(param1:String) : Boolean
      {
         var _loc2_:IMessage = null;
         for each(_loc2_ in this.messages)
         {
            if(_loc2_.key == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isOnStage() : Boolean
      {
         return this._container != null ? Boolean(this._container.stage != null) : Boolean(false);
      }
      
      public function pushMessage(param1:IMessage) : void
      {
         this.pushMessageIntoQueue(param1);
         this.startMessageShowing(param1);
      }
      
      protected function pushMessageIntoQueue(param1:IMessage) : void
      {
         this.messages.push(param1);
         param1.addEventListener(Event.CLOSE,this.onMessageCloseHandler);
      }
      
      protected function startMessageShowing(param1:IMessage) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc2_:Vector.<DisplayObject> = param1.getDisplayObjects();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_ != null)
            {
               this._container.addChild(_loc3_);
            }
         }
         param1.show();
         this.rearrangeMessages();
         this.setMessageVisibility(param1);
      }
      
      public function setLocation(param1:Number, param2:Number) : void
      {
         this._x = param1;
         this._y = param2;
         this.rearrangeMessages();
      }
      
      public function setup(param1:MessageListSettingsVO) : void
      {
         this.direction = param1.direction;
         this.messageGap = param1.messageGap;
      }
      
      protected function onDispose() : void
      {
         this.clearMessages();
         this.messages = null;
         this.disposeContainer();
         this._container = null;
      }
      
      protected function rearrangeMessages() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc4_:IMessage = null;
         var _loc5_:Number = NaN;
         var _loc1_:int = this.messages.length - 1;
         if(_loc1_ >= 0)
         {
            _loc2_ = this.direction == BATTLE_MESSAGES_CONSTS.LIST_DIRECTION_DOWN;
            _loc3_ = this.messageGap + this.messages[0].height;
            if(!_loc2_)
            {
               _loc3_ = -_loc3_;
            }
            _loc5_ = this._y;
            while(_loc1_ >= 0)
            {
               _loc4_ = this.messages[_loc1_];
               _loc4_.x = this._x;
               _loc4_.y = _loc5_ | 0;
               _loc5_ += _loc3_;
               _loc1_--;
            }
         }
      }
      
      protected function onMessageClose(param1:IMessage) : void
      {
         var _loc2_:int = this.messages.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.messages.splice(_loc2_,1);
            this.clearMessage(param1);
         }
         else
         {
            App.utils.asserter.assert(false,"Deleted message index must be >= 0");
         }
      }
      
      private function clearMessage(param1:IMessage) : void
      {
         var _loc3_:DisplayObject = null;
         var _loc4_:int = 0;
         param1.removeEventListener(Event.CLOSE,this.onMessageCloseHandler);
         var _loc2_:Vector.<DisplayObject> = param1.getDisplayObjects();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_)
            {
               _loc4_ = this._container.getChildIndex(_loc3_);
               if(_loc4_ != -1)
               {
                  this._container.removeChildAt(_loc4_);
               }
            }
         }
      }
      
      private function disposeContainer() : void
      {
         if(this._container != null)
         {
            this._container.removeEventListener(Event.ADDED_TO_STAGE,this.onContainerAddedToStageHandler);
         }
      }
      
      public function get length() : int
      {
         return this.messages.length;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function get container() : DisplayObjectContainer
      {
         return this._container;
      }
      
      public function set container(param1:DisplayObjectContainer) : void
      {
         this.disposeContainer();
         this._container = param1;
         if(this._container != null)
         {
            if(this._container.stage != null)
            {
               dispatchEvent(new Event(Event.ADDED_TO_STAGE));
            }
            else
            {
               this._container.addEventListener(Event.ADDED_TO_STAGE,this.onContainerAddedToStageHandler);
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      private function onMessageCloseHandler(param1:MessageEvent) : void
      {
         this.onMessageClose(param1.message);
      }
      
      private function onContainerAddedToStageHandler(param1:Event) : void
      {
         this._container.removeEventListener(Event.ADDED_TO_STAGE,this.onContainerAddedToStageHandler);
         dispatchEvent(new Event(Event.ADDED_TO_STAGE));
      }
      
      private function setMessageVisibility(param1:IMessage) : void
      {
         var _loc2_:Vector.<DisplayObject> = param1.getDisplayObjects();
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_])
            {
               _loc2_[_loc4_].visible = this._visible;
            }
            _loc4_++;
         }
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this._visible = param1;
         var _loc2_:int = this.messages.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            this.setMessageVisibility(this.messages[_loc3_]);
            _loc3_++;
         }
      }
      
      public function setCompVisible(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      public function isCompVisible() : Boolean
      {
         return this.visible;
      }
   }
}
