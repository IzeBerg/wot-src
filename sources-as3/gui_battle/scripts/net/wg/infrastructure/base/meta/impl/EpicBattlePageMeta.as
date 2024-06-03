package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.BaseBattlePage;
   
   public class EpicBattlePageMeta extends BaseBattlePage
   {
       
      
      public var onDeactivateRadialMenu:Function;
      
      public function EpicBattlePageMeta()
      {
         super();
      }
      
      public function onDeactivateRadialMenuS() : void
      {
         App.utils.asserter.assertNotNull(this.onDeactivateRadialMenu,"onDeactivateRadialMenu" + Errors.CANT_NULL);
         this.onDeactivateRadialMenu();
      }
   }
}
