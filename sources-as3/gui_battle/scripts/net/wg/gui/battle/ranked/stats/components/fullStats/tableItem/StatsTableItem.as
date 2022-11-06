package net.wg.gui.battle.ranked.stats.components.fullStats.tableItem
{
   import flash.display.MovieClip;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.views.stats.constants.FullStatsValidationType;
   import net.wg.gui.battle.views.stats.fullStats.StatsTableItemCommon;
   
   public class StatsTableItem extends StatsTableItemCommon
   {
      
      private static const NUM_ROWS:int = 10;
       
      
      private var _rankIcon:BattleAtlasSprite;
      
      private var _level:int;
      
      private var _division:int;
      
      private var _isGroup:Boolean;
      
      public function StatsTableItem(param1:MovieClip, param2:int, param3:int)
      {
         super(param1,param2,param3);
         var _loc4_:int = param2 * this.numRows + param3;
         this._rankIcon = param1.rankIconsCollection[_loc4_];
      }
      
      override public function reset() : void
      {
         this._level = 0;
         super.reset();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Function = null;
         super.draw();
         if(isInvalid(FullStatsValidationType.RANK))
         {
            this._rankIcon.visible = this._level > -1 || this._division > -1;
            if(this._rankIcon.visible)
            {
               _loc1_ = !!this._isGroup ? BATTLEATLAS.getRBRanksGroupIcon : BATTLEATLAS.getRBRankIcon;
               this._rankIcon.imageName = _loc1_(this._division.toString(),this._level.toString());
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._rankIcon = null;
         super.onDispose();
      }
      
      public function setRank(param1:int, param2:int, param3:Boolean) : void
      {
         if(this._level == param2 && this._division == param1 && this._isGroup == param3)
         {
            return;
         }
         this._level = param2;
         this._division = param1;
         this._isGroup = param3;
         invalidate(FullStatsValidationType.RANK);
      }
      
      override protected function get numRows() : uint
      {
         return NUM_ROWS;
      }
   }
}
