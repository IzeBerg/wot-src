package net.wg.gui.components.controls
{
   public class HelpButton extends SoundButtonEx
   {
       
      
      public function HelpButton()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         toggle = true;
         if(hitMc != null)
         {
            setSize(hitMc.width,hitMc.height);
            preventAutosizing = true;
         }
      }
   }
}
