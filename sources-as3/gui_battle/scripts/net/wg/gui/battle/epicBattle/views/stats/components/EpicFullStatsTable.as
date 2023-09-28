package net.wg.gui.battle.epicBattle.views.stats.components
{
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.components.buttons.BattleButton;
   import net.wg.gui.components.controls.ScrollBar;
   
   public class EpicFullStatsTable extends BattleUIComponent
   {
       
      
      public var team1TF:TextField = null;
      
      public var team2TF:TextField = null;
      
      public var team1PlayerList:PlayerScrollingList = null;
      
      public var team2PlayerList:PlayerScrollingList = null;
      
      public var team1ScrollBar:ScrollBar = null;
      
      public var team2ScrollBar:ScrollBar = null;
      
      public var squadAcceptBt:BattleButton = null;
      
      public var squadAddBt:BattleButton = null;
      
      public var statsFilters:EpicStatsTableFilterGroup = null;
      
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
   }
}
