package net.wg.gui.battle.epicRandom.battleloading.components
{
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.battleloading.interfaces.IVehiclesDataProvider;
   import net.wg.gui.battle.epicRandom.battleloading.renderers.IEpicRandomBattleLoadingRenderer;
   import net.wg.gui.battle.interfaces.IStatsTableController;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.controls.ScrollingList;
   
   public class EpicRandomStatsTableCtrl implements IStatsTableController, IDisposable
   {
       
      
      protected var teamDP:VehiclesDataProvider = null;
      
      protected var enemyDP:VehiclesDataProvider = null;
      
      private var _table:EpicRandomStatsTable = null;
      
      private var _disposed:Boolean = false;
      
      public function EpicRandomStatsTableCtrl(param1:EpicRandomStatsTable)
      {
         super();
         this._table = param1;
         this.teamDP = new VehiclesDataProvider();
         this.teamDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onTeamDPValidateItemsHandler);
         this.enemyDP = new VehiclesDataProvider();
         this.enemyDP.addEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDPValidateItemsHandler);
      }
      
      public function addVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         if(_loc4_.addVehiclesInfo(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         if(_loc4_.setPlayerStatus(param2,param3))
         {
            _loc4_.invalidate();
         }
      }
      
      public function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void
      {
         var _loc3_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         if(_loc3_.setUserTags(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      public function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void
      {
         var _loc5_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         var _loc6_:Boolean = _loc5_.setVehicleStatus(param2,param3);
         _loc6_ = _loc5_.setSorting(param4) || _loc6_;
         if(_loc6_)
         {
            _loc5_.invalidate();
         }
      }
      
      public function setVehiclesData(param1:Boolean, param2:Array, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         _loc4_.setSource(param2);
         _loc4_.setSorting(param3);
         _loc4_.invalidate();
         if(param1)
         {
            this._table.team2PlayerList.visible = true;
            this._table.team2PlayerList.dataProvider = _loc4_;
         }
         else
         {
            this._table.team1PlayerList.visible = true;
            this._table.team1PlayerList.dataProvider = _loc4_;
         }
      }
      
      public function updateVehiclesInfo(param1:Boolean, param2:Vector.<DAAPIVehicleInfoVO>, param3:Vector.<Number>) : void
      {
         var _loc4_:IVehiclesDataProvider = !!param1 ? this.enemyDP : this.teamDP;
         var _loc5_:Boolean = _loc4_.updateVehiclesInfo(param2);
         _loc5_ = _loc4_.setSorting(param3) || _loc5_;
         if(_loc5_)
         {
            _loc4_.invalidate();
         }
      }
      
      protected function onDispose() : void
      {
         this._table = null;
         this.teamDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onTeamDPValidateItemsHandler);
         this.teamDP.cleanUp();
         this.teamDP = null;
         this.enemyDP.removeEventListener(ListDataProviderEvent.VALIDATE_ITEMS,this.onEnemyDPValidateItemsHandler);
         this.enemyDP.cleanUp();
         this.enemyDP = null;
      }
      
      private function getRendererIfInRange(param1:ScrollingList, param2:int) : IEpicRandomBattleLoadingRenderer
      {
         var _loc5_:IEpicRandomBattleLoadingRenderer = null;
         var _loc3_:int = param2 - param1.scrollPosition;
         var _loc4_:IEpicRandomBattleLoadingRenderer = null;
         if(_loc3_ >= 0 && _loc3_ < param1.rowCount)
         {
            _loc5_ = param1.getRendererAt(_loc3_) as IEpicRandomBattleLoadingRenderer;
            if(_loc5_)
            {
               _loc4_ = _loc5_;
            }
         }
         return _loc4_;
      }
      
      protected function updateTeamDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:IEpicRandomBattleLoadingRenderer = null;
         var _loc2_:uint = this._table.team1PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team1PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc5_ in _loc4_)
         {
            if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
            {
               _loc6_ = this.teamDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
               _loc7_ = this.getRendererIfInRange(this._table.team1PlayerList,_loc5_);
               if(_loc6_ && _loc7_)
               {
                  _loc7_.isEnemy = false;
                  _loc7_.setData(_loc6_);
                  _loc7_.validateNow();
               }
            }
         }
      }
      
      protected function updateEnemyDPItems(param1:ListDataProviderEvent) : void
      {
         var _loc5_:int = 0;
         var _loc6_:DAAPIVehicleInfoVO = null;
         var _loc7_:IEpicRandomBattleLoadingRenderer = null;
         var _loc2_:uint = this._table.team2PlayerList.scrollPosition;
         var _loc3_:uint = _loc2_ + this._table.team2PlayerList.rowCount - 1;
         var _loc4_:Vector.<int> = Vector.<int>(param1.data);
         for each(_loc5_ in _loc4_)
         {
            if(!(_loc5_ < _loc2_ || _loc5_ > _loc3_))
            {
               _loc6_ = this.enemyDP.requestItemAt(_loc5_) as DAAPIVehicleInfoVO;
               _loc7_ = this.getRendererIfInRange(this._table.team2PlayerList,_loc5_);
               if(_loc6_ && _loc7_)
               {
                  _loc7_.isEnemy = true;
                  _loc7_.setData(_loc6_);
                  _loc7_.validateNow();
               }
            }
         }
      }
      
      private function onTeamDPValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         this.updateTeamDPItems(param1);
      }
      
      private function onEnemyDPValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         this.updateEnemyDPItems(param1);
      }
      
      public function setTeamsInfo(param1:String, param2:String) : void
      {
         this._table.team1TF.text = param1;
         this._table.team2TF.text = param2;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
