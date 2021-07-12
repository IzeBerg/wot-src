package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITrainingFormMeta extends IEventDispatcher
   {
       
      
      function joinTrainingRequestS(param1:String) : void;
      
      function createTrainingRequestS() : void;
      
      function onEscapeS() : void;
      
      function onLeaveS() : void;
      
      function as_setInfo(param1:Object) : void;
      
      function as_setList(param1:Object) : void;
   }
}
