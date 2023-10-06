package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITutorialView extends IDisplayObjectContainer, IDisposable
   {
       
      
      function get tutorialId() : String;
      
      function set tutorialId(param1:String) : void;
      
      function get isResizable() : Boolean;
   }
}
