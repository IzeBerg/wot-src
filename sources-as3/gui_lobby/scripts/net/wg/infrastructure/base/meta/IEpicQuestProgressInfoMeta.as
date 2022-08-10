package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicQuestProgressInfoMeta extends IEventDispatcher
   {
       
      
      function showQuestByIdS(param1:String, param2:String) : void;
      
      function as_updateData(param1:Array) : void;
   }
}
