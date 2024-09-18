package net.wg.gui.battle.eventBattle.views.battleHints
{
   import flash.display.Sprite;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class EventBattleHint extends BattleHintMeta implements IBattleHintMeta
   {
      
      private static const EVENT_MESSAGE_Y_POSITION_SMALL_SCREEN:int = 100;
      
      private static const EVENT_MESSAGE_Y_POSITION_MEDIUM_SCREEN:int = 150;
      
      private static const EVENT_MESSAGE_Y_POSITION_BIG_SCREEN:int = 200;
      
      private static const SCREEN_MEDIUM_WIDTH:Number = 1920;
      
      private static const SCREEN_MEDIUM_HEIGHT:Number = 1080;
      
      private static const SCREEN_SMALL_WIDTH:Number = 1280;
      
      private static const SCREEN_SMALL_HEIGHT:Number = 720;
       
      
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
      
      override protected function showHint(param1:BattleHintVO) : void
      {
         this.alignBattleMessages(parent.width,parent.height);
         this.hintContainer.showHint(param1);
      }
      
      public function alignBattleMessages(param1:Number, param2:Number) : void
      {
         if(param2 <= SCREEN_SMALL_HEIGHT || param1 <= SCREEN_SMALL_WIDTH)
         {
            this.y = EVENT_MESSAGE_Y_POSITION_SMALL_SCREEN;
         }
         else if(param2 <= SCREEN_MEDIUM_HEIGHT || param1 <= SCREEN_MEDIUM_WIDTH)
         {
            this.y = EVENT_MESSAGE_Y_POSITION_MEDIUM_SCREEN;
         }
         else
         {
            this.y = EVENT_MESSAGE_Y_POSITION_BIG_SCREEN;
         }
      }
      
      public function as_cancelFadeOut() : void
      {
         this.hintContainer.hideHintImmediately();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.updateStage(param1,param2);
         this._container.x = param1 >> 1;
      }
   }
}
