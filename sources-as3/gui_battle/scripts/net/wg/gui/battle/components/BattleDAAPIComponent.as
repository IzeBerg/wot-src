package net.wg.gui.battle.components
{
   import net.wg.infrastructure.base.meta.IBattleDAAPIComponentMeta;
   import net.wg.infrastructure.base.meta.impl.BattleDAAPIComponentMeta;
   
   public class BattleDAAPIComponent extends BattleDAAPIComponentMeta implements IBattleDAAPIComponentMeta
   {
       
      
      public function BattleDAAPIComponent()
      {
         super();
      }
      
      public final function as_populate() : void
      {
         this.onPopulate();
      }
      
      public final function as_dispose() : void
      {
         dispose();
      }
      
      protected function onPopulate() : void
      {
      }
   }
}
