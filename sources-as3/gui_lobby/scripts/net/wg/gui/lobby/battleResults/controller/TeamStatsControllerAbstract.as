package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SortingInfo;
   import net.wg.gui.components.advanced.InteractiveSortingButton;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.ColumnCollection;
   import net.wg.gui.lobby.battleResults.data.ColumnData;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.event.TeamTableSortEvent;
   import net.wg.infrastructure.exceptions.AbstractException;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class TeamStatsControllerAbstract implements IDisposable
   {
       
      
      private var _dispatcher:IEventDispatcher;
      
      private var _columnTooltip:Dictionary;
      
      private var _columnWidth:Dictionary;
      
      private var _sortingKey:Dictionary;
      
      private var _sortingIsNumeric:Dictionary;
      
      private var _sortingDirection:Dictionary;
      
      private var _leftColumns:ColumnCollection;
      
      private var _rightColumns:ColumnCollection;
      
      private var _sortingBonusType:int;
      
      private var _disposed:Boolean = false;
      
      public function TeamStatsControllerAbstract(param1:IEventDispatcher)
      {
         this._columnTooltip = new Dictionary();
         this._columnWidth = new Dictionary();
         this._sortingKey = new Dictionary();
         this._sortingIsNumeric = new Dictionary();
         this._sortingDirection = new Dictionary();
         this._leftColumns = new ColumnCollection(true);
         this._rightColumns = new ColumnCollection(false);
         super();
         this._dispatcher = param1;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this.clearColumnsData();
         this._disposed = true;
         this._dispatcher = null;
         this._columnTooltip = null;
         this._columnWidth = null;
         this._sortingKey = null;
         this._sortingIsNumeric = null;
         this._sortingDirection = null;
         this._leftColumns.dispose();
         this._leftColumns = null;
         this._rightColumns.dispose();
         this._rightColumns = null;
      }
      
      protected function onDispose() : void
      {
      }
      
      public function onHeaderClick(param1:InteractiveSortingButton, param2:SortableHeaderButtonBar, param3:Boolean) : void
      {
         var _loc4_:ColumnCollection = !!param3 ? this._leftColumns : this._rightColumns;
         this.applySort(_loc4_,param1.id,param1.sortDirection);
      }
      
      public function update(param1:BattleResultsVO) : void
      {
         var _loc2_:CommonStatsVO = param1.common;
         this.setupColumns(this._leftColumns,_loc2_);
         this.setupColumns(this._rightColumns,_loc2_);
         this.setupLists(param1);
         this.setupInitialSorting(this._leftColumns,_loc2_);
         this.setupInitialSorting(this._rightColumns,_loc2_);
      }
      
      protected function sortLists(param1:ColumnData, param2:Number) : void
      {
         throw new AbstractException("TeamStatsControllerAbstract.sortLists" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         throw new AbstractException("TeamStatsControllerAbstract.getColumnIds" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function setupTeamListHeaders(param1:ColumnCollection, param2:int, param3:String) : void
      {
         throw new AbstractException("TeamStatsControllerAbstract.setupTeamListHeaders" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function setupLists(param1:BattleResultsVO) : void
      {
         throw new AbstractException("TeamStatsControllerAbstract.setupLists" + Errors.ABSTRACT_INVOKE);
      }
      
      protected function setupList(param1:DataProvider, param2:CommonStatsVO, param3:TeamStatsList) : void
      {
         param3.dataProvider = param1;
         param3.setCommonStatsVO(param2);
      }
      
      protected function initColumnsData(param1:CommonStatsVO) : void
      {
         if(param1.isShowSquad)
         {
            this._columnTooltip[ColumnConstants.SQUAD] = BATTLE_RESULTS.TEAM_SQUADHEADER;
            this._columnWidth[ColumnConstants.SQUAD] = ColumnConstants.FIRST_COLUMN_WIDTH;
            this._sortingKey[ColumnConstants.SQUAD] = [ColumnConstants.KEY_SQUAD_ID];
         }
         this._columnTooltip[ColumnConstants.PLAYER] = BATTLE_RESULTS.TEAM_PLAYERHEADER;
         this._columnWidth[ColumnConstants.PLAYER] = !!param1.isShowSquad ? ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH : ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH + ColumnConstants.FIRST_COLUMN_WIDTH;
         this._sortingKey[ColumnConstants.PLAYER] = [ColumnConstants.KEY_PLAYER_NAME];
         this._sortingIsNumeric[ColumnConstants.PLAYER] = false;
         this._sortingDirection[ColumnConstants.PLAYER] = SortingInfo.ASCENDING_SORT;
         this._columnTooltip[ColumnConstants.TANK] = BATTLE_RESULTS.TEAM_TANKHEADER;
         this._columnWidth[ColumnConstants.TANK] = ColumnConstants.TANK_COLUMN_WIDTH;
         this._sortingKey[ColumnConstants.TANK] = [ColumnConstants.KEY_VEHICLE_SORT];
         this._columnTooltip[ColumnConstants.DAMAGE] = BATTLE_RESULTS.TEAM_DAMAGEHEADER;
         this._columnWidth[ColumnConstants.DAMAGE] = ColumnConstants.DAMAGE_COLUMN_WIDTH;
         this._sortingKey[ColumnConstants.DAMAGE] = [ColumnConstants.KEY_DAMAGE];
         this._columnTooltip[ColumnConstants.FRAG] = BATTLE_RESULTS.TEAM_FRAGHEADER;
         this._columnWidth[ColumnConstants.FRAG] = ColumnConstants.DEFAULT_FRAG_COLUMN_WIDTH;
         this._sortingKey[ColumnConstants.FRAG] = [ColumnConstants.KEY_REAL_KILLS];
         this._columnTooltip[ColumnConstants.XP] = BATTLE_RESULTS.TEAM_XPHEADER;
         this._columnWidth[ColumnConstants.XP] = ColumnConstants.XP_COLUMN_WIDTH;
         this._sortingKey[ColumnConstants.XP] = [ColumnConstants.KEY_XP,ColumnConstants.KEY_DAMAGE,ColumnConstants.KEY_VEHICLE_ID];
         this._columnTooltip[ColumnConstants.MEDAL] = BATTLE_RESULTS.TEAM_MEDALHEADER;
         this._columnWidth[ColumnConstants.MEDAL] = ColumnConstants.DEFAULT_MEDAL_COLUMN_WIDTH;
         this._sortingKey[ColumnConstants.MEDAL] = [ColumnConstants.KEY_MEDALS];
      }
      
      protected function initColumns(param1:ColumnCollection, param2:CommonStatsVO) : Vector.<String>
      {
         this.initColumnsData(param2);
         return this.getColumnIds(param2);
      }
      
      private function setupColumns(param1:ColumnCollection, param2:CommonStatsVO) : void
      {
         var _loc4_:String = null;
         var _loc5_:ColumnData = null;
         var _loc6_:Boolean = false;
         var _loc7_:String = null;
         var _loc3_:Vector.<String> = this.initColumns(param1,param2);
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = param1.add(_loc4_,this._columnTooltip[_loc4_],RES_ICONS.maps_icons_buttons_tab_sort_button(_loc4_ + ".png"),this._columnWidth[_loc4_]);
            if(_loc4_ in this._sortingKey)
            {
               _loc6_ = _loc4_ in this._sortingIsNumeric ? Boolean(this._sortingIsNumeric[_loc4_]) : Boolean(true);
               _loc7_ = _loc4_ in this._sortingDirection ? this._sortingDirection[_loc4_] : SortingInfo.DESCENDING_SORT;
               _loc5_.setSorting(this._sortingKey[_loc4_],_loc6_,_loc7_);
            }
         }
         _loc3_.splice(0,_loc3_.length);
         this.clearColumnsData();
      }
      
      private function clearColumnsData() : void
      {
         App.utils.data.cleanupDynamicObject(this._columnTooltip);
         App.utils.data.cleanupDynamicObject(this._columnWidth);
         App.utils.data.cleanupDynamicObject(this._sortingKey);
         App.utils.data.cleanupDynamicObject(this._sortingDirection);
         App.utils.data.cleanupDynamicObject(this._sortingIsNumeric);
      }
      
      private function setupInitialSorting(param1:ColumnCollection, param2:CommonStatsVO) : void
      {
         this._sortingBonusType = param2.bonusType;
         var _loc3_:String = param2.iconType;
         var _loc4_:String = param2.sortDirection;
         var _loc5_:int = 1;
         var _loc6_:int = _loc5_;
         var _loc7_:ColumnData = param1.getById(_loc3_);
         if(_loc7_ != null && _loc7_.sortingKeys != null)
         {
            _loc6_ = _loc7_.index;
         }
         else
         {
            _loc7_ = param1.getByIndex(_loc6_);
            _loc3_ = _loc7_.columnId;
         }
         this.setupTeamListHeaders(param1,_loc6_,_loc4_);
         this.applySort(param1,_loc3_,_loc4_);
      }
      
      private function applySort(param1:ColumnCollection, param2:String, param3:String) : void
      {
         var _loc4_:Number = 0;
         var _loc5_:ColumnData = param1.getById(param2);
         if(_loc5_ && _loc5_.sortingKeys)
         {
            if(_loc5_.isNumeric)
            {
               _loc4_ |= Array.NUMERIC;
            }
            else
            {
               _loc4_ |= Array.CASEINSENSITIVE;
            }
            if(param3 == SortingInfo.DESCENDING_SORT)
            {
               _loc4_ |= Array.DESCENDING;
            }
            this.sortLists(_loc5_,_loc4_);
            this._dispatcher.dispatchEvent(new TeamTableSortEvent(param2,param3,this._sortingBonusType));
         }
      }
      
      protected function getColumns(param1:Boolean) : ColumnCollection
      {
         return !!param1 ? this._leftColumns : this._rightColumns;
      }
      
      protected function get columnTooltip() : Dictionary
      {
         return this._columnTooltip;
      }
      
      protected function get columnWidth() : Dictionary
      {
         return this._columnWidth;
      }
      
      protected function get sortingKey() : Dictionary
      {
         return this._sortingKey;
      }
      
      protected function get sortingIsNumeric() : Dictionary
      {
         return this._sortingIsNumeric;
      }
      
      protected function get sortingDirection() : Dictionary
      {
         return this._sortingDirection;
      }
      
      protected function get dispatcher() : IEventDispatcher
      {
         return this._dispatcher;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
