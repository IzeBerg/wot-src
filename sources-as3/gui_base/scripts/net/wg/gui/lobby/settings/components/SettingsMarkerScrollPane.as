package net.wg.gui.lobby.settings.components
{
   import net.wg.gui.components.controls.ResizableScrollPane;
   
   public class SettingsMarkerScrollPane extends ResizableScrollPane
   {
       
      
      public function SettingsMarkerScrollPane()
      {
         super();
      }
      
      override protected function drawScrollBar() : void
      {
         if(!_autoScrollBar)
         {
            return;
         }
         _scrollBar.x = _width - _scrollBar.width - scrollBarMargin + scrollBarShiftHorizontal | 0;
         _scrollBar.y = scrollBarMargin >> 1;
         _scrollBar.height = availableHeight - scrollBarMargin;
         _scrollBar.validateNow();
      }
   }
}
