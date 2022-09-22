package net.wg.gui.lobby.battleResults.event
{
   import flash.events.Event;
   
   public class TeamTableSortEvent extends Event
   {
      
      public static const TYPE:String = "TeamTableSortEvent";
       
      
      public var columnId:String;
      
      public var sortDirection:String;
      
      public var bonusType:Number;
      
      public function TeamTableSortEvent(param1:String, param2:String, param3:Number)
      {
         super(TYPE,true,true);
         this.columnId = param1;
         this.sortDirection = param2;
         this.bonusType = param3;
      }
   }
}
