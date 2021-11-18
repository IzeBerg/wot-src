package net.wg.gui.lobby.rankedBattles19.view.stats
{
   import flash.display.Sprite;
   import net.wg.gui.lobby.rankedBattles19.components.stats.RankedBattleStats;
   import net.wg.gui.lobby.rankedBattles19.data.LeaguesStatsBlockVO;
   
   public class LeaguesStatsBlock extends StatsBlock
   {
      
      private static const GAP_BIG:int = 200;
      
      private static const GAP_SMALL:int = 170;
       
      
      public var stripesInLeague:RankedBattleStats = null;
      
      public var battlesInLeague:RankedBattleStats = null;
      
      public var stripesTotal:RankedBattleStats = null;
      
      public var battlesTotal:RankedBattleStats = null;
      
      public var separator1:Sprite = null;
      
      public var separator2:Sprite = null;
      
      public var separator3:Sprite = null;
      
      private var _data:LeaguesStatsBlockVO = null;
      
      private var _blocks:Vector.<RankedBattleStats> = null;
      
      public function LeaguesStatsBlock()
      {
         super();
         this._blocks = new <RankedBattleStats>[this.stripesInLeague,this.battlesInLeague,this.stripesTotal,this.battlesTotal];
      }
      
      override protected function minimizeElements() : void
      {
         var _loc2_:RankedBattleStats = null;
         super.minimizeElements();
         var _loc1_:int = -GAP_SMALL * (this._blocks.length - 1) >> 1;
         for each(_loc2_ in this._blocks)
         {
            _loc2_.minimize();
            _loc2_.x = _loc1_;
            _loc1_ += GAP_SMALL;
         }
         this.separator1.x = 0;
         this.separator2.x = -GAP_SMALL;
         this.separator3.x = GAP_SMALL;
      }
      
      override protected function maximizeElements() : void
      {
         var _loc2_:RankedBattleStats = null;
         super.maximizeElements();
         var _loc1_:int = -GAP_BIG * (this._blocks.length - 1) >> 1;
         for each(_loc2_ in this._blocks)
         {
            _loc2_.maximize();
            _loc2_.x = _loc1_;
            _loc1_ += GAP_BIG;
         }
         this.separator1.x = 0;
         this.separator2.x = -GAP_BIG;
         this.separator3.x = GAP_BIG;
      }
      
      override protected function onDispose() : void
      {
         this._blocks.length = 0;
         this._blocks = null;
         this.stripesInLeague.dispose();
         this.stripesInLeague = null;
         this.battlesInLeague.dispose();
         this.battlesInLeague = null;
         this.stripesTotal.dispose();
         this.stripesTotal = null;
         this.battlesTotal.dispose();
         this.battlesTotal = null;
         this.separator1 = null;
         this.separator2 = null;
         this.separator3 = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:LeaguesStatsBlockVO) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = param1;
            this.stripesInLeague.setData(this._data.stripesInLeague);
            this.battlesInLeague.setData(this._data.battlesInLeague);
            this.stripesTotal.setData(this._data.stripesTotal);
            this.battlesTotal.setData(this._data.battlesTotal);
         }
      }
   }
}
