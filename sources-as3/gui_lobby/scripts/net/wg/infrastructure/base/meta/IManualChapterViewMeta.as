package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IManualChapterViewMeta extends IEventDispatcher
   {
       
      
      function closeViewS() : void;
      
      function pageButtonClickedS(param1:String) : void;
      
      function buttonHighlightedS() : void;
      
      function onPreviewClickedS(param1:String) : void;
      
      function onPageChangedS(param1:String) : void;
      
      function as_setInitData(param1:Object) : void;
      
      function as_setPages(param1:Array) : void;
      
      function as_showPage(param1:int) : void;
   }
}
