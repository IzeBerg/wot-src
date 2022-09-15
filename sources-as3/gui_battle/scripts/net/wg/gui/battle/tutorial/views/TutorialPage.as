package net.wg.gui.battle.tutorial.views
{
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.battle.components.TimersPanel;
   import net.wg.gui.battle.tutorial.views.tutorial.BattleTutorial;
   import net.wg.gui.battle.views.BaseBattlePage;
   import net.wg.gui.battle.views.consumablesPanel.ConsumablesPanel;
   
   public class TutorialPage extends BaseBattlePage
   {
       
      
      public var battleTutorial:BattleTutorial = null;
      
      public var consumablesPanel:ConsumablesPanel = null;
      
      public var destroyTimersPanel:TimersPanel = null;
      
      public function TutorialPage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.battleTutorial.updateStage(param1,param2);
         this.consumablesPanel.updateStage(param1,param2);
         this.destroyTimersPanel.updateStage(param1,param2);
         super.updateStage(param1,param2);
      }
      
      override protected function onPopulate() : void
      {
         registerComponent(this.battleTutorial,BATTLE_VIEW_ALIASES.BATTLE_TUTORIAL);
         registerComponent(this.consumablesPanel,BATTLE_VIEW_ALIASES.CONSUMABLES_PANEL);
         registerComponent(this.destroyTimersPanel,BATTLE_VIEW_ALIASES.TIMERS_PANEL);
         super.onPopulate();
      }
      
      override protected function onDispose() : void
      {
         this.battleTutorial = null;
         this.consumablesPanel = null;
         this.destroyTimersPanel = null;
         super.onDispose();
      }
   }
}
