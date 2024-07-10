package net.wg.data.VO
{
   import net.wg.gui.lobby.questsWindow.data.PersonalInfoVO;
   import net.wg.gui.lobby.questsWindow.data.StateVO;
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   
   public class BattleResultsQuestVO extends SubtaskVO
   {
      
      private static const PERSONAL_INFO_KEY:String = "personalInfo";
      
      private static const QUEST_STATE_KEY:String = "questState";
       
      
      public var questType:int = -1;
      
      public var personalInfo:PersonalInfoVO = null;
      
      public var isLinkBtnVisible:Boolean = true;
      
      public var awards:Array = null;
      
      public var progressList:Array = null;
      
      public var alertMsg:String = "";
      
      public var collapsedToggleBtnVisible:Boolean = true;
      
      public var linkBtnVisible:Boolean = true;
      
      public var linkBtnEnabled:Boolean = true;
      
      public var linkBtnTooltip:String = "";
      
      public var questState:StateVO = null;
      
      public var descr:String = "";
      
      public function BattleResultsQuestVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.personalInfo != null)
         {
            this.personalInfo.dispose();
            this.personalInfo = null;
         }
         if(this.awards != null)
         {
            this.awards.splice(0);
            this.awards = null;
         }
         if(this.progressList != null)
         {
            this.progressList.splice(0,this.progressList.length);
            this.progressList = null;
         }
         if(this.questState != null)
         {
            this.questState.dispose();
            this.questState = null;
         }
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == PERSONAL_INFO_KEY)
         {
            this.personalInfo = new PersonalInfoVO(param2);
            return false;
         }
         if(param1 == QUEST_STATE_KEY)
         {
            this.questState = new StateVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
   }
}
