package net.wg.infrastructure.interfaces
{
   public interface IWindowGeometry
   {
       
      
      function canOverwrite() : Boolean;
      
      function setSize(param1:IWindow) : Boolean;
      
      function setPosition(param1:IWindow) : Boolean;
      
      function get positionStrategy() : String;
      
      function set positionStrategy(param1:String) : void;
   }
}
