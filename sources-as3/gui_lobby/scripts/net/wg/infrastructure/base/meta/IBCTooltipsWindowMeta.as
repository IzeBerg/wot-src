package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCTooltipsWindowMeta extends IEventDispatcher
   {
       
      
      function animFinishS() : void;
      
      function as_setRotateTipVisibility(param1:Boolean) : void;
      
      function as_showHandler() : void;
      
      function as_completeHandler() : void;
      
      function as_hideHandler() : void;
   }
}
