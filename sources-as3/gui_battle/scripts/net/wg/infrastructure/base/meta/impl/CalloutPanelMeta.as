package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   
   public class CalloutPanelMeta extends BattleDisplayable
   {
       
      
      public var onHideCompleted:Function;
      
      public var onHideStart:Function;
      
      public function CalloutPanelMeta()
      {
         super();
      }
      
      public function onHideCompletedS() : void
      {
         App.utils.asserter.assertNotNull(this.onHideCompleted,"onHideCompleted" + Errors.CANT_NULL);
         this.onHideCompleted();
      }
      
      public function onHideStartS() : void
      {
         App.utils.asserter.assertNotNull(this.onHideStart,"onHideStart" + Errors.CANT_NULL);
         this.onHideStart();
      }
   }
}
