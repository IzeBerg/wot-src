package net.wg.infrastructure.interfaces
{
   import flash.events.IEventDispatcher;
   
   public interface ITutorialCustomComponent extends IEventDispatcher
   {
       
      
      function getTutorialDescriptionName() : String;
      
      function needPreventInnerEvents() : Boolean;
      
      function generatedUnstoppableEvents() : Boolean;
   }
}
