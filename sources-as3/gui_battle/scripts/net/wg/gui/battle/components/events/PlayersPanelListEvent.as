package net.wg.gui.battle.components.events
{
   import flash.events.Event;
   
   public class PlayersPanelListEvent extends Event
   {
      
      public static const ITEM_SELECTED:String = "itemSelected";
      
      public static const ITEM_CONTEXT_MENU_OPEN:String = "itemContextMenuOpen";
      
      public static const ITEMS_COUNT_CHANGE:String = "itemsCountChange";
      
      public static const ITEMS_GROUP_MOUSE_OVER_CHANGED:String = "itemsGroupMouseOverChanged";
      
      public static const ITEMS_GROUP_CHANGED:String = "itemsGroupChanged";
       
      
      public var vehicleID:Number;
      
      public var group:int;
      
      public function PlayersPanelListEvent(param1:String, param2:Number, param3:Number = 0, param4:Boolean = false, param5:Boolean = false)
      {
         this.vehicleID = param2;
         this.group = param3;
         super(param1,param4,param5);
      }
      
      override public function clone() : Event
      {
         return new PlayersPanelListEvent(type,this.vehicleID,this.group,bubbles,cancelable);
      }
   }
}
