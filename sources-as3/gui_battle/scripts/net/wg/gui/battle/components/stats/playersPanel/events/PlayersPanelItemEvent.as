package net.wg.gui.battle.components.stats.playersPanel.events
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.gui.battle.components.stats.playersPanel.interfaces.IPlayersPanelListItem;
   
   public class PlayersPanelItemEvent extends Event
   {
      
      public static const ON_ITEM_OVER:String = "onPlayersPanelItemOver";
      
      public static const ON_ITEM_OUT:String = "onPlayersPanelItemOut";
      
      public static const ON_ITEM_CLICK:String = "onPlayersPanelItemClick";
       
      
      public var playersListItem:IPlayersPanelListItem = null;
      
      public var holderItemID:Number = -1;
      
      public var mEvent:MouseEvent = null;
      
      public function PlayersPanelItemEvent(param1:String, param2:IPlayersPanelListItem, param3:Number, param4:MouseEvent, param5:Boolean = false, param6:Boolean = false)
      {
         this.playersListItem = param2;
         this.holderItemID = param3;
         this.mEvent = param4;
         super(param1,param5,param6);
      }
      
      override public function clone() : Event
      {
         return new PlayersPanelItemEvent(type,this.playersListItem,this.holderItemID,this.mEvent,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("PlayersPanelItemEvent","type","playersListItem","holderItemID","mEvent","bubbles","cancelable");
      }
   }
}
