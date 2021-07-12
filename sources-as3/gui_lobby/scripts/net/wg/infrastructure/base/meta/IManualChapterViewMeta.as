package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IManualChapterViewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function bootcampButtonClickedS() : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_showPage(param1:int) : void;
   }
}
