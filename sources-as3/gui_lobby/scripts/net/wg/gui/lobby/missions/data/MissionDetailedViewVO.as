package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class MissionDetailedViewVO extends BaseMissionDetailedViewVO
   {
      
      private static const BATTLE_CONDITIONS:String = "battleConditions";
      
      private static const PREBATTLE_CONDITIONS:String = "prebattleConditions";
      
      private static const ACCOUNT_REQUIREMENTS:String = "accountRequirements";
      
      private static const SCHEDULE_TOOLTIP:String = "scheduleTooltip";
       
      
      private var _scheduleTooltip:ToolTipVO = null;
      
      private var _accountRequirements:MissionAccountRequirementsVO = null;
      
      private var _prebattleConditions:DataProvider;
      
      private var _battleConditions:Vector.<MissionConditionsContainerVO>;
      
      public function MissionDetailedViewVO(param1:Object)
      {
         this._battleConditions = new Vector.<MissionConditionsContainerVO>();
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         if(param1 == PREBATTLE_CONDITIONS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,PREBATTLE_CONDITIONS + Errors.INVALID_TYPE + Array);
            this._prebattleConditions = new DataProvider();
            for each(_loc3_ in _loc4_)
            {
               this._prebattleConditions.push(new MissionBattleRequirementRendererVO(_loc3_));
            }
            return false;
         }
         if(param1 == BATTLE_CONDITIONS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,BATTLE_CONDITIONS + Errors.INVALID_TYPE + Array);
            for each(_loc3_ in _loc4_)
            {
               this._battleConditions.push(new MissionConditionsContainerVO(_loc3_));
            }
            return false;
         }
         if(param1 == ACCOUNT_REQUIREMENTS)
         {
            this._accountRequirements = new MissionAccountRequirementsVO(param2);
            return false;
         }
         if(param1 == SCHEDULE_TOOLTIP)
         {
            this._scheduleTooltip = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._battleConditions)
         {
            _loc1_.dispose();
         }
         this._battleConditions.splice(0,this._battleConditions.length);
         this._battleConditions = null;
         for each(_loc1_ in this._prebattleConditions)
         {
            _loc1_.dispose();
         }
         this._prebattleConditions = null;
         if(this._accountRequirements != null)
         {
            this._accountRequirements.dispose();
            this._accountRequirements = null;
         }
         if(this._scheduleTooltip)
         {
            this._scheduleTooltip.dispose();
            this._scheduleTooltip = null;
         }
         super.onDispose();
      }
      
      public function get battleConditions() : Vector.<MissionConditionsContainerVO>
      {
         return this._battleConditions;
      }
      
      public function get prebattleConditions() : IDataProvider
      {
         return this._prebattleConditions;
      }
      
      public function get accountRequirements() : MissionAccountRequirementsVO
      {
         return this._accountRequirements;
      }
      
      public function get scheduleTooltip() : ToolTipVO
      {
         return this._scheduleTooltip;
      }
   }
}
