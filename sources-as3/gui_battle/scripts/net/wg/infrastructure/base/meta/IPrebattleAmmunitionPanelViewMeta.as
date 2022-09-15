package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPrebattleAmmunitionPanelViewMeta extends IEventDispatcher
   {
       
      
      function onViewIsHiddenS() : void;
      
      function as_show() : void;
      
      function as_hide(param1:Boolean) : void;
      
      function as_setIsInLoading(param1:Boolean) : void;
      
      function as_showShadows(param1:Boolean) : void;
   }
}
