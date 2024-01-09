package net.wg.gui.battle.epicBattle.views.stats.components
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.components.controls.ScrollBar;
   
   public class EpicFullStatsTable extends BattleUIComponent
   {
      
      private static const STATS_FILTER_Y:int = -158;
      
      private static const STATS_FILTER_Y_SMALL:int = -121;
      
      private static const GENERAL_BONUS_Y:int = -88;
      
      private static const GENERAL_BONUS_Y_SMALL:int = -75;
       
      
      public var team1TF:TextField = null;
      
      public var team2TF:TextField = null;
      
      public var team1PlayerList:PlayerScrollingList = null;
      
      public var team2PlayerList:PlayerScrollingList = null;
      
      public var team1ScrollBar:ScrollBar = null;
      
      public var team2ScrollBar:ScrollBar = null;
      
      public var squadAcceptBt:BattleButton = null;
      
      public var squadAddBt:BattleButton = null;
      
      public var statsFilters:EpicStatsTableFilterGroup = null;
      
      public var generalBonus:EpicStatsGeneralBonus = null;
      
      public function EpicFullStatsTable()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.squadAcceptBt.dispose();
         this.squadAcceptBt = null;
         this.squadAddBt.dispose();
         this.squadAddBt = null;
         this.statsFilters.dispose();
         this.statsFilters = null;
         this.generalBonus.dispose();
         this.generalBonus = null;
         this.team1TF = null;
         this.team2TF = null;
         this.team1PlayerList.dispose();
         this.team1PlayerList = null;
         this.team2PlayerList.dispose();
         this.team2PlayerList = null;
         this.team1ScrollBar.dispose();
         this.team1ScrollBar = null;
         this.team2ScrollBar.dispose();
         this.team2ScrollBar = null;
         super.onDispose();
      }
      
      public function updateSize(param1:Boolean) : void
      {
         if(param1)
         {
            this.statsFilters.y = STATS_FILTER_Y_SMALL;
            this.generalBonus.y = GENERAL_BONUS_Y_SMALL;
         }
         else
         {
            this.statsFilters.y = STATS_FILTER_Y;
            this.generalBonus.y = GENERAL_BONUS_Y;
         }
      }
   }
}
