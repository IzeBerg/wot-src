package net.wg.infrastructure.helpers.statisticsDataController
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import net.wg.data.VO.daapi.DAAPIArenaInfoVO;
   import net.wg.data.VO.daapi.DAAPIPlayerStatusVO;
   import net.wg.data.VO.daapi.DAAPIQuestStatusVO;
   import net.wg.data.VO.daapi.DAAPITriggeredCommandsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesDataVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehiclesUserTagsVO;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressDataHub;
   import net.wg.gui.battle.views.questProgress.interfaces.IQuestProgressViewUpdatable;
   import net.wg.gui.components.questProgress.data.QuestProgressVO;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.gui.components.questProgress.interfaces.data.IQuestProgressItemData;
   import net.wg.infrastructure.base.meta.IBattleStatisticDataControllerMeta;
   import net.wg.infrastructure.base.meta.impl.BattleStatisticDataControllerMeta;
   import net.wg.infrastructure.events.LifeCycleEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   
   public class BattleStatisticDataController extends BattleStatisticDataControllerMeta implements IBattleStatisticDataControllerMeta, IDAAPIModule, IQuestProgressDataHub
   {
       
      
      private var _componentControllers:Vector.<IBattleComponentDataController>;
      
      private var _questProgressViews:Vector.<IQuestProgressViewUpdatable>;
      
      private var _container:DisplayObjectContainer;
      
      private var _isDAAPIInited:Boolean = false;
      
      private var _questProgressData:QuestProgressVO;
      
      private var _currentQuestId:int = -1;
      
      public function BattleStatisticDataController(param1:DisplayObjectContainer = null)
      {
         this._componentControllers = new Vector.<IBattleComponentDataController>();
         this._questProgressViews = new Vector.<IQuestProgressViewUpdatable>(0);
         super();
         this._container = param1;
      }
      
      override protected function setVehiclesData(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.setVehiclesData(param1);
         }
      }
      
      override protected function addVehiclesInfo(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.addVehiclesInfo(param1);
         }
      }
      
      override protected function updateVehiclesInfo(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updateVehiclesData(param1);
         }
      }
      
      override protected function updateVehicleStatus(param1:DAAPIVehicleStatusVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updateVehicleStatus(param1);
         }
      }
      
      override protected function setFrags(param1:DAAPIVehiclesStatsVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.setFrags(param1);
         }
      }
      
      override protected function updateVehiclesStats(param1:DAAPIVehiclesStatsVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updateVehiclesStat(param1);
         }
      }
      
      override protected function updatePlayerStatus(param1:DAAPIPlayerStatusVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updatePlayerStatus(param1);
         }
      }
      
      override protected function setArenaInfo(param1:DAAPIArenaInfoVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.setArenaInfo(param1);
         }
      }
      
      override protected function setQuestStatus(param1:DAAPIQuestStatusVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.setQuestStatus(param1);
         }
      }
      
      override protected function setUserTags(param1:DAAPIVehiclesUserTagsVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.setUserTags(param1);
         }
      }
      
      override protected function updateUserTags(param1:DAAPIVehicleUserTagsVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updateUserTags(param1);
         }
      }
      
      override protected function updateInvitationsStatuses(param1:DAAPIVehiclesInvitationStatusVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updateInvitationsStatuses(param1);
         }
      }
      
      override protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         return new DAAPIVehiclesDataVO(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForVehInfo(param1:Object) : DAAPIVehiclesDataVO
      {
         return this.getDAAPIVehiclesDataVOForVehData(param1);
      }
      
      override protected function getDAAPIVehiclesDataVOForUpVehInfo(param1:Object) : DAAPIVehiclesDataVO
      {
         return this.getDAAPIVehiclesDataVOForVehData(param1);
      }
      
      override protected function onPopulate() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_POPULATE));
         this._isDAAPIInited = true;
         super.onPopulate();
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_POPULATE));
      }
      
      override protected function onDispose() : void
      {
         this._container = null;
         this._componentControllers.fixed = false;
         this._componentControllers.splice(0,this._componentControllers.length);
         this._componentControllers = null;
         this._questProgressViews.fixed = false;
         this._questProgressViews.splice(0,this._questProgressViews.length);
         this._questProgressViews = null;
         if(this._questProgressData)
         {
            this._questProgressData.dispose();
            this._questProgressData = null;
         }
         removeEventListener(Event.ADDED_TO_STAGE,this.onThisAddedToStageHandler);
         super.onDispose();
      }
      
      override protected function setQuestsInfo(param1:QuestProgressVO, param2:Boolean) : void
      {
         var _loc3_:QuestProgressVO = null;
         var _loc4_:IQuestProgressViewUpdatable = null;
         if(this._currentQuestId != param1.questID || param2)
         {
            _loc3_ = this._questProgressData;
            this._questProgressData = param1;
            this._currentQuestId = param1.questID;
            for each(_loc4_ in this._questProgressViews)
            {
               _loc4_.init(param1);
            }
            if(_loc3_)
            {
               _loc3_.dispose();
               _loc3_ = null;
            }
         }
      }
      
      override protected function updateQuestHeaderProgress(param1:Array) : void
      {
         var _loc2_:IQuestProgressViewUpdatable = null;
         if(this._questProgressData)
         {
            this._questProgressData.updateHeaderProgressData(param1);
            for each(_loc2_ in this._questProgressViews)
            {
               _loc2_.updateHeaderProgress(this._questProgressData.headerConditions);
            }
         }
      }
      
      override protected function updateTriggeredChatCommands(param1:DAAPITriggeredCommandsVO) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.updateTriggeredChatCommands(param1);
         }
      }
      
      public function as_isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      public function as_resetFrags() : void
      {
         var _loc1_:IBattleComponentDataController = null;
         for each(_loc1_ in this._componentControllers)
         {
            _loc1_.resetFrags();
         }
      }
      
      public function as_refresh() : void
      {
         if(this.isOnStage())
         {
            onRefreshCompleteS();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.onThisAddedToStageHandler);
         }
      }
      
      public function as_setPersonalStatus(param1:uint) : void
      {
         var _loc2_:IBattleComponentDataController = null;
         for each(_loc2_ in this._componentControllers)
         {
            _loc2_.setPersonalStatus(param1);
         }
      }
      
      public function as_updatePersonalStatus(param1:uint, param2:uint) : void
      {
         var _loc3_:IBattleComponentDataController = null;
         for each(_loc3_ in this._componentControllers)
         {
            _loc3_.updatePersonalStatus(param1,param2);
         }
      }
      
      public function as_updateQuestProgress(param1:String, param2:Object) : void
      {
         var _loc4_:IQuestProgressViewUpdatable = null;
         var _loc3_:IQPProgressData = this._questProgressData.parseProgressData(param1,param2);
         this._questProgressData.updateProgressData(param1,_loc3_);
         for each(_loc4_ in this._questProgressViews)
         {
            _loc4_.update(param1,_loc3_);
         }
      }
      
      public function getData() : Vector.<IQuestProgressItemData>
      {
         return this._questProgressData.getData();
      }
      
      public function isOnStage() : Boolean
      {
         return this._container != null ? Boolean(this._container.stage != null) : Boolean(false);
      }
      
      public function registerComponentController(param1:IBattleComponentDataController) : void
      {
         this._componentControllers.push(param1);
      }
      
      public function registerQuestProgressView(param1:IQuestProgressViewUpdatable) : void
      {
         this._questProgressViews.push(param1);
      }
      
      public final function setDisplayObjectContainer(param1:DisplayObjectContainer) : void
      {
         this._container = param1;
      }
      
      public function unregisterComponentController(param1:IBattleComponentDataController) : void
      {
         var _loc2_:int = this._componentControllers.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._componentControllers.splice(_loc2_,1);
         }
      }
      
      public function get isDAAPIInited() : Boolean
      {
         return this._isDAAPIInited;
      }
      
      public function get disposed() : Boolean
      {
         return _baseDisposed;
      }
      
      public function get hasQuestProgressActiveData() : Boolean
      {
         return this._questProgressData != null && this._questProgressData.isActiveData;
      }
      
      private function onThisAddedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onThisAddedToStageHandler);
         onRefreshCompleteS();
      }
   }
}
