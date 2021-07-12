package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class EventBoardsTableViewStatusVO extends DAAPIDataClass
   {
       
      
      public var title:String = "";
      
      public var info:String = "";
      
      public var value1:String = "";
      
      public var value2:String = "";
      
      public var value3:String = "";
      
      public var valueTime:String = "";
      
      public var buttonLabel:String = "";
      
      public var buttonVisible:Boolean = false;
      
      public var buttonEnabled:Boolean = false;
      
      public var buttonTop:Boolean = false;
      
      public var titleTooltip:String = "";
      
      public var informationTooltip:String = "";
      
      public var buttonTooltip:String = "";
      
      public function EventBoardsTableViewStatusVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
