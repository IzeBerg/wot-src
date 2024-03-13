package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class BattleRoyaleWinnerCongratsMeta extends BattleDisplayable
   {
       
      
      public var onBecomeVisible:Function;
      
      public function BattleRoyaleWinnerCongratsMeta()
      {
         super();
      }
      
      public function onBecomeVisibleS() : void
      {
         App.utils.asserter.assertNotNull(this.onBecomeVisible,"onBecomeVisible" + Errors.CANT_NULL);
         this.onBecomeVisible();
      }
   }
}
