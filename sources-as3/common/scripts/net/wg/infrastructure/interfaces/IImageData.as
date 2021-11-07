package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface IImageData extends IEventDispatcher
   {
       
      
      function showTo(param1:IImage) : void;
      
      function removeFrom(param1:IImage) : void;
      
      function get ready() : Boolean;
   }
}
