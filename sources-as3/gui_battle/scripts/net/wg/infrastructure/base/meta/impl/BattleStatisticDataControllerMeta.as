package net.wg.infrastructure.base.meta.impl
{
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
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDAAPIComponent;
   import net.wg.gui.components.questProgress.data.QuestProgressVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleStatisticDataControllerMeta extends BattleDAAPIComponent
   {
       
      
      public var onRefreshComplete:Function;
      
      private var _dAAPIVehiclesDataVO:DAAPIVehiclesDataVO;
      
      private var _dAAPIVehiclesDataVO1:DAAPIVehiclesDataVO;
      
      private var _dAAPIVehiclesStatsVO:DAAPIVehiclesStatsVO;
      
      private var _dAAPIArenaInfoVO:DAAPIArenaInfoVO;
      
      private var _dAAPIQuestStatusVO:DAAPIQuestStatusVO;
      
      private var _dAAPIVehiclesUserTagsVO:DAAPIVehiclesUserTagsVO;
      
      private var _array:Array;
      
      public function BattleStatisticDataControllerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dAAPIVehiclesDataVO)
         {
            this._dAAPIVehiclesDataVO.dispose();
            this._dAAPIVehiclesDataVO = null;
         }
         if(this._dAAPIVehiclesDataVO1)
         {
            this._dAAPIVehiclesDataVO1.dispose();
            this._dAAPIVehiclesDataVO1 = null;
         }
         if(this._dAAPIVehiclesStatsVO)
         {
            this._dAAPIVehiclesStatsVO.dispose();
            this._dAAPIVehiclesStatsVO = null;
         }
         if(this._dAAPIArenaInfoVO)
         {
            this._dAAPIArenaInfoVO.dispose();
            this._dAAPIArenaInfoVO = null;
         }
         if(this._dAAPIQuestStatusVO)
         {
            this._dAAPIQuestStatusVO.dispose();
            this._dAAPIQuestStatusVO = null;
         }
         if(this._dAAPIVehiclesUserTagsVO)
         {
            this._dAAPIVehiclesUserTagsVO.dispose();
            this._dAAPIVehiclesUserTagsVO = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         super.onDispose();
      }
      
      public function onRefreshCompleteS() : void
      {
         App.utils.asserter.assertNotNull(this.onRefreshComplete,"onRefreshComplete" + Errors.CANT_NULL);
         this.onRefreshComplete();
      }
      
      public final function as_setVehiclesData(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = this._dAAPIVehiclesDataVO;
         this._dAAPIVehiclesDataVO = this.getDAAPIVehiclesDataVOForVehData(param1);
         this.setVehiclesData(this._dAAPIVehiclesDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_addVehiclesInfo(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = this._dAAPIVehiclesDataVO1;
         this._dAAPIVehiclesDataVO1 = this.getDAAPIVehiclesDataVOForVehInfo(param1);
         this.addVehiclesInfo(this._dAAPIVehiclesDataVO1);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateVehiclesInfo(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesDataVO = this.getDAAPIVehiclesDataVOForUpVehInfo(param1);
         this.updateVehiclesInfo(_loc2_);
      }
      
      public final function as_updateVehicleStatus(param1:Object) : void
      {
         var _loc2_:DAAPIVehicleStatusVO = new DAAPIVehicleStatusVO(param1);
         this.updateVehicleStatus(_loc2_);
      }
      
      public final function as_setFrags(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = this._dAAPIVehiclesStatsVO;
         this._dAAPIVehiclesStatsVO = new DAAPIVehiclesStatsVO(param1);
         this.setFrags(this._dAAPIVehiclesStatsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateVehiclesStats(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesStatsVO = new DAAPIVehiclesStatsVO(param1);
         this.updateVehiclesStats(_loc2_);
      }
      
      public final function as_updatePlayerStatus(param1:Object) : void
      {
         var _loc2_:DAAPIPlayerStatusVO = new DAAPIPlayerStatusVO(param1);
         this.updatePlayerStatus(_loc2_);
      }
      
      public final function as_setArenaInfo(param1:Object) : void
      {
         var _loc2_:DAAPIArenaInfoVO = this._dAAPIArenaInfoVO;
         this._dAAPIArenaInfoVO = new DAAPIArenaInfoVO(param1);
         this.setArenaInfo(this._dAAPIArenaInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setQuestStatus(param1:Object) : void
      {
         var _loc2_:DAAPIQuestStatusVO = this._dAAPIQuestStatusVO;
         this._dAAPIQuestStatusVO = new DAAPIQuestStatusVO(param1);
         this.setQuestStatus(this._dAAPIQuestStatusVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setUserTags(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesUserTagsVO = this._dAAPIVehiclesUserTagsVO;
         this._dAAPIVehiclesUserTagsVO = new DAAPIVehiclesUserTagsVO(param1);
         this.setUserTags(this._dAAPIVehiclesUserTagsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateUserTags(param1:Object) : void
      {
         var _loc2_:DAAPIVehicleUserTagsVO = new DAAPIVehicleUserTagsVO(param1);
         this.updateUserTags(_loc2_);
      }
      
      public final function as_updateInvitationsStatuses(param1:Object) : void
      {
         var _loc2_:DAAPIVehiclesInvitationStatusVO = new DAAPIVehiclesInvitationStatusVO(param1);
         this.updateInvitationsStatuses(_loc2_);
      }
      
      public final function as_setQuestsInfo(param1:Object, param2:Boolean) : void
      {
         var _loc3_:QuestProgressVO = new QuestProgressVO(param1);
         this.setQuestsInfo(_loc3_,param2);
      }
      
      public final function as_updateQuestHeaderProgress(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.updateQuestHeaderProgress(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_updateTriggeredChatCommands(param1:Object) : void
      {
         var _loc2_:DAAPITriggeredCommandsVO = new DAAPITriggeredCommandsVO(param1);
         this.updateTriggeredChatCommands(_loc2_);
      }
      
      protected function getDAAPIVehiclesDataVOForVehData(param1:Object) : DAAPIVehiclesDataVO
      {
         var _loc2_:String = "getDAAPIVehiclesDataVOForVehData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVehiclesData(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc2_:String = "as_setVehiclesData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getDAAPIVehiclesDataVOForVehInfo(param1:Object) : DAAPIVehiclesDataVO
      {
         var _loc2_:String = "getDAAPIVehiclesDataVOForVehInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function addVehiclesInfo(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc2_:String = "as_addVehiclesInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function getDAAPIVehiclesDataVOForUpVehInfo(param1:Object) : DAAPIVehiclesDataVO
      {
         var _loc2_:String = "getDAAPIVehiclesDataVOForUpVehInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateVehiclesInfo(param1:DAAPIVehiclesDataVO) : void
      {
         var _loc2_:String = "as_updateVehiclesInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateVehicleStatus(param1:DAAPIVehicleStatusVO) : void
      {
         var _loc2_:String = "as_updateVehicleStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFrags(param1:DAAPIVehiclesStatsVO) : void
      {
         var _loc2_:String = "as_setFrags" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateVehiclesStats(param1:DAAPIVehiclesStatsVO) : void
      {
         var _loc2_:String = "as_updateVehiclesStats" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updatePlayerStatus(param1:DAAPIPlayerStatusVO) : void
      {
         var _loc2_:String = "as_updatePlayerStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setArenaInfo(param1:DAAPIArenaInfoVO) : void
      {
         var _loc2_:String = "as_setArenaInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setQuestStatus(param1:DAAPIQuestStatusVO) : void
      {
         var _loc2_:String = "as_setQuestStatus" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setUserTags(param1:DAAPIVehiclesUserTagsVO) : void
      {
         var _loc2_:String = "as_setUserTags" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateUserTags(param1:DAAPIVehicleUserTagsVO) : void
      {
         var _loc2_:String = "as_updateUserTags" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateInvitationsStatuses(param1:DAAPIVehiclesInvitationStatusVO) : void
      {
         var _loc2_:String = "as_updateInvitationsStatuses" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setQuestsInfo(param1:QuestProgressVO, param2:Boolean) : void
      {
         var _loc3_:String = "as_setQuestsInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function updateQuestHeaderProgress(param1:Array) : void
      {
         var _loc2_:String = "as_updateQuestHeaderProgress" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateTriggeredChatCommands(param1:DAAPITriggeredCommandsVO) : void
      {
         var _loc2_:String = "as_updateTriggeredChatCommands" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
