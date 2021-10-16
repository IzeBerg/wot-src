package net.wg.gui.battle.views.messages
{
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FadedMessagesPool implements IDisposable
   {
       
      
      private var _items:Vector.<FadedTextMessage>;
      
      private var _numAvailableItems:int;
      
      public function FadedMessagesPool(param1:FadingMessageListSettingsVO, param2:String)
      {
         var _loc4_:FadedTextMessage = null;
         var _loc5_:int = 0;
         super();
         var _loc3_:uint = param1.maxLinesCount;
         this._items = new Vector.<FadedTextMessage>(_loc3_,true);
         this._numAvailableItems = _loc3_;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = new FadedTextMessage(this,param1);
            _loc4_.setRenderer(param2);
            this._items[_loc5_] = _loc4_;
            _loc5_++;
         }
      }
      
      public function createItem() : FadedTextMessage
      {
         if(this._numAvailableItems > 0)
         {
            return this._items[this._numAvailableItems-- - 1];
         }
         return null;
      }
      
      public function deleteItem(param1:FadedTextMessage) : Boolean
      {
         var _loc2_:int = this._items.indexOf(param1);
         if(_loc2_ < 0)
         {
            return false;
         }
         var _loc3_:FadedTextMessage = this._items[this._numAvailableItems];
         var _loc4_:* = this._numAvailableItems++;
         this._items[_loc4_] = param1;
         this._items[_loc2_] = _loc3_;
         return true;
      }
      
      public final function dispose() : void
      {
         var _loc1_:int = this._items.length - 1;
         while(_loc1_ >= 0)
         {
            this._items[_loc1_].dispose();
            _loc1_--;
         }
         this._items.fixed = false;
         this._items.splice(0,this._items.length);
         this._items = null;
      }
      
      public function get numAvailableItems() : int
      {
         return this._numAvailableItems;
      }
      
      public function get capacity() : int
      {
         return this._items != null ? int(this._items.length) : int(0);
      }
   }
}
