package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBoardsDetailsContainerVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var linkage:String = "";
      
      public var bgWidth:int = -1;
      
      public var bgHeight:int = -1;
      
      public function EventBoardsDetailsContainerVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
