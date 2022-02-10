package net.wg.infrastructure.interfaces
{
   import flash.display.MovieClip;
   
   public interface IAnimation
   {
       
      
      function getTarget() : MovieClip;
      
      function setTarget(param1:MovieClip) : void;
   }
}
