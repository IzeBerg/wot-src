package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class BCBattleTopHintMeta extends BattleDisplayable
   {
       
      
      public var animFinish:Function;
      
      public function BCBattleTopHintMeta()
      {
         super();
      }
      
      public function animFinishS() : void
      {
         App.utils.asserter.assertNotNull(this.animFinish,"animFinish" + Errors.CANT_NULL);
         this.animFinish();
      }
   }
}
