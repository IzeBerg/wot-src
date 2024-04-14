package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.gui.lobby.missions.data.CollapsedHeaderTitleBlockVO;
   import net.wg.gui.lobby.missions.data.MissionPackHeaderBaseVO;
   
   public class MissionEventBoardsHeaderVO extends MissionPackHeaderBaseVO
   {
       
      
      public var timer:String = "";
      
      public var participate:String = "";
      
      public var buttonLabel:String = "";
      
      public var isButton:Boolean = false;
      
      public var isButtonEnabled:Boolean = true;
      
      public var title:String = "";
      
      public var isButtonRegistration:Boolean = false;
      
      public var isButtonRegistrationEnabled:Boolean = true;
      
      public var buttonRegistrationLabel:String = "";
      
      public var eventID:String = "";
      
      public var participateTooltip:String = "";
      
      public var buttonTooltip:String = "";
      
      public var titleTooltip:String = "";
      
      public var buttonRegistrationTooltip:String = "";
      
      public function MissionEventBoardsHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override public function get titleBlockClass() : Class
      {
         return CollapsedHeaderTitleBlockVO;
      }
   }
}
