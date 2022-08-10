package net.wg.gui.cyberSport.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CSIntroViewStaticTeamVO extends DAAPIDataClass
   {
       
      
      public var ladderIconSource:String = "";
      
      public var isLadderBtnEnabled:Boolean = true;
      
      public var clockIconSource:String = "";
      
      public var isClockIconVisible:Boolean = false;
      
      public var teamHeaderText:String = "";
      
      public var isRequestWaitingTextVisible:Boolean = false;
      
      public var requestWaitingText:String = "";
      
      public var isTeamDescriptionBackVisible:Boolean = false;
      
      public var teamDescriptionText:String = "";
      
      public var isTeamDescriptionTooltip:Boolean = false;
      
      public var teamDescriptionTooltip:String = "";
      
      public var createBtnLabel:String = "";
      
      public var createBtnTooltip:String = "";
      
      public var isCreateBtnEnabled:Boolean = false;
      
      public var isCreateBtnVisible:Boolean = false;
      
      public var teamAdditionalBtnLabel:String = "";
      
      public var teamAdditionalBtnTooltip:String = "";
      
      public var isTeamAdditionalBtnVisible:Boolean = false;
      
      public var isNeedAddPlayers:Boolean = false;
      
      public var isCanCreateBattle:Boolean = false;
      
      public var isHaveTeamToShow:Boolean = false;
      
      public var isCanJoinBattle:Boolean = false;
      
      public function CSIntroViewStaticTeamVO(param1:Object)
      {
         super(param1);
      }
      
      override public function isEquals(param1:DAAPIDataClass) : Boolean
      {
         var _loc2_:CSIntroViewStaticTeamVO = param1 as CSIntroViewStaticTeamVO;
         if(!_loc2_)
         {
            return false;
         }
         return this.ladderIconSource == _loc2_.ladderIconSource && this.isLadderBtnEnabled == _loc2_.isLadderBtnEnabled && this.clockIconSource == _loc2_.clockIconSource && this.isClockIconVisible == _loc2_.isClockIconVisible && this.teamHeaderText == _loc2_.teamHeaderText && this.isRequestWaitingTextVisible == _loc2_.isRequestWaitingTextVisible && this.requestWaitingText == _loc2_.requestWaitingText && this.isTeamDescriptionBackVisible == _loc2_.isTeamDescriptionBackVisible && this.teamDescriptionText == _loc2_.teamDescriptionText && this.isTeamDescriptionTooltip == _loc2_.isTeamDescriptionTooltip && this.teamDescriptionTooltip == _loc2_.teamDescriptionTooltip && this.createBtnLabel == _loc2_.createBtnLabel && this.createBtnTooltip == _loc2_.createBtnTooltip && this.isCreateBtnEnabled == _loc2_.isCreateBtnEnabled && this.isCreateBtnVisible == _loc2_.isCreateBtnVisible && this.teamAdditionalBtnLabel == _loc2_.teamAdditionalBtnLabel && this.teamAdditionalBtnTooltip == _loc2_.teamAdditionalBtnTooltip && this.isTeamAdditionalBtnVisible == _loc2_.isTeamAdditionalBtnVisible && this.isNeedAddPlayers == _loc2_.isNeedAddPlayers && this.isCanCreateBattle == _loc2_.isCanCreateBattle && this.isHaveTeamToShow == _loc2_.isHaveTeamToShow && this.isCanJoinBattle == _loc2_.isCanJoinBattle;
      }
   }
}
