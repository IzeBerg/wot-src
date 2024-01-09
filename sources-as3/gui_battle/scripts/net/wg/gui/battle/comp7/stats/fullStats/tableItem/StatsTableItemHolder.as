package net.wg.gui.battle.comp7.stats.fullStats.tableItem
{
   import net.wg.data.constants.UserTags;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7DAAPIVehicleInfoVO;
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   import net.wg.gui.battle.comp7.infrastructure.interfaces.IFullStatsPoiHolder;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderCommon;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class StatsTableItemHolder extends StatsTableItemHolderCommon implements IFullStatsPoiHolder
   {
       
      
      private var _statsItem:StatsTableItem = null;
      
      private var _anonymizerCtrl:AnonymizerCtrl = null;
      
      public function StatsTableItemHolder(param1:StatsTableItem, param2:DogTagCtrl, param3:AnonymizerCtrl, param4:Boolean)
      {
         super(param1,param2,param4);
         this._statsItem = param1;
         this._anonymizerCtrl = param3;
      }
      
      override protected function vehicleDataSync() : void
      {
         super.vehicleDataSync();
         var _loc1_:Comp7DAAPIVehicleInfoVO = data as Comp7DAAPIVehicleInfoVO;
         if(_loc1_)
         {
            this._statsItem.setIsEnemy(isEnemy);
            this._statsItem.setRole(_loc1_.role);
            this._statsItem.setSkillLevel(_loc1_.skillLevel);
            this._statsItem.setRank(_loc1_.rank,_loc1_.rankDivision,_loc1_.isQualification);
            this._statsItem.setVoiceChatConnected(_loc1_.voiceChatConnected);
            this._statsItem.isSuperSquad = _loc1_.isSuperSquad;
            if(data.isAnonymized && UserTags.isCurrentPlayer(data.userTags))
            {
               this._anonymizerCtrl.setIsPlayerInClan(StringUtils.isNotEmpty(data.clanAbbrev));
               this._anonymizerCtrl.setPlayerFakeName(data.playerFakeName);
            }
         }
      }
      
      override protected function applyPlayerStatus() : void
      {
         super.applyPlayerStatus();
         this._statsItem.setSquadIndex(data.squadIndex);
      }
      
      override protected function onDispose() : void
      {
         this._anonymizerCtrl.dispose();
         this._anonymizerCtrl = null;
         this._statsItem = null;
         super.onDispose();
      }
      
      public function removeAllPOI() : void
      {
         this._statsItem.removeAllPOI();
      }
      
      public function removePointOfInterest(param1:uint, param2:uint) : void
      {
         this._statsItem.removePointOfInterest(param1,param2);
      }
      
      public function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void
      {
         this._statsItem.updatePointOfInterest(param1,param2);
      }
   }
}
