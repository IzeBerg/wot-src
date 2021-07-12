package net.wg.gui.battle.epicBattle.battleloading.components
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.battleloading.renderers.EpicBattleLoadingPlayerItemRenderer;
   import net.wg.gui.battle.epicBattle.views.data.EpicStatsDataProviderBaseCtrl;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import scaleform.clik.controls.ScrollingList;
   
   public class EpicBattleStatsTableCtrl extends EpicStatsDataProviderBaseCtrl
   {
       
      
      private var _table:EpicBattleStatsTable = null;
      
      public function EpicBattleStatsTableCtrl(param1:EpicBattleStatsTable)
      {
         super();
         this._table = param1;
      }
      
      override public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:IVehiclesDataProvider = null;
         var _loc5_:EpicBattleScrollingList = null;
         if(param3)
         {
            _loc5_ = this._table.team2PlayerList;
            _loc4_ = enemyDP;
         }
         else
         {
            _loc5_ = this._table.team1PlayerList;
            _loc4_ = teamDP;
         }
         _loc5_.visible = true;
         if(_loc5_.dataProvider != null)
         {
            _loc5_.dataProvider.cleanUp();
         }
         super.setVehiclesData(param1,param2,param3);
         _loc5_.dataProvider = _loc4_;
      }
      
      override protected function onDispose() : void
      {
         this._table = null;
         super.onDispose();
      }
      
      public function scrollToPosition(param1:int) : void
      {
         this._table.team1ScrollBar.position = param1;
         this._table.team2ScrollBar.position = param1;
      }
      
      private function getRendererIfInRange(param1:ScrollingList, param2:int) : EpicBattleLoadingPlayerItemRenderer
      {
         var _loc5_:EpicBattleLoadingPlayerItemRenderer = null;
         var _loc3_:int = param2 - param1.scrollPosition;
         var _loc4_:EpicBattleLoadingPlayerItemRenderer = null;
         if(_loc3_ >= 0 && _loc3_ < param1.rowCount)
         {
            _loc5_ = param1.getRendererAt(_loc3_) as EpicBattleLoadingPlayerItemRenderer;
            if(_loc5_)
            {
               _loc4_ = _loc5_;
            }
         }
         return _loc4_;
      }
      
      override protected function updateTeamDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:EpicBattleLoadingPlayerItemRenderer = null;
         var _loc8_:EpicVehicleStatsVO = null;
         var _loc2_:uint = this._table.team1PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team1PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc5_ in _loc4_)
         {
            if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
            {
               _loc6_ = teamDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
               _loc7_ = this.getRendererIfInRange(this._table.team1PlayerList,_loc5_);
               if(_loc6_ && _loc7_)
               {
                  _loc7_.isEnemy = false;
                  _loc7_.setData(_loc6_);
                  _loc8_ = teamDP.requestEpicData(_loc6_.vehicleID);
                  if(_loc8_)
                  {
                     _loc7_.setEpicData(_loc8_);
                  }
                  _loc7_.validateNow();
               }
            }
         }
      }
      
      override protected function updateEnemyDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:EpicBattleLoadingPlayerItemRenderer = null;
         var _loc8_:EpicVehicleStatsVO = null;
         var _loc2_:uint = this._table.team2PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team2PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc5_ in _loc4_)
         {
            if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
            {
               _loc6_ = enemyDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
               _loc7_ = this.getRendererIfInRange(this._table.team2PlayerList,_loc5_);
               if(_loc6_ && _loc7_)
               {
                  _loc7_.isEnemy = true;
                  _loc7_.setData(_loc6_);
                  _loc8_ = enemyDP.requestEpicData(_loc6_.vehicleID);
                  if(_loc8_)
                  {
                     _loc7_.setEpicData(_loc8_);
                  }
                  _loc7_.validateNow();
               }
            }
         }
      }
   }
}
