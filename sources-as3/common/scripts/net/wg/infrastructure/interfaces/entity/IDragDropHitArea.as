package net.wg.infrastructure.interfaces.entity
{
   import flash.display.InteractiveObject;
   import flash.events.IEventDispatcher;
   
   public interface IDragDropHitArea extends IEventDispatcher
   {
       
      
      function getHitArea() : InteractiveObject;
   }
}
