package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface INotifyProperties extends IDisposable
   {
       
      
      function set imgUrl(param1:String) : void;
      
      function get imgUrl() : String;
      
      function set messageArguments(param1:Array) : void;
      
      function get messageArguments() : Array;
      
      function set titleArguments(param1:Array) : void;
      
      function get titleArguments() : Array;
   }
}
