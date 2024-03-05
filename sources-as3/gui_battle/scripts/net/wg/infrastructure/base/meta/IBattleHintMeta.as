package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleHintMeta extends IEventDispatcher
   {
       
      
      function onFadeOutFinishedS() : void;
      
      function as_showHint(param1:Object) : void;
      
      function as_hideHint() : void;
      
      function as_cancelFadeOut() : void;
   }
}
