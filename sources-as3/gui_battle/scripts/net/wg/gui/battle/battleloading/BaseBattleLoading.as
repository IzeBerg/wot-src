package net.wg.gui.battle.battleloading
{
   import net.wg.infrastructure.base.meta.IBaseBattleLoadingMeta;
   import net.wg.infrastructure.base.meta.impl.BaseBattleLoadingMeta;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IBattleComponentDataController;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   
   public class BaseBattleLoading extends BaseBattleLoadingMeta implements IBattleComponentDataController, IBaseBattleLoadingMeta
   {
      
      private static const MSG_MUST_BE_OVERRIDEN:String = "Method must be overridden!";
       
      
      public function BaseBattleLoading()
      {
         super();
      }
      
      public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function as_setMapIcon(param1:String) : void
      {
         this.throwAbstractException();
      }
      
      public function as_setProgress(param1:Number) : void
      {
         this.throwAbstractException();
      }
      
      public function as_setTip(param1:String) : void
      {
         this.throwAbstractException();
      }
      
      public function as_setTipTitle(param1:String) : void
      {
         this.throwAbstractException();
      }
      
      public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function resetFrags() : void
      {
      }
      
      public function setFrags(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function setPersonalStatus(param1:uint) : void
      {
         this.throwAbstractException();
      }
      
      public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function setUserTags(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
         this.throwAbstractException();
      }
      
      public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
      }
      
      public function updateUserTags(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
         this.throwAbstractException();
      }
      
      private function throwAbstractException() : void
      {
         DebugUtils.LOG_ERROR(MSG_MUST_BE_OVERRIDEN);
         throw new AbstractException(MSG_MUST_BE_OVERRIDEN);
      }
   }
}
