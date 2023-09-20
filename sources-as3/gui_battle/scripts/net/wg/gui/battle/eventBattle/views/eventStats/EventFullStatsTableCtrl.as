package net.wg.gui.battle.eventBattle.views.eventStats
{
   import flash.display.DisplayObject;
   import net.wg.gui.battle.random.views.stats.components.fullStats.FullStatsTableCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   
   public class EventFullStatsTableCtrl extends FullStatsTableCtrl
   {
      
      private static const RIGHT_COLUMN:int = 1;
       
      
      private var _table:EventFullStatsTable = null;
      
      public function EventFullStatsTableCtrl(param1:EventFullStatsTable, param2:StatsBaseMeta)
      {
         this._table = param1;
         super(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._table = null;
         super.onDispose();
      }
      
      override public function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void
      {
         super.setVehiclesData(param1,param2,param3);
         var _loc4_:DisplayObject = !!param3 ? this._table.rightPlatoon : this._table.leftPlatoon;
         _loc4_.visible = param1.length > 1;
      }
      
      override protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         var _loc3_:EventStatsTableItem = this.createPlayerStatsItem(param1,param2);
         var _loc4_:DynamicSquadCtrl = this.createSquadItem(param1,param2);
         _loc4_.addActionHandler(this);
         return new EventStatsTableItemHolder(_loc3_,_loc4_,param1 == RIGHT_COLUMN);
      }
      
      override protected function onEnemyDataProviderValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         this._table.selfBgRight.visible = false;
         super.onEnemyDataProviderValidateItemsHandler(param1);
      }
      
      override protected function onAllyDataProviderValidateItemsHandler(param1:ListDataProviderEvent) : void
      {
         this._table.selfBgLeft.visible = false;
         super.onAllyDataProviderValidateItemsHandler(param1);
      }
      
      private function createPlayerStatsItem(param1:int, param2:int) : EventStatsTableItem
      {
         return new EventStatsTableItem(this._table,param1,param2);
      }
      
      private function createSquadItem(param1:int, param2:int) : DynamicSquadCtrl
      {
         var _loc3_:int = param1 * numRows + param2;
         return new DynamicSquadCtrl(this._table.squadStatusCollection[_loc3_],this._table.squadCollection[_loc3_],this._table.squadAcceptBt,this._table.squadAddBt,this._table.hitCollection[_loc3_],this._table.noSoundCollection[_loc3_]);
      }
   }
}
