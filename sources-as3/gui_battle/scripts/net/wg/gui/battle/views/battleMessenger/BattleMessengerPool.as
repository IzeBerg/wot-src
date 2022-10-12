package net.wg.gui.battle.views.battleMessenger
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleMessengerPool implements IDisposable
   {
       
      
      private var _items:Vector.<BattleMessage> = null;
      
      private var _numAvailableItems:int = -1;
      
      private var _isUnlimitedMessageStack:Boolean = false;
      
      private var _lifeTime:int = -1;
      
      private var _alphaSpeed:int = -1;
      
      private var _lastMessageAlpha:Number = -1;
      
      private var _recoveredLatestMessagesAlpha:Number = -1;
      
      private var _recoveredMessagesLifeTime:int = -1;
      
      private var _renderer:String = "";
      
      private var _battleSmileyMap:BattleSmileyMap = null;
      
      private var _disposed:Boolean = false;
      
      private var _messagesAvailableWidth:int;
      
      public function BattleMessengerPool(param1:int, param2:int, param3:int, param4:Number, param5:Number, param6:int, param7:String, param8:BattleSmileyMap, param9:Function = null)
      {
         var _loc10_:BattleMessage = null;
         var _loc11_:int = 0;
         this._messagesAvailableWidth = BattleMessage.DEFAULT_TEXT_WIDTH;
         super();
         this._lifeTime = param2;
         this._alphaSpeed = param3;
         this._lastMessageAlpha = param4;
         this._recoveredLatestMessagesAlpha = param5;
         this._recoveredMessagesLifeTime = param6;
         this._renderer = param7;
         this._isUnlimitedMessageStack = param1 == -1;
         this._battleSmileyMap = param8;
         if(this._isUnlimitedMessageStack)
         {
            this._items = new Vector.<BattleMessage>();
         }
         else
         {
            this._items = new Vector.<BattleMessage>(param1,true);
            this._numAvailableItems = param1;
            _loc11_ = 0;
            while(_loc11_ < param1)
            {
               _loc10_ = new BattleMessage(this._lifeTime,this._alphaSpeed,this._lastMessageAlpha,this._recoveredLatestMessagesAlpha,this._recoveredMessagesLifeTime,this.deleteItem,param9,this._messagesAvailableWidth);
               _loc10_.setRenderer(this._renderer);
               this._battleSmileyMap.mapText(_loc10_.messageField);
               this._items[_loc11_] = _loc10_;
               _loc11_++;
            }
         }
      }
      
      public function createItem(param1:Function) : BattleMessage
      {
         var _loc2_:BattleMessage = null;
         if(this._isUnlimitedMessageStack)
         {
            _loc2_ = new BattleMessage(this._lifeTime,this._alphaSpeed,this._lastMessageAlpha,this._recoveredLatestMessagesAlpha,this._recoveredMessagesLifeTime,this.deleteItem,param1,this._messagesAvailableWidth);
            _loc2_.setRenderer(this._renderer);
            this._battleSmileyMap.mapText(_loc2_.messageField);
            this._items.push(_loc2_);
            return _loc2_;
         }
         if(this._numAvailableItems > 0)
         {
            return this._items[--this._numAvailableItems];
         }
         return null;
      }
      
      public function deleteItem(param1:BattleMessage) : Boolean
      {
         var _loc2_:int = this._items.indexOf(param1);
         if(_loc2_ < 0)
         {
            return false;
         }
         var _loc3_:BattleMessage = this._items[this._numAvailableItems];
         var _loc4_:* = this._numAvailableItems++;
         this._items[_loc4_] = param1;
         this._items[_loc2_] = _loc3_;
         return true;
      }
      
      public function setAvailableWidth(param1:int) : void
      {
         var _loc2_:BattleMessage = null;
         this._messagesAvailableWidth = param1;
         for each(_loc2_ in this._items)
         {
            _loc2_.setAvailableWidth(this._messagesAvailableWidth);
         }
      }
      
      public final function dispose() : void
      {
         var _loc1_:BattleMessage = null;
         this._disposed = true;
         for each(_loc1_ in this._items)
         {
            _loc1_.dispose();
         }
         this._items.fixed = false;
         this._items.splice(0,this._items.length);
         this._items = null;
         this._battleSmileyMap = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
