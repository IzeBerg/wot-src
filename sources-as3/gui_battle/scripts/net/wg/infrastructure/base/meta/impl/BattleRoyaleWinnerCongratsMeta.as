package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class BattleRoyaleWinnerCongratsMeta extends BattleDisplayable
   {
       
      
      public var playWinSound:Function;
      
      public function BattleRoyaleWinnerCongratsMeta()
      {
         super();
      }
      
      public function playWinSoundS() : void
      {
         App.utils.asserter.assertNotNull(this.playWinSound,"playWinSound" + Errors.CANT_NULL);
         this.playWinSound();
      }
   }
}
