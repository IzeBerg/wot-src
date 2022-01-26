package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBoardsTableViewHeaderVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var icon:String = "";
      
      public var name:String = "";
      
      public var level:String = "";
      
      public var status:String = "";
      
      public var statusTooltip:String = "";
      
      public var popoverAlias:String = "";
      
      public function EventBoardsTableViewHeaderVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
