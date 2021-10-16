package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class RadarButtonMeta extends BattleDisplayable
   {
       
      
      public var onClick:Function;
      
      public function RadarButtonMeta()
      {
         super();
      }
      
      public function onClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onClick,"onClick" + Errors.CANT_NULL);
         this.onClick();
      }
   }
}
