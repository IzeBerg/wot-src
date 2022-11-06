package net.wg.data.managers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IToolTipParams extends IDisposable
   {
       
      
      function get header() : Object;
      
      function set header(param1:Object) : void;
      
      function get body() : Object;
      
      function set body(param1:Object) : void;
      
      function get note() : Object;
      
      function set note(param1:Object) : void;
   }
}
