package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IManualMainViewMeta extends IEventDispatcher
   {
       
      
      function onChapterOpenedSS(param1:String) : void;
      
      function closeViewS() : void;
      
      function as_setChapters(param1:Array) : void;
      
      function as_setPageBackground(param1:String) : void;
      
      function as_showCloseBtn(param1:Boolean) : void;
   }
}
