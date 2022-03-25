package net.wg.gui.battle.commanderBootcamp.views
{
   import net.wg.data.constants.generated.BATTLE_VIEW_ALIASES;
   import net.wg.gui.bootcamp.BCSecondaryHint;
   import net.wg.gui.bootcamp.battleTopHint.BCBattleTopHint;
   import net.wg.infrastructure.base.meta.IBCCommanderBattlePageMeta;
   import net.wg.infrastructure.base.meta.impl.BCCommanderBattlePageMeta;
   
   public class BCCommanderBattlePage extends BCCommanderBattlePageMeta implements IBCCommanderBattlePageMeta
   {
      
      private static const SEC_HINT_OFFSET_Y:int = 30;
      
      private static const RIBBONS_CENTER_SCREEN_OFFSET_Y:int = 185;
       
      
      public var secondaryHint:BCSecondaryHint;
      
      public var battleTopHint:BCBattleTopHint;
      
      public function BCCommanderBattlePage()
      {
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.battleTopHint.updateStage(param1,param2);
         this.secondaryHint.y = ribbonsPanel.y - SEC_HINT_OFFSET_Y;
         this.secondaryHint.x = param1 >> 1;
      }
      
      override protected function getRibbonsCenterOffset(param1:Number) : int
      {
         return RIBBONS_CENTER_SCREEN_OFFSET_Y;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.secondaryHint,BATTLE_VIEW_ALIASES.BOOTCAMP_SECONDARY_HINT);
         registerFlashComponentS(this.battleTopHint,BATTLE_VIEW_ALIASES.BOOTCAMP_BATTLE_TOP_HINT);
      }
      
      override protected function onDispose() : void
      {
         this.secondaryHint = null;
         this.battleTopHint = null;
         super.onDispose();
      }
      
      override protected function get isQuestProgress() : Boolean
      {
         return false;
      }
      
      override protected function registerSpecificComponents() : void
      {
      }
   }
}
