package net.wg.gui.bootcamp.interfaces
{
   import scaleform.clik.controls.Button;
   
   public interface IAnimatedButtonRenderer extends IAnimatedMovieClip
   {
       
      
      function get button() : Button;
      
      function set button(param1:Button) : void;
   }
}
