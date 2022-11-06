package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IMissionsListViewBaseMeta extends IEventDispatcher
   {
       
      
      function openMissionDetailsViewS(param1:String, param2:String) : void;
      
      function as_getDP() : Object;
      
      function as_scrollToItem(param1:String, param2:String) : void;
   }
}
