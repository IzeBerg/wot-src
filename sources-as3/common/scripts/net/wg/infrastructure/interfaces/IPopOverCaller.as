package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   
   public interface IPopOverCaller
   {
       
      
      function getTargetButton() : DisplayObject;
      
      function getHitArea() : DisplayObject;
   }
}
