package net.wg.gui.battle.ranked.stats.components.fullStats
{
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.battleloading.data.VehiclesDataProvider;
   import net.wg.gui.battle.interfaces.ITabbedFullStatsTableController;
   import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.StatsTableItem;
   import net.wg.gui.battle.ranked.stats.components.fullStats.tableItem.StatsTableItemHolder;
   import net.wg.gui.battle.views.stats.fullStats.DogTagCtrl;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableControllerBase;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemHolderBase;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import scaleform.gfx.TextFieldEx;
   
   public class FullStatsTableCtrl extends StatsTableControllerBase implements ITabbedFullStatsTableController
   {
      
      private static const RIGHT_COLUMN:int = 1;
      
      private static const ITEM_HEIGHT:Number = 25;
      
      private static const TABLE_START_POINT:int = 33;
      
      private static const NUM_ROWS:int = 10;
       
      
      private var _table:FullStatsTable = null;
      
      public function FullStatsTableCtrl(param1:FullStatsTable)
      {
         super();
         this._table = param1;
         TextFieldEx.setNoTranslate(this._table.team1TF,true);
         TextFieldEx.setNoTranslate(this._table.team2TF,true);
         numRows = NUM_ROWS;
         init();
         this.initCommonItems();
         this.setNoTranslate();
      }
      
      override public function setTeamsInfo(param1:String, param2:String) : void
      {
         this._table.team1TF.text = param1;
         this._table.team2TF.text = param2;
      }
      
      override protected function createItemHolder(param1:int, param2:int) : StatsTableItemHolderBase
      {
         var _loc3_:StatsTableItem = this.createPlayerStatsItem(param1,param2);
         var _loc4_:DogTagCtrl = this.createDogTagCtrl(param1,param2);
         return new StatsTableItemHolder(_loc3_,_loc4_,param1 == RIGHT_COLUMN);
      }
      
      override protected function setSelectedItem(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            this._table.selfBgRight.y = TABLE_START_POINT + param2 * ITEM_HEIGHT;
            this._table.selfBgRight.visible = true;
            this._table.selfBgLeft.visible = false;
         }
         else
         {
            this._table.selfBgLeft.y = TABLE_START_POINT + param2 * ITEM_HEIGHT;
            this._table.selfBgLeft.visible = true;
            this._table.selfBgRight.visible = false;
         }
      }
      
      override protected function onDispose() : void
      {
         this._table = null;
         super.onDispose();
      }
      
      public function setDogTagToShow(param1:Number, param2:DogTagVO) : void
      {
         var _loc3_:StatsTableItemHolderBase = null;
         _dogTagsToShow[param1] = param2;
         for each(_loc3_ in _enemyRenderers)
         {
            if(_loc3_.containsData)
            {
               if(_loc3_.getVehicleID() == param1)
               {
                  _loc3_.showDogTag(param2);
               }
            }
         }
      }
      
      public function setInteractive(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function setIsInviteShown(param1:Boolean, param2:Boolean) : void
      {
      }
      
      public function setSpeaking(param1:Number, param2:Boolean) : void
      {
         if(_teamDP.setSpeaking(param1,param2))
         {
            _teamDP.invalidate();
         }
         else if(_enemyDP.setSpeaking(param1,param2))
         {
            _enemyDP.invalidate();
         }
      }
      
      public function setVehiclesStats(param1:Vector.<DAAPIVehicleStatsVO>, param2:Vector.<DAAPIVehicleStatsVO>) : void
      {
         var _loc3_:VehiclesDataProvider = _teamDP;
         if(_loc3_.updateFrags(param1))
         {
            _loc3_.invalidate();
         }
         _loc3_ = _enemyDP;
         if(_loc3_.updateFrags(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      public function updateInvitationsStatuses(param1:Boolean, param2:Vector.<DAAPIInvitationStatusVO>) : void
      {
         var _loc3_:VehiclesDataProvider = !!param1 ? _enemyDP : _teamDP;
         if(_loc3_.updateInvitationsStatuses(param2))
         {
            _loc3_.invalidate();
         }
      }
      
      private function createDogTagCtrl(param1:int, param2:int) : DogTagCtrl
      {
         var _loc3_:int = param1 * numRows + param2;
         return new DogTagCtrl(this._table.hitCollection[_loc3_]);
      }
      
      private function createPlayerStatsItem(param1:int, param2:int) : StatsTableItem
      {
         return new StatsTableItem(this._table,param1,param2);
      }
      
      private function initCommonItems() : void
      {
         this._table.selfBgLeft.visible = false;
         this._table.selfBgLeft.imageName = BATTLEATLAS.FULL_STATS_SELF_BG;
         this._table.selfBgRight.visible = false;
         this._table.selfBgRight.imageName = BATTLEATLAS.FULL_STATS_SELF_BG;
      }
      
      private function setNoTranslate() : void
      {
         setNoTranslateForCollection(this._table.playerNameCollection);
         setNoTranslateForCollection(this._table.vehicleNameCollection);
         setNoTranslateForCollection(this._table.fragsCollection);
      }
   }
}
