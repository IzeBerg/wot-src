package net.wg.gui.battle.views.vehicleMessages
{
   import net.wg.gui.battle.views.messages.VO.FadingMessageListSettingsVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleMessagesPool implements IDisposable
   {
       
      
      private var _items:Vector.<VehicleMessage>;
      
      private var _itemsCount:int = 0;
      
      public function VehicleMessagesPool(param1:FadingMessageListSettingsVO, param2:String)
      {
         var _loc3_:VehicleMessage = null;
         var _loc4_:int = 0;
         super();
         this._itemsCount = param1.maxLinesCount;
         this._items = new Vector.<VehicleMessage>(this._itemsCount,true);
         _loc4_ = 0;
         while(_loc4_ < this._itemsCount)
         {
            _loc3_ = new VehicleMessage(param1);
            _loc3_.setRenderer(param2);
            this._items[_loc4_] = _loc3_;
            _loc4_++;
         }
      }
      
      public function createItem() : VehicleMessage
      {
         var _loc1_:VehicleMessage = null;
         for each(_loc1_ in this._items)
         {
            if(!_loc1_.used)
            {
               return _loc1_;
            }
         }
         return null;
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
         var _loc2_:VehicleMessage = null;
         var _loc1_:int = this._itemsCount;
         for each(_loc2_ in this._items)
         {
            _loc1_ -= int(_loc2_.used);
         }
         return _loc1_;
      }
      
      public function get capacity() : int
      {
         return this._itemsCount;
      }
      
      public function updateStage() : void
      {
         var _loc1_:VehicleMessage = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.updateStage();
         }
      }
   }
}
