package net.wg.gui.battle.epicBattle.battleloading
{
   import net.wg.gui.battle.battleloading.BattleLoading;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicPlayerStatsVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehiclesStatsVO;
   import net.wg.gui.battle.epicBattle.battleloading.events.EpicBattleLoadingEvent;
   import net.wg.infrastructure.helpers.statisticsDataController.intarfaces.IEpicBattleStatisticDataController;
   
   public class EpicBattleLoading extends BattleLoading implements IEpicBattleStatisticDataController
   {
      
      private static const FORM_VISIBLE_AREA_HEIGHT:int = 750;
       
      
      private var _epicForm:EpicBattleLoadingForm = null;
      
      public function EpicBattleLoading()
      {
         super();
      }
      
      override public function setCompVisible(param1:Boolean) : void
      {
         super.setCompVisible(param1);
         dispatchEvent(new EpicBattleLoadingEvent(EpicBattleLoadingEvent.VISIBILITY_CHANGED));
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         form.y = param2 - FORM_VISIBLE_AREA_HEIGHT >> 1;
      }
      
      override protected function onDispose() : void
      {
         if(this._epicForm)
         {
            this._epicForm = null;
         }
         super.onDispose();
      }
      
      override protected function onPopulate() : void
      {
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._epicForm = form as EpicBattleLoadingForm;
      }
      
      public function setEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         if(this._epicForm)
         {
            this._epicForm.setEpicVehiclesStats(param1);
         }
      }
      
      public function updateEpicPlayerStats(param1:EpicPlayerStatsVO) : void
      {
      }
      
      public function updateEpicVehiclesStats(param1:EpicVehiclesStatsVO) : void
      {
         if(this._epicForm)
         {
            this._epicForm.setEpicVehiclesStats(param1);
         }
      }
   }
}
