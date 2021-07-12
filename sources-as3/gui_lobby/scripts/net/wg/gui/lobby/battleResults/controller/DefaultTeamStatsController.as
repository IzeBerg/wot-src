package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.InteractiveSortingButton;
   import net.wg.gui.components.advanced.SortableHeaderButtonBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.lobby.battleResults.components.TeamMemberStatsViewBase;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.cs.CsTeamStats;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.ColumnCollection;
   import net.wg.gui.lobby.battleResults.data.ColumnData;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class DefaultTeamStatsController extends TeamStatsControllerAbstract
   {
       
      
      private var _header1:SortableHeaderButtonBar;
      
      private var _team1List:TeamStatsList;
      
      private var _header2:SortableHeaderButtonBar;
      
      private var _team2List:TeamStatsList;
      
      private var _teamResourceTotal:TextField;
      
      private var _teamInfluenceTotal:TextField;
      
      private var _ownTitle:TextField;
      
      private var _enemyTitle:TextField;
      
      private var _csAlly:CsTeamStats;
      
      private var _csEnemy:CsTeamStats;
      
      public function DefaultTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         this._teamResourceTotal = null;
         this._teamInfluenceTotal = null;
         this._ownTitle = null;
         this._enemyTitle = null;
         this._header1 = null;
         this._team1List = null;
         this._header2 = null;
         this._team2List = null;
         this._csAlly = null;
         this._csEnemy = null;
         super.dispose();
      }
      
      override public function onHeaderClick(param1:InteractiveSortingButton, param2:SortableHeaderButtonBar) : void
      {
         var _loc3_:SortableHeaderButtonBar = param2 == this._header1 ? this._header2 : this._header1;
         _loc3_.selectedIndex = param2.selectedIndex;
         var _loc4_:InteractiveSortingButton = InteractiveSortingButton(_loc3_.getButtonAt(param2.selectedIndex));
         _loc4_.sortDirection = param1.sortDirection;
         super.onHeaderClick(param1,param2);
      }
      
      override public function update(param1:BattleResultsVO) : void
      {
         super.update(param1);
         this.setupResources(param1);
         this.setupCybersport(param1,this._csAlly,this._csEnemy,this._header1,this._header2,this._team1List,this._team2List);
         if(param1.selectedTeamMemberId >= 0)
         {
            this.selectTeamListItem(this._team1List,param1.selectedTeamMemberId);
         }
      }
      
      override protected function setupLists(param1:BattleResultsVO) : void
      {
         this.setupTitles(param1,this._ownTitle,this._enemyTitle);
         this.setupRenderers(this._team1List,this._team2List);
         setupList(param1.team1,param1.common,this._team1List);
         setupList(param1.team2,param1.common,this._team2List);
      }
      
      override protected function setupTeamListHeaders(param1:ColumnCollection, param2:int, param3:String) : void
      {
         if(this._header1.dataProvider != null)
         {
            this._header1.dataProvider.cleanUp();
         }
         this._header1.dataProvider = this._header2.dataProvider = new DataProvider(param1.getHeaderData());
         this._header1.selectedIndex = this._header2.selectedIndex = param2;
         this._header1.validateNow();
         this._header2.validateNow();
         var _loc4_:InteractiveSortingButton = InteractiveSortingButton(this._header1.getButtonAt(param2));
         var _loc5_:InteractiveSortingButton = InteractiveSortingButton(this._header2.getButtonAt(param2));
         _loc4_.sortDirection = _loc5_.sortDirection = param3;
      }
      
      override protected function getColumnIds(param1:CommonStatsVO) : Vector.<String>
      {
         var _loc2_:Vector.<String> = new Vector.<String>(0);
         if(param1.isShowSquad)
         {
            _loc2_.push(ColumnConstants.SQUAD);
         }
         _loc2_.push(ColumnConstants.PLAYER);
         _loc2_.push(ColumnConstants.TANK);
         _loc2_.push(ColumnConstants.DAMAGE);
         _loc2_.push(ColumnConstants.FRAG);
         _loc2_.push(ColumnConstants.XP);
         _loc2_.push(ColumnConstants.MEDAL);
         return _loc2_;
      }
      
      override protected function sortLists(param1:ColumnData, param2:Number) : void
      {
         this.sortList(this._team1List,param1,param2);
         this.sortList(this._team2List,param1,param2);
      }
      
      public function handleListIndexChange(param1:ScrollingListEx, param2:TeamMemberStatsViewBase, param3:TeamMemberStatsViewBase, param4:BattleResultsVO) : void
      {
         var _loc7_:ScrollingListEx = null;
         if(param1.selectedIndex != -1)
         {
            _loc7_ = param1 == this._team1List ? this._team2List : this._team1List;
            _loc7_.selectedIndex = -1;
            _loc7_.validateNow();
         }
         param2.data = TeamMemberItemVO(this._team1List.dataProvider[this._team1List.selectedIndex]);
         param3.data = TeamMemberItemVO(this._team2List.dataProvider[this._team2List.selectedIndex]);
         param2.visible = this._team1List.selectedIndex > -1 && param2.data;
         param3.visible = this._team2List.selectedIndex > -1 && param3.data;
         var _loc5_:Boolean = this._team2List.selectedIndex == -1 || !param3.visible;
         var _loc6_:Boolean = this._team1List.selectedIndex == -1 || !param2.visible;
         this._team1List.tabEnabled = this._team1List.visible = this._header1.visible = _loc5_;
         this._team2List.tabEnabled = this._team2List.visible = this._header2.visible = _loc6_;
      }
      
      public function setCybersport(param1:CsTeamStats, param2:CsTeamStats) : void
      {
         this._csAlly = param1;
         this._csEnemy = param2;
      }
      
      public function setResources(param1:TextField, param2:TextField) : void
      {
         this._teamResourceTotal = param1;
         this._teamInfluenceTotal = param2;
      }
      
      public function setTables(param1:SortableHeaderButtonBar, param2:SortableHeaderButtonBar, param3:TeamStatsList, param4:TeamStatsList) : void
      {
         this._header1 = param1;
         this._team1List = param3;
         this._header2 = param2;
         this._team2List = param4;
      }
      
      public function setTitles(param1:TextField, param2:TextField) : void
      {
         this._ownTitle = param1;
         this._enemyTitle = param2;
      }
      
      protected function setupResources(param1:BattleResultsVO) : void
      {
         this._teamInfluenceTotal.visible = false;
         this._teamResourceTotal.visible = false;
      }
      
      protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList) : void
      {
         param1.itemRendererName = Linkages.TEAM_LEFT_MEMBER_RENDERER;
         param2.itemRendererName = Linkages.TEAM_RIGHT_MEMBER_RENDERER;
      }
      
      protected function setupCybersport(param1:BattleResultsVO, param2:CsTeamStats, param3:CsTeamStats, param4:SortableHeaderButtonBar, param5:SortableHeaderButtonBar, param6:TeamStatsList, param7:TeamStatsList) : void
      {
         param2.visible = param3.visible = false;
      }
      
      protected function setupTitles(param1:BattleResultsVO, param2:TextField, param3:TextField) : void
      {
         param2.htmlText = param1.textData.ownTitle;
         param3.htmlText = param1.textData.enemyTitle;
      }
      
      private function selectTeamListItem(param1:TeamStatsList, param2:Number) : void
      {
         var _loc6_:TeamMemberItemVO = null;
         var _loc3_:IDataProvider = param1.dataProvider;
         var _loc4_:int = _loc3_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = TeamMemberItemVO(_loc3_.requestItemAt(_loc5_));
            if(_loc6_.playerId == param2)
            {
               param1.selectedIndex = _loc5_;
               break;
            }
            _loc5_++;
         }
      }
      
      private function sortList(param1:TeamStatsList, param2:ColumnData, param3:Number) : void
      {
         var _loc4_:Number = -1;
         var _loc5_:Object = param1.getSelectedVO();
         if(_loc5_ != null)
         {
            _loc4_ = TeamMemberItemVO(_loc5_).playerId;
         }
         var _loc6_:DataProvider = DataProvider(param1.dataProvider);
         _loc6_.sortOn(param2.sortingKeys,param3);
         param1.invalidateData();
         if(_loc4_ >= 0)
         {
            this.selectTeamListItem(param1,_loc4_);
         }
         else
         {
            param1.selectedIndex = -1;
         }
      }
      
      protected function get teamResourceTotal() : TextField
      {
         return this._teamResourceTotal;
      }
      
      protected function get teamInfluenceTotal() : TextField
      {
         return this._teamInfluenceTotal;
      }
      
      protected function get ownTitle() : TextField
      {
         return this._ownTitle;
      }
      
      protected function get enemyTitle() : TextField
      {
         return this._enemyTitle;
      }
   }
}
