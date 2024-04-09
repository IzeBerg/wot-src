package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class DeathCamHudMeta extends BattleDisplayable
   {
       
      
      public var onAnimationFinished:Function;
      
      public function DeathCamHudMeta()
      {
         super();
      }
      
      public function onAnimationFinishedS() : void
      {
         App.utils.asserter.assertNotNull(this.onAnimationFinished,"onAnimationFinished" + Errors.CANT_NULL);
         this.onAnimationFinished();
      }
   }
}
