package net.wg.gui.components.carousels.events
{
   import flash.events.Event;
   
   public class FiltersTileListEvent extends Event
   {
      
      public static const ITEM_CLICK:String = "itemClick";
       
      
      private var _groupId:int = 0;
      
      private var _itemId:int = 0;
      
      public function FiltersTileListEvent(param1:String, param2:uint, param3:uint, param4:Boolean = true, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._groupId = param2;
         this._itemId = param3;
      }
      
      override public function clone() : Event
      {
         return new FiltersTileListEvent(type,this._groupId,this._itemId,bubbles,cancelable);
      }
      
      public function get groupId() : int
      {
         return this._groupId;
      }
      
      public function get itemId() : uint
      {
         return this._itemId;
      }
   }
}
