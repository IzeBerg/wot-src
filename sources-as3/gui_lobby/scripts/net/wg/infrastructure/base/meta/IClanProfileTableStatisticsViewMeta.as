package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanProfileTableStatisticsViewMeta extends IEventDispatcher
   {
       
      
      function as_setData(param1:Object) : void;
      
      function as_setAdditionalText(param1:Boolean, param2:String) : void;
      
      function as_getDP() : Object;
   }
}
