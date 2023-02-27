package net.wg.gui.battle.epicBattle.battleloading
{
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.gui.battle.battleloading.BaseLoadingForm;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleLoadingTankBalance;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleStatsTable;
   import net.wg.gui.battle.epicBattle.battleloading.components.EpicBattleStatsTableCtrl;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattleLoadingForm extends BaseLoadingForm
   {
      
      private static const LOADING_BAR_MIN:int = 0;
      
      private static const LOADING_BAR_MAX:int = 1;
      
      private static const LOADING_BAR_DEF_VALUE:int = 0;
       
      
      public var team1Text:TextField = null;
      
      public var team2Text:TextField = null;
      
      public var team1TankBalance:EpicBattleLoadingTankBalance;
      
      public var team2TankBalance:EpicBattleLoadingTankBalance;
      
      public var table:EpicBattleStatsTable = null;
      
      private var _tableCtrl:EpicBattleStatsTableCtrl = null;
      
      private var _leftTeamName:String = "";
      
      private var _rightTeamName:String = "";
      
      public function EpicBattleLoadingForm()
      {
         super();
         this._tableCtrl = new EpicBattleStatsTableCtrl(this.table);
      }
      
      override public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         this._tableCtrl.addVehiclesInfo(param1,param2,param3);
      }
      
      override public function setFormDisplayData(param1:VisualTipInfoVO) : void
      {
         if(!param1.showMinimap && param1.tipIcon != null)
         {
            this.configureTip(param1.tipTitleTop,param1.tipBodyTop,param1.tipIcon);
         }
         this.configureTip(param1.tipTitleTop,param1.tipBodyTop,param1.tipIcon);
      }
      
      override public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         this._tableCtrl.setPlayerStatus(param1,param2,param3);
      }
      
      override public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         this._tableCtrl.setUserTags(param1,param2);
      }
      
      override public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         this._tableCtrl.setVehicleStatus(param1,param2,param3,param4);
      }
      
      override public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>) : void
      {
         this._tableCtrl.setVehiclesData(param2,param3,param1);
         if(!param1)
         {
            this.team1TankBalance.setVehiclesData(param2);
            this.team1TankBalance.isAllyTankBalance = true;
         }
         else
         {
            this.team2TankBalance.setVehiclesData(param2);
         }
      }
      
      override public function toString() : String
      {
         return "[WG EpicRandomBattleLoadingForm " + name + "]";
      }
      
      override public function updateTeamsHeaders(param1:String, param2:String) : void
      {
         this._leftTeamName = param1;
         this._rightTeamName = param2;
         invalidateData();
      }
      
      override public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         this._tableCtrl.updateVehiclesInfo(param1,param2,param3);
      }
      
      override protected function onDispose() : void
      {
         if(this._tableCtrl)
         {
            this._tableCtrl.dispose();
            this._tableCtrl = null;
         }
         this.table.dispose();
         this.table = null;
         this.team1Text = null;
         this.team2Text = null;
         this.team1TankBalance.dispose();
         this.team1TankBalance = null;
         this.team2TankBalance.dispose();
         this.team2TankBalance = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.team1Text.text = this._leftTeamName;
            this.team2Text.text = this._rightTeamName;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mapIcon.autoSize = false;
         loadingBar.minimum = LOADING_BAR_MIN;
         loadingBar.maximum = LOADING_BAR_MAX;
         loadingBar.value = LOADING_BAR_DEF_VALUE;
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         this._tableCtrl.setEpicVehiclesStats(false,param1.leftItems,param1.leftVehiclesIDs);
         this._tableCtrl.setEpicVehiclesStats(true,param1.rightItems,param1.rightVehiclesIDs);
         this._tableCtrl.sortVehicles();
      }
      
      private function configureTip(param1:int, param2:int, param3:String = null) : void
      {
         var _loc4_:Boolean = StringUtils.isNotEmpty(param3);
         if(_loc4_)
         {
            helpTip.y = param1;
            tipText.y = param2;
         }
      }
   }
}
