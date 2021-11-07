package net.wg.gui.battle.eventBattle.views.battleHints
{
   import net.wg.gui.battle.eventBattle.views.battleHints.data.HintInfoVO;
   import net.wg.gui.battle.eventBattle.views.battleHints.event.BattleHintEvent;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class EventBattleHint extends BattleHintMeta implements IBattleHintMeta
   {
      
      private static const PLAYERS_PANEL_WIDTH:int = 300;
      
      private static const HINT_CONTAINER_WIDTH:int = 800;
      
      private static const BOTTOM_OFFSET:int = 120;
       
      
      public var hintContainer:InfoContainer = null;
      
      private var _isShown:Boolean = false;
      
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
      
      public function as_closeHint() : void
      {
         this.as_hideHint();
      }
      
      public function as_hideHint() : void
      {
         this.hintContainer.hideHint();
         this._isShown = false;
         dispatchEvent(new BattleHintEvent(BattleHintEvent.HINT_CHANGED));
      }
      
      override protected function showHint(param1:String, param2:HintInfoVO) : void
      {
         this.hintContainer.showHint(param1,param2);
         this.updateStage(App.appWidth,App.appHeight);
         this._isShown = true;
         dispatchEvent(new BattleHintEvent(BattleHintEvent.HINT_CHANGED));
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         var _loc3_:uint = 0;
         _loc3_ = param1 >> 1;
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
      
      public function get isShown() : Boolean
      {
         return this._isShown;
      }
      
      public function getMessageBottom() : int
      {
         return BOTTOM_OFFSET + this.hintContainer.txtMessage.txt.textHeight;
      }
   }
}
