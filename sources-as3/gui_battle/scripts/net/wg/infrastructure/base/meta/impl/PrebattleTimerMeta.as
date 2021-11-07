package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.prebattleTimer.PrebattleTimerBase;
   
   public class PrebattleTimerMeta extends PrebattleTimerBase
   {
       
      
      public var onShowInfo:Function;
      
      public var onHideInfo:Function;
      
      public function PrebattleTimerMeta()
      {
         super();
      }
      
      public function onShowInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.onShowInfo,"onShowInfo" + Errors.CANT_NULL);
         this.onShowInfo();
      }
      
      public function onHideInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.onHideInfo,"onHideInfo" + Errors.CANT_NULL);
         this.onHideInfo();
      }
   }
}
