package net.wg.gui.tutorial.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.AbstractWindowView;
   
   public class TutorialBattleStatisticMeta extends AbstractWindowView
   {
       
      
      public var restart:Function;
      
      public var showVideoDialog:Function;
      
      public function TutorialBattleStatisticMeta()
      {
         super();
      }
      
      public function restartS() : void
      {
         App.utils.asserter.assertNotNull(this.restart,"restart" + Errors.CANT_NULL);
         this.restart();
      }
      
      public function showVideoDialogS() : void
      {
         App.utils.asserter.assertNotNull(this.showVideoDialog,"showVideoDialog" + Errors.CANT_NULL);
         this.showVideoDialog();
      }
   }
}
