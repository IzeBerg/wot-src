package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.gui.lobby.missions.data.MissionCardViewVO;
   
   public class MissionEventBoardsCardVO extends MissionCardViewVO
   {
       
      
      public var amount:String = "";
      
      public var type:String = "";
      
      public var description1:String = "";
      
      public var description2:String = "";
      
      public var uiPicture:String = "";
      
      public var ribbon:int = -1;
      
      public var cardID:String = "";
      
      public var amountTooltip:String = "";
      
      public var descriptionTooltip:String = "";
      
      public var ribbonTooltip:String = "";
      
      public function MissionEventBoardsCardVO(param1:Object)
      {
         super(param1);
      }
   }
}
