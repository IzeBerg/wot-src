package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IAtlasItemVO extends IDisposable
   {
       
      
      function get x() : int;
      
      function get y() : int;
      
      function get width() : int;
      
      function get height() : int;
      
      function get name() : String;
      
      function set name(param1:String) : void;
      
      function set height(param1:int) : void;
      
      function set width(param1:int) : void;
      
      function set x(param1:int) : void;
      
      function set y(param1:int) : void;
   }
}
