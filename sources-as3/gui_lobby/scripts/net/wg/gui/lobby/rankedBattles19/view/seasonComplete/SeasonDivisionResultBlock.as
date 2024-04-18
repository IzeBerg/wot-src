package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import net.wg.gui.lobby.rankedBattles19.events.SeasonCompleteEvent;
   
   public class SeasonDivisionResultBlock extends SeasonBaseResultBlock
   {
       
      
      public var descrLabel:SeasonTextWrapper;
      
      public function SeasonDivisionResultBlock()
      {
         super();
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         this.descrLabel.setText(data.descr);
      }
      
      override protected function onDispose() : void
      {
         this.descrLabel.dispose();
         this.descrLabel = null;
         super.onDispose();
      }
      
      override protected function onEndFadeInAnim() : void
      {
         super.onEndFadeInAnim();
         dispatchEvent(new SeasonCompleteEvent(SeasonCompleteEvent.RESULT_BLOCK_READY));
      }
   }
}
