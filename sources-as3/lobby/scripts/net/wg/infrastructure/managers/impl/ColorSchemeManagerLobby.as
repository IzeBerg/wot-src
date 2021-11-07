package net.wg.infrastructure.managers.impl
{
   import net.wg.infrastructure.events.ColorSchemeEvent;
   
   public class ColorSchemeManagerLobby extends ColorSchemeManager
   {
       
      
      public function ColorSchemeManagerLobby()
      {
         super();
      }
      
      override public function as_update() : void
      {
         super.as_update();
         dispatchEvent(new ColorSchemeEvent(ColorSchemeEvent.SCHEMAS_UPDATED));
      }
   }
}
