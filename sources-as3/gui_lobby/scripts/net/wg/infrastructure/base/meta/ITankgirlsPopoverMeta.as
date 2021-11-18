package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ITankgirlsPopoverMeta extends IEventDispatcher
   {
       
      
      function onRecruitClickS(param1:String) : void;
      
      function as_setListDataProvider(param1:Array) : void;
   }
}
