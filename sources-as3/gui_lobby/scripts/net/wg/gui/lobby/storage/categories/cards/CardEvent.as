package net.wg.gui.lobby.storage.categories.cards
{
   import flash.events.Event;
   
   public class CardEvent extends Event
   {
      
      public static const SELECT:String = "select";
      
      public static const DESELECT:String = "deselect";
      
      public static const SELL:String = "sell";
      
      public static const PREVIEW:String = "preview";
      
      public static const REMOVE:String = "remove";
      
      public static const UPGRADE:String = "upgrade";
      
      public static const SHOW_CONTEXT_MENU:String = "showContextMenu";
      
      public static const PLAY_INFO_SOUND:String = "playInfoSound";
       
      
      private var _data:BaseCardVO;
      
      public function CardEvent(param1:String, param2:BaseCardVO = null)
      {
         super(param1,true,false);
         this._data = param2;
      }
      
      override public function clone() : Event
      {
         return new CardEvent(type,this.data);
      }
      
      public function get data() : BaseCardVO
      {
         return this._data;
      }
   }
}
