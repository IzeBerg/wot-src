package net.wg.gui.battle.random.views.fragCorrelationBar
{
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import scaleform.gfx.TextFieldEx;
   
   public class FragsAndEnemiesBar extends BattleDisplayable implements IBattleComponentDataController
   {
      
      protected static const INVALID_FRAGS:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const ZERO_STRING:String = "0";
       
      
      public var allyTeamFragsField:TextField = null;
      
      public var enemyTeamFragsField:TextField = null;
      
      public var background:BattleAtlasSprite = null;
      
      private var _allyTeamFragsStr:String = "0";
      
      private var _enemyTeamFragsStr:String = "0";
      
      public function FragsAndEnemiesBar()
      {
         super();
         TextFieldEx.setNoTranslate(this.allyTeamFragsField,true);
         TextFieldEx.setNoTranslate(this.enemyTeamFragsField,true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.background.imageName = BATTLEATLAS.FRAG_CORELATION_BG;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INVALID_FRAGS))
         {
            this.allyTeamFragsField.text = this._allyTeamFragsStr;
            this.enemyTeamFragsField.text = this._enemyTeamFragsStr;
         }
      }
      
      override protected function onDispose() : void
      {
         this.allyTeamFragsField = null;
         this.enemyTeamFragsField = null;
         this.background = null;
         super.onDispose();
      }
      
      public function resetFrags() : void
      {
         this.allyTeamFragsField.text = ZERO_STRING;
         this.enemyTeamFragsField.text = ZERO_STRING;
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         if(_loc2_.totalStats)
         {
            this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
         }
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.totalStats)
         {
            this.updateFrags(_loc2_.totalStats.leftScope,_loc2_.totalStats.rightScope);
         }
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      protected function updateFrags(param1:int, param2:int) : void
      {
         this._allyTeamFragsStr = param1.toString();
         this._enemyTeamFragsStr = param2.toString();
         invalidate(INVALID_FRAGS);
      }
   }
}
