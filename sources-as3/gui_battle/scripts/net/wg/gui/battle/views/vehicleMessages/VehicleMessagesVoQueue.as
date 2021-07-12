package net.wg.gui.battle.views.vehicleMessages
{
   import net.wg.gui.battle.views.vehicleMessages.vo.VehicleMessageVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleMessagesVoQueue implements IDisposable
   {
      
      private static const BASE_ITEMS_COUNT:int = 5;
      
      private static const EMPTY_STR:String = "";
       
      
      private var _pool:Vector.<VehicleMessageVO> = null;
      
      private var _items:Vector.<VehicleMessageVO> = null;
      
      public function VehicleMessagesVoQueue()
      {
         super();
         this._items = new Vector.<VehicleMessageVO>();
         this.fillPool();
      }
      
      private function fillPool() : void
      {
         this._pool = new Vector.<VehicleMessageVO>();
         var _loc1_:int = BASE_ITEMS_COUNT;
         while(_loc1_ > 0)
         {
            this._pool.push(new VehicleMessageVO(EMPTY_STR,EMPTY_STR,0));
            _loc1_--;
         }
      }
      
      public function addMessageData(param1:String, param2:String, param3:int) : void
      {
         var _loc4_:VehicleMessageVO = this._pool.shift();
         if(_loc4_)
         {
            _loc4_.update(param1,param2,param3);
         }
         else
         {
            _loc4_ = new VehicleMessageVO(param1,param2,param3);
         }
         this._items.push(_loc4_);
      }
      
      public function getNextMessage() : VehicleMessageVO
      {
         return this._items.length > 0 ? this._items[0] : null;
      }
      
      public function shiftNextMessage() : void
      {
         var _loc1_:VehicleMessageVO = this._items.shift();
         if(_loc1_)
         {
            this._pool.push(_loc1_);
         }
      }
      
      public final function dispose() : void
      {
         if(this._items)
         {
            this._items.splice(0,this._items.length);
            this._items = null;
         }
         if(this._pool)
         {
            this._pool.splice(0,this._pool.length);
            this._pool = null;
         }
      }
   }
}
