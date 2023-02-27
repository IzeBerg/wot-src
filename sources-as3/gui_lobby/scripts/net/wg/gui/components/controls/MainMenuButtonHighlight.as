package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   
   public class MainMenuButtonHighlight extends MovieClip
   {
       
      
      public function MainMenuButtonHighlight()
      {
         super();
      }
      
      public function setSize(param1:uint) : void
      {
         gotoAndStop(MainMenuButtonSize.LAYOUT_LABEL[param1]);
      }
   }
}
