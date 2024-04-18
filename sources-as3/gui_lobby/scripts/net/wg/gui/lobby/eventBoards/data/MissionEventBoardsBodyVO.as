package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.gui.lobby.missions.data.MissionPackMarathonBodyVO;
   
   public class MissionEventBoardsBodyVO extends MissionPackMarathonBodyVO
   {
      
      private static const SERVER_BLOCK_FIELD_NAME:String = "serverBlock";
      
      private static const RELOGIN_BLOCK_FIELD_NAME:String = "reloginBlock";
      
      private static const TASK_BLOCK_FIELD_NAME:String = "taskBlock";
      
      private static const CONDITION_BLOCK_FIELD_NAME:String = "conditionBlock";
      
      private static const AWARD_BLOCK_FIELD_NAME:String = "awardBlock";
       
      
      public var isUnsuitableServer:Boolean = false;
      
      public var isRelogin:Boolean = false;
      
      public var isRegistration:Boolean = true;
      
      public var isRegistrationEnabled:Boolean = true;
      
      public var isRegistrationTop:Boolean = true;
      
      public var buttonRegistrationLabel:String = "";
      
      public var isRating:Boolean = true;
      
      public var isEventBegan:Boolean = false;
      
      public var uiDecoration:String = "";
      
      public var popoverAlias:String = "";
      
      public var title:String = "";
      
      public var description1:String = "";
      
      public var description2:String = "";
      
      public var eventID:String = "";
      
      public var titleTooltip:String = "";
      
      public var description1Tooltip:String = "";
      
      public var description2Tooltip:String = "";
      
      public var registrationTooltip:String = "";
      
      public var ratingTooltip:String = "";
      
      private var _serverBlockVO:HeaderServerBlockVO;
      
      private var _reloginBlockVO:HeaderReloginBlockVO;
      
      private var _taskBlockVO:HeaderDescBlockVO;
      
      private var _conditionBlockVO:HeaderConditionBlockVO;
      
      private var _awardBlockVO:HeaderAwardBlockVO;
      
      public function MissionEventBoardsBodyVO(param1:Object, param2:String)
      {
         super(param1,param2);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SERVER_BLOCK_FIELD_NAME)
         {
            this._serverBlockVO = new HeaderServerBlockVO(param2);
            return false;
         }
         if(param1 == RELOGIN_BLOCK_FIELD_NAME)
         {
            this._reloginBlockVO = new HeaderReloginBlockVO(param2);
            return false;
         }
         if(param1 == TASK_BLOCK_FIELD_NAME)
         {
            this._taskBlockVO = new HeaderDescBlockVO(param2);
            return false;
         }
         if(param1 == CONDITION_BLOCK_FIELD_NAME)
         {
            this._conditionBlockVO = new HeaderConditionBlockVO(param2);
            return false;
         }
         if(param1 == AWARD_BLOCK_FIELD_NAME)
         {
            this._awardBlockVO = new HeaderAwardBlockVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._serverBlockVO)
         {
            this._serverBlockVO.dispose();
            this._serverBlockVO = null;
         }
         if(this._reloginBlockVO)
         {
            this._reloginBlockVO.dispose();
            this._reloginBlockVO = null;
         }
         this._taskBlockVO.dispose();
         this._taskBlockVO = null;
         this._conditionBlockVO.dispose();
         this._conditionBlockVO = null;
         this._awardBlockVO.dispose();
         this._awardBlockVO = null;
         super.onDispose();
      }
      
      override protected function get missionCardClass() : Class
      {
         return MissionEventBoardsCardVO;
      }
      
      public function get serverBlockVO() : HeaderServerBlockVO
      {
         return this._serverBlockVO;
      }
      
      public function get reloginBlockVO() : HeaderReloginBlockVO
      {
         return this._reloginBlockVO;
      }
      
      public function get taskBlockVO() : HeaderDescBlockVO
      {
         return this._taskBlockVO;
      }
      
      public function get conditionBlockVO() : HeaderConditionBlockVO
      {
         return this._conditionBlockVO;
      }
      
      public function get awardBlockVO() : HeaderAwardBlockVO
      {
         return this._awardBlockVO;
      }
   }
}
