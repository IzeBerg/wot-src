package net.wg.gui.components.carousels.events
{
   import flash.events.Event;
   
   public class TankItemEvent extends Event
   {
      
      public static const SELECT_ITEM:String = "selectItemEvent";
      
      public static const SELECT_BUY_SLOT:String = "selectBuySlot";
      
      public static const SELECT_RESTORE_TANK:String = "selectRestoreTank";
      
      public static const SELECT_BUY_TANK:String = "selectBuyTank";
      
      public static const SELECT_RENT_PROMOTION_SLOT:String = "selectRentPromotion";
       
      
      private var _itemId:int = 0;
      
      public function TankItemEvent(param1:String, param2:uint, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._itemId = param2;
      }
      
      override public function clone() : Event
      {
         return new TankItemEvent(type,this._itemId,bubbles,cancelable);
      }
      
      public function get itemId() : uint
      {
         return this._itemId;
      }
   }
}
