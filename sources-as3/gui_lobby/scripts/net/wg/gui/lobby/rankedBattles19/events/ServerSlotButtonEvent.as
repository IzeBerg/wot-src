package net.wg.gui.lobby.rankedBattles19.events
{
   import flash.events.Event;
   
   public class ServerSlotButtonEvent extends Event
   {
      
      public static const SERVER_SLOT_BUTTON_RESIZE:String = "serverSlotButtonResize";
      
      public static const SERVER_SLOT_BUTTON_TEXT_RESIZE:String = "serverSlotButtonTextResize";
       
      
      private var _itemWidth:Number = 0;
      
      private var _itemHeight:Number = 0;
      
      public function ServerSlotButtonEvent(param1:String, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._itemWidth = param2;
         this._itemHeight = param3;
      }
      
      override public function clone() : Event
      {
         return new ServerSlotButtonEvent(type,this._itemWidth,this._itemHeight,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ServerSlotButtonEvent","type","itemWidth","itemHeight","bubbles");
      }
      
      public function get itemWidth() : Number
      {
         return this._itemWidth;
      }
      
      public function get itemHeight() : Number
      {
         return this._itemHeight;
      }
   }
}
