package net.wg.gui.battle.eventBattle.views.battleHints
{
   import flash.display.Sprite;
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class EventBattleHint extends BattleHintMeta implements IBattleHintMeta
   {
       
      
      public var hintContainer:InfoContainer = null;
      
      private var _container:Sprite;
      
      public function EventBattleHint()
      {
         this._container = new Sprite();
         super();
         addChild(this._container);
         this._container.addChild(this.hintContainer);
      }
      
      override protected function onDispose() : void
      {
         this._container.removeChild(this.hintContainer);
         removeChild(this._container);
         this._container = null;
         this.hintContainer.dispose();
         this.hintContainer = null;
         super.onDispose();
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
         this.hintContainer.updateStage(param1,param2);
         this._container.x = param1 >> 1;
      }
   }
}
