package net.wg.gui.battle.commander.views.fullStats
{
   import flash.events.Event;
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderDataVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPICommanderInfoVO;
   import net.wg.gui.battle.commander.VO.daapi.DAAPISuppliesDataVO;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsList;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsListSupply;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsListVehicles;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IRTSBattleStatisticDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class RTSFullStatsTable extends UIComponentEx implements IRTSBattleStatisticDataController, IBattleComponentDataController
   {
      
      private static const SUPPLY_PADDING:Number = 27;
       
      
      public var listLeft:IRTSFullStatsListVehicles = null;
      
      public var listRight:IRTSFullStatsListVehicles = null;
      
      public var supplyListLeft:IRTSFullStatsListSupply = null;
      
      public var supplyListRight:IRTSFullStatsListSupply = null;
      
      public function RTSFullStatsTable()
      {
         super();
      }
      
      private static function updateList(param1:IRTSFullStatsList, param2:Vector.<IDAAPIDataClass>, param3:Vector.<Number>) : void
      {
         param1.setData(param2);
         param1.updateOrder(param3);
      }
      
      override protected function onDispose() : void
      {
         this.listLeft.removeEventListener(Event.RESIZE,this.onVehiclesListResized);
         this.listRight.removeEventListener(Event.RESIZE,this.onVehiclesListResized);
         this.listLeft.dispose();
         this.listLeft = null;
         this.listRight.dispose();
         this.listRight = null;
         this.supplyListLeft.dispose();
         this.supplyListLeft = null;
         this.supplyListRight.dispose();
         this.supplyListRight = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.supplyListLeft.visible = this.supplyListRight.visible = false;
         this.supplyListLeft.setHeaderText(RTS_BATTLES.TEAM_COMMANDER_SUPPLY);
         this.supplyListRight.setHeaderText(RTS_BATTLES.TEAM_COMMANDER_SUPPLY);
         this.listLeft.addEventListener(Event.RESIZE,this.onVehiclesListResized);
         this.listRight.addEventListener(Event.RESIZE,this.onVehiclesListResized);
         this.onVehiclesListResized();
         super.onDispose();
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1);
      }
      
      public function resetFrags() : void
      {
         this.listLeft.resetFrags();
         this.listRight.resetFrags();
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
         this.updateFrags(param1);
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function setRTSCommanderInfo(param1:DAAPICommanderInfoVO) : void
      {
         this.listLeft.setRTSCommanderInfo(param1.leftCommanderInfo);
         this.listRight.setRTSCommanderInfo(param1.rightCommanderInfo);
      }
      
      public function setRTSCommanderData(param1:DAAPICommanderDataVO) : void
      {
         this.listLeft.setRTSCommanderData(param1.leftItems);
         this.listRight.setRTSCommanderData(param1.rightItems);
      }
      
      public function setRTSOrder(param1:Number, param2:Number, param3:Boolean) : void
      {
         var _loc4_:IRTSFullStatsListVehicles = this.getListByVehicleID(param1);
         if(_loc4_)
         {
            this.listLeft.setRTSIsMove(param1,param3);
         }
      }
      
      public function setRTSIsSpotted(param1:Number, param2:Boolean) : void
      {
         var _loc3_:IRTSFullStatsListVehicles = this.getListByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setIsSpotted(param1,param2);
         }
      }
      
      public function setRTSVehicleDisabled(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSPlayerCommander(param1:Boolean) : void
      {
      }
      
      public function setRTSSupplyData(param1:DAAPISuppliesDataVO) : void
      {
         var _loc2_:DAAPISuppliesDataVO = DAAPISuppliesDataVO(param1);
         updateList(this.supplyListLeft,Vector.<IDAAPIDataClass>(_loc2_.leftSupplyInfos),_loc2_.leftSupplyIDs);
         updateList(this.supplyListRight,Vector.<IDAAPIDataClass>(_loc2_.rightSupplyInfos),_loc2_.rightSupplyIDs);
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleUserTagsVO = null;
         var _loc2_:DAAPIVehiclesUserTagsVO = DAAPIVehiclesUserTagsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleUserTagsVO> = _loc2_.leftUserTags;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setUserTags(_loc4_.vehicleID,_loc4_.userTags);
         }
         _loc3_ = _loc2_.rightUserTags;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setUserTags(_loc4_.vehicleID,_loc4_.userTags);
         }
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.clearVehicleData();
         this.applyVehicleData(param1);
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIInvitationStatusVO = null;
         var _loc2_:DAAPIVehiclesInvitationStatusVO = DAAPIVehiclesInvitationStatusVO(param1);
         var _loc3_:Vector.<DAAPIInvitationStatusVO> = _loc2_.leftItems;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setInvitationStatus(_loc4_.vehicleID,_loc4_.status);
         }
         _loc3_ = _loc2_.rightItems;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setInvitationStatus(_loc4_.vehicleID,_loc4_.status);
         }
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPITriggeredCommandVO = null;
         var _loc2_:DAAPITriggeredCommandsVO = DAAPITriggeredCommandsVO(param1);
         var _loc3_:Vector.<DAAPITriggeredCommandVO> = _loc2_.triggeredCommands;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.triggerChatCommand(_loc4_.vehicleID,_loc4_.chatCommandName);
         }
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleUserTagsVO = DAAPIVehicleUserTagsVO(param1);
         if(_loc2_.isEnemy)
         {
            this.listRight.setUserTags(_loc2_.vehicleID,_loc2_.userTags);
         }
         else
         {
            this.listLeft.setUserTags(_loc2_.vehicleID,_loc2_.userTags);
         }
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = DAAPIVehicleStatusVO(param1);
         if(_loc2_.isEnemy)
         {
            this.listRight.setVehicleStatus(_loc2_.vehicleID,_loc2_.status);
            if(_loc2_.rightVehiclesIDs)
            {
               this.listRight.updateOrder(_loc2_.rightVehiclesIDs);
            }
         }
         else
         {
            this.listLeft.setVehicleStatus(_loc2_.vehicleID,_loc2_.status);
            if(_loc2_.leftVehiclesIDs)
            {
               this.listLeft.updateOrder(_loc2_.leftVehiclesIDs);
            }
         }
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.applyVehicleData(param1);
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
         this.updateFrags(param1);
         this.updateChatCommands(param1);
      }
      
      private function getListByVehicleID(param1:Number) : IRTSFullStatsListVehicles
      {
         if(this.listLeft.getItemByID(param1))
         {
            return this.listLeft;
         }
         if(this.listRight.getItemByID(param1))
         {
            return this.listRight;
         }
         return null;
      }
      
      private function applyVehicleData(param1:IDAAPIDataClass) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = DAAPIVehiclesDataVO(param1);
         updateList(this.listLeft,Vector.<IDAAPIDataClass>(_loc2_.leftVehicleInfos),_loc2_.leftVehiclesIDs);
         updateList(this.listRight,Vector.<IDAAPIDataClass>(_loc2_.rightVehicleInfos),_loc2_.rightVehiclesIDs);
      }
      
      private function clearVehicleData() : void
      {
         this.listLeft.removeAllItems();
         this.listRight.removeAllItems();
      }
      
      private function updateChatCommands(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleStatsVO = null;
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleStatsVO> = _loc2_.leftFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setChatCommand(_loc4_.vehicleID,_loc4_.chatCommand,_loc4_.chatCommandFlags);
         }
         _loc3_ = _loc2_.rightFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setChatCommand(_loc4_.vehicleID,_loc4_.chatCommand,_loc4_.chatCommandFlags);
         }
      }
      
      private function updateFrags(param1:IDAAPIDataClass) : void
      {
         var _loc4_:DAAPIVehicleStatsVO = null;
         var _loc2_:DAAPIVehiclesStatsVO = DAAPIVehiclesStatsVO(param1);
         var _loc3_:Vector.<DAAPIVehicleStatsVO> = _loc2_.leftFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listLeft.setFrags(_loc4_.vehicleID,_loc4_.frags);
         }
         _loc3_ = _loc2_.rightFrags;
         for each(_loc4_ in _loc3_)
         {
            this.listRight.setFrags(_loc4_.vehicleID,_loc4_.frags);
         }
      }
      
      private function onVehiclesListResized(param1:Event = null) : void
      {
         this.supplyListLeft.y = this.listLeft.y + this.listLeft.getHeight() + SUPPLY_PADDING;
         this.supplyListRight.y = this.listRight.y + this.listRight.getHeight() + SUPPLY_PADDING;
      }
      
      public function setRTSVehicleGroup(param1:int, param2:int) : void
      {
      }
      
      public function setRTSVehicleInFocus(param1:int) : void
      {
      }
      
      public function setRTSVehiclesInFocus(param1:Vector.<int>, param2:Boolean) : void
      {
      }
      
      public function setRTSReloading(param1:int, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function setRTSSelectedVehicles(param1:Vector.<int>) : void
      {
      }
      
      public function setRTSSpeakingVehicle(param1:int, param2:Boolean) : void
      {
      }
      
      public function setRTSClipData(param1:int, param2:int, param3:int, param4:Boolean, param5:Boolean) : void
      {
      }
      
      public function setRTSCommanderMode(param1:Boolean) : void
      {
      }
      
      public function setRTSVehicleModuleDamaged(param1:int, param2:String) : void
      {
      }
      
      public function setRTSVehicleModuleRepaired(param1:int, param2:String) : void
      {
      }
      
      public function setRTSCondition(param1:Number, param2:String) : void
      {
      }
   }
}
