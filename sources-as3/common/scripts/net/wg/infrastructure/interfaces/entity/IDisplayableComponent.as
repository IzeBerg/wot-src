package net.wg.infrastructure.interfaces.entity
{
   public interface IDisplayableComponent extends IDisplayable
   {
       
      
      function setCompVisible(param1:Boolean) : void;
      
      function isCompVisible() : Boolean;
   }
}
