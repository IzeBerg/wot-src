package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBoardsBattleOverlayVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var description:String = "";
      
      public var description2:String = "";
      
      public var status:String = "";
      
      public var isTable:Boolean = true;
      
      public var isSquad:Boolean = true;
      
      public var statusTooltip:String = "";
      
      public function EventBoardsBattleOverlayVO(param1:Object)
      {
         super(param1);
      }
   }
}
