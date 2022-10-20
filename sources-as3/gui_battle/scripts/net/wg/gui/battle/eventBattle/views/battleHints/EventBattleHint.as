package net.wg.gui.battle.eventBattle.views.battleHints
{
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.gui.battle.eventBattle.views.battleHints.event.BattleHintEvent;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class EventBattleHint extends BattleHintMeta implements IBattleHintMeta
   {
       
      
      public var hintContainer:InfoContainer = null;
      
      public function EventBattleHint()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hintContainer.addFrameScript(this.hintContainer.totalFrames - 1,this.onHintHidden);
      }
      
      override protected function onDispose() : void
      {
         this.hintContainer.dispose();
         this.hintContainer = null;
         super.onDispose();
      }
      
      override protected function showHint(param1:HintInfoVO) : void
      {
         this.hintContainer.showHint(param1);
         this.updateStage(App.appWidth,App.appHeight);
         dispatchEvent(new BattleHintEvent(BattleHintEvent.START_APPEAR));
      }
      
      public function as_hideHint() : void
      {
         this.hintContainer.hideHint();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.x = param1 >> 1;
      }
      
      private function onHintHidden() : void
      {
         dispatchEvent(new BattleHintEvent(BattleHintEvent.HIDING_COMPLETE));
      }
   }
}
