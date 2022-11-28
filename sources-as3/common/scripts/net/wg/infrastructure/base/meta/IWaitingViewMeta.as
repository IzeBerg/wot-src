package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IWaitingViewMeta extends IEventDispatcher
   {
       
      
      function as_showWaiting(param1:String, param2:Boolean, param3:Boolean) : void;
      
      function as_showBackgroundImg(param1:String) : void;
      
      function as_hideWaiting() : void;
      
      function as_showAwards(param1:Boolean) : void;
   }
}
