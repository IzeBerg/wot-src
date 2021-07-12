package net.wg.gui.lobby.colorSettings.components
{
   import net.wg.gui.lobby.colorSettings.events.ColorSettingsRendererEvent;
   
   public class ColorSettingsFilterRenderer extends ColorSettingsButtonRenderer
   {
       
      
      public function ColorSettingsFilterRenderer()
      {
         super();
      }
      
      override protected function clickHandler() : void
      {
         dispatchEvent(new ColorSettingsRendererEvent(ColorSettingsRendererEvent.FILTER_SELECTED,buttonData.id));
      }
   }
}
