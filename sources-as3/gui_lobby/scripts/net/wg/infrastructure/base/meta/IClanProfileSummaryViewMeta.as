package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IClanProfileSummaryViewMeta extends IEventDispatcher
   {
       
      
      function hyperLinkGotoMapS() : void;
      
      function hyperLinkGotoDetailsMapS() : void;
      
      function sendRequestHandlerS() : void;
      
      function as_updateStatus(param1:Object) : void;
      
      function as_updateGeneralBlock(param1:Object) : void;
      
      function as_updateFortBlock(param1:Object) : void;
      
      function as_updateGlobalMapBlock(param1:Object) : void;
      
      function as_updateLeaguesBlock(param1:Object) : void;
   }
}
