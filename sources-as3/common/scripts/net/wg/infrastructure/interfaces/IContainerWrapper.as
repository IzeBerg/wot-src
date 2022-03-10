package net.wg.infrastructure.interfaces
{
   import flash.display.DisplayObject;
   
   public interface IContainerWrapper extends IView
   {
       
      
      function getTutorialHintZone(param1:String) : DisplayObject;
      
      function removeTutorialHintZone(param1:String) : void;
   }
}
