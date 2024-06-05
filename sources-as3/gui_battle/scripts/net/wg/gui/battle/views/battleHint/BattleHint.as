package net.wg.gui.battle.views.battleHint
{
   import net.wg.gui.battle.views.battleHint.containers.HintContainer;
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class BattleHint extends BattleHintMeta implements IBattleHintMeta
   {
      
      private static const FRAME_SHOW_FINISH:int = 33;
      
      private static const FRAME_HIDE_FINISH:int = 65;
       
      
      public var hintContainer:HintContainer = null;
      
      private var _isFadingIn:Boolean = false;
      
      private var _isFadingOut:Boolean = false;
      
      private var _isHidePending:Boolean = false;
      
      public function BattleHint()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hintContainer.addFrameScript(FRAME_SHOW_FINISH,this.onFadeInFinishedHandler);
         this.hintContainer.addFrameScript(FRAME_HIDE_FINISH,this.onFadeOutFinishedHandler);
      }
      
      override protected function onDispose() : void
      {
         this.hintContainer.addFrameScript(FRAME_SHOW_FINISH,null);
         this.hintContainer.addFrameScript(FRAME_HIDE_FINISH,null);
         this.hintContainer.dispose();
         this.hintContainer = null;
         super.onDispose();
      }
      
      public function as_hideHint() : void
      {
         if(this._isFadingIn)
         {
            this._isHidePending = true;
         }
         else
         {
            this._isFadingOut = true;
            this.hintContainer.hideHint();
         }
      }
      
      public function as_cancelFadeOut() : void
      {
         this.cancelFadeOut();
      }
      
      override protected function showHint(param1:BattleHintVO) : void
      {
         this._isFadingIn = true;
         this.hintContainer.showHint(param1);
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.updateStage(param1);
         this.hintContainer.x = param1 >> 1;
      }
      
      private function cancelFadeOut() : void
      {
         this._isFadingOut = false;
         this.hintContainer.stopHint();
      }
      
      private function onFadeInFinishedHandler() : void
      {
         this.hintContainer.stop();
         this._isFadingIn = false;
         if(this._isHidePending)
         {
            this._isHidePending = false;
            this.hintContainer.hideHint();
         }
      }
      
      private function onFadeOutFinishedHandler() : void
      {
         this.cancelFadeOut();
         onFadeOutFinishedS();
      }
   }
}
