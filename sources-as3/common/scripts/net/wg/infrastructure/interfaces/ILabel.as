package net.wg.infrastructure.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ILabel extends ISprite, IDisposable
   {
       
      
      function setTextAutoSize(param1:String) : void;
      
      function get text() : String;
      
      function set text(param1:String) : void;
   }
}
