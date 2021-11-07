package net.wg.gui.battle.epicBattle.views.stats.components
{
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.gui.battle.epicBattle.VO.daapi.EpicVehicleStatsVO;
   import net.wg.gui.battle.epicBattle.views.data.EpicStatsDataProviderBaseCtrl;
   import net.wg.gui.battle.epicBattle.views.data.EpicVehicleDataProvider;
   import net.wg.gui.battle.epicBattle.views.stats.*;
   import net.wg.gui.battle.epicBattle.views.stats.renderers.EpicStatsPlayerRenderer;
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   
   public class EpicFullStatsTableCtrl extends EpicStatsDataProviderBaseCtrl implements ISquadHandler
   {
      
      private static const SQUAD_BT_LEFT_X:Number = -496;
      
      private static const SQUAD_BT_RIGHT_X:Number = 464;
      
      private static const ITEM_HEIGHT:Number = 25;
       
      
      private var _table:EpicFullStatsTable = null;
      
      private var _squadHandler:EpicFullStats = null;
      
      private var _currentLane:int = -1;
      
      private var _filteringActive:Boolean = true;
      
      private var _isAllyInviteShown:Boolean = false;
      
      private var _isEnemyInviteShown:Boolean = false;
      
      private var _isAllyInteractive:Boolean = false;
      
      private var _isEnemyInteractive:Boolean = false;
      
      private var _isRenderingAvailable:Boolean = false;
      
      private var _activePlayerData:DAAPIVehicleInfoVO;
      
      public function EpicFullStatsTableCtrl(param1:EpicFullStatsTable, param2:EpicFullStats)
      {
         super();
         this._table = param1;
         this._squadHandler = param2;
      }
      
      override public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         super.addVehiclesInfo(param1,param2,param3);
         var _loc4_:PlayerScrollingList = !!param1 ? this._table.team2PlayerList : this._table.team1PlayerList;
         _loc4_.invalidateData();
      }
      
      override public function setEpicVehiclesStats(param1:Boolean, param2:Vector.<EpicVehicleStatsVO>, param3:Vector.<Number>) : void
      {
         super.setEpicVehiclesStats(param1,param2,param3);
         this.sortingIfVisible();
         if(this._filteringActive)
         {
            this._table.team1PlayerList.invalidateData();
            this._table.team2PlayerList.invalidateData();
         }
      }
      
      override public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
      {
         var _loc4_:EpicVehicleDataProvider = null;
         var _loc5_:PlayerScrollingList = null;
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
         if(_loc5_.dataProvider)
         {
            _loc5_.dataProvider.cleanUp();
         }
         super.setVehiclesData(param1,param2,param3);
         _loc5_.dataProvider = _loc4_;
      }
      
      override protected function onDispose() : void
      {
         this._squadHandler = null;
         this._table = null;
         this._activePlayerData = null;
         super.onDispose();
      }
      
      public function focusScrollbar(param1:int = 0) : void
      {
         this._table.team1ScrollBar.position = param1;
         this._table.team2ScrollBar.position = param1;
      }
      
      public function onAcceptSquad(param1:DynamicSquadCtrl) : void
      {
         this._squadHandler.acceptSquadS(param1.sessionID);
      }
      
      public function onAddToSquad(param1:DynamicSquadCtrl) : void
      {
         this._squadHandler.addToSquadS(param1.sessionID);
      }
      
      public function onSquadBtVisibleChange(param1:DynamicSquadCtrl) : void
      {
         var _loc4_:EpicStatsPlayerRenderer = null;
         var _loc2_:int = -1;
         var _loc3_:Boolean = false;
         var _loc5_:int = this._table.team1PlayerList.rowCount;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._table.team1PlayerList.getRendererAt(_loc6_) as EpicStatsPlayerRenderer;
            if(_loc4_ && _loc4_.squadItem == param1)
            {
               _loc2_ = _loc6_;
               break;
            }
            _loc6_++;
         }
         _loc5_ = this._table.team2PlayerList.rowCount;
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = this._table.team2PlayerList.getRendererAt(_loc7_) as EpicStatsPlayerRenderer;
            if(_loc4_ && _loc4_.squadItem == param1)
            {
               _loc2_ = _loc7_;
               _loc3_ = true;
               break;
            }
            _loc7_++;
         }
         if(_loc2_ != -1 && !_loc4_.isCurrentPlayer())
         {
            if(param1.isAcceptBtAvailable)
            {
               this._table.squadAcceptBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
               this._table.squadAcceptBt.y = _loc2_ * ITEM_HEIGHT + this._table.team1PlayerList.y;
               this._table.squadAcceptBt.visible = true;
            }
            else
            {
               this._table.squadAcceptBt.visible = false;
            }
            if(param1.isAddBtAvailable)
            {
               this._table.squadAddBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
               this._table.squadAddBt.y = _loc2_ * ITEM_HEIGHT + this._table.team1PlayerList.y;
               this._table.squadAddBt.visible = true;
            }
            else
            {
               this._table.squadAddBt.visible = false;
            }
         }
      }
      
      public function setInteractive(param1:Boolean, param2:Boolean) : void
      {
         if(param2 != this._isEnemyInteractive)
         {
            this._table.team2PlayerList.setInteractive(param2);
            this._isEnemyInteractive = param2;
         }
         if(param1 != this._isAllyInteractive)
         {
            this._table.team1PlayerList.setInteractive(param1);
            this._isAllyInteractive = param1;
         }
      }
      
      public function setIsInviteShown(param1:Boolean, param2:Boolean) : void
      {
         if(param2 != this._isEnemyInviteShown)
         {
            this._table.team2PlayerList.setIsInviteShown(param2);
            this._isEnemyInviteShown = param2;
         }
         if(param1 != this._isAllyInviteShown)
         {
            this._table.team1PlayerList.setIsInviteShown(param1);
            this._isAllyInviteShown = param1;
         }
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         var _loc3_:EpicStatsPlayerRenderer = null;
         if(teamDP.setSpeaking(param1,param2))
         {
            _loc3_ = this.getRendererByAccountId(false,param1);
            if(_loc3_)
            {
               _loc3_.setIsSpeaking(param2);
            }
            teamDP.invalidate();
         }
         else if(enemyDP.setSpeaking(param1,param2))
         {
            _loc3_ = this.getRendererByAccountId(true,param1);
            if(_loc3_)
            {
               _loc3_.setIsSpeaking(param2);
            }
            enemyDP.invalidate();
         }
      }
      
      public function setupSquadElements() : void
      {
         this._table.team1PlayerList.setupSquadElements(this._table.squadAcceptBt,this._table.squadAddBt);
         this._table.team1PlayerList.setupSquadHandler(this);
         this._table.team2PlayerList.setupSquadElements(this._table.squadAcceptBt,this._table.squadAddBt);
         this._table.team2PlayerList.setupSquadHandler(this);
      }
      
      public function updateColorBlind() : void
      {
         var _loc3_:EpicStatsPlayerRenderer = null;
         var _loc1_:int = 0;
         var _loc2_:int = this._table.team1PlayerList.rowCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._table.team1PlayerList.getRendererAt(_loc1_) as EpicStatsPlayerRenderer;
            if(_loc3_)
            {
               _loc3_.updateColorBlind();
            }
            _loc1_++;
         }
         _loc2_ = this._table.team2PlayerList.rowCount;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this._table.team2PlayerList.getRendererAt(_loc1_) as EpicStatsPlayerRenderer;
            if(_loc3_)
            {
               _loc3_.updateColorBlind();
            }
            _loc1_++;
         }
      }
      
      public function updateInvitationsStatuses(param1:Boolean, param2:Vector.<DAAPIInvitationStatusVO>) : void
      {
         var _loc3_:EpicVehicleDataProvider = !!param1 ? enemyDP : teamDP;
         if(_loc3_.updateInvitationsStatuses(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      private function sortingIfVisible() : void
      {
         if(this._isRenderingAvailable)
         {
            sortVehicles();
         }
      }
      
      private function getRendererByAccountId(param1:Boolean, param2:int) : EpicStatsPlayerRenderer
      {
         var _loc3_:PlayerScrollingList = !!param1 ? this._table.team2PlayerList : this._table.team1PlayerList;
         var _loc4_:int = _loc3_.rowCount;
         var _loc5_:int = _loc3_.scrollPosition;
         var _loc6_:EpicStatsPlayerRenderer = null;
         var _loc7_:int = _loc5_;
         while(_loc7_ < _loc4_)
         {
            _loc6_ = _loc3_.getRendererAt(_loc7_) as EpicStatsPlayerRenderer;
            if(_loc6_ != null && _loc6_.getAccountId() == param2)
            {
               break;
            }
            _loc7_++;
         }
         return _loc6_;
      }
      
      private function getRendererIfInRange(param1:PlayerScrollingList, param2:int, param3:EpicVehicleStatsVO) : EpicStatsPlayerRenderer
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this._filteringActive)
         {
            if(param3 && param3.lane != this._currentLane)
            {
               return null;
            }
            _loc4_ = param1.getRendererIndexByVehicleID(param3.vehicleID);
            if(_loc4_ >= 0)
            {
               return param1.getRendererAt(_loc4_) as EpicStatsPlayerRenderer;
            }
            return null;
         }
         _loc5_ = param2 - param1.scrollPosition;
         if(_loc5_ >= 0 && _loc5_ < param1.rowCount)
         {
            return param1.getRendererAt(_loc5_) as EpicStatsPlayerRenderer;
         }
         return null;
      }
      
      private function updateLaneFilter(param1:Boolean) : void
      {
         this.sortingIfVisible();
         this._table.team1PlayerList.setLaneFilter(!!param1 ? int(this._currentLane) : int(-1));
         this._table.team2PlayerList.setLaneFilter(!!param1 ? int(this._currentLane) : int(-1));
         this._table.statsFilters.setPlayerLane(this._currentLane);
      }
      
      private function updateActivePlayerVO(param1:Vector.<int>) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            this._activePlayerData = teamDP.requestItemAt(_loc2_) as DAAPIVehicleInfoVO;
            if(this._activePlayerData.isCurrentPlayer)
            {
               break;
            }
         }
      }
      
      public function set currentLane(param1:int) : void
      {
         if(this._currentLane != param1)
         {
            this._currentLane = param1;
            enemyDP.activeLane = this._currentLane;
            teamDP.activeLane = this._currentLane;
            this.updateLaneFilter(this._filteringActive);
         }
      }
      
      public function set filterActive(param1:Boolean) : void
      {
         this._filteringActive = param1;
         this.updateLaneFilter(param1);
      }
      
      public function set isRenderingAvailable(param1:Boolean) : void
      {
         var _loc3_:EpicStatsPlayerRenderer = null;
         if(this._isRenderingAvailable == param1)
         {
            return;
         }
         this._isRenderingAvailable = param1;
         this.sortingIfVisible();
         var _loc2_:int = 0;
         var _loc4_:int = this._table.team2PlayerList.rowCount;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this._table.team2PlayerList.getRendererAt(_loc2_) as EpicStatsPlayerRenderer;
            if(_loc3_)
            {
               _loc3_.isRenderingAvailable = param1;
            }
            _loc2_++;
         }
         _loc4_ = this._table.team1PlayerList.rowCount;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = this._table.team1PlayerList.getRendererAt(_loc2_) as EpicStatsPlayerRenderer;
            if(_loc3_)
            {
               _loc3_.isRenderingAvailable = param1;
            }
            _loc2_++;
         }
      }
      
      override protected function updateTeamDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:EpicVehicleStatsVO = null;
         var _loc8_:EpicStatsPlayerRenderer = null;
         var _loc2_:uint = this._table.team1PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team1PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         if(this._activePlayerData == null)
         {
            this.updateActivePlayerVO(_loc4_);
         }
         for each(_loc5_ in _loc4_)
         {
            if(!this._filteringActive)
            {
               if(_loc5_ < _loc2_ || _loc5_ > _loc3_)
               {
                  continue;
               }
            }
            _loc6_ = teamDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
            if(_loc6_)
            {
               _loc7_ = teamDP.requestEpicData(_loc6_.vehicleID);
               if(_loc7_)
               {
                  _loc8_ = this.getRendererIfInRange(this._table.team1PlayerList,_loc5_,_loc7_);
                  if(_loc8_)
                  {
                     if(this._activePlayerData)
                     {
                        _loc8_.setActivePlayerData(this._activePlayerData);
                     }
                     _loc8_.setDAAPIVehicleInfoVO(_loc6_);
                     _loc8_.setEpicData(_loc7_);
                  }
               }
            }
         }
      }
      
      override protected function updateEnemyDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:EpicVehicleStatsVO = null;
         var _loc8_:EpicStatsPlayerRenderer = null;
         var _loc2_:uint = this._table.team2PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team2PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc5_ in _loc4_)
         {
            if(!this._filteringActive)
            {
               if(_loc5_ < _loc2_ || _loc5_ > _loc3_)
               {
                  continue;
               }
            }
            _loc6_ = enemyDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
            if(_loc6_)
            {
               _loc7_ = enemyDP.requestEpicData(_loc6_.vehicleID);
               if(_loc7_)
               {
                  _loc8_ = this.getRendererIfInRange(this._table.team2PlayerList,_loc5_,_loc7_);
                  if(_loc8_)
                  {
                     _loc8_.setDAAPIVehicleInfoVO(_loc6_);
                     _loc8_.setEpicData(_loc7_);
                  }
               }
            }
         }
      }
   }
}
