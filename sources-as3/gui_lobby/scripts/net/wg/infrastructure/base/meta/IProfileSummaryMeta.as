package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IProfileSummaryMeta extends IEventDispatcher
   {
       
      
      function getGlobalRatingS(param1:String) : Number;
      
      function as_setUserData(param1:Object) : void;
   }
}
