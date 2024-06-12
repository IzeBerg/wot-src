package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class EarlyAccessButton extends SoundButtonEx
   {
       
      
      public function EarlyAccessButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         focusIndicator = new MovieClip();
      }
      
      override protected function onDispose() : void
      {
         focusIndicator = null;
         super.onDispose();
      }
   }
}
