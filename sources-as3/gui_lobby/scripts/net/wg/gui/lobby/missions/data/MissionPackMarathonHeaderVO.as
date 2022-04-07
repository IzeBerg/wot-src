package net.wg.gui.lobby.missions.data
{
   public class MissionPackMarathonHeaderVO extends MissionPackHeaderBaseVO
   {
      
      private static const CONDITION_BLOCK_FIELD_NAME:String = "conditionBlock";
      
      private static const AWARD_BLOCK_FIELD_NAME:String = "awardBlock";
       
      
      public var uiDecoration:String = "";
      
      private var _conditionBlockVO:MarathonHeaderConditionBlockVO;
      
      private var _awardBlockVO:MarathonHeaderAwardBlockVO;
      
      public function MissionPackMarathonHeaderVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == CONDITION_BLOCK_FIELD_NAME)
         {
            this._conditionBlockVO = new MarathonHeaderConditionBlockVO(param2);
            return false;
         }
         if(param1 == AWARD_BLOCK_FIELD_NAME)
         {
            this._awardBlockVO = new MarathonHeaderAwardBlockVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._conditionBlockVO.dispose();
         this._conditionBlockVO = null;
         this._awardBlockVO.dispose();
         this._awardBlockVO = null;
         super.onDispose();
      }
      
      override public function get titleBlockClass() : Class
      {
         return CollapsedHeaderTitleBlockVO;
      }
      
      public function get conditionBlockVO() : MarathonHeaderConditionBlockVO
      {
         return this._conditionBlockVO;
      }
      
      public function get awardBlockVO() : MarathonHeaderAwardBlockVO
      {
         return this._awardBlockVO;
      }
   }
}
