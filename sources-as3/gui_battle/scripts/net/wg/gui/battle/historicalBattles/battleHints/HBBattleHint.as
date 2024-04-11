package net.wg.gui.battle.historicalBattles.battleHints
{
   import net.wg.gui.battle.historicalBattles.battleHints.data.HintInfoVO;
   import net.wg.infrastructure.base.meta.IHBBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.HBBattleHintMeta;
   
   public class HBBattleHint extends HBBattleHintMeta implements IHBBattleHintMeta
   {
      
      private static const PLAYERS_PANEL_WIDTH:int = 300;
      
      private static const HINT_CONTAINER_WIDTH:int = 800;
       
      
      public var hintContainer:InfoContainer = null;
      
      public function HBBattleHint()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.hintContainer.dispose();
         this.hintContainer = null;
         super.onDispose();
      }
      
      public function as_closeHint() : void
      {
         this.hintContainer.hideHint();
      }
      
      public function as_hideHint() : void
      {
         this.hintContainer.hideHint();
      }
      
      override protected function showHint(param1:HintInfoVO) : void
      {
         this.hintContainer.showHint(param1);
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = param1 >> 1;
         this.hintContainer.x = _loc3_;
         if(_loc3_ < PLAYERS_PANEL_WIDTH + (HINT_CONTAINER_WIDTH >> 1))
         {
            this.hintContainer.setWidth(_loc3_ - PLAYERS_PANEL_WIDTH << 1);
         }
         else
         {
            this.hintContainer.setWidth(HINT_CONTAINER_WIDTH);
         }
      }
   }
}
