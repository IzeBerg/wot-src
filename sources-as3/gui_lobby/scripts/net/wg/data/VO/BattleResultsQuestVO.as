package net.wg.data.VO
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.questsWindow.data.PersonalInfoVO;
   import net.wg.gui.lobby.questsWindow.data.StateVO;
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleResultsQuestVO extends SubtaskVO
   {
      
      private static const PERSONAL_INFO_KEY:String = "personalInfo";
      
      private static const QUEST_STATE_KEY:String = "questState";
       
      
      public var questType:int = -1;
      
      public var personalInfo:Vector.<PersonalInfoVO> = null;
      
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
         var _loc1_:IDisposable = null;
         if(this.personalInfo != null)
         {
            for each(_loc1_ in this.personalInfo)
            {
               _loc1_.dispose();
            }
            this.personalInfo.splice(0,this.personalInfo.length);
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
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == PERSONAL_INFO_KEY)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,PERSONAL_INFO_KEY + Errors.CANT_NULL);
            this.personalInfo = new Vector.<PersonalInfoVO>(0);
            for each(_loc4_ in _loc3_)
            {
               this.personalInfo.push(new PersonalInfoVO(_loc4_));
            }
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
