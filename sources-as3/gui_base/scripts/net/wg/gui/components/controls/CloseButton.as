package net.wg.gui.components.controls
{
   import net.wg.data.constants.SoundTypes;
   
   public class CloseButton extends SoundButtonEx
   {
       
      
      public function CloseButton()
      {
         super();
         soundType = SoundTypes.CLOSE_WINDOW;
      }
   }
}
