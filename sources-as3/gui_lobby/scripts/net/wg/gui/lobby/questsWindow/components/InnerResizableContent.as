package net.wg.gui.lobby.questsWindow.components
{
   public class InnerResizableContent extends EventsResizableContent
   {
      
      private static const AVAILABLE_WIDTH:int = 365;
       
      
      public function InnerResizableContent()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         headerYShift = -4;
         super.configUI();
         resizableContainer.availableWidth = AVAILABLE_WIDTH;
      }
   }
}
