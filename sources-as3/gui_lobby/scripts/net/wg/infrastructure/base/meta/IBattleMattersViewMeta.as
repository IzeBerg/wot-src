package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleMattersViewMeta extends IEventDispatcher
   {
       
      
      function as_showView() : void;
      
      function as_hideView() : void;
   }
}
