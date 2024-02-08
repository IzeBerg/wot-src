package net.wg.gui.battle.eventBattle.views.battleHints
{
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class EventBattleHint extends BattleHintMeta implements IBattleHintMeta
   {
       
      
      public var hintContainer:InfoContainer = null;
      
      public function EventBattleHint()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.hintContainer.dispose();
         this.hintContainer = null;
         super.onDispose();
      }
      
      public function as_hideHint() : void
      {
         this.hintContainer.hideHint();
      }
      
      override protected function showHint(param1:BattleHintVO) : void
      {
         this.hintContainer.showHint(param1);
         this.updateStage(App.appWidth,App.appHeight);
      }
      
      public function as_cancelFadeOut() : void
      {
         this.hintContainer.closeHint();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.x = param1 >> 1;
      }
   }
}
