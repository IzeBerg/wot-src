package net.wg.gui.lobby.battleResults.controller
{
   import flash.events.IEventDispatcher;
   import net.wg.data.constants.ArenaBonusTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.battleResults.components.TeamStatsList;
   import net.wg.gui.lobby.battleResults.data.BattleResultsVO;
   import net.wg.gui.lobby.battleResults.data.ColumnCollection;
   import net.wg.gui.lobby.battleResults.data.ColumnData;
   import net.wg.gui.lobby.battleResults.data.CommonStatsVO;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import scaleform.clik.data.DataProvider;
   
   public class RTSTeamStatsController extends ScrollBarTeamStatsController
   {
       
      
      private var _arenaBonusType:Number = 0;
      
      private var _isCommander:Boolean = false;
      
      public function RTSTeamStatsController(param1:IEventDispatcher)
      {
         super(param1);
      }
      
      override protected function initColumns(param1:ColumnCollection, param2:CommonStatsVO) : Vector.<String>
      {
         var _loc3_:Boolean = param1.isLeft;
         this.initRTSColumnsData(param2,_loc3_);
         return this.getRTSColumnIds(param2,_loc3_);
      }
      
      override public function update(param1:BattleResultsVO) : void
      {
         this._arenaBonusType = param1.common.bonusType;
         this._isCommander = param1.personal.isCommander;
         super.update(param1);
      }
      
      override protected function setupRenderers(param1:TeamStatsList, param2:TeamStatsList) : void
      {
         if(this._arenaBonusType == ArenaBonusTypes.RTS_1x1)
         {
            param1.itemRendererName = Linkages.RTS_TEAM_LEFT_MEMBER_RENDERER_UI;
            param2.itemRendererName = Linkages.RTS_TEAM_RIGHT_MEMBER_RENDERER_UI;
         }
         else if(this._isCommander)
         {
            param1.itemRendererName = Linkages.RTS_TEAM_LEFT_MEMBER_RENDERER_UI;
            param2.itemRendererName = Linkages.RTS_TANKERS_TEAM_RIGHT_MEMBER_RENDERER_UI;
         }
         else
         {
            param1.itemRendererName = Linkages.RTS_TANKERS_TEAM_LEFT_MEMBER_RENDERER_UI;
            param2.itemRendererName = Linkages.RTS_TEAM_RIGHT_MEMBER_RENDERER_UI;
         }
      }
      
      override protected function sortDP(param1:DataProvider, param2:ColumnData, param3:Number) : void
      {
         var _loc7_:TeamMemberItemVO = null;
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:Number = NaN;
         var _loc12_:Object = null;
         var _loc13_:Array = null;
         if(!this.isRTSColumns(param2.isLeft))
         {
            super.sortDP(param1,param2,param3);
            return;
         }
         var _loc4_:Array = [];
         var _loc5_:Array = [];
         var _loc6_:Array = [];
         for each(_loc7_ in param1)
         {
            if(_loc7_.isRTSSeparator)
            {
               _loc6_.push(_loc7_);
            }
            else if(_loc7_.isSupply)
            {
               _loc5_.push(_loc7_);
            }
            else
            {
               _loc4_.push(_loc7_);
            }
         }
         param1.cleanUp();
         _loc8_ = [this.findOrCreateSeparator(RTS_BATTLES.BATTLERESULTS_BATTLEEFFICIENCY_SUPPLIES,_loc6_),_loc5_,this.findOrCreateSeparator(RTS_BATTLES.BATTLERESULTS_BATTLEEFFICIENCY_TECHNIQUE,_loc6_),_loc4_];
         _loc9_ = _loc8_.length;
         _loc10_ = param2.sortingKeys;
         _loc11_ = 0;
         while(_loc11_ < _loc9_)
         {
            _loc12_ = _loc8_[_loc11_];
            if(_loc12_ is Array)
            {
               _loc13_ = _loc12_ as Array;
               _loc13_.sortOn(_loc10_,param3);
               for each(_loc7_ in _loc13_)
               {
                  param1.push(_loc7_);
               }
            }
            else
            {
               param1.push(_loc12_);
            }
            _loc11_++;
         }
      }
      
      private function findOrCreateSeparator(param1:String, param2:Array) : TeamMemberItemVO
      {
         var _loc3_:int = param2.length;
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_)
         {
            if(param2[_loc4_].rtsSeparatorLabel == param1)
            {
               return param2[_loc4_];
            }
            _loc4_++;
         }
         return new TeamMemberItemVO({
            "isRTSSeparator":true,
            "rtsSeparatorLabel":param1
         });
      }
      
      private function initRTSColumnsData(param1:CommonStatsVO, param2:Boolean) : void
      {
         super.initColumnsData(param1);
         if(this.isRTSColumns(param2))
         {
            columnWidth[ColumnConstants.TANK] = ColumnConstants.FIRST_COLUMN_WIDTH + ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH + ColumnConstants.TANK_COLUMN_WIDTH + ColumnConstants.XP_COLUMN_WIDTH + ColumnConstants.DEFAULT_MEDAL_COLUMN_WIDTH;
         }
         else
         {
            columnWidth[ColumnConstants.PLAYER] = ColumnConstants.FIRST_COLUMN_WIDTH + ColumnConstants.DEFAULT_PLAYER_COLUMN_WIDTH + ColumnConstants.DEFAULT_MEDAL_COLUMN_WIDTH;
         }
      }
      
      private function getRTSColumnIds(param1:CommonStatsVO, param2:Boolean) : Vector.<String>
      {
         var _loc3_:Vector.<String> = new Vector.<String>(0);
         if(!this.isRTSColumns(param2))
         {
            if(param1.isShowSquad)
            {
               _loc3_.push(ColumnConstants.SQUAD);
            }
            _loc3_.push(ColumnConstants.PLAYER);
            _loc3_.push(ColumnConstants.TANK);
            _loc3_.push(ColumnConstants.DAMAGE);
            _loc3_.push(ColumnConstants.FRAG);
            _loc3_.push(ColumnConstants.XP);
         }
         else
         {
            _loc3_.push(ColumnConstants.TANK);
            _loc3_.push(ColumnConstants.DAMAGE);
            _loc3_.push(ColumnConstants.FRAG);
         }
         return _loc3_;
      }
      
      private function isRTSColumns(param1:Boolean) : Boolean
      {
         return this._arenaBonusType == ArenaBonusTypes.RTS_1x1 || this._isCommander && param1 || !this._isCommander && !param1;
      }
   }
}
