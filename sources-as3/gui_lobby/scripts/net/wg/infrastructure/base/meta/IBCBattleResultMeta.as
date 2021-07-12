package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBCBattleResultMeta extends IEventDispatcher
   {
       
      
      function clickS() : void;
      
      function onAnimationAwardStartS(param1:String) : void;
      
      function onToolTipShowS(param1:String) : void;
      
      function onVideoButtonClickS(param1:int) : void;
      
      function as_setData(param1:Object) : void;
   }
}
