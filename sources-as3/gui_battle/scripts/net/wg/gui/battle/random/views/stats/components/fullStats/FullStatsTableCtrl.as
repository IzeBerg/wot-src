package net.wg.gui.battle.random.views.stats.components.fullStats
{
   import net.wg.gui.battle.random.views.stats.components.fullStats.interfaces.ISquadHandler;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.DynamicSquadCtrl;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.random.views.stats.components.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   import net.wg.infrastructure.base.meta.impl.StatsBaseMeta;
   import net.wg.infrastructure.uilogging.player_satisfaction_rating.PLAYER_SATISFACTION_RATING_CONSTANTS;
   
   public class FullStatsTableCtrl extends StatsTableControllerBase implements ISquadHandler
   {
      
      private static const RIGHT_COLUMN:int = 1;
      
      private static const SQUAD_BT_LEFT_X:int = -508;
      
      private static const SQUAD_BT_RIGHT_X:int = 477;
      
      private static const ITEM_HEIGHT:int = 25;
      
      private static const TABLE_START_POINT:int = 37;
      
      private static const SQUAD_BT_Y_START:int = 38;
       
      
      private var _squadHandler:StatsBaseMeta = null;
      
      private var _isAllyInviteShown:Boolean = false;
      
      private var _isEnemyInviteShown:Boolean = false;
      
      private var _isAllyInteractive:Boolean = false;
      
      private var _isEnemyInteractive:Boolean = false;
      
      public function FullStatsTableCtrl(param1:FullStatsTable, param2:StatsBaseMeta)
      {
         super(param1);
         this._squadHandler = param2;
      }
      
      override public function setInteractive(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(this._isAllyInteractive != param1)
         {
            _loc3_ = 0;
            while(_loc3_ < numRows)
            {
               this.setItemInteractive(false,_loc3_,param1);
               _loc3_++;
            }
            this._isAllyInteractive = param1;
         }
         if(this._isEnemyInteractive != param2)
         {
            _loc3_ = 0;
            while(_loc3_ < numRows)
            {
               this.setItemInteractive(true,_loc3_,param2);
               _loc3_++;
            }
            this._isEnemyInteractive = param2;
         }
      }
      
      override public function setIsInviteShown(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(this._isAllyInviteShown != param1)
         {
            _loc3_ = 0;
            while(_loc3_ < numRows)
            {
               this.setItemInviteShown(false,_loc3_,param1);
               _loc3_++;
            }
            this._isAllyInviteShown = param1;
         }
         if(this._isEnemyInviteShown != param2)
         {
            _loc3_ = 0;
            while(_loc3_ < numRows)
            {
               this.setItemInviteShown(true,_loc3_,param2);
               _loc3_++;
            }
            this._isEnemyInviteShown = param2;
         }
      }
      
      override protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         var _loc3_:StatsTableItem = this.createPlayerStatsItem(param1,param2);
         var _loc4_:DynamicSquadCtrl = this.createSquadItem(param1,param2);
         _loc4_.addActionHandler(this);
         return new StatsTableItemHolder(_loc3_,_loc4_,param1 == RIGHT_COLUMN);
      }
      
      override protected function onDispose() : void
      {
         this._squadHandler = null;
         super.onDispose();
      }
      
      override protected function onItemDataSet(param1:StatsTableItemHolderBase, param2:Boolean) : void
      {
         var _loc3_:StatsTableItemHolder = param1 as StatsTableItemHolder;
         if(_loc3_)
         {
            _loc3_.setIsInviteShown(!!param2 ? Boolean(this._isEnemyInviteShown) : Boolean(this._isAllyInviteShown));
            _loc3_.setIsInteractive(!!param2 ? Boolean(this._isEnemyInteractive) : Boolean(this._isAllyInteractive));
         }
      }
      
      public function onAcceptSquad(param1:DynamicSquadCtrl) : void
      {
         this._squadHandler.acceptSquadS(param1.sessionID);
      }
      
      public function onAddToSquad(param1:DynamicSquadCtrl) : void
      {
         this._squadHandler.addToSquadS(param1.sessionID,PLAYER_SATISFACTION_RATING_CONSTANTS.FULL_STATS_VIEW);
      }
      
      public function onSquadBtVisibleChange(param1:DynamicSquadCtrl) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:FullStatsTable = null;
         var _loc2_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < numRows)
         {
            if(this.getHolderByIndex(false,_loc4_).squadItem == param1)
            {
               _loc2_ = _loc4_;
               break;
            }
            if(this.getHolderByIndex(true,_loc4_).squadItem == param1)
            {
               _loc2_ = _loc4_;
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(_loc2_ != -1)
         {
            _loc5_ = this.getTable();
            if(param1.isAcceptBtAvailable)
            {
               _loc5_.squadAcceptBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
               _loc5_.squadAcceptBt.y = SQUAD_BT_Y_START + _loc2_ * ITEM_HEIGHT;
               _loc5_.squadAcceptBt.visible = true;
            }
            else
            {
               _loc5_.squadAcceptBt.visible = false;
            }
            if(param1.isAddBtAvailable)
            {
               _loc5_.squadAddBt.x = !!_loc3_ ? Number(SQUAD_BT_RIGHT_X) : Number(SQUAD_BT_LEFT_X);
               _loc5_.squadAddBt.y = SQUAD_BT_Y_START + _loc2_ * ITEM_HEIGHT;
               _loc5_.squadAddBt.visible = true;
            }
            else
            {
               _loc5_.squadAddBt.visible = false;
            }
         }
      }
      
      private function createPlayerStatsItem(param1:int, param2:int) : StatsTableItem
      {
         return new StatsTableItem(this.getTable(),param1,param2);
      }
      
      private function createSquadItem(param1:int, param2:int) : DynamicSquadCtrl
      {
         var _loc3_:int = param1 * numRows + param2;
         var _loc4_:FullStatsTable = this.getTable();
         return new DynamicSquadCtrl(_loc4_.squadStatusCollection[_loc3_],_loc4_.squadCollection[_loc3_],_loc4_.squadAcceptBt,_loc4_.squadAddBt,_loc4_.hitCollection[_loc3_],_loc4_.noSoundCollection[_loc3_]);
      }
      
      private function getHolderByIndex(param1:Boolean, param2:int) : StatsTableItemHolder
      {
         return (!!param1 ? enemyRenderers[param2] : allyRenderers[param2]) as StatsTableItemHolder;
      }
      
      private function setItemInviteShown(param1:Boolean, param2:int, param3:Boolean) : void
      {
         var _loc4_:StatsTableItemHolder = this.getHolderByIndex(param1,param2);
         if(_loc4_.containsData)
         {
            _loc4_.setIsInviteShown(param3);
         }
      }
      
      private function setItemInteractive(param1:Boolean, param2:int, param3:Boolean) : void
      {
         var _loc4_:StatsTableItemHolder = this.getHolderByIndex(param1,param2);
         if(_loc4_.containsData)
         {
            _loc4_.setIsInteractive(param3);
         }
      }
      
      override protected function get tableStartPoint() : int
      {
         return TABLE_START_POINT;
      }
      
      private function getTable() : FullStatsTable
      {
         return FullStatsTable(table);
      }
   }
}
