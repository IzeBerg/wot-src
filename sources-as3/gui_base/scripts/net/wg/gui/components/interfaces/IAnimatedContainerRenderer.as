package net.wg.gui.components.interfaces
{
   import flash.display.DisplayObject;
   
   public interface IAnimatedContainerRenderer extends IAnimatedMovieClip
   {
       
      
      function addContent(param1:DisplayObject) : void;
      
      function removeContent(param1:DisplayObject) : void;
   }
}
