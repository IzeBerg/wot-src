package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimer;
   
   public class Comp7PrebattleTimerMeta extends PrebattleTimer
   {
       
      
      public var onReadyBtnClick:Function;
      
      public function Comp7PrebattleTimerMeta()
      {
         super();
      }
      
      public function onReadyBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onReadyBtnClick,"onReadyBtnClick" + Errors.CANT_NULL);
         this.onReadyBtnClick();
      }
   }
}
