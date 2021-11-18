package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ISeniorityAwardsEntryPointMeta extends IEventDispatcher
   {
       
      
      function onClickS() : void;
      
      function playSoundS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
   }
}
