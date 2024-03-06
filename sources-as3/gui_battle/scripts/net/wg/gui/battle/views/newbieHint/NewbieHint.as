package net.wg.gui.battle.views.newbieHint
{
   import net.wg.gui.battle.views.battleHint.vo.BattleHintVO;
   import net.wg.gui.battle.views.newbieHint.containers.HintContainer;
   import net.wg.infrastructure.base.meta.IBattleHintMeta;
   import net.wg.infrastructure.base.meta.impl.BattleHintMeta;
   
   public class NewbieHint extends BattleHintMeta implements IBattleHintMeta
   {
      
      private static const FRAME_SHOW_FINISH:int = 46;
      
      private static const FRAME_HIDE_FINISH:int = 76;
       
      
      public var hintContainer:HintContainer = null;
      
      private var _isFadingIn:Boolean = false;
      
      private var _isHidePending:Boolean = false;
      
      public function NewbieHint()
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
            this.hideHint();
         }
      }
      
      public function as_cancelFadeOut() : void
      {
         this.stopFadeOut();
      }
      
      override protected function showHint(param1:BattleHintVO) : void
      {
         this.hintContainer.showHint(param1);
         this._isFadingIn = true;
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this.hintContainer.x = param1 >> 1;
         this.hintContainer.updateStage(param1,param2);
      }
      
      private function stopFadeOut() : void
      {
         this.hintContainer.stopHint();
      }
      
      private function hideHint() : void
      {
         this._isHidePending = false;
         this.hintContainer.hideHint();
      }
      
      private function onFadeInFinishedHandler() : void
      {
         this.hintContainer.stop();
         this._isFadingIn = false;
         if(this._isHidePending)
         {
            this.hideHint();
         }
      }
      
      private function onFadeOutFinishedHandler() : void
      {
         this.stopFadeOut();
         onFadeOutFinishedS();
      }
   }
}
